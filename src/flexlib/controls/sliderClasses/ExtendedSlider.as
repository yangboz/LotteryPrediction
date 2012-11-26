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

package flexlib.controls.sliderClasses
{
	import flexlib.baseClasses.SliderBase;
	
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.controls.sliderClasses.SliderDataTip;
	import mx.controls.sliderClasses.SliderDirection;
	import mx.core.UIComponent;
	import mx.core.mx_internal;
	import mx.events.SliderEvent;
	import mx.events.SliderEventClickTarget;
	use namespace mx_internal;

	
	/**
	 * An extension of the base Slider class that adds a draggable region between the thumbs.
	 * 
	 * <p>The user can drag the highlight space between the thumbs and it will drag each of the
	 * thumbs all at once. It also displays dataTips for all the thumbs at the same time.</p>
	 * 
	 * @see mx.controls.sliderClasses.Slider
	 */
	public class ExtendedSlider extends SliderBase
	{
		
		private var draggingRegion:Boolean = false;
		
		/**
		 * If this prperty is true then when you drag the draggable region between two thumbs
		 * the thumbs will always keep their same distance between each other, even when you
		 * drag the region to the left or right edges of the track. If set to false then when 
		 * you drag the region to the edges of the track the region itself will begin to resize.
		 * It's a little hard to explain, just try it out.
		 */
		public var lockRegionsWhileDragging:Boolean = false;
		
		protected var highlightHitArea:UIComponent;
		
		/**
		 * @private
		 * 
		 * Instead of only storing one dataTip object, we store an array of 
		 * sataTip objects. This lets us display a dataTip for every slider 
		 * thumb all at once.
		 */
		private var dataTips:Array;
		
		/**
		 * @private
		 * 
		 * This variable is used to help us know when to dispatch a change event
		 * if the draggable region is dragged. The way we're dragging all the thumbs
		 * makes it so each thumb dispatches a thumbRelease and change event each time
		 * the draggable region is dropped. This means for a slider with 2 thumbs we'd have
		 * 2 change events fired, which is no good.
		 * 
		 * So instead we keep track using this counter variable, so we only dispatch
		 * the thumbRelease and change events once.
		 */
		private var counter:Number = 0;
		
		/**
		 * Constructor
		 */
		public function ExtendedSlider()
		{
			super();
		}
	
		/**
		 * Overridden to create the draggable region and perform some initialization tasks.
		 */
		override protected function createChildren():void {
			super.createChildren();
			
			if (!highlightHitArea)
			{
				highlightHitArea = new UIComponent();
				
				innerSlider.addChild(highlightHitArea);
			
				highlightHitArea.addEventListener(MouseEvent.MOUSE_DOWN,
											   highlight_mouseDownHandler);
			}
			
			dataTips = new Array();
			
			this.sliderThumbClass = SliderThumb;
			
			/* Hack to get the component to work with Flex 3 SDK.
			 * The Flex 3 SDK default stylesheet introduces the thumbSkin style and does not
			 * set the other styles (thumbUpSkin, etc), so here we check if thumbSkin
			 * has been set, and if so we set the other, older styles.
			 */
			var thumbSkin:* = getStyle("thumbSkin");
			if(thumbSkin != null) {
				setStyle("thumbUpSkin", thumbSkin);
				setStyle("thumbDownSkin", thumbSkin);
				setStyle("thumbOverSkin", thumbSkin);
				setStyle("thumbDisabledSkin", thumbSkin);
			}
		}
		
		public function get dragHitArea():UIComponent {
			return highlightHitArea;
		}
		
		/**
		 * @private
		 * 
		 * Here's the magic behind how we drag all the thumbs at once. We basically just dispatch
		 * a mouseDown evet to each of the thumbs, which makes the thumbs think they're
		 * being dragged. Woohoo! Magic!
		 * 
		 * Setting focusEnabled = false to each of the thumbs means that they all will show
		 * the focus skin, instead of the last thumb stealing the focus away from the others.
		 */
		private function highlight_mouseDownHandler(event:MouseEvent):void
		{
			var x:Number = event.stageX;
			var y:Number = event.stageY;
			
			draggingRegion = true;
			
			systemManager.addEventListener(MouseEvent.MOUSE_UP, regionDraggingStopped, false, 0, true);
			
			for(var i:int=0; i<thumbCount; i++) {
				var curThumb:SliderThumb = SliderThumb(thumbs.getChildAt(i));
				
				event.localX = curThumb.globalToLocal(new Point(x, y)).x;
				event.localY = curThumb.globalToLocal(new Point(x, y)).y;
			
				curThumb.focusEnabled = false;
				curThumb.dispatchEvent(event);
			}
		}
		
		private function regionDraggingStopped(event:MouseEvent):void {
			draggingRegion = false;
		}
		
		/**
		 * Changed to draw the track highlighting between the first thubm and the last thumb.
		 * Also draws the draggable region in the same area as an overlay.
		 * 
		 * <p>I think the original <code>drawTrackHighlight</code> function only drew the highlight
		 * correctly between the first and second thumbs. If you had three or more thumbs I think
		 * it screwed up (or at least didn't do what I wanted it to do). So instead now we
		 * figure out which thumb is first and which is last and draw the highlighting for that
		 * entire region. That's teh same region that we use for the draggable region.</p>
		 */
		override mx_internal function drawTrackHighlight():void
	    {
	       	var firstThumb:SliderThumb = SliderThumb(this.getThumbAt(0));
			var lastThumb:SliderThumb = firstThumb;
			
			// We loop through all the thumbs, by the end we have found the first and last
			for(var i:int=0; i<this.thumbCount; i++) {
				var curThumb:SliderThumb = SliderThumb(this.getThumbAt(i));
				
				if(curThumb.xPosition < firstThumb.xPosition) {
					firstThumb = curThumb;
				}
				
				if(curThumb.xPosition > lastThumb.xPosition) {
					lastThumb = curThumb;
				}
			}
			
			var xPos:Number = firstThumb.xPosition;
			var tWidth:Number = lastThumb.xPosition - firstThumb.xPosition;
			
			var fullThumbHeight:Number = firstThumb.getExplicitOrMeasuredHeight();
			var highlightSkinHeight:Number = fullThumbHeight - 2;
			
			if(highlightTrack) {
				highlightTrack.move(xPos, track.y - highlightTrack.height/2 + 2);
	            highlightTrack.setActualSize(tWidth > 0 ? tWidth : 0, highlightTrack.height);
			}

			// Here's where we define the draggable region
			if(highlightHitArea) {
		        var g:Graphics = highlightHitArea.graphics;
	
				g.clear();		
				g.beginFill(0xff0000,0);
				
				g.drawRect(xPos, 
						track.y + track.height/2 - highlightSkinHeight/2 , 
						tWidth > 0 ? tWidth : 0, 
						highlightSkinHeight);
					
				g.endFill();
			}
	    }
	    
	    /**
	    * Overridden to allow for multiple dataTips displayed at once.
	    * 
	    * <p>Instead of using one single instance of a SliderDataTip, now we can use as
	    * many as there are thumbs. So we can have one dataTip per thumb all displayed at once
	    * if we want. This is what we want if we're dragging the entire region.</p>
	    * 
	    * <p>This function is very similar to the <code>onThumbPress</code> function in the 
	    * original Slider class.</p>
	    */
	    override mx_internal function onThumbPress(thumb:Object):void
	    {
	    	// Here we jack up the counter, see the code for onThumbRelease to see how we use this
			counter++;
			
	        if (showDataTip)
	        {
	        	var dataTip:SliderDataTip = dataTips[thumb.thumbIndex];
	        	
	            if (!dataTip)
	            {
	                dataTip = SliderDataTip(new sliderDataTipClass());
	                dataTips[thumb.thumbIndex] = dataTip;
	                
	                systemManager.toolTipChildren.addChild(dataTip);
	
	                var dataTipStyleName:String = getStyle("dataTipStyleName");
	                if (dataTipStyleName)
	                {
	                    dataTip.styleName = dataTipStyleName;
	                }
	            }
	          
	
	            var formattedVal:String;
	            if (_dataTipFormatFunction != null)
	                formattedVal = this._dataTipFormatFunction(getValueFromX(thumb.xPosition));
	            else
	                formattedVal = dataFormatter.formatPrecision(String(getValueFromX(thumb.xPosition)),
	                                            getStyle("dataTipPrecision"));
	
	            dataTip.text = formattedVal;
	
	            //dataTip.text = String(getValueFromX(thumb.xPosition));
	
	            // Tool tip has been freshly created and new text assigned to it.
	            // Hence force a validation so that we can set the
	            // size required to show the text completely.
	            dataTip.validateNow();
	            dataTip.setActualSize(dataTip.getExplicitOrMeasuredWidth(),dataTip.getExplicitOrMeasuredHeight());
	            positionDataTip(thumb);
	        }
	        keyInteraction = false;
	
	        var event:SliderEvent = new SliderEvent(SliderEvent.THUMB_PRESS);
	        event.thumbIndex = thumb.thumbIndex;
	        dispatchEvent(event);
	    }
	    
	    /**
	    * Overridden to allow for multiple dataTips displayed at once.
	    * 
	    * <p>This function is very similar to the <code>onThumbMove</code> function in the 
	    * original Slider class.</p>
	    */
	    override mx_internal function onThumbMove(thumb:Object):void
	    {
	        var value:Number = getValueFromX(thumb.xPosition);
	        var dataTip:SliderDataTip = dataTips[thumb.thumbIndex];
	        
	        if (showDataTip)
	        {
	            dataTip.text = _dataTipFormatFunction != null ?
	                           _dataTipFormatFunction(value) :
	                           dataFormatter.formatPrecision(
	                               String(value), getStyle("dataTipPrecision"));
	            
	            dataTip.setActualSize(dataTip.getExplicitOrMeasuredWidth(),
	                                  dataTip.getExplicitOrMeasuredHeight());
	            
	            positionDataTip(thumb);
	        }

	        if (liveDragging)
	        {
	            interactionClickTarget = SliderEventClickTarget.THUMB;
	            setValueAt(value, thumb.thumbIndex);
	        }
	
	        var event:SliderEvent = new SliderEvent(SliderEvent.THUMB_DRAG);
	        event.thumbIndex = thumb.thumbIndex;
	        dispatchEvent(event);
	    }
	    
	    /**
	    * Overridden to allow for multiple dataTips displayed at once.
	    * 
	    * <p>This function is very similar to the <code>onThumbMove</code> function in the 
	    * original Slider class.</p>
	    */
	    override mx_internal function onThumbRelease(thumb:Object):void
	    {
	        var localDataTip:SliderDataTip = dataTips[thumb.thumbIndex];
	        if (localDataTip)
	        {
	        	systemManager.toolTipChildren.removeChild(localDataTip);
	         	
	            localDataTip = null;
	            dataTips[thumb.thumbIndex] = null;
	        }
	        
	        // Drop down the counter by one
	        counter--;
	        
	        interactionClickTarget = SliderEventClickTarget.THUMB;

	        var mythumb:SliderThumb = SliderThumb(thumbs.getChildAt(thumb.thumbIndex));
        	
        	// If the counter is zero that means that all thumbs have been
        	// released, so we're the last one that can trigger a change event.
        	// In that case we need to dispatch our events.
        	var dispatch:Boolean = (counter == 0);
        	
        	setValueAt(getValueFromX(mythumb.xPosition), thumb.thumbIndex, !dispatch);
	
	        if(dispatch) {
	        	var event:SliderEvent = new SliderEvent(SliderEvent.THUMB_RELEASE);
	        	event.thumbIndex = thumb.thumbIndex;
	        	dispatchEvent(event);
	        }
	    }
	    
	    /**
	    * Overridden to allow for multiple dataTips.
	    */
	    override protected function positionDataTip(thumb:Object):void
	    {
	    	var dataTip:SliderDataTip = dataTips[thumb.thumbIndex];
	        	
	        var relX:Number;
	        var relY:Number;
	
	        var tX:Number = thumb.x;
	        var tY:Number = thumb.y;
	
	        var tPlacement:String =  getStyle("dataTipPlacement");
	        var tOffset:Number = getStyle("dataTipOffset");

	        // Need to special case tooltip position because the tooltip movieclip
	        // resides in the root movie clip, instead of the Slider movieclip
	        if (_direction == SliderDirection.HORIZONTAL)
	        {
	            relX = tX;
	            relY = tY;
	
	            if (tPlacement == "left")
	            {
	                relX -= tOffset + dataTip.width;
	                relY += (thumb.height - dataTip.height) / 2;
	            }
	            else if (tPlacement == "right")
	            {
	                relX += tOffset + thumb.width;
	                relY += (thumb.height - dataTip.height) / 2;
	            }
	            else if (tPlacement == "top")
	            {
	                relY -= tOffset + dataTip.height;
	                relX -= (dataTip.width - thumb.width) / 2;
	            }
	            else if (tPlacement == "bottom")
	            {
	                relY += tOffset + thumb.height;
	                relX -= (dataTip.width - thumb.width) / 2;
	            }
	        }
	        else
	        {
	            relX = tY;
	            relY = unscaledHeight - tX - (dataTip.height + thumb.width) / 2;
	
	            if (tPlacement == "left")
	            {
	                relX -= tOffset + dataTip.width;
	            }
	            else if (tPlacement == "right")
	            {
	                relX += tOffset + thumb.height;
	            }
	            else if (tPlacement == "top")
	            {
	                relY -= tOffset + (dataTip.height + thumb.width) / 2;
	                relX -= (dataTip.width - thumb.height) / 2;
	            }
	            else if (tPlacement == "bottom")
	            {
	                relY += tOffset + (dataTip.height + thumb.width) / 2;
	                relX -= (dataTip.width - thumb.height) / 2;
	            }
	        }
	        
	        var o:Point = new Point(relX, relY);
	        var r:Point = localToGlobal(o);
	
	        dataTip.x = r.x < 0 ? 0 : r.x;
	        dataTip.y = r.y < 0 ? 0 : r.y;
	    }
	    
	    override mx_internal function getXBounds(selectedThumbIndex:int):Object {
	    	if(!draggingRegion || !lockRegionsWhileDragging) {
	    		return super.getXBounds(selectedThumbIndex);
	    	}
	    	else {
	    		var minThumbValue:Number;
		        var maxThumbValue:Number;
		        
		        for each(var value:Number in values) {
		        	if(isNaN(minThumbValue) || value < minThumbValue) {
		        		minThumbValue = value;
		        	}
		        	
		        	if(isNaN(maxThumbValue) || value > maxThumbValue) {
		        		maxThumbValue = value;
		        	}
		        }
		
			//	trace("values[0]=" + values[0] + " values[1]=" + values[1]);
		
				var minValue:Number = values[selectedThumbIndex] - minThumbValue + minimum;
				var maxValue:Number = maximum - (maxThumbValue - values[selectedThumbIndex]);
				
				var minX:Number = getXFromValue(minValue);
				var maxX:Number = getXFromValue(maxValue);
				
		//		trace("minX " + minX + " maxX " + maxX);
				
				return { min: minX, max: maxX };        
	    	}
	    }
	    
	    
		
	}
}