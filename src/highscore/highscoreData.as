package highscore
{
	import se.lnu.stickossdk.system.Session;

	public class HighscoreData
	{
		public var score:Vector.<String> = new Vector.<String>();
		public var name:Vector.<String> = new Vector.<String>();
		
		public var a:String;
		
		private var scoreData:XMLList;
		private var scoreName:XMLList;
		
		public function HighscoreData()
		{
			Session.highscore.receive(1, 10, initHighscore);
			trace("highscore data");
		}
		
		private function initHighscore(xml:XML):void
		{	
			trace("initHighscore");
			scoreData = xml.items.item.score.*;
			scoreName = xml.items.item.name.*;
			
			for(var i:uint; i<scoreData.length(); i++)
			{
				scoreSettings(scoreData[i]);
			}
			
			for(var j:uint; j<scoreName.length(); j++)
			{
				name.push(scoreName[j]);
			}
			trace("vector names", name);
		}
		
		private function scoreSettings(secs:Number):void
		{
			var hundraSek:Number = secs;
			var sek:Number;
			var min:int;
			var x:String;
			
			sek = hundraSek/98;
			min = sek/60;
			 if(sek >= 60) sek = sek - (60*min);
			 hundraSek = (sek - Math.floor(sek)) * 100;
			 hundraSek = Math.floor(hundraSek);
			 sek = Math.floor(sek);
			 
			 
			x =  min+":"+ sek + ":" +hundraSek;
			trace((secs/98) - min);
			score.push(x);
			trace("min: "+ min+": sek "+ sek + ": hundrasek" +hundraSek);
			trace("vector score", score);
		}
		
		public function dispose():void
		{
			disposeHighscore();
		}
		
		private function disposeHighscore():void
		{
			scoreData = null;
			scoreName = null;
		}
	}
}