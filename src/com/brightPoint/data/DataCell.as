////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2005-2008 BrightPoint Consluting Inc.
//
////////////////////////////////////////////////////////////////////////////////

package com.brightPoint.data
{
	[Bindable]
	public class DataCell extends Object
	{
		public var col:int;
		public var row:int;
		public var data:Object;
		
		public function DataCell(col:int=-1,row:int=-1,data:Object=null):void {
			this.col=col;
			this.row=row;
			this.data=data;
		}
		
		public function clone():DataCell {
			var dc:DataCell=new DataCell();
			dc.col=this.col;
			dc.row=this.row;
			dc.data=this.data;
			
			return dc;
		}
		
	}			
}