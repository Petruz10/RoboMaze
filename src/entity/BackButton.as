package entity
{
	public class BackButton extends Button {
		
        public function BackButton()	{	
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
            _skin = new MenuBtn_mc();
			_skin.stop();
			this.addChild(_skin);
		}
		public function pulse():void {
			_skin.play();
		}
	}
}