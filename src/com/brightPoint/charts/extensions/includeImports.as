// ActionScript file
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
/**
 * This file is included in extended chart classes to support the styles declared below
 */
	import flash.events.Event;
	import mx.core.ClassFactory;
	import mx.charts.chartClasses.Series;
	import mx.graphics.SolidColor;
	import mx.charts.GridLines;
	import mx.charts.renderers.BoxItemRenderer;
	import flash.geom.Rectangle;
	import mx.charts.series.LineSeries;
	import mx.core.ClassFactory;
	import mx.graphics.IFill;
	import mx.graphics.Stroke;
	
	[Style(name="seriesItemRenderer", type="class", inherit="yes")]
	[Style(name="seriesItemFill", type="class", inherit="yes")]
	[Style(name="themeColors", type="Array", inherit="no")]
	[Style(name="backgroundFill", type="class", inherit="no")]
	