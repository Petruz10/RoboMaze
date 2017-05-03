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
			initDebugger = true;
<<<<<<< HEAD
			//initDisplayState = SplashScreen; // <--- opens SplashScreen that leads to Menu State
			initDisplayState = Menu;
			initBackgroundColor = 0x666666;
=======
			initDisplayState = SplashScreen; // <--- opens SplashScreen that leads to Menu State
			//initDisplayState = Menu;
			initBackgroundColor = 0x333333;
>>>>>>> 4cd1dd9655de6a6c7c4a7c96a85f240ffe6e09b6
		}
	}
}