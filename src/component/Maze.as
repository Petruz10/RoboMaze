package component
{
	import flash.display.Sprite;
	import entity.Tile;

	public class Maze extends Sprite {
		/*
		* maze design
		*/
		private var _mazeArray:Array;
		/*
		* 
		*/
		private const MAZE_HEIGHT:int = 600; 	// total height 
		/*
		* 
		*/
		private const MAZE_WIDTH:int = 800; 	// total width
		/*
		* 
		*/
		private const TILE_HEIGHT:int = 50; // tile height
		/*
		* 
		*/
		private const TILE_WIDTH:int = 50; // tile width
		
		public var holder:Sprite = new Sprite();
		
		//------------------------------------------------------------------------
		// Constructor
		//------------------------------------------------------------------------
		public function Maze(){
			trace("Maze constructor");
			initMaze();
			initTiles();
		}
		//------------------------------------------------------------------------
		// create Vector
		//------------------------------------------------------------------------
		private function initMaze():void {
			_mazeArray = [
				[3,2,2,2,2,2,14,2,2,2,2,2,2,2,2,4],
				[1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1],
				[1,0,3,2,7,0,11,2,14,2,4,0,3,7,0,1],
				[1,0,1,0,0,0,1,0,1,0,1,0,1,0,0,1],
				[1,0,1,0,8,2,12,0,1,0,5,2,6,0,0,1],
				[1,0,1,0,0,0,10,0,1,0,0,0,0,0,0,1],
				[11,2,13,2,7,0,0,0,10,0,8,14,2,7,0,1],
				[1,0,0,0,0,0,9,0,0,0,0,1,0,0,0,1],
				[1,0,0,0,3,2,6,0,3,2,2,15,2,4,0,1],
				[1,0,8,2,6,0,0,0,1,0,0,10,0,10,0,1],
				[1,0,0,0,0,0,9,0,1,0,0,0,0,0,0,1],
				[5,2,2,2,2,2,13,2,13,2,2,2,2,2,2,6]
			];
		} 
		//------------------------------------------------------------------------
		// fill object with tiles based on mazeArray
		//------------------------------------------------------------------------
		// https://gamedevelopment.tutsplus.com/tutorials/an-introduction-to-creating-a-tile-map-engine--gamedev-10900
		private function initTiles():void {
			/*
			* the tile to add 
			*/
			
			addChild(holder);

			var tile:Tile;

			for (var i:int = 0; i <_mazeArray.length; i++ ){
				for (var j:int = 0; j < _mazeArray[i].length; j++) {
					tile = new Tile(_mazeArray[i][j]);
					tile.y = i * tile.height;
					tile.x = j * tile.width;
					tile.scaleX = 0.5;
					tile.scaleY = 0.5;
					holder.addChild(tile);
				}
			}
		}
	}
}