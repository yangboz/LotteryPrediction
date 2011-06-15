package org.generalrelativity.thread
{
	
	public interface IRunnable
	{
		
		/**
		 * Runs the smallest chunk of the process
		 * */
		function run() : void;
		
		/**
		 * Runs and manages the process over the given allocation
		 * */
		function runAndManage( allocation:int ) : void;
		
		/**
		 * Terminates the process
		 * */
		function terminate() : void;
		
		/**
		 * Returns the percentage completion
		 * */
		function get percentage() : Number;
		
		/**
		 * Determines whether the process is self managing or not. If it
		 * is, runAndManage gets called by the thread, otherwise, run is
		 * called.
		 * */
		function get isSelfManaging() : Boolean;
		function set isSelfManaging( value:Boolean ) : void;
		
	}
	
}