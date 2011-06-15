package org.generalrelativity.thread.event
{
	import flash.events.Event;
	import org.generalrelativity.thread.IRunnable;

	/**
	 * Carries an instance of IRunnable to handle process specific Events related
	 * to the running GreenThread.
	 * 
	 * @author Drew Cummins
	 * 
	 * @see IRunnable
	 * @see GreenThread.onCycle
	 * */
	public class GreenThreadEvent extends Event
	{
		
		public static const PROCESS_COMPLETE:String = "processComplete";
		public static const PROCESS_TIMEOUT:String = "processTimeout";
				
		public var process:IRunnable;
		
		public function GreenThreadEvent( type:String, process:IRunnable, bubbles:Boolean = false, cancelable:Boolean = false )
		{
			
			this.process = process;
			
			super( type, bubbles, cancelable );
			
		}
		
		override public function clone() : Event
		{
			return new GreenThreadEvent( type, process, bubbles, cancelable );
		}
		
	}
}