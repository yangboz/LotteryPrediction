package com.lookbackon.AI.artificalNeuralNetwork
{
	/**
	 * A Neuron is the basic building block of a Neural Network
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class Neuron
	{
//--------------------------------------------------------------------------
//
//  Constructor
//
//--------------------------------------------------------------------------
		public function Neuron(layer:int,index:int)
		{
			this.layer = layer;
			this.index = index;
		}
//--------------------------------------------------------------------------
//
//  Properties
//
//--------------------------------------------------------------------------
		//----------------------------------
		//  layer(native)
		//----------------------------------
		/// Internal storage for Neuron.Layer public property
		private var _layer:int;
		public function get layer():int
		{
			return _layer;
		}
		/// INPUT LAYER = 0, HIDDEN LAYER = 1, OUTPUT LAYER = 2
		public function set layer(value:int):void
		{
			_layer = value;
		}
		//----------------------------------
		//  index(native)
		//----------------------------------
		/// Internal storage for Neuron.Index public property
		private var _index:int;
		public function get index():int
		{
			return _index;
		}
		/// Identifies a Neuron or the position of a Neuron in a LAYER
		public function set index(value:int):void
		{
			_index = value;
		}
		//----------------------------------
		//  input(native)
		//----------------------------------
		/// Internal storage for Neuron.Input public property
		private var _input:int;
		public function get input():int
		{
			return _input;
		}
		/// Input data fed to the Neural Network
		public function set input(value:int):void
		{
			_input = value;
			if(this.layer==0)
			{
				this.output = this.input;
			}else
			{
				this.output = this.logisticFunction(this.input);
				//System.Diagnostics.Debug.WriteLine("Layer : " + this.player + " Input " + this.pinput + " Output " + this.poutput);
			}
		}
		//----------------------------------
		//  output(native)
		//----------------------------------
		/// Internal storage for Neuron.Output public property
		private var _output:int;
		public function get output():int
		{
			return _output;
		}
		/// Calculated Ouput from the INPUT, HIDDEN or OUTPUT LAYER
		public function set output(value:int):void
		{
			_output = value;
		}
		//----------------------------------
		//  outputTraning(native)
		//----------------------------------
		/// Internal storage for Neutron.OutputTraining public property
		private var _outputTraning:int;
		public function get outputTraning():int
		{
			return _outputTraning;
		}
		/// Expected or Target or Learning output for a neutron
		/// in the OUPUT LAYER
		public function set outputTraning(value:int):void
		{
			_outputTraning = value;
		}
		//----------------------------------
		//  weight(native)
		//----------------------------------
		/// Internal storage for Network.Weight public property
		protected var _weight:Array=[];
		/// Storage for array of weights from OUTPUT to
		/// HIDDEN LAYER and from HIDDENLAYER TO INPUT
		/// LAYER. Each Neuron in the OUTPUT and HIDDEN
		/// LAYER is connected to an array of Neurons
		public function get weight():Array
		{
			return _weight;
		}
		//----------------------------------
		//  bias(native)
		//----------------------------------
		/// Internal storage for Network.Bias public property
		private var _bias:Number;
		public function get bias():Number
		{
			return _bias;
		}
		/// Varies the OUTPUT of a Neuronin a HIDDEN or OUTPUT LAYER
		public function set bias(value:Number):void
		{
			_bias = value;
		}
		//----------------------------------
		//  error(native)
		//----------------------------------
		/// Internal storage for Network.Error public property
		private var _error:Number;
		public function get error():Number
		{
			return _error;
		}
		/// Error = (ACTUALOUTPUT * (1 - ACTUALOUTPUT) * (EXPECTEDOUTPUT - ACTUALOUTPUT))
		public function set error(value:Number):void
		{
			_error = value;
		}
//--------------------------------------------------------------------------
//
//  Methods:
//
//--------------------------------------------------------------------------
		//----------------------------------
		//  logisticFunction(native)
		//----------------------------------
		/// Sigmoid Function or Logistic Function or Activation Function
		/// is applied to the INPUT to a NETWORK LAYER to get an OUTPUT
		/// The value to calculate a Sigmoid or Logistic Function for
		/// System.Double datatype of the Logistic or Sigmoid Function result
		public function logisticFunction(val:Number):Number
		{
			var tempExp:uint = Math.exp(-val);
			trace("tempExp:",tempExp);
			var logisticFunctionResult:Number = 1.0 / (1.0 + tempExp );
			trace("logisticFunctionResult:",logisticFunctionResult);
			return logisticFunctionResult;
		}
		//------------------------------------
		//  logisticFunctionDerivative(native)
		//------------------------------------
		/// Derivative of the Sigmoid Function or Logistic Function or Activation Function
		/// The value to calculate the derivative of the Sigmoid Function for
		/// System.Double datatype of the numeric result
		public function logisticFunctionDerivative(val:Number):Number
		{
			return val * (1 - val);
		}
	}
}