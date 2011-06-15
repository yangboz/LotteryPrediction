package com.masterbaboon {
	
	import flash.events.KeyboardEvent;
	
	/**
	 * Collection of advanced math functions for AS3
	 * @author Pietro Berkes
	 */
	public class AdvancedMath {
		
		// ARRAY FUNCTIONS
		// ===============
		
		/**
		 * Add two arrays elementwise. They must be of the same length.
		 */
		static public function add(x:Array, y:Array):Array {
			if (x.length != y.length) {
				throw Error('Input arrays must be of same length');
			}
			
			var res:Array = new Array(x.length);
			for (var i:int = 0; i < x.length; i++) {
				res[i] = x[i] + y[i];
			}
			return res;
		}
		
		/**
		 * Create a new array with elements initialized to a particular value.
		 * @param dim		Number of dimensions
		 * @param val		Value to initialize the array to. Default: 0
		 */
		static public function zeros(dim:int, val:Number = 0):Array {
			var a:Array = new Array(dim);
			for (var i:int = 0; i < dim; i++) {
				a[i] = val;
			}
			return a;
		}
		
		// SIMPLE STATISTICS
		// =================
		
		/**
		 * Compute the sum of the elements of the input array x
		 */
		static public function sum(x:Array):Number {
			var res:Number = 0;
			for each (var n:Number in x) {
				res += n;
			}
			return res;
		}
		
		/**
		 * Compute the mean of the input array x.
		 */
		static public function mean(x:Array):Number {
			return sum(x) / x.length;
		}
		
		/**
		 * Compute the variance of the input array x.
		 */
		static public function variance(x:Array):Number {
			// square input array elementwise
			var x2:Array = x.map(function (a:Number, idx:int, arr:Array):Number { return a * a; } );
			var mn:Number = mean(x);
			return mean(x2) - mn * mn;
		}
		
		// GAMMA FUNCTION
		// ==============
		
		// Magic numbers needed by the lnGamma function
		static private const LNGAMMA_COEFFS:Array =
			[76.18009172947146, -86.50532032941677, 24.01409824083091,
			 -1.231739572450155, 0.1208650973866179e-2, -0.5395239384953e-5];
		
		/**
		 * Lanczos implementation of the log Gamma function,
		 * cf. Numerical Recipes in C (2nd edition, p.213).
		 * Reference:
		 * Lanczos, C. 1964, SIAM Journal on Numerical Analysis, ser. B, vol. 1, pp. 86–96.
		 */
		static public function lnGamma(x:Number):Number {
			// check range
			if (x < 0) throw RangeError("Input argument must be >= 0 .");
			
			var y:Number = x;
			var tmp:Number = x + 5.5;
			tmp -= (x + 0.5) * Math.log(tmp);
			
			var ser:Number = 1.000000000190015;
			for (var j:int = 0; j <= 5; j++) {
				y += 1;
				ser += LNGAMMA_COEFFS[j] / y;
			}
			
			return -tmp + Math.log(2.5066282746310005 * ser / x);
		}

		
		/**
		 * Lanczos implementation of the Gamma function,
		 * cf. Numerical Recipes in C (2nd edition, p.213).
		 * Reference:
		 * Lanczos, C. 1964, SIAM Journal on Numerical Analysis, ser. B, vol. 1, pp. 86–96.
		 */
		static public function gamma(x:Number):Number {
			// check range
			if (x < 0) throw RangeError("Input argument must be >= 0 .");
						
			// if x is a small integer, return exact value
			// \Gamma(x) = (x-1)!
			if (Math.round(x) === x && x <= FACTORIAL_MAXEXACT) {
				return factorial(int(x) - 1);
			}
			
			return Math.exp(lnGamma(x));
		}
		
		
		// FACTORIAL
		// =========
		
		// for numbers larger than FACTORIAL_MAXEXACT, the factorial function
		// approximates the result using the Gamma function
		public static const FACTORIAL_MAXEXACT:Number = 20;
			
		private static function initFactorialCache(max:int):Object {
			var cache:Object = new Object();
			// fill the cache up to max
			var fact:Number = 1;
			cache[0] = 1;
			for (var tmp:int = 1; tmp <= max; tmp++) {
				fact *= tmp;
				cache[tmp] = fact;
			}
			return cache;
		}
		// cache for factorial function
		private static var fcache:Object = initFactorialCache(FACTORIAL_MAXEXACT);

		
		/**
		 * Computes the factorial of x.
		 * Requested values are cached to speed-up future calls.
		 * If x>FACTORIAL_MAXEXACT, the result is approximated using the
		 * Gamma function, as x! = Gamma(x+1) .
		 */
		static public function factorial(x:int):Number {
			// check range
			if (x < 0) throw RangeError("Input argument must be >= 0 .");
			
			var y:Number = fcache[x];
			// found in cache
			if (y) return y;
			
			// otherwise approximate with gamma
			y = gamma(x + 1);
			// cache value
			fcache[x] = y;
			return y;
		}
		
		
		// DIRICHLET DISTRIBUTION
		// ======================
		
		/**
		 * Sample from a Gamma(k, theta) distribution.
		 * The definition and the sample generating algorithm are as at
		 * http://en.wikipedia.org/wiki/Gamma_distribution .
		 * For the Matlab Gamma(alpha, beta) definition, call Gamma(alpha, 1/beta).
		 */
		static public function sampleGamma(k:Number, theta:Number):Number {
			var ik:Number = Math.floor(k);
			var fk:Number = k - ik;
			
			// generate samples from Gamma([k], 1), where [k] is the integral part of k
			var x:Number = 0;
			for (var i:int = 0; i < ik; i++) {
				x += - Math.log(Math.random());
			}
			
			// now generate from Gamma(k-[k], 1) for the fractional part of k
			var v0:Number = Math.E / (Math.E + fk);
			var v:Array = new Array(3);
			var epsilon:Number;
			var eta:Number;
			do {
				// v_{0}, v_{2}, v_{2} are uniform
				for (i = 0; i < 3; i++) v[i] = Math.random();
				
				if (v[0] <= v0) {
					epsilon = Math.pow(v[1], 1 / fk);
					eta = v[2] * Math.pow(epsilon, fk - 1);
				} else {
					epsilon = 1 - Math.log(v[1]);
					eta = v[2] * Math.exp( -epsilon );
				}
			} while (eta > Math.pow(epsilon, fk - 1) * Math.exp( -epsilon ));
			
			// sum to obtain Gamma(k, 1)
			x += epsilon;
			
			// scale to transform to Gamma(k, theta)
			return theta * x;
		}
		
		/**
		 * Sample from a Dirichlet distribution.
		 * Dirichlet distribution can be used as prior for multinomial variables.
		 * @param alpha		Array of parameters for the Dirichlet distribution
		 * @see sampleDirichlet2
		 */
		static public function sampleDirichlet(alpha:Array):Array {
			var k:int = alpha.length;
			var res:Array = new Array(k);
			
			// Gamma variables
			var g:Array = new Array(k);
			for (var i:int = 0; i < k; i++) {
				g[i] = sampleGamma(alpha[i], 1);
			}
			
			var gsum:Number = sum(g);
			for (i = 0; i < k; i++) {
				res[i] = g[i] / gsum;
			}
			return res;
		}
		
		/**
		 * Sample from a multinomial distribution.
		 * In other words, choose randomly from a set of N choices with
		 * probabilities p[0], ..., p[N-1]
		 * @param p		An array of probabilities, one for each element.
		 * 				p must sum to 1.
		 */
		static public function sampleMultinomial(p:Array):int {
			if (Math.abs(sum(p)-1) > 1e-3) {
				throw Error('The elements of the input array must sum to 1');
			}
			
			var x:Number = Math.random();
			var cum:Number = 0;
			var idx:int = -1;
			do {
				idx++;
				cum += p[idx];
			} while (cum < x);
			return idx;
		}
	}
	
}
