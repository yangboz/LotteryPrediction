package  com.brightPoint.utils
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
	import flash.display.Graphics;
	import mx.graphics.Stroke;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import mx.graphics.IFill;
	import mx.charts.chartClasses.GraphicsUtilities;
	import mx.graphics.SolidColor;
	
	public class GraphicsUtil
	{
	
		public static function drawArc(g:Graphics, 
										angleStart:Number,
										angleEnd:Number, 
										color:Number, 
										alpha:Number, diameter:Number):void {
		 	
		 	
			const SHADOW_INSET:Number = 0;

		 	
	      	var fCenterX:Number=diameter/2;
	      	var fCenterY:Number=diameter/2;
	      	var fRadius:Number=diameter/2;
	     
			// //trace("radius is " + fRadius);
			
			//fRadius=100;
			
			if(isNaN(fRadius)) return;
					
			var outerRadius:Number = fRadius/1.25;
			var innerRadius:Number = fRadius/1.55;
			var origin:Point = new Point();
			origin.x=fCenterX;
			origin.y=fCenterY;
			var angle:Number = (angleEnd) * Math.PI/180; //in radians
			var startAngle:Number = angleStart * Math.PI/180; //in radians
					
			var stroke:Stroke = new Stroke;
			stroke.alpha=0;
			stroke.weight=0;
			stroke.color=0xFF0000;
			stroke.alpha=alpha;
			
			if (stroke && !isNaN(stroke.weight))
				outerRadius -= Math.max(stroke.weight/2,SHADOW_INSET);
			else
				outerRadius -= SHADOW_INSET;
							
			outerRadius = Math.max(outerRadius, innerRadius);
			
			var rc:Rectangle = new Rectangle(origin.x - outerRadius,
											 origin.y - outerRadius,
											 2 * outerRadius, 2 * outerRadius);
			
			var sc:SolidColor=new SolidColor(color);
			sc.alpha=alpha;
			var fill:IFill = sc;
	
			
			var startPt:Point = new Point(
				origin.x + Math.cos(startAngle) * outerRadius,
				origin.y - Math.sin(startAngle) * outerRadius);
	
			var endPt:Point = new Point(
				origin.x + Math.cos(startAngle + angle) * outerRadius,
				origin.y - Math.sin(startAngle + angle) * outerRadius);
	
			g.moveTo(endPt.x, endPt.y);
	
			fill.begin(g,rc);
			
	
			//GraphicsUtilities.setLineStyle(g, stroke);
	
			if (innerRadius == 0)
			{
				g.lineTo(origin.x, origin.y);
				g.lineTo(startPt.x, startPt.y);
			}
			else
			{
				var innerStart:Point = new Point(
					origin.x + Math.cos(startAngle + angle) * innerRadius,
					origin.y - Math.sin(startAngle + angle) * innerRadius);
	
				g.lineTo(innerStart.x, innerStart.y);			
	
				//GraphicsUtilities.setLineStyle(g, stroke);
				GraphicsUtilities.drawArc(g, origin.x, origin.y,
										  startAngle + angle, -angle,
										  innerRadius, innerRadius, true);
	
				//GraphicsUtilities.setLineStyle(g, stroke);
				g.lineTo(startPt.x, startPt.y);
			}
	
			//GraphicsUtilities.setLineStyle(g, stroke);
	
			GraphicsUtilities.drawArc(g, origin.x, origin.y,
									  startAngle, angle,
									  outerRadius, outerRadius, true);
	
			fill.end(g);
		}
	}
}