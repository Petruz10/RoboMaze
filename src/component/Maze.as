package component
{
	import flash.display.Graphics;
	
	import se.lnu.stickossdk.display.DisplayStateLayer;
	
	public class Maze extends DisplayStateLayer {
		private var mazeVector:Vector.<int>;
		//------------------------------------------------------------------------
		// Constructor
		//------------------------------------------------------------------------
		public function Maze(){
			super();
		}
		//------------------------------------------------------------------------
		// create Vector
		//------------------------------------------------------------------------
		private function initMaze():void {
			mazeVector = new Vector.<int>[
				3,2,14,2,2,2,2,4,
				1,0,1,0,0,0,0,1,
				1,0,10,0,3,2,2,12,
				1,0,0,0,10,0,0,1,
				1,0,0,0,0,0,0,1,
				5,0,0,0,0,0,0,6
			];	
		}
		//------------------------------------------------------------------------
		// fill object with tiles based on mazeVector
		// each tile is 100x100px
		//------------------------------------------------------------------------
		private function initTiles():void {
			/*
			* 0 = path 
			*/
			var t0:Graphics; // path - no need for rotation
			/*
			* 1 = vertical wall // 2 = horizontal wall 
			*/
			var t1:Graphics; // straight wall - default right up
			/*
			* 3 = right turn up // 4 = left turn up // 5 = left turn down // 6 = right turn down
			*/
			var t2:Graphics; // turn - default right turn up
			/*
			* 7 = end right // 8 = end left  // 9 = end up // 10 = end down
			*/
			var t3:Graphics; // end - default right
			/*
			* 11 = t-intersection right // 12 = t-intersection left  // 13 = t-intersection up // 14 = t-intersection down
			*/
			var t4:Graphics; // t-intersection - default right
			/*
			* 14 = 4-way-intersection 
			*/
			var t5:Graphics; // 4-way - no need for rotation
		}
	}
}