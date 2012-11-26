package com.brightPoint.data
{
/*
Copyright (c) 2008, Thomas W. Gonzalez

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

www.brightpointinc.com

*/	
	import com.brightPoint.evaluator.Evaluator;
	import flash.utils.getTimer;
	import mx.charts.chartClasses.Series;
	import mx.controls.DataGrid;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.ClassFactory;
	
	[Bindable]
	public class DataSet
	{
		
		/**
		 * Stores our internal 2 dimensional array of row/column values
		 */
		private var _dataRows:Array;
		
		/**
		 * Flag to indicate we should process source data with the first row acting as a header row
		 */
		private var _firstRowIsHeader:Boolean=true;
		
		/**
		 * Stores data in column arrays
		 */ 
		private var _dataColumns:Array
		
		/**
		 * Used to cache select queries for performance - might need to clean up and make sure this gets cleared when new data is loaded
		 * Each time a query is executed we store it in the cache for fast retrival next time
		 */
		private var _queryCache:Object=new Object(); 
		
		/**
		 * Hash to store column names to index
		 */
		private var _headerNameHash:Object;
		
		/**
		 * Stores the header row in a separate array
		 */
		private var _headerRow:Array;
		
		/**
		 * Total row count of source
		 */
		private var _rowCount:int;
		
		/**
		 * Total column count
		 */
		 private var _colCount:int;
		
		/**
		 * Stores all data as raw CSV format
		 */
		private var _csvRawData:String;
		
		/**
		 * Comma delimted string of string-->null translation values
		 */
		public var nullValues:String="NA, null";  //Comma delimted string;
		
		//FILTER VARIABLES
		/**
		 * private evaluator that parses WHERE clause of select queries - sorry not open sourced at this point
		 * email: tgonzalez@brightpointinc.com if bugs occur
		 */
		private var _expParser:Evaluator;  
		
		/**
		 * Temp storage used when matching rows on select queries
		 */
		private var _currentFilterRow:int;

		
		public function DataSet()
		{

		}
		
		public function get rowCount():int { return _rowCount }
		public function get colCount():int { return _colCount }
		
		/**
		 * Populates DataSet from raw CSV source data - does simple cleansing
		 */
		public function processCsvSource(value:String, firstRowIsHeader:Boolean=true, cleanPayload:Boolean=true):void {
			createTableFromCsv(value,firstRowIsHeader);
		}
		
		public function get csvSource():String {
			return _csvRawData;
		}
		
		/**
		 * Populates DataSet from Array
		 */
		public function processArraySource(value:Array, firstRowIsHeader:Boolean):void {
			if (firstRowIsHeader) {
				createTableFromArray(value.slice(1,value.length),value.slice(0,1)[0]);
			}
			else 
				createTableFromArray(value);
		}
		
		/**
		 * returns all rows
		 */
		public function get source():Array {	
			return _dataRows;			
		}
		
		/**
		 * returns header row
		 */
		public function get header():Array {
			return _headerRow;
		}
		
		/**
		 * returns all data columns
		 */
		public function get dataColumns():Array {
			return _dataColumns;
		}
		
		/**
		 * clears query cache
		 */
		public function clearCache():void {
			_queryCache=new Object();
		}
			
	
		/***
		 * Uses an array as the data source string into our private _dataRows
		 * @value = needs to be a 2 dimensional array
		 * 
		 */
		private function createTableFromArray(value:Array,header:Array=null):void {
			
			//Create header hashes
			//Create our Header hash
			_headerNameHash=new Object();
			_headerRow=new Array();
			var headerSplice:int=0;
			if (header==null) { header=value[0]; headerSplice=1; }
			
			for (var i:int=0;i<header.length;i++) {
 
					if (headerSplice==1) {
						_headerNameHash["@col"+i]=i; //We are using a key for header names
						_headerRow.push("@col"+i);
					}
					else {
						if (!isNaN(Number(header[i]))) header[i]="["+header[i]+"]";
						_headerNameHash[header[i]]=i;  //We are just using the index for header names
						_headerRow.push(header[i]);
					}
				
				
			}
			
			_colCount=i;
			value=value.splice(headerSplice);
			_rowCount=value.length;
			_dataRows=value;
			createColumns();
			
		}
		
		/***
		 * Parses a CSV string into our private _dataRows
		 * 
		 */
		private function createTableFromCsv(value:String, firstRowIsHeader:Boolean=true, cleanPayload:Boolean=true):void {
			//First we need to use a regEx to find any string enclosed in Quotes - as they are being escaped
			
			var t:int=getTimer();
			
			//Then need to put in symbols for  quotes and commas
			var temp:String=value;
			var tempData:String="";
			var pattern:RegExp = /"[^"]*"/g;
			
			//Find anything enclosed in quotes
			var arr:Array=temp.match(pattern);
			for (var x:int=0;x<arr.length;x++) {
				var s:String=arr[x];
				var re:RegExp =/,/g;
				s=s.replace(re,"&comma;");
				temp=temp.replace(arr[x],s);
			}
			
			var rowArray:Array=temp.split("\n");
			
			//Try to split on a double return instead
			if (rowArray.length==1)  
				rowArray=temp.split("\r\r");
			
			//Try and split on single return	
			if (rowArray.length==1) 
				rowArray=temp.split("\r");
			
			//Create our Header hash
			_headerNameHash=new Object();
			_headerRow=new Array();
			var header:Array=rowArray[0].split(",");
			
			for (var i:int=0;i<header.length;i++) {
				if (firstRowIsHeader) {
					if (!isNaN(Number(header[i]))) header[i]="["+header[i]+"]";
					_headerNameHash[header[i]]=i; //We are using a key for header names
					_headerRow.push(header[i]);
				}
				else {
					_headerNameHash["@col" + i]=i;  //We are just using the index for header names
					_headerRow.push("@col" + i);
				}
			}
			
			_colCount=i;
			
			var start:int=(firstRowIsHeader) ? 1:0; //Determine where we start parsing
			
			_dataRows= new Array();
			for (i=start;i<rowArray.length;i++) { 

				var row:Array=rowArray[i].split(","); //Create a row
				
				if (cleanPayload) {		//We go through this cleanining stage to prepare raw CSV data
							
					for (var z:int=0;z<row.length;z++) {

						var dataCell:String=row[z];
							//clean up commas encoding
							var re1:RegExp=/\&comma;/g;
							dataCell=dataCell.replace(re1,",");
							
							//Clean up any encoding quotes excel put it at front of cell
							if (dataCell.charAt(0)=='"')
								dataCell=dataCell.substr(1);
							
							//Clean up any encoding quotes excel put it at end of cell	
							if (dataCell.charAt(dataCell.length-1)=='"')
								dataCell=dataCell.substr(0,dataCell.length-1);
								
							//Now replace any double quotes with single quotes
							re1=/\""/g;
							dataCell=dataCell.replace(re1,'"');
							if (dataCell=" ") dataCell="";
					}
					tempData+=dataCell + ",";
				}
				
				if (rowArray[i].length > row.length+2) { //Make sure that we do not have an empty row (i.e. just a string with all commas in it.
					tempData=tempData.substr(0,tempData.length-1) + "\n";
					if (row.length==_colCount) {  //don't enter fragmented rows (this can occur if a row length does not match the number of columns in the first row which is used to determine the header)
						_dataRows.push(row);
					}
				}
			}
			
			_rowCount=i;
			
			tempData=rowArray[0] + "\n" + tempData.substr(0,tempData.length-3);  //strip off last new line
			_csvRawData=tempData;
			
			createColumns();

		trace("DataSetCollection: elapsed time for creating data rows =" + (getTimer()-t).toString());
		}
		
		/***
		 * Creates dimensional arrays for columns
		 * 
		 */
		private function createColumns():void { 
			
			 _dataColumns=new Array();
			
			for (var i:int=0;i<_headerRow.length;i++) {
				_dataColumns[i]=new Array();
				for (var y:int=0; y<_dataRows.length;y++) {
					_dataColumns[i].push(_dataRows[y][i]);
				}
			}
			
		}
		
		
		/***
		 * Returns a subset of the collection based on the queryExpression following a SQL like Syntax
		 * Supports SELECT col0 or [1980] or ColumnName
		 * Suports inline conditionals that allows you to compare column values within a row for a match 
		 *  ex: WHERE (col1*2) > col3
		 * 
		 * Syntax:
		 * SELECT * WHERE col1='USA' and col2>1000;
		 * 
		 * or
		 * 
		 * SELECT [2001],[2002],Country
		 */
		public function select(queryExpression:String, pivot:Boolean=false, queryAlias:String=null, refreshCache:Boolean=false):DataSet {
			var t:int=getTimer();
			
			if (queryAlias==null) queryAlias=queryExpression+"_"+pivot;
			
			if (_queryCache[queryAlias]!=null && !refreshCache) {
				trace("DataSetCollection: elapsed time for selecting CACHED data rows =" + (getTimer()-t).toString());
				return _queryCache[queryAlias]
			}
			
			var temp:Array=new Array();
			var header:Array=new Array();
			var t:int=getTimer();
			
			//Parse query:  SELECT col1,col2,col3 WHERE col1=test AND/OR col2=test2
			var re:RegExp=/(?i)SELECT\b(?-i)(.*?)((?i)WHERE(?-i)|$)\b(.*?)$/

				
			var rer:Array=re.exec(queryExpression);
			
			if (rer==null) throw new Error("Invalid query Syntax");
			
			var selectClause:String=rer[1];
			var whereClause:String=rer[3];
			
			if (whereClause.length!=0) 
				_expParser=new Evaluator(whereClause,expressionLookup);
			else
				_expParser=null;
			
			var columns:String=selectClause;
			var colCount:int=columns.split(",").length;
			//Since we will need to inspect every row for the filter funciton we might as well create a new array with the new number of columns
			//Note: Typcially you would use the array's filter function  - but performance testing shows this to be just as quick.
			
			for (var i:int=0;i<_dataRows.length;i++) {
				_currentFilterRow=i;
				var match:Boolean=(_expParser==null) ? true:_expParser.evaluate();  //Only execute the evaluator if we need to
				if (match) {   
					if (columns.indexOf("*")>-1) {
						if (header.length==0) header=_headerRow;  //Create header
						temp.push(_dataRows[i]);
					}
					else {
						var tempRow:Array=new Array();
						for (var y:int=0;y<_colCount;y++) {
							var clean:String=String(_headerRow[y]).replace("[","");
							clean=clean.replace("]","");
							
							if (columns.match(clean)!=null && _headerRow[y]!="" ) {
								if (header.length<colCount) header.push(_headerRow[y]); //Create Header
								tempRow.push(_dataRows[i][y]);
							}
						}
						temp.push(tempRow);
					}
				}
			}
			
			var temp2:Array=new Array();
			var tempHeader:Array=new Array();
			if (pivot) {
				for (i=0;i<header.length;i++) {
					var tempRow:Array=new Array();
					for (y=0;y<temp.length;y++) {
						if (y==0) {
							tempRow.push(header[i]);
						}
						tempRow.push(temp[y][i]);
					}
					if (i>0)
						temp2.push(tempRow);
					else
						tempHeader=tempRow;
				}
				
				header=tempHeader;
				temp=temp2;
			}
					
			var dt:DataSet=new DataSet();
			dt.createTableFromArray(temp,header);
			trace("DataSetCollection: elapsed time for selecting data rows =" + (getTimer()-t).toString());
			_queryCache[queryAlias]=dt;
			return dt;
			
			
		}
		
		
		/***
		 * Used by the expression parser to lookup column values
		 * 
		 */
		private function expressionLookup(value:String):* {

			if (value.indexOf("@col")>-1) {
				return _dataRows[_currentFilterRow][Number(value.substr(4))];
			}
			else {
				var val:Object;
				val=_dataRows[_currentFilterRow][_headerNameHash[value]];
				if (isNaN(Number(val))) {
					if (nullValues.indexOf(String(val)) > -1)  //See if we need to translate string values into zero Nulls
						return 0
					else
						return val 
				
				}
				else return Number(val);
			}
		}
		
		/***
		 * Creates a DataGrid based on current dataset
		 *
		 */
		public function createDataGrid():DataGrid
		{
	
		    var dg:DataGrid = new DataGrid;                              
		    var dgc:DataGridColumn;
		    var newCols:Array = new Array();
		    
		    //based on the array param, create the columns using the first array in the collection
		    for (var i:int=0;i<_colCount;i++)  {                
		      dgc = new DataGridColumn();                                  
		      dgc.dataField = String(i);  
		      dgc.headerText = _headerRow[i];               
		      newCols.push(dgc)                                       
		    }
		 
		 	dg.percentHeight=100;
		 	dg.percentWidth=100;
		    dg.resizableColumns=true;
		    dg.itemRenderer=new ClassFactory(DataCellRenderer);
		    dg.columns = newCols;    
		    dg.dataProvider = _dataRows;     
		            
			return dg;
		}
		
		/***
		 * Sets a DataGrid columns based on current dataset value
		 * 
		 */
		public function setDataGrid(dg:DataGrid):DataGrid
		{
		    var dgc:DataGridColumn;
		    var newCols:Array = new Array();
		    
		    //based on the array param, create the columns using the first array in the collection
		    for (var i:int=0;i<_colCount;i++)  {                
		      dgc = new DataGridColumn();                                  
		      dgc.dataField = String(i);  
		      dgc.headerText = _headerRow[i];               
		      newCols.push(dgc)                                       
		    }

		    dg.itemRenderer=new ClassFactory(DataCellRenderer);
		    dg.columns = newCols;    
		    dg.dataProvider = _dataRows;     
		            
			return dg;
		}
		
		/**
		 * Creates an array of series based on start/end field
		 * 
		 */
		public function createSeriesSet(startField:int, endField:int, seriesClass:Class, axisField:String, styleValuePairs:Array=null, propertyValuePairs:Array=null):Array {
			
			var seriesArray:Array=new Array;
			
			for (var i:int=startField;i<=endField;i++) {
				var s:Series=new seriesClass();
				s[axisField]=i;
				if (propertyValuePairs) {
					for (var y:int=0;y<propertyValuePairs.length;y++) {
						s[String(propertyValuePairs[y].name)]=propertyValuePairs[y].value;
					}
				}
				
				if (styleValuePairs) {
					for (var y:int=0;y<styleValuePairs.length;y++) {
						if (styleValuePairs[y].value is Function)
							s.setStyle(styleValuePairs[y].name,styleValuePairs[y].value.call(this));
						else
							s.setStyle(styleValuePairs[y].name,styleValuePairs[y].value);
					}
				}
				s.displayName=header[i];
				
				seriesArray.push(s);
			}
			
			return seriesArray;
			
		}
		
	}
}