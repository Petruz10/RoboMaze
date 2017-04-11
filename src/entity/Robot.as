package entity
{
	import se.lnu.stickossdk.input.EvertronControls;

	public class Robot extends Entity
	{
		private var m_controls:EvertronControls;
		
		public function Robot()
		{
			super();
			super.update();
			trace("robot");
		}
		
		private function moveUp():void
		{
			
		}
		
		private function moveDown():void
		{
			
		}
		
		private function moveLeft():void
		{
			
		}
		
		private function moveRight():void
		{
			
		}
	}
}