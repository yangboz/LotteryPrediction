package org.generalrelativity.thread.diagnostic
{
	import __AS3__.vec.Vector;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	import org.generalrelativity.thread.IRunnable;
	
	
	/**
	 * Wraps all ProcessDiagnostics
	 * 
	 * @author Drew Cummins
	 * 
	 * @see GreenThread.diagnostic
	 * @see ProcessDiagnostic
	 * */
	public class GreenThreadDiagnostic extends ProcessDiagnostic
	{
		
		private var processDiagnosticMap:Dictionary;
		
		public function GreenThreadDiagnostic( processes:Vector.<IRunnable> )
		{
			
			super();
			
			processDiagnosticMap = new Dictionary( true );
			for each( var process:IRunnable in processes )
			{
				var pd:ProcessDiagnostic = new ProcessDiagnostic();
				pd.process = process;
				processDiagnosticMap[ process ] = pd;
			}
			
		}
		
		public function recordPreProcessCycle( process:IRunnable ) : void
		{
			var diagnostic:ProcessDiagnostic = ProcessDiagnostic( processDiagnosticMap[ process ] );
			diagnostic.recordPreCycle();
		}
		
		public function recordProcessCycle( process:IRunnable, allocation:int ) : void
		{
			var diagnostic:ProcessDiagnostic = ProcessDiagnostic( processDiagnosticMap[ process ] );
			diagnostic.recordCycle( allocation );
		}
		
		public function getProcessDiagnostic( process:IRunnable ) : ProcessDiagnostic
		{
			return processDiagnosticMap[ process ];
		}

	}
}