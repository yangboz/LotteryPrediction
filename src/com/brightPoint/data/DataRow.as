////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2005-2008 BrightPoint Consluting Inc.
//
////////////////////////////////////////////////////////////////////////////////
package  com.brightPoint.data
{
	[Bindable]
	public class DataRow
	{
		public var rowNum:int=0;
		private var _cells:Array=new Array();
		
		public function get cells():Array {
			return _cells;
		}
		
		public function addDataCell(value:DataCell):void {
			_cells.push(value);
		}
		
		public function clone():DataRow {
			var dr:DataRow=new DataRow();
			dr.rowNum=this.rowNum
			for each (var dc:DataCell in _cells) {
				dr.addDataCell(dc.clone());
			}
			return dr;
		}
	
	}
}