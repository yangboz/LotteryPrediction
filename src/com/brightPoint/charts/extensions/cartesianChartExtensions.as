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
// ActionScript file
/**
 * This file is used as an "include" in any extended charts
 * It provides common code to support the following styles
 *  [Style(name="seriesItemRenderer", type="class", inherit="yes")]
 *	[Style(name="seriesItemFill", type="class", inherit="yes")]
 *	[Style(name="themeColors", type="Array", inherit="no")]
 *	[Style(name="backgroundFill", type="class", inherit="no")]
 */
 		private var _seriesItemRenderer:ClassFactory;
		private var _themeColors:Array;
		private var _backgroundFill:IFill;
		
		override public function set styleName(value:Object):void {			
			super.styleName=value;
			
			_themeColors=null;
			_seriesItemRenderer=null;
	
			if (getStyle("verticalAxisStyleName"))	
				this.verticalAxisRenderer["styleName"]=this.getStyle("verticalAxisStyleName");
			if (getStyle("horizontalAxisStyleName"))	
				this.horizontalAxisRenderer["styleName"]=this.getStyle("horizontalAxisStyleName");
			if (getStyle("gridLinesStyleName")) {
				for (var i:int=0;i<backgroundElements.length;i++) {
					if (backgroundElements[i] is GridLines) {
						backgroundElements[i]["styleName"]=getStyle("gridLinesStyleName");
					}
				}
			}
			if (getStyle("seriesItemRenderer")) {
				_seriesItemRenderer=new ClassFactory(getStyle("seriesItemRenderer"));
			}
			
			if (getStyle("themeColors")) {
				_themeColors=getStyle("themeColors");
				trace("setting theme colors");
			}

			if (getStyle("backgroundFill") is Class) {
				var cls:Class=getStyle("backgroundFill");
				_backgroundFill=new cls();
			}
			else _backgroundFill=null;

			
			setSeriesStyles();
			
		}
		
		override public function setStyle(styleProp:String, newValue:*):void {
			if (styleProp=="seriesItemRenderer") {
				_seriesItemRenderer=new ClassFactory(newValue);
				setSeriesStyles();
			}
			else if (styleProp=="themeColors") {
				_themeColors=newValue;
				setSeriesStyles();
			}
			else if (styleProp=="backgroundFill") {
				var cls:Class=newValue;
				_backgroundFill=new cls();
			}
	
			super.setStyle(styleProp,newValue);
		}
		
		override public function set series(value:Array):void {
			super.series=value;
			setSeriesStyles();
		}
		
		private function setSeriesStyles():void {
			for (var i:int;i<series.length;i++) {
				var s:Series=Series(series[i]);
				if (_seriesItemRenderer) 
					s.setStyle("itemRenderer",_seriesItemRenderer); 
				else 
					s.setStyle("itemRenderer", new ClassFactory(BoxItemRenderer));
				
				var fill:IFill;
				if (getStyle("seriesItemFill")) {
					var cls:Class=getStyle("seriesItemFill");
					fill=new cls();
				}
				else {
					fill=new SolidColor(0xFFFFFF);
					
				}
				
				if (_themeColors) {
					if (fill["color"]) fill["color"]=_themeColors[(i % (_themeColors.length-1))] 
				//	trace(_themeColors.length);
				//	trace(_themeColors[i]);
				//	trace("fillColor=" + fill["color"]);
				}
				
				s.setStyle("fill",fill); 

			}
			invalidateSeries();
		}
		
		override protected function updateDisplayList(w:Number,h:Number):void {
			
			super.updateDisplayList(w,h);
			
			if (_backgroundFill) {
				var cr:int=getStyle("cornerRadius");
				if (!cr) cr=0;
				_backgroundFill.begin(graphics,new Rectangle(0,0,w,h));
				graphics.drawRoundRectComplex(0,0,w,h,cr,cr,cr,cr);
				_backgroundFill.end(graphics);
			}
		}