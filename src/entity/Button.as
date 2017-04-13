package entity
{
	import flash.display.MovieClip;
	import flash.media.Sound;

	public class Button extends Entity {
		/*
		* btn id
		*/
		public var id:int; // 0-3
		/*
		* sound file for btn
		*/
		protected var _btnSound:Sound;
		
		public function Button(id:int)	{	
			super();
			this.id = id;
			initUI();
			initSound();
		}
		override public function init():void {

		}
		override public function update():void {
			
		}
		override public function dispose():void {
			
		}
		protected function initUI():void {
			switch(id) {
				case 0:
					_skin = new OnePlayerBtn; 
				break;
				case 1:
					_skin = new TwoPlayerBtn;
				break;
				case 2:
					_skin = new HighscoreBtn;
				break;
				case 3:
					_skin = new CreditsBtn;
			}	
			_skin.stop();
			this.addChild(_skin);
		}
		protected function initSound():void
		{
			
		}
		public function activate():void {
			_skin.gotoAndStop("activated");
			//trace("activated");
		}
		public function deactivate():void {
			_skin.gotoAndStop("deactivated");
			//trace("deactivated");
		}
	}
}