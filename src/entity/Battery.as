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
		private var m_deadSound2:SoundObject;
		
		private var m_players:int;
		
		public function Battery(player:int)
		{
			trace("battery players", player);
			super();
			m_players = player;
			HPtimer();
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		/*
		* function to set a  timer to when the battery should go down
		*/
		private function HPtimer():void
		{
			//m_timer = Session.timer.create(1300, removeHP);
			//m_timer = Session.timer.create(100, removeHP);
			switch(m_players)
			{
				case 1:
				//	m_timer = Session.timer.create(85, removeHP);
					m_timer = Session.timer.create(95, removeHP);
				//	m_timer = Session.timer.create(100, removeHP);
					break;
				case 2:
					m_timer = Session.timer.create(100, removeHP);
				//	m_timer = Session.timer.create(200, removeHP);
					break;
			}
			
		}
		
		//------------------------------------------------------------------------
		// private methods 
		//------------------------------------------------------------------------
		/*
		* function to remove battery 
		*/
		private function removeHP():void
		{
			if(HP != 0) 
			{
				HP --;
				HPtimer();
			}
			
			if(HP == 30 || HP == 10) initWarningSound();
			
			if(HP == 0) 
			{
				initDeadSound();
				initShutdownSound();
			}
		}
		
		/*
		* function for the warning sound when the robot is about to die
		*/
		private function initWarningSound():void
		{
			trace("WARNING ljud");
			Session.sound.musicChannel.sources.add("game_warningSound", RobotWarning_mp3);
			m_warningSound = Session.sound.musicChannel.get("game_warningSound");
			m_warningSound.volume = 0.9;
			m_warningSound.play();
		}
		
		/*
		* function for the sound that plays when you die
		*/
		private function initDeadSound():void
		{
			Session.sound.musicChannel.sources.add("game_deadSound", RobotDeath_mp3);
			m_deadSound = Session.sound.musicChannel.get("game_deadSound");
			m_deadSound.volume = 0.3;
			m_deadSound.play();
		}
		
		private function initShutdownSound():void
		{
			trace("sound");
			Session.sound.musicChannel.sources.add("game_deadSound2", RobotShutdown_mp3);
			m_deadSound2 = Session.sound.musicChannel.get("game_deadSound2");
			m_deadSound2.volume = 0.9;
			m_deadSound2.play();
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