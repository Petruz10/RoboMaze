package entity
{
	//------------------------------------------------------------------------
	// imports
	//------------------------------------------------------------------------
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;

	//------------------------------------------------------------------------
	// Public class Battery
	//------------------------------------------------------------------------
	public class Battery extends Entity
	{
		//------------------------------------------------------------------------
		// public properties 
		//------------------------------------------------------------------------
		public var HP:int = 100;
		
		//------------------------------------------------------------------------
		// private properties 
		//------------------------------------------------------------------------
		private var m_timer:Timer;
		private var m_warningSound:SoundObject;
		
		public function Battery()
		{
			super();
			trace("battery konstruktor");
			HPtimer();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		private function HPtimer():void
		{
			m_timer = Session.timer.create(1500, removeHP);
		}
		
		//------------------------------------------------------------------------
		// public methods 
		//------------------------------------------------------------------------
		public function getHP():void
		{
			
		}
		
		public function addHP():void
		{
			
		}
		
		public function removeHP():void
		{
			if(HP != 0) 
			{
				HP -= 10;
				HPtimer();
				trace(HP);
			}
			
			if(HP == 30 ||  HP == 10) 
			{
				trace("10 eller 30");
				//initWarningSound();
			}
		//	else dead();
		}
		
		private function initWarningSound():void
		{
			Session.sound.musicChannel.sources.add("game_warningSound", RobotWarning_mp3);
			m_warningSound = Session.sound.musicChannel.get("game_warningSound");
			m_warningSound.volume = 0.65;
			m_warningSound.play();
		}
		
		/*	private function dead():void
		{
			Session.timer.create(1000, gameOver);
		}
		
		private function gameOver():void
		{
			Session.application.displayState = new GameOver;
		}*/
		
		override public function dispose():void
		{
			disposeTimer();
		}
		
		private function disposeTimer():void
		{
			m_timer = null;
			trace("dispose battery timer");
		}
	}
}