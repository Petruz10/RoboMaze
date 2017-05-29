package entity
{
	import flash.media.Sound;

	public class Button extends Entity {
		
		public function Button()	{	
			super();
			initSound();
		}
		override public function init():void {

		}
		override public function update():void {
			
		}
		override public function dispose():void {
			this.removeChild(_skin);
            _skin = null;
		}
		protected function initSound():void{
		
		}
		public function activate():void {
			_skin.gotoAndStop("activated");
		}
		public function deactivate():void {
			_skin.gotoAndStop("deactivated");
		}
	}
}