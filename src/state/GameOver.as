package state
{
	import entity.BackButton;
	
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.system.Session;
	
	public class GameOver extends DisplayState {
		private var _layerBackground:DisplayStateLayer;
		private var _layerGameOverHUD:DisplayStateLayer;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function GameOver(){
			super();
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {
            trace("GAME OVER");
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
			disposeBackground();
            disposeGameOverHUD();
		}
		//------------------------------------------------------------------------
		// init layers
		//------------------------------------------------------------------------
		private function initLayers():void {
			initBackground();
			initHUD();
		}
		private function initBackground():void {
			var bgImg:BgImgTest = new BgImgTest();
			
			_layerBackground = layers.add("MENU_BG");
			_layerBackground.x = 0;
			_layerBackground.y = 0;
			
			_layerBackground.addChild(bgImg);
		}
		//------------------------------------------------------------------------
		// init "menu" --> back btn
		//------------------------------------------------------------------------
		private function initHUD():void {
			var btn:BackButton = new BackButton();
			_layerHUD = layers.add("BACK_BTN");
			_layerHUD.x = 0;
			_layerHUD.y = 0;
			btn.x = 0;
			btn.y = 540;
			_layerHUD.addChild(btn);
		}
		private function changeState():void {
			if(Input.keyboard.justPressed(_controlls.PLAYER_BUTTON_1) == true){
				Session.application.displayState = new Menu; 
			}
		}
	}
}