package component
{
	import se.lnu.stickossdk.display.DisplayStateLayer;
	import flash.display.MovieClip;

	public class Maze extends DisplayStateLayer {
		/*
		* maze design
		*/
		private var mazeVector:Vector.<int>;
		/*
		* the tiles
		*/
		private var tiles:Object;
		//------------------------------------------------------------------------
		// Constructor
		//------------------------------------------------------------------------
		public function Maze(){
			super();
			initMaze();
			initTiles();
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
			var t0:MovieClip = new Path; // path - no need for rotation
			/*
			* 1 = vertical wall // 2 = horizontal wall 
			*/
			var t1:MovieClip = new Wall; // straight wall - default vertical
			/*
			* 3 = right turn up // 4 = left turn up // 5 = left turn down // 6 = right turn down
			*/
			var t2:MovieClip = new Turn; // turn - default right turn up
			/*
			* 7 = end right // 8 = end left  // 9 = end up // 10 = end down
			*/
			var t3:MovieClip = new End; // end - default right
			/*
			* 11 = t-intersection right // 12 = t-intersection left  // 13 = t-intersection up // 14 = t-intersection down
			*/
			var t4:MovieClip = new T_Intersection; // t-intersection - default right
			/*
			* 14 = 4-way-intersection 
			*/
			var t5:MovieClip  = new FourwayIntersection; // 4-way - no need for rotation
			
			tiles = {
				t0 : t0,
				t1 : t1,
				t2 : t2,
				t3 : t3,
				t4 : t4,
				t5 : t5
			};
		}
		//------------------------------------------------------------------------
		// create maze
		//------------------------------------------------------------------------
		private function placeTiles():void {
			var tile:MovieClip;
			
			for (var i:int = 0; i < mazeVector.length; i++) {
				tile = rotateTile(mazeVector[i]);
				this.addChild(tile);
			}
		}
		//------------------------------------------------------------------------
		// using the tile object to retrieve tiles
		//------------------------------------------------------------------------
		private function rotateTile(index:int):MovieClip {
			var tile:MovieClip;
			switch(index) {
				case 0:
					tile = tiles.t0;
				break;
				case 1:
					tile = tiles.t1;
				break;
				case 2:
					tile = tiles.t1;
					tile.rotation = 90;
				break;
				case 3:
					tile = tiles.t3; // turn right up
				break;
				case 4:
					tile = tiles.t3;
					tile.rotation = 90; // turn left up 
				break;
				case 5:
					tile = tiles.t3;
					tile.rotation = 270; // turn right udown
				break;
				case 6:
					tile = tiles.t3;
					tile.rotation = 180// turn left down
				break;
				case 7:
					tile = tiles.t4; // end right
				break;
				case 8:
					tile = tiles.t4;
					tile.rotation = 180; // end left
				break;
				case 9:
					tile = tiles.t4;
					tile.rotation = -90; // end up
				break;
				case 10:
					tile = tiles.t4;
					tile.rotation = 90; // end down
				break;
				case 11:
					tile = tiles.t5; // T-section right
				break;
				case 12:
					tile = tiles.t5;
					tile.rotation = 180; // T-section left
				break;
				case 13:
					tile = tiles.t5;
					tile.rotation = -90; // T-section up
					break;
				case 14:
					tile = tiles.t5;
					tile.rotation = 90; // T-section down
					break;
				case 15:
					tile = tiles.t6;
				break;
			}
			
				return tile;
		}
	}
}