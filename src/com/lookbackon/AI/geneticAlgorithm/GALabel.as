package com.lookbackon.AI.geneticAlgorithm
{
	import com.lookbackon.lp.Constants;
	import com.lookbackon.lp.model.vo.BallVO;
	import com.lookbackon.utils.MathUtil;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.core.FlexGlobals;
	import mx.events.FlexEvent;
	
	import org.generalrelativity.thread.process.AbstractProcess;
	
	import spark.components.Label;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	
	/**
	 * GeneticAlgorthemLabel.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 20, 2010 5:39:53 PM
	 */   	 
	public class GALabel extends Label
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		private var dna:DNA=new DNA();
		private var mutatedDNA:DNA;
		private var reRenderDNA:Boolean=true;
		private var dnaFitness:int = 0;
		private var mutatedFitness:int = 0;
		private var targetBallNumber:int;
		//
		private var variety:uint;
//		[Bindable]
		public var number:int;
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
		public function GALabel(variety:uint)
		{
			this.variety = variety;
			//
			for(var i:int=0;i<1;i++)
			{
				this.dna.push(new BallVO(variety));
			}
			this.addEventListener(FlexEvent.CREATION_COMPLETE,function():void
			{
				addEventListener(Event.ENTER_FRAME,cycle);
			});
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
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
		
		private function cycle(event:Event):void
		{
			if (mx.core.FlexGlobals.topLevelApplication.isRunning)
			{
				render();
				fitnessFunction();
			}
		}
		
		private function render():void
		{
			var ball:BallVO;
			
			if (reRenderDNA)
			{
				this.text = "0";
				for each (ball in dna)
				{
					this.text = ball.number.toString();
					this.setStyle("color", "yellow");
				}
			}
			mutatedDNA=dna.mutate();
			for each (ball in mutatedDNA)
			{
				this.text = ball.number.toString();
			}
		}
		
		private function fitnessFunction():void
		{
			var dnaNumber:int;
			var mutatedNumber:Number;
			//
			if (reRenderDNA)
			{
//				if(this.variety==Constants.VARIETY_BLUE)
//				{
//					dnaNumber =  MathUtil.transactDiffRandomNumberInRange(1,16);
//				}else
//				{
//					dnaNumber =  MathUtil.transactDiffRandomNumberInRange(1,33);
//				}
				dnaNumber = dna[0].number;
				dnaFitness=0;
			}
			//
//			if(this.variety==Constants.VARIETY_BLUE)
//			{
//				mutatedNumber =  MathUtil.transactDiffRandomNumberInRange(1,16);
//			}else
//			{
//				mutatedNumber =  MathUtil.transactDiffRandomNumberInRange(1,33);
//			}
			mutatedNumber = mutatedDNA[0].number;
			mutatedFitness=0;
			//
			targetBallNumber=this.number;
			if (reRenderDNA)
			{
				dnaFitness = -Math.abs(targetBallNumber - dnaNumber);
			}
			mutatedFitness = -Math.abs(targetBallNumber - mutatedNumber);
			
//			if (reRenderDNA)
//			{
//				dnaNumber=0;
//			}
//			mutatedNumber=0;
			
			if (mutatedFitness > dnaFitness)
			{
				dna=mutatedDNA.clone();
				mutatedDNA=null;
				reRenderDNA=true;
			}
			else
			{
				if (reRenderDNA)
				{
					this.setStyle("color", "black");
//					dnaNumber=0;
//					mutatedNumber=0;
				}
				if(dnaNumber==this.number)
				{
					reRenderDNA=false;
					this.text = dnaNumber.toString();
					this.setStyle("color", "red");
					//
					removeEventListener(Event.ENTER_FRAME,cycle);
				}
			}
		}

	}
	
}