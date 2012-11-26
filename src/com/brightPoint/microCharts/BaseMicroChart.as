package com.brightPoint.microCharts
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

	import com.brightPoint.fills.AquaGhostFill;
	import com.degrafa.Surface;
	import com.degrafa.core.IGraphicsFill;
	import com.degrafa.core.IGraphicsStroke;
	
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import mx.events.ResizeEvent;
	
	/**
	 *  The base color that will be used for the chart
	 *  
	 *  @default 0xDDDDFF
	 */
	[Style(name="colorTheme", type="Number", format="Color", inherit="no")]
	
	[Style(name="colorFill", type="Class", format="Class", inherit="no")]
	
	[Style(name="useGhostFill", type="Boolean", format="Boolean", inherit="no")]
	
	
	public class BaseMicroChart extends Surface
	{
		
		[Bindable]
		protected var count:Number;
		
		[Bindable] 
		public var colorTheme:Number=0xeff6fb;
		
		[Bindable]
		protected var _colorFill:IGraphicsFill;
		
		[Bindable]
		protected var _colorStroke:IGraphicsStroke;

		
		/**
		 * Array of numerica values
		 */
		[Bindable]
		private var _dataProvider:Array;
		public function set dataProvider(value:Array):void {
			_dataProvider=value;
		//	trace("BaseMicroChart set Data: " + value[0]);
			setMinMax();
		}
		
		[Bindable]
		public function get dataProvider():Array { return _dataProvider; }
		
		/**
		 * If the data provider contains objects, this grabs the correct field
		 */
		protected var _dataField:String="";
		public function set dataField(value:String):void {
			_dataField=value;
			setMinMax();
		}
		public function get dataField():String { return _dataField; }	
		
		/**
		 * Used to align min value
		 */
		 public function set minValue(value:Number):void {
		 	_minValue=value;
		 	setMinMax();
		 }
		 
		private var _minValue:Number=0;
		
		protected var _max:Number=1;
		protected var _min:Number=0;
		
		protected var chartData:Array;
		
		protected function setMinMax():void {
			if (_dataProvider==null || _dataProvider.length==0) return;
			_min=_minValue;
			_max=1;
			chartData=new Array();
			for (var i:int=0;i<_dataProvider.length;i++) {
				if (_dataField.length>0) {
					chartData.push(_dataProvider[i][_dataField]);
				}
				else {
					chartData.push(_dataProvider[i]);
				}
				_min=(_min < chartData[i]) ? _min : chartData[i];
				_max=(_max > chartData[i]) ? _max : chartData[i];
			}
			count=chartData.length.valueOf();
			draw();
		}
		
		override public function setStyle(styleProp:String, newValue:*):void {
			trace("BaseMicroChart styleProp=" + styleProp);
			if (styleProp=="colorFill") {
				var cls:Class=Class(getDefinitionByName(String(newValue)));
				_colorFill=new cls();
			}
			super.setStyle(styleProp,newValue);
		}
		
		public function BaseMicroChart()
		{
			super();
			this.addEventListener(ResizeEvent.RESIZE,onResize);
		}
		
		private function onResize(e:Event):void {
			draw();	
		}
		
		public function draw():void {}

	}
}