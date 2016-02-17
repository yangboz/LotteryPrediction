package com.lookbackon.utils
{
	/**
	 *
	 * 
	 * Permutation Utility class version 1.
	 * 
	 * Copyright (c) 2008 H. Melih Elibol
	 * 
	 * Permission is hereby granted, free of charge, to any person obtaining a copy
	 * of this software and associated documentation files (the "Software"), to deal
	 * in the Software without restriction, including without limitation the rights
	 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	 * copies of the Software, and to permit persons to whom the Software is
	 * furnished to do so, subject to the following conditions:
	 * 
	 * The above copyright notice and this permission notice shall be included in
	 * all copies or substantial portions of the Software.
	 * 
	 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	 * THE SOFTWARE.
	 * 
	 * /
	 /**
	 * 
	 * @author Knight.zhou
	 *
	 */
	public class MathUtil
	{
		private static var UINT_MAX_RATIO:Number = 1/uint.MAX_VALUE;
		private static var INT_MAX_RATIO:Number = 1/int.MAX_VALUE;
		private static var UINT_RANDOM:uint = Math.random()*uint.MAX_VALUE;
		private static var NEGA_INT_MAX_RATIO:Number = -INT_MAX_RATIO;
		private static var INT_RANDOM:int	 = Math.random()*int.MAX_VALUE;
		/**
		 *
		 * @param the minium of random ranges.
		 * @param the maxium of random ranges.
		 * @return the random number between min and max.
		 *
		 */
		public static function transactRandomNumberInRange(min:Number, max:Number):Number
		{
			return (Math.floor(Math.random() * (max - min + 1)) + min);
		}
		
		public static var returnedResult:Array = [];
		/**
		 * 
		 * @param min
		 * @param max
		 * @return the random number between min and max but diff from previous result.
		 * 
		 */		
		public static function transactDiffRandomNumberInRange(min:Number, max:Number):Number
		{
			var result:Number = (Math.floor(Math.random() * (max - min + 1)) + min);
			if(result in returnedResult)
			{
				if(returnedResult.length>=max-1)
				{
					returnedResult = [];
				}
				return transactDiffRandomNumberInRange(min,max);
			}else
			{
				returnedResult.push(result);
				return result;
			}
			//default return value.
			return min;
		}
		/**
		 * 
		 * @param value wheather negative or postive number.
		 * @return postive number.
		 * 
		 */		
		public static function transactAbs(value:Number):Number
		{
			var i:Number;
			//version 1
			//			i = x < 0 ? -x : x;
			//version 2
			i = (value ^ (value >> 31)) - (value >> 31);
			return i;
		}
		/**
		 * Using XOR algorithm with integer, 
		 * primarily because AS3 is lightning-quick with bit operations, 
		 * and the algorithm is only 4 lines of code. 
		 * Notice: it is 2 time faster than Math.random();
		 * @return random number between 0~1.
		 * 
		 */		
		public static function intXORrandom():Number
		{
			INT_RANDOM ^= (INT_RANDOM << 21);
			INT_RANDOM ^= (INT_RANDOM >>> 35);
			INT_RANDOM ^= (INT_RANDOM << 4);//comment out this line for -1 ~ 1
			if(INT_RANDOM < 0) return INT_RANDOM * INT_MAX_RATIO;
			return INT_RANDOM * NEGA_INT_MAX_RATIO;
		}
		/**
		 * Using XOR algorithm with un-integer, 
		 * primarily because AS3 is lightning-quick with bit operations, 
		 * and the algorithm is only 4 lines of code. 
		 * Notice: it is 4 time faster than Math.random();
		 * @return random number between 0~1.
		 * 
		 */		
		public static function uintXORrandom():Number
		{
			UINT_RANDOM ^= (UINT_RANDOM << 21);
			UINT_RANDOM ^= (UINT_RANDOM >>> 35);
			UINT_RANDOM ^= (UINT_RANDOM << 4);
			return (UINT_RANDOM * UINT_MAX_RATIO);
		}
		
		/**
		 * Computes the factorial of parameter n.
		 * 
		 * @param n the number
		 * @return the factorial of n
		 * 
		 */		
		public static function factorial(n:Number):Number {
			if(n>1) return n*arguments.callee(n-1);
			return 1;
		}
		
		/**
		 * 
		 * logic (lsd = least significant digit):
		 * 
		 * j++; //move to next digit
		 * n/=(j-1); //move "decimal place" of n (this is to create the next lsd) by previous base j-1, which does not move (since j is 1)
		 * Number(n)%j; //get the lsd of n in base j
		 * 
		 * @param k positive integer to represent
		 * @return Factoradic representation of integer k as an Array
		 * 
		 */
		public static function toFactoradic(n:Number):Array {
			var factoradic:Array = [0];
			var j:Number = 1;
			while(j<=n) factoradic.unshift(Number(n/=j++)%j);
			return factoradic;
		}
		
		/**
		 * 
		 * This function can be used with a permutation generator.
		 * 
		 * @param n positive integer to represent
		 * @param k factoradic length
		 * @return Factoradic representation of integer k as an Array
		 * 
		 */
		public static function toFactoradic2(n:Number, k:Number):Array {
			var factoradic:Array = [0];
			for(var j:Number = 1;j++<n;){
				k = k/(j-1);
				factoradic.unshift(k%j);
			}
			return factoradic;
		}
		
		/**
		 * @param n Order
		 * @param k Factoradic
		 * @return kth permutation of order n
		 */
		public static function permutation(n:Number, k:Number):Array {
			var r:Array = [], j:Number = 1, i:Number, p:Number;
			r[n-1] = 0;
			while(j++<n){
				p = i = n-j;
				r[p] = Math.floor((k/=(j-1))%j);
				while(i++<n)
					if(r[i] >= r[p])
						++r[i];
			}
			return r;
		}
		
		/**
		 * 
		 * @param n Order as an array
		 * @param k Factoradic
		 * @return kth permutation of order n
		 * 
		 */
		public static function permutateArray(n:Array, k:Number):Array {
			var r:Array = permutation(n.length, k);
			for(var i:int = -1;++i<n.length;)
				r[i] = n[r[i]];
			return r;
		}
		/**
		 * 
		 * @param n number of blanket elements.
		 * @param r number of picking elements from blanket.
		 * @return the premutated number with picked elements.
		 * 
		 */		
		public static function premutate(n:Number,r:Number):Number
		{
			if(r>=n) throw new Error("Invalid parameter!!!");
			return factorial(n)/factorial(n-r);
		}
	}
}