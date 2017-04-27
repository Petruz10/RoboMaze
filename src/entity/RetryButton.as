package entity
{
	public class RetryButton extends Button {
		
		public function RetryButton()	{	
				super();
				initSkin();
		}
		override public function init():void {

		}
		override public function update():void {
				
		}
		override public function dispose():void {
				super.dispose();
		}
		protected function initSkin():void {
			_skin = new RetryBtn_mc();
			_skin.stop();
			this.addChild(_skin);
		}
	}
}