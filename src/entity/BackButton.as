package entity
{
	public class BackButton extends Entity {
		
        public function BackButton()	{	
			super();
			initUI();
		}
		override public function init():void {

		}
		override public function update():void {
			
		}
		override public function dispose():void {
			
		}
		protected function initUI():void {
            _skin = new BackBtn();
			this.addChild(_skin);
		}
	}
}