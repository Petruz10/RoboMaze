package state
{
	import entity.BackButton;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	public class Credits extends DisplayState {
		private var _layerBackground:DisplayStateLayer;
		private var _layerCreditsText:DisplayStateLayer;
		private var _layerBtn:DisplayStateLayer;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function Credits(){
			super();
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {
			trace("credits");
			initLayers();
		}
		//------------------------------------------------------------------------
		// update
		//------------------------------------------------------------------------
		override public function update():void {
			changeState();
		}
		//------------------------------------------------------------------------
		// dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			trace("dispose");
		}
		//------------------------------------------------------------------------
		// init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			initButton();
		}
		//------------------------------------------------------------------------
		// init "menu" --> back btn
		//------------------------------------------------------------------------
		private function initButton():void {
			var btn:BackButton = new BackButton();
			_layerBtn = layers.add("BACK_BTN");
			_layerBtn.x = 0;
			_layerBtn.y = 0;
			btn.x = 0;
			btn.y = 540;
			_layerBtn.addChild(btn);
		}
		private function changeState():void {
			if(Input.keyboard.justPressed("SPACE") == true){
				Session.application.displayState = new Menu; 
			}
		}
	}
}