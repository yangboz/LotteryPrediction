////////////////////////////////////////////////////////////////////////////////
//
//  Copyright (C) 2005-2008 BrightPoint Consluting Inc.
//
////////////////////////////////////////////////////////////////////////////////
package com.brightPoint.data
{
	import mx.controls.TextInput;
	import mx.controls.dataGridClasses.DataGridListData;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.controls.DataGrid;
	
	public class DataCellRenderer extends TextInput
	{
		public function DataCellRenderer() {
            super();
            this.percentHeight=100;
            this.percentWidth=100;
            setStyle("backgroundAlpha",0);
            setStyle("borderStyle", "none");
            editable=false;
        }

        // Override the set method for the data property.
        override public function set data(value:Object):void {
            super.data = value;
       
            if (value != null)
            {
            	if (value is DataRow)
                	text = value.cells[DataGridListData(listData).dataField].data;  
            }
			

            super.invalidateDisplayList();
        }
	}
}


