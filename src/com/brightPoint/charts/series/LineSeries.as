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
package com.brightPoint.charts.series
{
	import mx.charts.series.LineSeries;
	import mx.core.UIComponent;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.graphics.Stroke;
	
	public class LineSeries extends mx.charts.series.LineSeries
	{
		public function LineSeries()
		{
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
			
			//if (getStyle("lineSegmentRenderer") is Class) 
			//	setStyle("lineSegmentRenderer",new ClassFactory(getStyle("lineSegmentRenderer")));
			if (this.chart && this.chart.getStyle("themeColors")) {
			
				var stroke:IStroke=this.getStyle("lineStroke");
				if (!stroke) stroke=new Stroke();
				var fill:IFill=this.getStyle("fill");
				if (fill && fill["color"]) {
					
					stroke["color"]=fill["color"]; 
					trace(fill["color"]);
					//this.setStyle("lineStroke",stroke);	
				}
				
			}
			
			super.updateDisplayList(unscaledWidth,unscaledHeight);
		}
	
	}
}