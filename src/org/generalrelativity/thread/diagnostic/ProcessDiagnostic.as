package org.generalrelativity.thread.diagnostic
{
	import __AS3__.vec.Vector;
	
	import flash.utils.getTimer;
	
	import org.generalrelativity.thread.IRunnable;
	
	
	/**
	 * Offers some simple means of diagnosing overall performance of 
	 * an IRunnable instance.
	 * 
	 * @author Drew Cummins
	 * */
	public class ProcessDiagnostic
	{
		
		public var numCycles:int;
		public var numErrors:int;
		
		public var totalTime:int;
		
		public var times:Vector.<Number>;
		public var allocationDifferentials:Vector.<Number>;
		
		private var currentCycleStart:int;
		
		public var process:IRunnable;
		
		public function ProcessDiagnostic()
		{
			times = new Vector.<Number>();
			allocationDifferentials = new Vector.<Number>();
		}
		
		public function recordPreCycle() : void
		{
			currentCycleStart = getTimer();
		}
		
		public function recordCycle( allocation:int ) : void
		{
			
			var time:Number = getTimer() - currentCycleStart;
			
			totalTime += time;
			
			times[ numCycles ] = time;
			allocationDifferentials[ numCycles ] = time - allocation;
			
			numCycles++;
			
		}
		
		public function recordError() : void
		{
			//TODO: Build this out
			numErrors++;
		}
		
		public function get meanTime() : Number
		{
			return totalTime / numCycles; 
		}
		
		public function get averageDifferential() : Number
		{
			
			var sum:int = 0;
			
			for each( var differential:int in allocationDifferentials )
			{
				sum += differential;
			}
			
			return sum / numCycles;
			
		}
		
		public function get peak() : int 
		{
			
			var max:int = 0;
			
			for each( var time:int in times )
			{
				if( time > max ) max = time;
			}
			
			return max;
			
		}
		
		public function get valley() : int
		{
			
			var min:int = Number.MAX_VALUE;
			
			for each( var time:int in times )
			{
				if( time < min ) min = time;
			}
			
			return min;
			
		}

	}
}