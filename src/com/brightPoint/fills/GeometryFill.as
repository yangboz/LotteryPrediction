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
package com.brightPoint.fills
{
	import com.degrafa.GeometryComposition;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.graphics.IFill;
	[DefaultProperty("source")]
	public class GeometryFill implements IFill
	{
		
		public var filters:Array;
		
		public var source:GeometryComposition;
		
		[Bindable]
		public var width:Number;
		
		[Bindable]
		public var height:Number;
		
		public function GeometryFill()
		{
			
		}
		
		public function begin(target:Graphics, rc:Rectangle):void {
		//Calc our bitmap fill	
			if (rc.height<1|| rc.width<1) return;
			if (source) {
				var shape:Shape=new Shape();
				shape.alpha=0;
				width=Math.ceil(rc.width);
				height=Math.ceil(rc.height);
				shape.width=width;
				shape.height=height;
				source.width=width;
				source.height=height;
				source.draw(shape.graphics,rc);
				var bmd:BitmapData=new BitmapData(width,height,true,0);
				bmd.draw(shape,new Matrix(),null);
				
				if (filters && filters.length>0) {
					var fillRc:Rectangle=new Rectangle(rc.x,rc.y,width+2,height+2);
					for (var i:int=0;i<filters.length;i++) {
						bmd.applyFilter(bmd,fillRc,new Point(0,0),filters[i]);
					}
				}
				
			}
			target.beginBitmapFill(bmd);
			
		}
	

		public function end(target:Graphics):void {
			target.endFill();
		}
	}
}