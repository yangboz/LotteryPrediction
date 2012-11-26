
/*
Copyright (c) 2008, Thomas W. Gonzalez

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

www.brightpointinc.com

*/

package  com.brightPoint.utils
{
	import mx.collections.ArrayCollection;
	import mx.collections.IViewCursor;
	import mx.collections.Sort;
	import mx.collections.SortField;
	
	public class CollectionUtils
	{
		public static function getItemByField(collection:ArrayCollection, field:String, value:String):* {
			if (collection==null || field==null) return null;
			
			var cur:IViewCursor = collection.createCursor();
			
			var sort:Sort=new Sort();
			sort.fields=[new SortField(field,false)];
			collection.sort=sort;
			collection.refresh();
			var obj:Object=new Object();
			obj[field]=value;
			cur.findFirst(obj);
			
			if (cur.current==null) return null;
			
			if (cur.current[field]==value)
				return cur.current;
			else
				return null;
		}
		
	}
}