package com.lookbackon.lp.model.vo
{
	import com.lookbackon.lp.Constants;
	import com.lookbackon.utils.MathUtil;
	
	import mx.core.FlexGlobals;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------

	/**
	 * BallVarietyVO.as class.Summarize the variety of ball type.
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 20, 2010 11:53:31 AM
	 */
	public class BallVO
	{
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		public var number:int;
		
		private var min:int=1;
		private var max:int;
		
		private var _variety:uint;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------

		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		public function get variety():uint
		{
			return _variety;
		}

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
		public function BallVO(variety:uint)
		{
			//
			this._variety = variety;
			if(this._variety==Constants.VARIETY_BLUE)
			{
				this.max = 16;
				this.number = MathUtil.transactRandomNumberInRange(min, max);
			}else
			{
				this.max = 33;
				//
				this.number = MathUtil.transactDiffRandomNumberInRange(min, max);
			}
		}

		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		public function mutate():void
		{
			if(Math.random()>mx.core.FlexGlobals.topLevelApplication.mutationProability)
			{
				if(this.variety==Constants.VARIETY_BLUE)
				{
					while(!(this.number in MathUtil.returnedResult))
					{
						this.number = MathUtil.transactRandomNumberInRange(min, max);
					}
				}else
				{
					MathUtil.returnedResult = [];
					//
					this.number = MathUtil.transactRandomNumberInRange(min, max);
				}
				
			}
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