package entity
{
	public class RetryButton extends Button {
		
		public function RetryButton()	{	
				super();
				initSkin();
		}
		//------------------------------------------------------------------------
		// 	init
		//------------------------------------------------------------------------
		override public function init():void {

		}
		//------------------------------------------------------------------------
		//	update
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
			_skin = new RetryBtn_mc();
			_skin.stop();
			this.addChild(_skin);
		}
	}
}