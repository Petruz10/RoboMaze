package component
{
	import entity.Tile;
	import flash.display.Sprite;
	import flash.display.DisplayObject;

	public class Maze extends Sprite {
		/*
		* maze design
		*/
		private var _mazeArray:Array;
		private var _multiMazeArray:Array; // mazes for multiplayer
		/*
		* 
		*/
		private const ONEPLAYER_MAZE_HEIGHT:int = 560; 	// total height 
		/*
		* 
		*/
		private const ONEPLAYER_MAZE_WIDTH:int = 800; 	// total width oneplayer maze.
		/*
		* 
		*/
		private const TWOPLAYER_MAZE_HEIGHT:int = 560; 	// total height 
		/*
		* 
		*/
		private const TWOPLAYER_MAZE_WIDTH:int = 400; 	// total width oneplayer maze.
		/*
		* 
		*/
		private const TILE_HEIGHT:int = 40; // tile height
		/*
		* 
		*/
		private const TILE_WIDTH:int = 40; // tile width
		/*
		* keeps track on how many mazes that is needed. one or two. 
		*/
		private var _mode:int; // game mode // oneplayer = 1, twoplayer = 2;
		//------------------------------------------------------------------------
		// Constructor
		// @param mode:int // 1 or 2, singleplayer or multiplayer.
		//------------------------------------------------------------------------
		public function Maze(mode:int=2){
			this._mode = mode;
			init();
		}
		public function init():void {
			if (_mode == 1) { initSingleplayerMaze(); }
			if (_mode == 2) { initMultiplayerMaze(); }
			initTiles();	
		}
		//------------------------------------------------------------------------
		// create Vector
		//------------------------------------------------------------------------
		private function initSingleplayerMaze():void {
				_mazeArray = [
					[3,2,2,2,2,2,2,2,2,2,14,2,2,2,2,2,2,14,2,4],
					[1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,1],
					[1,0,8,2,2,4,0,3,2,2,15,2,7,0,3,2,2,6,0,1],
					[1,0,0,0,0,1,0,1,0,0,1,0,0,0,1,0,0,0,0,1],
					[1,0,8,2,2,6,0,5,7,0,10,0,9,0,10,0,8,4,0,1],
					[1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,1,0,1],
					[1,0,9,0,8,2,2,7,0,3,2,2,13,7,0,8,2,15,2,12],
					[11,2,12,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1,0,1],
					[1,0,10,0,8,4,0,9,0,5,2,7,0,8,2,2,2,12,0,1],
					[1,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,1],
					[1,0,8,2,2,6,0,10,0,8,2,14,2,2,2,7,0,10,0,1],
					[1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,1],
					[5,2,2,2,2,2,2,2,2,2,2,13,2,2,2,2,2,2,2,6]
				];
		} 
		private function initMultiplayerMaze():void {
			var r:int;
			_multiMazeArray = 
			[
				[
					[3,2,14,2,2,2,2,2,2,4],
					[1,0,1,0,0,0,0,0,0,1],
					[1,0,5,2,2,7,0,9,0,1],
					[1,0,0,0,0,0,0,1,0,1],
					[1,0,9,0,8,4,0,1,0,1],
					[11,2,6,0,0,5,2,6,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[1,0,0,3,2,7,0,8,2,12],
					[1,0,8,6,0,0,0,0,0,1],
					[1,0,0,0,0,3,2,4,0,1],
					[11,2,7,0,8,6,0,1,0,1],
					[1,0,0,0,0,0,0,1,0,1],
					[5,2,2,2,2,2,2,13,2,6]
				],
				[
					[3,2,2,14,2,2,2,14,2,4],
					[1,0,0,1,0,0,0,1,0,1],
					[1,0,8,13,7,0,8,6,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[11,2,2,4,0,8,2,7,0,1],
					[1,0,0,1,0,0,0,0,0,1],
					[1,0,8,6,0,8,2,2,2,12],
					[1,0,0,0,0,0,0,0,0,1],
					[11,2,7,0,3,2,14,7,0,1],
					[1,0,0,0,1,0,1,0,0,1],
					[1,0,9,0,10,0,5,7,0,1],
					[1,0,1,0,0,0,0,0,0,1],
					[5,2,13,2,2,2,2,2,2,6]
				],
				[
					[3,2,2,2,2,2,2,2,2,4],
					[1,0,0,0,0,0,0,0,0,1],
					[1,0,9,0,9,0,8,4,0,1],
					[1,0,1,0,1,0,0,1,0,1],
					[1,0,1,0,1,0,0,1,0,1],
					[1,0,10,0,10,0,8,6,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[1,0,3,7,0,9,0,9,0,1],
					[1,0,1,0,0,1,0,1,0,1],
					[1,0,1,0,0,1,0,1,0,1],
					[1,0,5,7,0,10,0,10,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[5,2,2,2,2,2,2,2,2,6]
				],
				[
					[3,2,2,2,2,2,2,2,2,4],
					[1,0,0,0,0,0,0,0,0,1],
					[1,0,8,2,2,2,2,7,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[1,0,8,2,2,2,2,7,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[1,0,8,2,2,2,2,7,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[1,0,8,2,2,2,2,7,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[1,0,8,2,2,2,2,7,0,1],
					[1,0,0,0,0,0,0,0,0,1],
					[5,2,2,2,2,2,2,2,2,6]
				]
			];
			
			r = Math.floor(Math.random()*_multiMazeArray.length);
			_mazeArray = _multiMazeArray[r];
		}
		//------------------------------------------------------------------------
		// fill object with tiles based on mazeArray
		//------------------------------------------------------------------------
		// https://gamedevelopment.tutsplus.com/tutorials/an-introduction-to-creating-a-tile-map-engine--gamedev-10900
		private function initTiles():void {
			/*
			* the tile to add 
			*/
			var tile:Tile;
				for (var i:int = 0; i <_mazeArray.length; i++ ){
					for (var j:int = 0; j < _mazeArray[i].length; j++) {
						tile = new Tile(_mazeArray[i][j]);
						tile.width = TILE_WIDTH;
						tile.height = TILE_HEIGHT;
						tile.y = i * tile.height;
						tile.x = j * tile.width;
						this.addChild(tile); 
					}
				}
				if (_mode == 2) {
					for (var k:int = 0; k <_mazeArray.length; k++ ){
						for (var l:int = 0; l < _mazeArray[k].length; l++) {
							tile = new Tile(_mazeArray[k][l]);
							tile.width = TILE_WIDTH;
							tile.height = TILE_HEIGHT;
							tile.y = k * tile.height;
							tile.x = tile.x = 400 + (l * tile.width);
							this.addChild(tile); 
						}
					}	
				}
		}
		//------------------------------------------------------------------------
		//	dispose
		//------------------------------------------------------------------------
		public function dispose():void {
			disposeTiles();
		}
		//------------------------------------------------------------------------
		//	dispose tiles
		//------------------------------------------------------------------------
		private function disposeTiles():void {
			_mazeArray = null;
			var numCh:int = this.numChildren;
			var tile:DisplayObject;

			while (numCh > 0) {
				this.removeChildAt(0);
				tile = this.getChildAt(0);
				tile = null;
			} 
		}
	}
}