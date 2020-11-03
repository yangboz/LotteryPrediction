package org.generalrelativity.thread.process
{
	
	import flash.utils.getQualifiedClassName;
	
	import org.generalrelativity.thread.IRunnable;


	/**
	 * Offers an abstract implementation of <code>IRunnable</code>
	 * 
	 * @author Drew Cummins
	 * 
	 * @see IRunnable
	 * */
	public class AbstractProcess implements IRunnable
	{
		
		protected var _isSelfManaging:Boolean;
		
		
		public function AbstractProcess( isSelfManaging:Boolean = false )
		{
			
			if( getQualifiedClassName( this ).indexOf( "::AbstractProcess" ) > -1 )
			{
				throw new Error( "Cannot directly instantiate Abstract class AbstractProcess" );
			}
			
			_isSelfManaging = isSelfManaging;
			
		}
		
		
		public function run() : void
		{
			//abstract
		}

		public function runAndManage( allocation:int ) : void
		{
			//abstract
		}
		
		public function yield() : void
		{
			//abstract
		}
		
		public function terminate():void
		{
			//abstract
		}
		
		public function get percentage() : Number
		{
			//abstract
			return NaN;
		}
		
		//enforce a strict interface constraint- really just a property
		final public function get isSelfManaging() : Boolean
		{
			return _isSelfManaging;
		}
		
		final public function set isSelfManaging( value:Boolean ) : void
		{
			_isSelfManaging = value;
		}
		
	}
}