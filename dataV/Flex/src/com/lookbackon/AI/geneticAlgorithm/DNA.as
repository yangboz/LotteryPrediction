package com.lookbackon.AI.geneticAlgorithm
{
	import com.lookbackon.lp.model.vo.BallVO;
	import com.lookbackon.utils.MathUtil;
	
	import mx.core.FlexGlobals;
	
	import spark.components.Application;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * DNA.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 20, 2010 4:59:59 PM
	 */   	 
    dynamic	public class DNA extends Array
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Protected properties
		//
		//-------------------------------------------------------------------------- 
		
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		public function DNA(numElements:int=0)
		{
			//TODO: implement function
			super(numElements);
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function mutate():DNA
		{
			var mutatedDNA:DNA = new DNA();
			var newBall:BallVO;
			
			for each (var ball:BallVO in this)
			{
				newBall = new BallVO(ball.variety);
				//
				if (Math.random() > FlexGlobals.topLevelApplication.mutationProability)
				{
					newBall.mutate();
				}
				mutatedDNA.push(newBall);
			}
			
			return mutatedDNA;

		}
		
		public function clone():DNA
		{
			var newDNA:DNA = new DNA();
			var newBall:BallVO;
			
			for each (var ball:BallVO in this)
			{
				newBall = new BallVO(ball.variety);
				newDNA.push(newBall);
			}
			
			return newDNA;
		}
		//--------------------------------------------------------------------------
		//
		//  Protected methods
		//
		//--------------------------------------------------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Private methods
		//
		//--------------------------------------------------------------------------
	}
	
}