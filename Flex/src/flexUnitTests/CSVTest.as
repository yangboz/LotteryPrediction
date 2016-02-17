package flexUnitTests
{
	import com.shortybmc.data.parser.CSV;
	
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import flexunit.framework.Assert;
	
	public class CSVTest
	{		
		private var csv:CSV;
		
		[Before]
		public function setUp():void
		{
			this.csv = new CSV();
		}
		
		[After]
		public function tearDown():void
		{
//			this.csv = null;
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		[Test]
		public function testAddRecordSet():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_dataHasValues():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testDecode():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testDeleteRecordSet():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testDump():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_embededHeader():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_embededHeader():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testEncode():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_fieldEnclosureToken():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_fieldEnclosureToken():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_fieldSeperator():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_fieldSeperator():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGetRecordSet():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_header():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_header():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_headerHasValues():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_headerOverwrite():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_headerOverwrite():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testGet_recordsetDelimiter():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSet_recordsetDelimiter():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSearch():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testSort():void
		{
			Assert.fail("Test method Not yet implemented");
		}
//		
//		[Test]
//		public function testAddEventListener():void
//		{
//			Assert.fail("Test method Not yet implemented");
//		}
		
		[Test]
		public function testClose():void
		{
			Assert.fail("Test method Not yet implemented");
		}
		
		[Test]
		public function testLoad():void
		{
//			Assert.fail("Test method Not yet implemented");
			this.csv.load(new URLRequest("../lottery-data/red_bule_balls.csv"));
			this.csv.addEventListener(Event.COMPLETE,function(event:Event):void
			{
				Assert.assertNotNull(csv.data);
			});
		}
		//Event related
//		[Test]
//		public function testDispatchEvent():void
//		{
//			Assert.fail("Test method Not yet implemented");
//		}
//		
//		[Test]
//		public function testHasEventListener():void
//		{
//			Assert.fail("Test method Not yet implemented");
//		}
//		
//		[Test]
//		public function testRemoveEventListener():void
//		{
//			Assert.fail("Test method Not yet implemented");
//		}
//		
//		[Test]
//		public function testToString():void
//		{
//			Assert.fail("Test method Not yet implemented");
//		}
//		
//		[Test]
//		public function testWillTrigger():void
//		{
//			Assert.fail("Test method Not yet implemented");
//		}
	}
}