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
		private var m_deadSound:SoundObject;
		
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
			m_timer = Session.timer.create(1000, removeHP);
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
			}
			
		//	if(HP == 30 ||  HP == 10) initWarningSound();
			
			//if(HP == 0) initDeadSound();
		}
		
		private function initWarningSound():void
		{
			Session.sound.musicChannel.sources.add("game_warningSound", RobotWarning_mp3);
			m_warningSound = Session.sound.musicChannel.get("game_warningSound");
			m_warningSound.volume = 0.8;
			m_warningSound.play();
		}
		
		private function initDeadSound():void
		{
			Session.sound.musicChannel.sources.add("game_deadSound", RobotDeath_mp3);
			Session.sound.musicChannel.sources.add("game_deadSound", RobotShutdown_mp3);
			m_deadSound = Session.sound.musicChannel.get("game_deadSound");
			m_deadSound.volume = 0.55;
			m_deadSound.play();
		}
		
		//------------------------------------------------------------------------
		// dispose methods 
		//------------------------------------------------------------------------
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