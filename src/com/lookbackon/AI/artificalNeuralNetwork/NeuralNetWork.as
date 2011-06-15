package com.lookbackon.AI.artificalNeuralNetwork
{
	import mx.collections.ArrayCollection;

	public class NeuralNetWork
	{
//--------------------------------------------------------------------------
//
//  Variables
//
//--------------------------------------------------------------------------		
		/// Static variable for random numbers
		static private var random:Number = 0.5;
		/// Static variable for number of neurons or cells in INPUT LAYER
		static private var input_count:int = 3;
		/// Static variable for number of neurons or cells in HIDDEN LAYER
		static private var hidden_count:int = 2;
		/// Static variable for number of neurons or cells in OUTPUT LAYER
		static private var output_count:int = 1;
		/// Static variable for the number of processing cycles of the Neural Network
		static public var iterations:int = 5;
		/// Represents the LEARNING RATE used in gradient descent to
		/// prevent weights from converging at sub-optimal solutions.
		public var learning_rate:Number = 0.8;
		/// A two dimensional array of input data from a training sample
		/// An INPUT represented as double [,] inputDataArray = new Double [,]
		/// {{0.20, 0.80}, {0.80, 0.4}} would represent 2 training instances
		/// for an INPUT LAYER with 2 NEURONS or CELLS
		public var input_data:ArrayCollection;
		/// A two dimensional array of output data from a training sample
		/// An OUTPUT represented as double [,] outputDataArray = new Double [,]
		/// {{0}, {1}} would represent 2 training instances
		/// for an OUTPUT LAYER with 1 NEURON or CELL
		public var output_data:ArrayCollection;
		/// A collection of neurons representing the input layer
		private var inputNeurons:Neurons;
		/// A collection of neurons representing the hidden layer
		private var hiddenNeurons:Neurons;
		/// A collection of neurons representing the output layer
		public var outputNeurons:Neurons;
		
//--------------------------------------------------------------------------
//
//  Constructor
//
//--------------------------------------------------------------------------		
		public function NeuralNetWork()
		{
		}
//--------------------------------------------------------------------------
//
//  Properties
//
//--------------------------------------------------------------------------		
//--------------------------------------------------------------------------
//
//  Methods
//
//--------------------------------------------------------------------------
		/// Initializes the LAYERS in the NEURAL NETWORK
		/// INPUTS data for the NEURONS in the INPUT LAYER
		/// OUTPUT data for the NEURONS in the OUTPUT LAYER
		/// The number of neurons in the HIDDEN LAYER
		//----------------------------------
		//  initialize(native)
		//----------------------------------
		public function initialize(inputData:ArrayCollection,outputData:ArrayCollection,hidden_layer_count:int):void
		{
			this.input_data = inputData;
			input_count = (this.input_data.length+1);//
			
			hidden_count = hidden_layer_count;
			
			this.output_data = outputData;//
			output_count = this.output_data.length+1;
			
			inputNeurons = new Neurons();
			for(var i:int=0;i<input_count;i++)
			{
				var a:Neuron = new Neuron(0,i);
				inputNeurons.add(a);
			}
			
			hiddenNeurons = new Neurons();
			for(var j:int=0;j<hidden_count;j++)
			{
				var b:Neuron = new Neuron(1,j);
				hiddenNeurons.add(b);
			}
			
			outputNeurons = new Neurons();
			for(var k:int=0;k<output_count;k++)
			{
				var c:Neuron = new Neuron(2,k);
				outputNeurons.add(c);
			}
		}
		//----------------------------------
		//  feedForward(native)
		//----------------------------------
		/// Initializes the NEURAL NETWORK with training data input
		/// or a real world data input for classification.
		/// FeedForward feeds the INPUT to the INPUT LAYER neurons
		/// FeedForward feeds the OUTPUT from the INPUT LAYER to the HIDDEN LAYER
		/// FeedForward feeds the OUTPUT from the HIDDEN LAYER to the OUTPUT LAYER
		/// FeedForward uses the Sigmoid Function or Logistic Function to calculate
		/// the OUTPUT from the INPUT in the HIDDEN and OUTPUT LAYERS
		
		/// A numeric ordered value representing the training or
		/// classification instance. If the dataset contains 10
		/// instances or rows, the first row has a sampleNumber = 0
		/// and the last row or instance has a sample number = 9
		public function feedForward(sampleNumer:int):void
		{
			var total:Number;
			var ch:Neuron = null;
			var ci:Neuron = null;
			var co:Neuron = null;
			//feed the input data to the input Neurons layer
			trace("input_data.length:",input_data.length);
			for(var i:int=0;i<inputNeurons.length;i++)
			{
				ci = inputNeurons.gett(i);
				ci.input = this.input_data.getItemAt(sampleNumer)[i];
			}
			//feedforward from input to hidden Neurons
			for(var h:int=0;h<hiddenNeurons.length;h++)
			{
				total = 0.0;
				ch = hiddenNeurons[h];
				for(var j:int=0;j<inputNeurons.length;j++)
				{
					ci = inputNeurons[j];
					total += ci.output*ci.weight[j];
				}
				ch.input = total+ch.bias;
			}
			//feedforward from hidden to output Neurons
			for(var o:int=0;o<outputNeurons.length;o++)
			{
				total = 0.0;
				co = outputNeurons.getItemAt(o) as Neuron;
				//feed the expected training result to the output Neurons layer
				co.outputTraning = this.output_data.getItemAt(sampleNumer)[o];
				for(var k:int=0;k<hiddenNeurons.length;k++)
				{
					ch = hiddenNeurons[k];
					total += ch.output*co.weight[k];
				}
				co.input = total+co.bias;
			}
		}
		//----------------------------------
		//  backPropagate(native)
		//----------------------------------
		/// Recalculates the BIAS and ERROR in the HIDDEN LAYER
		/// and OUTPUT LAYER. Adjustes the WEIGHTS between the
		/// OUTPUT LAYER and HIDDEN LAYER and between the HIDDEN
		/// LAYER and the INPUT LAYER using the derivative of
		/// the Sigmoid Function or Logistic Function
		public function backPropagate():void
		{
			var total:Number;
			var ch:Neuron = null;
			var ci:Neuron = null;
			var co:Neuron = null;
			//calculate error rate for Output layer
			for(var o:int;o<outputNeurons.length;o++)
			{
				co = outputNeurons[o];
				co.error = co.logisticFunctionDerivative(co.output)*(co.outputTraning-co.output);
			}
			//error from output to hidden layer
			for(var h:int=0;h<hiddenNeurons.length;h++)
			{
				total = 0.0;
				ch = hiddenNeurons[h];
				for(var ho:int;ho<outputNeurons.length;ho++)
				{
					co = outputNeurons[ho];
					total += co.error*co.weight[ho];
				}
				ch.error = ch.logisticFunction(co.output)*total;
			}
			//update all weights in the network
			//from output Neurons to hidden Neurons
			for(var oo:int=0;oo<outputNeurons.length;oo++)
			{
				co = outputNeurons[oo];
				for(var hh:int=0;hh<hiddenNeurons.length;hh++)
				{
					ch = hiddenNeurons[hh];
					co.weight[hh] += this.learning_rate*co.error*co.output;
				}
				co.bias += this.learning_rate*co.error;
			}
			//update all weights in the network
			//from hidden Neurons to input Neurons
			for(var hhh:int=0;hhh<hiddenNeurons.length;hhh++)
			{
				ch = hiddenNeurons[hhh];
				for(var i:int=0;i<inputNeurons.length;i++)
				{
					ci = inputNeurons[i];
					ch.weight[i] += this.learning_rate*ch.error*ci.output;
				}
				ch.bias += this.learning_rate*ch.error;
			}
		}
	}
}
internal class Random
{
	/// Generates random double values between -1.0 and +1.0
	/// System.Double data type between -1.0 and +1.0
	public static function gett(minLimit:Number=-1000,maxLimit:Number=1000):Number
	{
		return (Math.random()*(maxLimit-minLimit+1)+minLimit);
	}
}