package entity
{
	public class MenuButton extends Button {
		/*
		* sound file for btn
		*/
		public var id:int;
		//------------------------------------------------------------------------
		// constructor
		//------------------------------------------------------------------------
		public function MenuButton(id:int)	{	
            this.id = id;
			super();
			super.initSound();
			initUI();
		}
		//------------------------------------------------------------------------
		// init
		//------------------------------------------------------------------------
		override public function init():void {

		}
		//------------------------------------------------------------------------
		// update
		//------------------------------------------------------------------------
		override public function update():void {
			
		}
		//------------------------------------------------------------------------
		// dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			
		}
		//------------------------------------------------------------------------
		// initUI apply btn skin
		//------------------------------------------------------------------------
		private function initUI():void {
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
	}
}