package highscore
{
	import se.lnu.stickossdk.system.Session;

	public class highscoreData
	{
		public var score:Vector.<String> = new Vector.<String>();
		public var name:Vector.<String> = new Vector.<String>();
		
		public function highscoreData()
		{
			trace("highscore info");
			Session.highscore.receive(1, 10, initHighscore)
		}
		
		private function initHighscore(xml:XML):void
		{
			trace(xml);
			trace("name", xml.items.item.score.*);
			
			var scoreData:XMLList = xml.items.item.score.*;
			var scoreName:XMLList = xml.items.item.name.*;
			
			for(var i:uint; i<scoreData.length(); i++)
			{
				trace("loop");
				trace(scoreData[i]);
				scoreSettings(scoreData[i]);
			}
			
			for(var j:uint; j<scoreName.length(); j++)
			{
				name.push(scoreName[j]);
			}
		}
		
		private function scoreSettings(secs:Number):void
		{
			trace("score", secs);
			var hundraSek:Number = secs;
			var sek:Number;
			var min:int;
			
			sek = hundraSek/98;
			min = sek/60;
			 if(sek >= 60) sek = sek - (60*min);
			 hundraSek = sek - Math.floor(sek);
			 sek = Math.floor(sek);
			 
			 trace((secs/98) - min);
			
			trace("min: "+ min+": sek "+ sek + ": hundrasek" +hundraSek);
		}
	}
}