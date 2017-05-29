package entity
{
	public class BackButton extends Button {
		
        public function BackButton()	{	
			super();
			initSkin();
		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {
		}
		//------------------------------------------------------------------------
		// 	update
		//------------------------------------------------------------------------
		override public function update():void {	
		}
		//------------------------------------------------------------------------
		// 	dispose
		//------------------------------------------------------------------------
		override public function dispose():void {
			super.dispose();
		}
		//------------------------------------------------------------------------
		// 	init skin
		//------------------------------------------------------------------------
		protected function initSkin():void {
            _skin = new MenuBtn_mc();
			_skin.stop();
			this.addChild(_skin);
		}
		public function pulse():void {
			_skin.play();
		}
	}
}