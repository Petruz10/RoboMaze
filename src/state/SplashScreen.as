package state
{
	import flash.display.MovieClip;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.system.Session;
	
	import state.Menu;
	
	public class SplashScreen extends DisplayState {
		private const TIMER:int = 300; // 5 sec
		private const LAYER_BACKGROUND:String = "background_layer"
		private var _counter:int = 0; // counter
		private var _layerBackground:DisplayStateLayer;
		private var _backgroundImg:MovieClip;
		
		public function SplashScreen(){
			super();
		}
		override public function init():void {
			trace("splashscreen");
			initLayers();
		}
		override public function update():void {
			_counter++
			if (_counter == 300) {
				Session.application.displayState = new Menu;
			}
			// put "timer" here
		}
		override public function dispose():void {
			trace("dispose");
		}
		private function initLayers():void {
			_backgroundImg = new SplashBgImgTest();
			_layerBackground = layers.add(LAYER_BACKGROUND);
			
			_layerBackground.x = 0;
			_layerBackground.y = 600;
			_layerBackground
			
			_layerBackground.addChild(_backgroundImg);
		}
	}
}