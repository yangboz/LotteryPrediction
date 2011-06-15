package org.generalrelativity.thread.util
{
	import __AS3__.vec.Vector;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import org.generalrelativity.thread.GreenThread;
	import org.generalrelativity.thread.IRunnable;
	
	/**
	 * Offers a simple API for thread creation
	 * 
	 * @author Drew Cummins
	 * 
	 * @see GreenThread
	 * */
	public class ThreadUtil
	{
		
		
		/**
		 * Maps thread to requested callback
		 * */
		private static var threads:Dictionary = new Dictionary();
		
		
	
		/**
		 * Opens and returns a GreenThread. 
		 * 
		 * <p>Note that the first 4 arguments match those in a GreenThread's constructor. If
		 * a callback is supplied, it (Function) is called when the thread has completed. For
		 * other handlable Events, see <code>GreenThread</code>.</p>
		 * 
		 * @example The following opens a <code>GreenThread</code> via ThreadUtil.open
		 * 
		 * <listing version="3.0">
		 * 
		 * 		public function openThread() : void
		 * 		{
		 * 		
		 * 			//create processes
		 * 			var process1:IRunnable = new SomeProcess();
		 * 			var process2:IRunnable = new SomeOtherProcess();
		 * 
		 * 			//wrap them in an array to pass to the thread
		 * 			var processes:Vector.<IRunnable> = Vector.<IRunnable>( [ process1, process2 ] );
		 * 
		 * 			//creates and opens the thread, requesting onThreadComplete to be called on completion
		 * 			ThreadUtil.open( processes, stage.frameRate, 0.5, false, onThreadComplete );
		 * 
		 * 		}
		 * 
		 * 		public function onThreadComplete() : void
		 * 		{
		 * 			//both processes done!
		 * 		}
		 * 
		 * </listing>
		 * 
		 * @see #openSingle
		 * @see GreenThread
		 * */
		public static function open( 	processes:Vector.<IRunnable>, 
										hertz:int, 
										share:Number = 0.5, 
										isDiagnostic:Boolean = false,
										callback:Function = null 		) : GreenThread
		
		{
			
			var thread:GreenThread = new GreenThread( processes, hertz, share, isDiagnostic );
			
			//if a callback is requested, map the thread to the callback and listen for its completion
			if( callback != null )
			{
				threads[ thread ] = callback;
				thread.addEventListener( Event.COMPLETE, onThreadComplete );
			}
			
			thread.open();
			
			return thread;
			
		}
		
		
		
		/**
		 * Opens a single process in its own <code>GreenThread</code>
		 * 
		 * <p>This is just a helpful utility to get around verbose Vector instantiation.</p>
		 * 
		 * @example The following opens a single process in a <code>GreenThread</code>
		 * 
		 * <listing version="3.0">
		 * 
		 * 		public function openThread() : void
		 * 		{
		 * 		
		 * 			//create process
		 * 			var process:IRunnable = new SomeProcess();
		 * 			
		 * 			//creates and opens the thread, requesting onThreadComplete to be called on completion
		 * 			ThreadUtil.openSingle( process, stage.frameRate, 0.5, false, onThreadComplete );
		 * 
		 * 		}
		 * 
		 * 		public function onThreadComplete() : void
		 * 		{
		 * 			//process done!
		 * 		}
		 * 
		 * </listing>
		 * 
		 * @see #open
		 * @see GreenThread
		 * */
		public static function openSingle( 	process:IRunnable, 
											hertz:int, 
											share:Number = 0.5, 
											isDiagnostic:Boolean = false,
											callback:Function = null 		) : GreenThread
											
		{
			return ThreadUtil.open( Vector.<IRunnable>( [ process ] ), hertz, share, isDiagnostic, callback );
		}
		
		
		
		/**
		 * Handles a thread's completion.
		 * 
		 * <p>The completed thread will map to a requested callback, which is executed.</p>
		 * */
		private static function onThreadComplete( event:Event ) : void
		{
			
			var thread:GreenThread = GreenThread( event.target );
			var callback:Function = threads[ thread ];
			
			threads[ thread ] = null;
			thread.removeEventListener( Event.COMPLETE, onThreadComplete );
			
			callback();
			
		}
		
		

	}
}