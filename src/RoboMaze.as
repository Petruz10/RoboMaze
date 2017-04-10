package
{
	import se.lnu.stickossdk.system.Engine;
	import state.SplashScreen;
	
	[SWF(width="800", height="600", frameRate="60")]
	
	public class RoboMaze extends Engine
	{
		public function RoboMaze()
		{
			
		}
		override public function setup():void
		{
			initId = 28;
			initDebugger = true;
			//initDisplayState = SplashScreen; <--- opens SplashScreen that leads to Menu State
		}
	}
}