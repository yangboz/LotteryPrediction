/**
 *  GODPAPER Confidential,Copyright 2012. All rights reserved.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining
 *  a copy of this software and associated documentation files (the "Software"),
 *  to deal in the Software without restriction, including without limitation
 *  the rights to use, copy, modify, merge, publish, distribute, sub-license,
 *  and/or sell copies of the Software, and to permit persons to whom the
 *  Software is furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included
 *  in all copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 *  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 *  THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 *  IN THE SOFTWARE.
 */
package com.lookbackon.lp.proxy
{
	import com.lookbackon.lp.model.BallsModel;
	import com.shortybmc.data.parser.CSV;
	
	import flash.events.Event;
	import flash.net.URLRequest;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * CSVParser.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 11.2+
	 * @airVersion 3.2+
	 * Created Oct 11, 2012 10:50:33 AM
	 */   	 
	public class CSVParser
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var csv:CSV;
		private var model:BallsModel = BallsModel.getInstance();
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
//		fixed year range:2003~2012
		private static const MIN_OF_YEAR:int = 2003;
		private static const MAX_OF_YEAR:int = 2012;
		private static const NUM_OF_RED:int = 6;
		private static const NUM_OF_BLUE:int = 1;
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function CSVParser()
		{
			this.csv = new CSV();
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function parse(url:String):void
		{
			this.csv.load(new URLRequest(url));
			this.csv.addEventListener(Event.COMPLETE,completeHandler);
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
		private function completeHandler(event:Event):void
		{
//			trace(this.csv.data[0]); 
			//lottery raw data parse:
			var len:int = (this.csv.data as Array).length;
			//<quote date="8/27/2007" red="11" blue="6" />
			var date:String = "8/27/2007";
			var red:String = "";
			var blue:String = "";
			var csvData:String = "";
			var csvDataGroup:Array = [];
			var dateSets:Array = [];
			var blues:Array = [];
			var reds:Array = [];
			for(var i:int=0;i<len;i++)
			{
				csvData = (this.csv.data[i] as Array).toString();
				csvDataGroup = csvData.split(";");
//				trace(csvDataGroup[0]);
				dateSets.push( csvDataGroup[0]);
				for(var j:int=1;j<7;j++)
				{
					reds.push(csvDataGroup[j]);
				}
				blues.push(csvDataGroup[7]);
			}
			trace("dateSets:",dateSets);
			trace("blues:",blues);
			trace("reds:",reds);
			//
			this.csv.removeEventListener(Event.COMPLETE,completeHandler);
			//Turn to assemble date sets.
			this.assembleRawData(dateSets,reds,blues);
		}
		
		//
		private function assembleRawData(dateSets:Array,reds:Array,blues:Array):void
		{
			//@see BallsModel.lotteryData example
			//<quote date="8/27/2007" red="11" blue="6" />
			var xml:XML = new XML(
				<quotes>
				</quotes>			
			);
			//fixed year range:2003~2012
			for(var i:int=0;i<reds.length;i++)
			{
				var offset:int = i/6;
				var dateFixture:String = this.indexToDate(dateSets[offset]);
				var red:String = reds[i];
				var blue:String = blues[offset];
				//item xml assemble
				var item:XML = new XML(<quote/>);
				item.@date = dateFixture;
				item.@red = red;
				item.@blue = blue;
				trace("xmlItem:",item.toXMLString());
				xml.appendChild(item);
			}
			//update model
			model.lotteryData = new XMLList(xml);
			model.lotteryQuoteData = model.lotteryData[0].quote;
			//update view(illigal operation based on MVC design pattern)
//			FlexGlobals.topLevelApplication.lineChart.dataProvider = model.lotteryData[0].quote;
		}
		//
		private function indexToDate(index:String):String
		{
			var numOfSerialPerWeek:int = 3;
			var maxOfSerial:int = 154;
			var numOfWeeksOfYear:int = 154/3+1;
			var dateRange:int = 365/154;
			var curYear:int = int(index.substr(0,4));
			var curSerial:int = int(index)-curYear*1000;
			trace("curYear:",curYear);
			trace("curSerial:",curSerial);
			var dayNumber:int = (curSerial-1)*2;
			var dateResult:String = this.calculateDate(dayNumber,curYear);
			trace("fuzzyDate:",dateResult);
			return dateResult;
		}
		//Calculate date from day number
//		All division is integer division, operator % is modulus. 
//			Given day number g, calculate year, month, and day:
		private function calculateDate(dayNumber:int,year:int):String
		{
			//Fuzzy every month of day to 30.
			var daysOfMonth:int = 30;
			var mm:int = dayNumber/30 +1;
			var day:int = dayNumber%30;
			var result:String = mm.toString().concat("/",day,"/",year);
			return result;
		}
	}
	
}