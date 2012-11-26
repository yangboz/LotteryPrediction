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

package com.brightPoint.charts.itemRenderers
{

	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import mx.charts.ChartItem;
	import mx.charts.series.items.ColumnSeriesItem;
	import mx.controls.Label;
	import mx.core.IDataRenderer;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;
	use namespace mx_internal;
	
	 /** Fill
	 * The fill used for the renderer
	 */
	[Style(name="itemFill",type="Class",inherit="no")]
	
	
	 /** Filters
	 * The fill used for the renderer
	 */
	[Style(name="filters",type="Array",inherit="no")]

	/** labelPosition
	 * 
	 */
	 [Style(name="labelPosition", type="String", enumeration="top, bottom, left, right", default="bottom", inherit="no")]
	 
	 /** labelRotation
	 * 
	 */
	 [Style(name="labelAngle", type="String", enumeration="horizontal, vertical", default="horizontal", inherit="no")]
	
	public class BoxItemRenderer extends UIComponent implements IDataRenderer
	{
		public function BoxItemRenderer()
		{
	        super(); 
	        _label = new Label();
	        _valueLabel= new Label();
	        addChild(_label);
	        addChild(_valueLabel);
	        _label.setStyle("color",0xFFFFFF);  
	        _label.alpha=1;
	        _valueLabel.setStyle("color",0xFFFFFF);      
	    }
	    
	    private var _label:Label;
	    private var _valueLabel:Label;
	    private var _chartItem:ChartItem;
	    private var _fillColor:Number;
	    [Bindable]
	    private var _tempLabel:String;
	    private var _tempValue:String;
	
	    public function get data():Object
	    {
	        return _chartItem;
	    }
	
	    public function set data(value:Object):void
	    {
	        if (_chartItem == value)
	            return;
	        _chartItem = ChartItem(value);
	
	        if(_chartItem != null) {
	        	if (_chartItem["fill"] is SolidColor)
					_fillColor=SolidColor(_chartItem["fill"]).color;
	        }
	        if (_chartItem.element["labelFunction"]) {
	         	var func:Function=_chartItem.element["labelFunction"];
	        	_tempLabel = func.call(_chartItem,_chartItem);
	        	this.invalidateDisplayList();
	        }
	        else if (_chartItem.element["labelField"])
	            _tempLabel = _chartItem.item[_chartItem.element["labelField"]];
	        else
	        	_tempLabel= _chartItem.item[_chartItem.element["yField"]];
	            
	        if (_chartItem is ColumnSeriesItem) {
	        	_tempValue=_chartItem["yValue"];
	        }
	        else {
	        	_tempValue=_chartItem["xValue"];
	        }
	            
	   
	    }
	
	    
	    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
	    {
	            
	        super.updateDisplayList(unscaledWidth, unscaledHeight);
	         
	        var fill:IFill;
	        var fillClass:Class;
	      
	      	//First see if the fill is set at the parent level
	      	if (UIComponent(this.parent).getStyle("seriesItemFill")) {
	      //		trace(UIComponent(this.parent).getStyle("seriesItemFill"));
	      		fillClass=Class(UIComponent(this.parent).getStyle("seriesItemFill"));
	      	}

	        
	        //Now see if we override individually
	        if (getStyle("itemFill")) fillClass=Class(getStyle("itemFill"));
	        
	        var tempFill:IFill=getStyle("fill");
	        
	        if (tempFill) _fillColor=tempFill["color"];

			if( !fillClass ) {
				fill=new SolidColor(_fillColor);
			}
			else {
				fill=new fillClass();
				if (SolidColor && fill["color"])  fill["color"]=_fillColor;
			}

	        var rc:Rectangle = new Rectangle(0, 0, width , height );

	        var g:Graphics = graphics;
	        g.clear();        
	        g.moveTo(rc.left,rc.top);
	        fill.begin(g,rc);
	        g.lineTo(rc.right,rc.top);
	        g.lineTo(rc.right,rc.bottom);
	        g.lineTo(rc.left,rc.bottom);
	        g.lineTo(rc.left,rc.top);
	        fill.end(g);
	        
	        _label.text=_tempLabel;
	        _valueLabel.text=_tempValue;
	        _label.setActualSize(_label.getExplicitOrMeasuredWidth(),_label.getExplicitOrMeasuredHeight());
	        _valueLabel.setActualSize(_valueLabel.getExplicitOrMeasuredWidth(), _valueLabel.getExplicitOrMeasuredHeight());
	        
	        var labelX:Number;
	        var labelY:Number;
	        
	        switch (getStyle("labelPosition")) {
	        	case "bottom": //Top
	        		labelX=unscaledWidth/2 - _label.getExplicitOrMeasuredWidth()/2;
	        		labelY=unscaledHeight-5-_label.getExplicitOrMeasuredHeight();
	        		break;
	        	case "top":
	        		labelX=unscaledWidth/2 - _label.getExplicitOrMeasuredWidth()/2;
	        		labelY=5;
	        		break;
	        	case "left":
	        		labelX=5;
	        		labelY=unscaledHeight/2 - _label.getExplicitOrMeasuredHeight()/2;
	        		break;
	        	case "right":
	        		labelX=unscaledWidth+5+_label.getExplicitOrMeasuredWidth();
	        		labelY=unscaledHeight/2 - _label.getExplicitOrMeasuredHeight()/2;
	        		break;
	        	default:
	        		labelX=unscaledWidth/2 - _label.getExplicitOrMeasuredWidth()/2;
	        		labelY=unscaledHeight-5-_label.getExplicitOrMeasuredHeight();
	        		break;
	        }
	        
	        if (_label.getExplicitOrMeasuredWidth() > rc.width) {
	        	var dif:Number=(_label.getExplicitOrMeasuredWidth() - rc.width);
	        	_label.text=_label.text.substr(0,Math.round(_label.text.length*(1-dif/_label.getExplicitOrMeasuredWidth()))-3) + "...";
	        }
	        _label.move(labelX,labelY);
	        _label.visible=(_label.getExplicitOrMeasuredWidth() < rc.width);
	        _valueLabel.visible=(_valueLabel.getExplicitOrMeasuredWidth() < rc.width);
	        _valueLabel.move(unscaledWidth/2 - _valueLabel.getExplicitOrMeasuredWidth()/2,-3-_valueLabel.getExplicitOrMeasuredHeight());
	    	
	    	
	    }
	
	}
	
	
}