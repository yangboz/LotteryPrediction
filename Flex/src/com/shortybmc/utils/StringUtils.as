package com.shortybmc.utils
{
	
	public class StringUtils
	{

		public static var NEWLINE_TOKENS : Array = new Array (
			'\n',
			'\r'
		);
		
		public static var WHITESPACE_TOKENS : Array = new Array (
			' ',
			'\t'
		);
		

		 /**
		 * Counts the occurrences of needle in haystack. <br />
		 * {@code trace (StringUtils.count ('hello world!', 'o')); // 2
		 * }
		 * @param haystack :String
		 * @param needle :String
		 * @param offset :Number (optional)
		 * @param length :Number (optional)
		 * @return The number of times the needle substring occurs in the
		 * haystack string. Please note that needle is case sensitive.
		 */
		public static function count ( haystack : String, needle : String, offset : Number = 0, length : Number = 0 ) : Number
		{
			if ( length === 0 )
				 length = haystack.length
			var result : Number = 0;
			haystack = haystack.slice( offset, length );
			while ( haystack.length > 0 && haystack.indexOf( needle ) != -1 )
			{
				haystack = haystack.slice( ( haystack.indexOf( needle ) + needle.length ) );
				result++;
			}
			return result;
		}
		
		
		/**
		 * Strip whitespace and newline (or other) from the beginning and end of a string. <br />
		 * {@code trace (StringUtils.trim ('hello world! ')); // hello world!
		 * }
		 * @param str :String
		 * @param charList :Array (optional)
		 * @return A string with whitespace stripped from the beginning and end
		 * of str. Without the second parameter, trim() will strip characters that
		 * defined in WHITESPACE_TOKENS and NEWLINE_TOKENS array.
		 */
		public static function trim ( str : String, charList : Array = null ) : String
		{
			var list : Array;
			if ( charList )
			{
				list = charList;
			}
			else
			{
				list = WHITESPACE_TOKENS.concat( NEWLINE_TOKENS );
			}
			str = trimLeft( str, list );
			str = trimRight( str, list );
			return str;
		}
		
		/**
		 * Does the same how trim method, but only on left-side. <br />
		 * {@code trace (StringUtils.trimLeft ('hello world!')); // hello world!
		 * }
		 * @param str :String
		 * @param charList :Array (optional)
		 * @return A string with whitespace stripped from the start of str.
		 * Without the second parameter, trimLeft() will strip haracters of
		 * WHITESPACE_TOKENS + NEWLINE_TOKENS.
		 */
		public static function trimLeft ( str : String, charList : Array = null ) : String
		{
			var list:Array;
			if ( charList )
				 list = charList;
			else
				 list = WHITESPACE_TOKENS.concat( NEWLINE_TOKENS );
			
			while ( list.toString().indexOf ( str.substr ( 0, 1 ) ) > -1 && str.length > 0 )
			{
				str = str.substr ( 1 );
			}
			return str;
		}
		
		/**
		 * Does the same how trim method, but only on right-side. <br />
		 * {@code trace (StringUtils.trimRight ('hello world!')); // hello world!
		 * }
		 * @param str :String
		 * @param charList :Array (optional)
		 * @return A string with whitespace stripped from the end of str.
		 * Without the second parameter, trimRight() will strip haracters of
		 * WHITESPACE_TOKENS + NEWLINE_TOKENS.
		 */
		public static function trimRight ( str:String, charList : Array = null ) : String
		{
			var list : Array;
			if ( charList )
				 list = charList;
			else
				 list = WHITESPACE_TOKENS.concat( NEWLINE_TOKENS );
			
			while ( list.toString().indexOf ( str.substr ( str.length - 1 ) ) > -1 && str.length > 0)
			{
				str = str.substr ( 0, str.length - 1 );
			}
			return str;
		}

	}
}