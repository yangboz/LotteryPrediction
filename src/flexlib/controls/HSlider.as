/*
Copyright (c) 2007 FlexLib Contributors.  See:
    http://code.google.com/p/flexlib/wiki/ProjectContributors

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

package flexlib.controls
{

import flexlib.controls.sliderClasses.ExtendedSlider;
import mx.controls.sliderClasses.SliderDirection;


//--------------------------------------
//  Styles
//--------------------------------------

/**
 *  The location of the data tip relative to the thumb.
 *  Possible values are <code>"left"</code>, <code>"right"</code>,
 *  <code>"top"</code>, and <code>"bottom"</code>.
 *
 *  @default "top"
 */
[Style(name="dataTipPlacement", type="String", inherit="no")]

//--------------------------------------
//  Excluded APIs
//--------------------------------------

[Exclude(name="direction", kind="property")]

//--------------------------------------
//  Other metadata
//--------------------------------------

[DefaultBindingProperty(source="value", destination="labels")]

[DefaultTriggerEvent("change")]

[IconFile("HSlider.png")]

/**	
 *  An alternative to the HSlider control included in the Flex framework. This 
 *  version of the HSlider allows you to drag the region between the thumbs, if
 *  the slider has mutliple thumbs. If there is more than one thumb then the region
 *  between the leftmost thumb and the rightmost thumb is draggable.
 * 
 *  <p>To use this control an enable the draggable regions between the thumbs you
 *  need to set the <code>thumbCount</code> to something greater than 1, otherwise
 *  this control will work exactly like the original HSlider.  
 *  @mxml
 *  
 *  <p>The <code>&lt;flexlib:HSlider&gt;</code> tag inherits all of the tag attributes
 *  of its superclass, and adds the following tag attribute:</p>
 * 
 *  <pre>
 *  &lt;flexlib:HSlider
 *    <strong>Styles</strong>
 *    dataTipPlacement="top"
 *  /&gt;
 *  </pre>
 *  </p>
 *  	
 *  @see mx.controls.HSlider
 *  @see flexlib.controls.VSlider
 *  @see flexlib.baseClasses.SliderBase
 */


public class HSlider extends ExtendedSlider 

{
	//include "../core/Version.as";
		
	//--------------------------------------------------------------------------
	//
	//  Constructor
	//
	//--------------------------------------------------------------------------

	/**
	 *  Constructor.
	 */
	public function HSlider()
	{
		super();
		
		// Slider variables.
		direction = SliderDirection.HORIZONTAL;
	}
}

}
