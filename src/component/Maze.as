package component
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class Maze extends Sprite {
		/*
		* maze design
		*/
		private var _mazeVector:Vector.<int>;
		/*
		* 
		*/
		private const MAZE_HEIGHT:int = 600; 	// total height 
		private const MAZE_WIDTH:int = 800; 	// total width
		private const TILE_HEIGHT:int = 100; // tile height
		private const TILE_WIDTH:int = 100; // tile width
		
		//------------------------------------------------------------------------
		// Constructor
		//------------------------------------------------------------------------
		public function Maze(){
			initMaze();
			initTiles();
		}
		//------------------------------------------------------------------------
		// create Vector
		//------------------------------------------------------------------------
		private function initMaze():void {
			_mazeVector = new Vector.<int>();
			
			_mazeVector.push([
				[3,2,14,2,2,2,2,4],
				[1,0,1,0,0,0,0,1],
				[1,0,10,0,3,2,2,12],
				[1,0,0,0,10,0,0,1],
				[1,0,0,0,0,0,0,1],
				[5,0,0,0,0,0,0,6]
			]);	
		} 
		//------------------------------------------------------------------------
		// fill object with tiles based on mazeVector
		// each tile is 100x100px
		//------------------------------------------------------------------------
		// https://gamedevelopment.tutsplus.com/tutorials/an-introduction-to-creating-a-tile-map-engine--gamedev-10900
		private function initTiles():void {
			var tile:MovieClip;
			
			for (var i:int = 0; i < _mazeVector[0].length; i++) {
				tile = rotateTile(_mazeVector[0][i]);
				tile.y = 0;
				if (i != 0) {
					tile.x += 100;
				}
				this.addChild(tile);
			}
			for (var j:int = 0; j < _mazeVector[1].length; i++) {
				tile = rotateTile(_mazeVector[1][j]);
				tile.y += 100;
				if (j != 0) {
					tile.x += 100;
				}
				this.addChild(tile);
			}
			for (var k:int = 0; k < _mazeVector[2].length; i++) {
				tile = rotateTile(_mazeVector[2][k]);
				tile.y += 200;
				if (k != 0) {
					tile.x += 100;
				}
				this.addChild(tile);
			}
			for (var l:int = 0; l < _mazeVector[3].length; i++) {
				tile = rotateTile(_mazeVector[3][l]);
				tile.y += 300;
				if (l != 0) {
					tile.x += 100;
				}
				this.addChild(tile);
			}
			for (var m:int = 0; m < _mazeVector[4].length; i++) {
				tile = rotateTile(_mazeVector[4][m]);
				tile.y += 400;
				if (m != 0) {
					tile.x += 100;
				}
				this.addChild(tile);
			}
			for (var n:int = 0; n < _mazeVector[1].length; i++) {
				tile = rotateTile(_mazeVector[1][n]);
				tile.y += 500;
				if (n != 0) {
					tile.x += 100;
				}
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
					tile = new Path; 		// path
				break;
				case 1:
					tile = new Wall; 		// vertical wall
				break;
				case 2:
					tile = new Wall; 		// horizontal wall
					tile.rotation = 90;
				break;
				case 3:
					tile = new Turn; 		// turn right up
				break;
				case 4:
					tile = new Turn;
					tile.rotation = 90; 	// turn left up 
				break;
				case 5:
					tile = new Turn;
					tile.rotation = 270; 	// turn right udown
				break;
				case 6:
					tile = new Turn;
					tile.rotation = 180		// turn left down
				break;
				case 7:
					tile = new End; 		// end right
				break;
				case 8:
					tile = new End;
					tile.rotation = 180; 	// end left
				break;
				case 9:
					tile = new End;
					tile.rotation = -90; 	// end up
				break;
				case 10:
					tile = new End;
					tile.rotation = 90; 	// end down
				break;
				case 11:
					tile = new T_Intersection; 	// T-section right
				break;
				case 12:
					tile = new T_Intersection;
					tile.rotation = 180; 		// T-section left
				break;
				case 13:
					tile = new T_Intersection;
					tile.rotation = -90; 		// T-section up
					break;
				case 14:
					tile = new T_Intersection;
					tile.rotation = 90; 		// T-section down
					break;
				case 15:
					tile = new FourwayIntersection;
				break;
			}
			return tile;
		}
	}
}