package state
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.system.Session;
	
	import state.Menu;
	
	public class SplashScreen extends DisplayState {
		private const TIMER:int = 300; // 5 sec
		private var counter:int = 0; // counter
		private var backgroundImg:MovieClip;
		
		public function SplashScreen(){
			super();
		}
		override public function init():void {
			trace("splashscreen");
			initLayers();
		}
		override public function update():void {
			counter++
			if (counter == 300) {
				Session.application.displayState = new Menu;
			}
			// put "timer" here
		}
		override public function dispose():void {
			trace("dispose");
		}
		private function initLayers():void {
			backgroundImg = new SplashBgImgTest;
			addChild(backgroundImg);
		}
	}
}