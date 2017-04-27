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
			initSkin();
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
			super.dispose();
		}
		//------------------------------------------------------------------------
		// initUI apply btn skin
		//------------------------------------------------------------------------
		private function initSkin():void {
            switch(id) {
				case 0:
					_skin = new OnePlayerBtn_mc(); 
				break;
				case 1:
					_skin = new TwoPlayerBtn_mc();
				break;
				case 2:
					_skin = new HighscoreBtn_mc();
				break;
				case 3:
					_skin = new CreditsBtn_mc();
			}	
			_skin.stop();
			this.addChild(_skin);
		}
	}
}