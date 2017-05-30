package
{
	import se.lnu.stickossdk.system.Engine;
	import state.Menu; // during testing
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
		//	initDebugger = true;
			initDisplayState = SplashScreen; // <--- opens SplashScreen that leads to Menu State
		//	initDisplayState = Menu;
			initBackgroundColor = 0x666666;
		}
	}
}