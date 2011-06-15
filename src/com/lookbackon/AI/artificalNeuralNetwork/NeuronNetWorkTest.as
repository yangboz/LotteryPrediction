package com.lookbackon.AI.artificalNeuralNetwork
{
	import mx.collections.ArrayCollection;

	public class NeuronNetWorkTest
	{
		private var inputDataArray:ArrayCollection;
		private var outputDataArray:ArrayCollection;
		/// Executes a Neural Network MultiLayer FeedForward BackPropagation
		/// Algorithm for Learning or Classification
		public function NeuronNetWorkTest()
		{
			//a two-dimensional array of 14 samples and 6 input Neurons
			//14 samples with 6 inputs
			inputDataArray = new ArrayCollection(
				[
					[1, 0, 0, 0.85, 0.85, 0], [1, 0, 0, 0.80, 0.90, 1], [0, 1, 0, 0.83, 0.86, 0], [0, 0, 1, 0.70, 0.96, 0],
					[0, 0, 1, 0.68, 0.80, 0], [0, 0, 1, 0.65, 0.70, 1], [0, 1, 0, 0.64, 0.65, 1], [1, 0, 0, 0.72, 0.95, 0],
					[1, 0, 0, 0.69, 0.70, 0], [0, 0, 1, 0.75, 0.80, 0], [1, 0, 0, 0.75, 0.70, 1], [0, 1, 0, 0.72, 0.90, 1],
					[0, 1, 0, 0.81, 0.75, 0], [0, 0, 1, 0.71, 0.91, 1]
				]);
			
			//a two-dimensional array of 14 samples and 1 output Neuron
			//14 samples with 1 target output
			outputDataArray = new ArrayCollection(
				[
					[0], [0], [1], [1], [1], [0], [1], [0], [1], [1], [1], [1], [1], [0]
				]
				);
			
			var net:NeuralNetWork = new NeuralNetWork();	
			var recordCount:int = inputDataArray.length;
//			int recordCount = inputDataArray.GetUpperBound(0) + 1;
			if(recordCount !=(outputDataArray.length))
			{
				throw new Error("number of samples in input data is not equal to number of samples in output data!!");
			}
			/*if (recordCount != (outputDataArray.GetUpperBound(0) + 1))
			{
				throw new System.ArgumentOutOfRangeException("number of samples in input data is not equal to number of samples in output data");
			}*/
			net.initialize(inputDataArray,outputDataArray,4);
			
			for(var count:int=0;count<NeuralNetWork.iterations;count++)
			{
				for(var sample:int=0;sample<recordCount;sample++)
				{
					net.feedForward(sample);
					net.backPropagate();
					trace("Count:", count.toFixed(4) , " Output : " , net.outputNeurons.gett(0).output.toFixed(4) , " OutputTraining : " , net.outputNeurons.gett(0).outputTraning.toFixed(4) , " Learning Rate : " , net.learning_rate);
				}
			
				//adjust the learning rate after every training sample iteration
				net.learning_rate = Number(1 / (Number(count) + 1));
				trace("After adjust Count: : " + count.toFixed(4) + " Output : " + net.outputNeurons.gett(0).output.toFixed(4) + " OutputTraining : " + net.outputNeurons.gett(0).outputTraning.toFixed(4) + " Learning Rate : " + net.learning_rate);
		
			}
		}
	}
}