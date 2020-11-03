package org.generalrelativity.thread
{
	import __AS3__.vec.Vector;
	
	import flash.errors.ScriptTimeoutError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import org.generalrelativity.thread.diagnostic.GreenThreadDiagnostic;
	import org.generalrelativity.thread.event.GreenThreadEvent;
	
	
	/**
	 * Dispatched when the thread has successfully executed all requested processes
	 * 
	 * @eventType flash.event.Event.COMPLETE
	 * */
	[Event(name="complete", type="flash.events.Event")]
	
	
	/**
	 * Dispatched when the thread has completed a cycle
	 * 
	 * @eventType GreenThread.CYCLE
	 * */
	[Event(name="cycle", type="GreenThread")]
	
	
	/**
	 * Dispatched whenever a process has completed executing
	 * 
	 * @eventType org.generalrelativity.thread.event.GreenThreadEvent.PROCESS_COMPLETE
	 * */
	[Event(name="processComplete", type="org.generalrelativity.thread.event.GreenThreadEvent")]
	
	
	/**
	 * Dispatched whenever a process has thrown a script timeout exception
	 * 
	 * @eventType org.generalrelativity.thread.event.GreenThreadEvent.PROCESS_TIMEOUT
	 * */
	[Event(name="processTimeout", type="org.generalrelativity.thread.event.GreenThreadEvent")]


	/**
	 * User-space thread emulator that manages a list of processes and considers 
	 * requested frequencies and allocation constraints.
	 * 
	 * @see http://en.wikipedia.org/wiki/Green_threads
	 * 
	 * @example The following utilizes a <code>GreenThread</code>
	 * 
	 * <listing version="3.0">
	 * 
	 * 		//create the processes to execute
	 * 		var process1:IRunnable = new SomeProcess();
	 * 		var process2:IRunnable = new SomeOtherProcess();
	 * 
	 * 		//wrap them in an array to pass to the thread
	 * 		var processes:Vector.<IRunnable> = Vector.<IRunnable>( [ process1, process2 ] );
	 * 
	 * 		//define frequency
	 * 		var hertz:Number = stage.frameRate;
	 * 
	 * 		//allow the thread to occupy whatever percentage of player's processing
	 * 		var share:Number = 0.3;
	 * 
	 * 		//create the thread
	 * 		var thread:GreenThread = new GreenThread( processes, hertz, share );
	 * 
	 * 		//listen for process and thread complete events
	 * 		thread.addEventListener( GreenThreadEvent.PROCESS_COMPLETE, processCompleteHandler );
	 * 		thread.addEventListener( Event.COMPLETE, threadCompleteHandler );
	 * 
	 * 		//open the thread
	 * 		thread.open();
	 * 
	 * </listing>
	 * 
	 * @author Drew Cummins
	 * @since 11.12.08
	 * 
	 * @see IRunnable
	 * @see GreenThreadDiagnostic
	 * */	
	final public class GreenThread extends EventDispatcher
	{
		
		
		public static const CYCLE:String = "cycle";
		
		/**
		 * Minimum contribution- will have to tweak this based on testing
		 * */
		public static const EPSILON:int = 1;
		
		
		/**
		 * List of all processes being run 
		 * */
		private var processes:Vector.<IRunnable>;
		
		/** 
		 * GreenThread runs off of <code>Timer</code> 
		 * */
		private var runner:Timer;
		
		/**
		 * Thread's allocation, in milliseconds, per execution
		 * */
		private var totalAllocation:int;
		
		/**
		 * Number of open processes
		 * */
		private var n:int;
				
		/**
		 * Flags whether diagnostics are recorded
		 * */
		private var isDiagnostic:Boolean;
		
		/**
		 * Error term to correct missed targets
		 * */
		private var errorTerm:int;
		
		/**
		 * Performance diagnostic
		 * */
		private var _diagnostic:GreenThreadDiagnostic;
		
		
		
		/**
		 * Constructor
		 * 
		 * <p>Creates a new GreenThread. If <code>isDiagnostic</code> is set to true, a diagnostic is performed
		 * during thread execution.</p>
		 * 
		 * @param processes 	Sets <code>processes</code>
		 * @param hertz 		Frequency at which thread is executed
		 * @param share			Percentage of VM processor that this thread should occupy
		 * @param isDiagnostic	Sets diagnostic mode
		 * 
		 * @throws Error if no processes are passed
		 * */
		public function GreenThread( processes:Vector.<IRunnable>, hertz:int, share:Number = 0.5, isDiagnostic:Boolean = false )
		{
			
			super();
			
			//make a copy- processes are removed on completion
			this.processes = processes.slice();
			
			n = processes.length;
			
			//throw an error if there aren't any processes to run
			if( n == 0 )
			{
				throw new Error( "no processes passed to thread" );
			}
			
			//solve for milliseconds
			//	hz = x / s
			//
			//	s = 1 / hz
			//	ms = s * 1000
			//	ms = 1000 / hz
			var milliseconds:int = 1000 / hertz;
			totalAllocation = milliseconds * share + 1;
			
			//ensure we're accounting for a minimum execution time per process
			//TODO: this should handle an impossible work load by pushing excess into a queue
			var perProcess:int = totalAllocation / n;
			if( perProcess < GreenThread.EPSILON )
			{
				totalAllocation = GreenThread.EPSILON * n;
			}
			
			if( isDiagnostic )
			{
				this.isDiagnostic = true;
				_diagnostic = new GreenThreadDiagnostic( processes );
			} 
			
			runner = new Timer( milliseconds );
			runner.addEventListener( TimerEvent.TIMER, onCycle );
			
		}
		
		
		
		/**
		 * Removes a process from the list, if actually in list
		 * */
		public function removeProcess( process:IRunnable ) : void
		{
			var processIndex:int = processes.indexOf( process );
			if( processIndex > -1 )
			{
				processes.splice( processIndex, 1 );
				n = processes.length;
			}
		}
		
		
		/**
		 * Determines whether the thread is open based on the existence of runner and processes
		 * */
		public function get isOpen() : Boolean
		{
			return runner && processes;
		}
		
		
		public function get isRunning() : Boolean
		{
			return isOpen && runner.running;
		}
		
		/**
		 * Gets this thread's diagnostic, if any
		 * */
		public function get diagnostic() : GreenThreadDiagnostic
		{
			return _diagnostic;
		}
		
		
		/**
		 * Opens the thread
		 * 
		 * <p>This is called to first open, and to reopen after forcing the thread to yield</p>
		 * 
		 * @see yield
		 * @see close
		 * */
		public function open() : void
		{
			
			if( isOpen && !runner.running )
			{
				errorTerm = 0;
				runner.start();	
			}
			
		}
		
		
		
		/**
		 * Forces the thread to yield
		 * */
		public function yield() : void
		{
			
			if( isOpen )
			{
				runner.stop();
			}
			
		}
		
		
		
		/**
		 * Closes the thread and readies itself for garbage collection
		 * 
		 * @param terminateProcesses Flags whether to explicitly terminate all open processes
		 * 
		 * @returns the diagnostic (null if isn't diagnostic) after nulling its reference
		 * */
		public function close( terminateProcesses:Boolean = true ) : GreenThreadDiagnostic
		{
			
			if( runner )
			{
				
				runner.stop();
				runner.removeEventListener( TimerEvent.TIMER, onCycle );
				
				runner = null;
				
			}
			
			if( processes && terminateProcesses )
			{
				
				for each( var process:IRunnable in processes )
				{
					process.terminate();
				}
				
			}
			
			processes = null;
			
			//copy to local reference before clearing instance reference
			var diagnosis:GreenThreadDiagnostic = _diagnostic;
			_diagnostic = null;
						
			return diagnosis;
			
		}
		
		
		/**
		 * Executes all open processes. If/when a process completes, the process is
		 * removed from the open list, and the process complete event is dispatched.
		 * At this point, the finished process' allocation is released and disperesed
		 * amongst all remaining open processes.
		 * 
		 * <p>The thread tries to maintain the player framerate by adhering to the
		 * user-defined frequency and allocation-share. An error term is introduced
		 * to account for deviation.</p>
		 * 
		 * @see open
		 * @see GreenThreadDiagnostic
		 * @see IRunnable
		 * */
		private function onCycle( event:TimerEvent ) : void
		{
			
			//if the error term is too large, skip a cycle
			if( errorTerm > totalAllocation - 1 )
			{
				errorTerm = 0;
				if( isDiagnostic ) _diagnostic.recordError();
				return;
			}
			
			//record cycle start time
			var cycleStart:int = getTimer();
			
			if( isDiagnostic ) _diagnostic.recordPreCycle();
			
			//define the allocation for the entire cycle, and account for error
			var cycleAllocation:int = totalAllocation - errorTerm;
			
			//each process gets an equal share
			var processAllocation:int = cycleAllocation / n;			
			
			
			//decrement for easy removal of processes from list
			for( var i:int = n - 1; i > -1; i-- )
			{
				
				var process:IRunnable = processes[ i ];
				
				//record pre process time
				if( isDiagnostic ) _diagnostic.recordPreProcessCycle( process );
				
				
				//handle any ScriptTimeoutErrors
				try
				{
				
					//if the process is self managing, pass its allocation
					if( process.isSelfManaging ) 
					{
						process.runAndManage( processAllocation );
					}
					else
					{
						
						var processStart:int = getTimer();
						
						//call run until process is complete or its share of the thread's allocation has expired
						while( getTimer() - processStart < processAllocation && process.percentage < 1.0 )
						{
							process.run();
						} 
						
					}
					
				}
				catch( error:ScriptTimeoutError )
				{
					if( isDiagnostic ) _diagnostic.recordError();
					dispatchEvent( new GreenThreadEvent( GreenThreadEvent.PROCESS_TIMEOUT, process ) );
				}
				
				
				//record post process time
				if( isDiagnostic ) _diagnostic.recordProcessCycle( process, processAllocation );
			
				if( process.percentage >= 1.0 ) 
				{
					
					dispatchEvent( new GreenThreadEvent( GreenThreadEvent.PROCESS_COMPLETE, process ) );
					
					//do any cleanup
					process.terminate();
					processes.splice( i, 1 );
					
					if( --n > 0 )
					{
						//open up more allocation to remaining processes
						processAllocation = cycleAllocation / n;
					}
					else
					{
						
						dispatchEvent( new Event( Event.COMPLETE ) );
						
						processes = null;
						
						runner.stop();
						runner.removeEventListener( TimerEvent.TIMER, onCycle );
						
						runner = null;
						
						break;
						
					}
					
				}
				
			}
			
			//record end cycle time
			if( isDiagnostic ) _diagnostic.recordCycle( totalAllocation );
			
			//solve for cycle time
			var cycleTime:int = getTimer() - cycleStart;
			var delta:Number = cycleTime - totalAllocation;
			
			//update the error term
			errorTerm = ( errorTerm + delta ) >> 1;
			
			dispatchEvent( new Event( GreenThread.CYCLE ) );
			
		}
		
		
		
		
		
	}
	
	
	
	
	
	
	
}