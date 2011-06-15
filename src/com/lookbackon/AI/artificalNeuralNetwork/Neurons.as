package com.lookbackon.AI.artificalNeuralNetwork
{
	import mx.collections.ArrayCollection;
	

	/**
	 *A Neural Network Layer or collection of cells or neurons 
	 * 
	 * @author Knight.zhou
	 * 
	 */	
	public class Neurons extends ArrayCollection
	{
//--------------------------------------------------------------------------
//
//  Constructor
//
//--------------------------------------------------------------------------
		public function Neurons()
		{
		}
//--------------------------------------------------------------------------
//
//  Methods:
//
//--------------------------------------------------------------------------		
		//----------------------------------
		//  add(native)
		//----------------------------------
		/// Adds a neuron to a Neural Network Layer or collection of cells
		/// The neuron to add to a Neural Network Layer
		public function add(newNeuron:Neuron):void
		{
			this.addItem(newNeuron);
		}
		//----------------------------------
		//  insert(native)
		//----------------------------------
		public function insert(index:int,newNeuron:Neuron):void
		{
			this.addItemAt(newNeuron,index);
		}
		
		/// ReadOnly indexer - retrieves the neuron at a
		/// specific position orlocation in the Neural
		/// Network Layer or Neural Network Collection
		//----------------------------------
		//  gett(native)
		//----------------------------------
		public function gett(index:int):Neuron
		{
			return this.getItemAt(index) as Neuron;
		}
		
	}
}