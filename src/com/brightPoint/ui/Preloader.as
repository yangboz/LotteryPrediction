package com.brightPoint.ui
{
    import mx.preloaders.DownloadProgressBar;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.events.ProgressEvent;
    import flash.events.Event;
    import mx.events.FlexEvent;

    /**
     * This class extends the lightweight DownloadProgressBar class.  This class
     * uses an embedded Flash 8 MovieClip symbol to show preloading.
     * 
     * 
     * 
     */    
    public class Preloader extends DownloadProgressBar
    {
        
        /**
        * The Flash 8 MovieClip embedded as a Class.
        */        
        [Embed(source="../assets/preloader.swf", symbol="Preloader")]
        private var FlashPreloaderSymbol:Class;
        
        private var clip:MovieClip;
        
        public function Preloader()
        {
            super();
            
            // instantiate the Flash MovieClip, show it, and stop it.
            // Remember, AS2 is removed when you embed SWF's, 
            // even "stop();", so you have to call it manually if you embed.
            clip = new FlashPreloaderSymbol();
            addChild(clip);
            clip.gotoAndStop("start");
        }
        
        public override function set preloader(preloader:Sprite):void 
        {                   
            preloader.addEventListener( ProgressEvent.PROGRESS ,     onSWFDownloadProgress );    
            preloader.addEventListener( Event.COMPLETE ,             onSWFDownloadComplete );
            preloader.addEventListener( FlexEvent.INIT_PROGRESS ,     onFlexInitProgress );
            preloader.addEventListener( FlexEvent.INIT_COMPLETE ,     onFlexInitComplete );
            
            centerPreloader();
        }
        
        /**
         * Makes sure that the preloader is centered in the center of the app.
         * 
         */        
        private function centerPreloader():void
        {
            x = (stageWidth / 2) - (clip.width / 2);
            y = (stageHeight / 2) - (clip.height / 2);
        }
        
        /**
         * As the SWF (frame 2 usually) downloads, this event gets called.
         * You can use the values from this event to update your preloader.
         * @param event
         * 
         */        
        private function onSWFDownloadProgress( event:ProgressEvent ):void
        {
            var t:Number = event.bytesTotal;
            var l:Number = event.bytesLoaded;
            var p:Number = Math.round( (l / t) * 100);
            clip.preloader.gotoAndStop(p);
            clip.preloader.amount_txt.text = String(p) + "%";
        }
        
        /**
         * When the download of frame 2
         * is complete, this event is called.  
         * This is called before the initializing is done.
         * @param event
         * 
         */        
        private function onSWFDownloadComplete( event:Event ):void
        {
               clip.preloader.gotoAndStop(100);
            clip.preloader.amount_txt.text = "100%";
        }
        
        /**
         * When Flex starts initilizating your application.
         * @param event
         * 
         */        
        private function onFlexInitProgress( event:FlexEvent ):void
        {
        	if (!clip.preloader) return;
            clip.preloader.gotoAndStop(100);
            clip.preloader.amount_txt.text = "Initializing...";
        }
        
        /**
         * When Flex is done initializing, and ready to run your app,
         * this function is called.
         * 
         * You're supposed to dispatch a complete event when you are done.
         * I chose not to do this immediately, and instead fade out the 
         * preloader in the MovieClip.  As soon as that is done,
         * I then dispatch the event.  This gives time for the preloader
         * to finish it's animation.
         * @param event
         * 
         */        
        private function onFlexInitComplete( event:FlexEvent ):void 
        {
            clip.addFrameScript(21, onDoneAnimating);
            clip.gotoAndPlay("fade out");
        }
        
        /**
         * If the Flash MovieClip is done playing it's animation,
         * I stop it and dispatch my event letting Flex know I'm done.
         * @param event
         * 
         */        
        private function onDoneAnimating():void
        {
            clip.stop();
            dispatchEvent( new Event( Event.COMPLETE ) );
        }
        
    }
}

