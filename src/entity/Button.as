package entity
{
	import flash.media.Sound;

	public class Button extends Entity {
		/*
		* sound file for btn
		*/
		protected var _btnSound:Sound;
		
		public function Button()	{	
			super();
			initSound();
		}
		override public function init():void {

		}
		override public function update():void {
			
		}
		override public function dispose():void {
			
		}
		protected function initSound():void{
			
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