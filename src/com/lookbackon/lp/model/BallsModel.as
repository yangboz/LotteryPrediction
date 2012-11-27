package com.lookbackon.lp.model
{
	import com.lookbackon.lp.model.vo.BallVO;
	
	import mx.collections.ArrayCollection;
	import mx.collections.XMLListCollection;

	//--------------------------------------------------------------------------
	//
	//  Imports
	//
	//--------------------------------------------------------------------------
	[Bindable]
	/**
	 * BallsModel.as class.   	
	 * @author yangboz
	 * @langVersion 3.0
	 * @playerVersion 9.0
	 * Created Dec 21, 2010 10:09:26 AM
	 */   	 
	public class BallsModel
	{		
		//--------------------------------------------------------------------------
		//
		//  Variables
		//
		//--------------------------------------------------------------------------
		//Singleton instance of BallsModel;
		private static var instance:BallsModel;
		//
		public var blues:Vector.<BallVO>;
		public var reds:Vector.<BallVO>;
		//
		public var lotteryData:XMLList = 
				new XMLList(
					new XML(
						<quotes>
								<quote date="8/27/2007" red="11" blue="6" />
								<quote date="8/24/2007" red="4" blue="6" />
								<quote date="8/23/2007" red="8" blue="6" />
								<quote date="8/22/2007" red="24" blue="6" />
								<quote date="8/21/2007" red="1" blue="6" />
								<quote date="8/20/2007" red="2" blue="6" />
								<quote date="8/17/2007" red="7" blue="6" />
								<quote date="8/27/2007" red="1" blue="16" />
								<quote date="8/24/2007" red="4" blue="16" />
								<quote date="8/23/2007" red="8" blue="16" />
								<quote date="8/22/2007" red="4" blue="16" />
								<quote date="8/21/2007" red="11" blue="16" />
								<quote date="8/20/2007" red="25" blue="16" />
								<quote date="8/16/2007" red="19" blue="3" />
								<quote date="8/15/2007" red="2" blue="3" />
								<quote date="8/14/2007" red="1" blue="3" />
								<quote date="8/13/2007" red="4" blue="3" />
								<quote date="8/9/2007" red="9" blue="3" />
								<quote date="8/8/2007" red="6" blue="3" />
								<quote date="8/7/2007" red="8" blue="24" />
								<quote date="8/6/2007" red="17" blue="24" />
								<quote date="8/3/2007" red="7" blue="24" />
								<quote date="8/2/2007" red="24" blue="24" />
								<quote date="8/1/2007" red="33" blue="24" />
								<quote date="8/2/2007" red="14" blue="24" />
								<quote date="8/16/2007" red="19" blue="13" />
								<quote date="8/15/2007" red="12" blue="13" />
								<quote date="8/14/2007" red="1" blue="13" />
								<quote date="8/13/2007" red="24" blue="13" />
								<quote date="8/10/2007" red="3" blue="13" />
								<quote date="8/9/2007" red="29" blue="13"/>
							</quotes>
						)
			);
		//for updating view
		public var lotteryQuoteData:XMLList;
		public var lotteryQuoteDataAC:ArrayCollection;
		//----------------------------------
		//  CONSTANTS
		//----------------------------------
		
		//--------------------------------------------------------------------------
		//
		//  Public properties
		//
		//-------------------------------------------------------------------------- 
		//For chart data slicer
//		public var quoteDataSlicer:Array=[{month:'june', sales:10, profit:5, cost:2}, {month:'july', sales:30, profit:10, cost:5}, {month:'aug', sales:20, profit:15, cost:5}];
		public function get quoteDataSlicer():Array
		{
			var result:Array = [];
			trace(lotteryQuoteData);
//			for(var i:int=0;i<lotteryQuoteData[i].@)
			return result;
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
		public function BallsModel(access:Private)
		{
			if (access != null) {
				if (instance == null) {
					instance=this;
				}
			} else {
				throw new Error("INITIALIZE_SINGLETON_CLASS");
			}
		}     	
		//--------------------------------------------------------------------------
		//
		//  Public methods
		//
		//--------------------------------------------------------------------------
		
		/**
		 *
		 * @return the singleton instance of BallsModel
		 *
		 */
		public static function getInstance():BallsModel 
		{
			if (instance == null) 
			{
				instance=new BallsModel(new Private());
			}
			return instance;
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
/**
 *Inner class which restricts construtor access to Private
 */
internal class Private 
{
}