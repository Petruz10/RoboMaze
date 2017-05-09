package component
{	
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import flash.display.Shape;
    //------------------------------------------------------------------------
    //   
    //      Instruction Screen Super Class
    //
    //------------------------------------------------------------------------
    public class Instruction extends DisplayStateLayerSprite { 
        private var _background:Shape;
        private var _rectangle1:Shape;
        private var _rectangle2:Shape;
        private var _header:InstructionsHeader_mc;
        private var _footer:InstructionPressAnyBtn_mc;
        //------------------------------------------------------------------------
        //      Constructor
        //------------------------------------------------------------------------
        public function Instruction() {

        }
        //------------------------------------------------------------------------
        //       init
        //------------------------------------------------------------------------
        override public function init():void {
            initBackground();
            initHeader();
            initFooter();
        }
        //------------------------------------------------------------------------
        //      update
        //------------------------------------------------------------------------
        override public function update():void {

        }
        //------------------------------------------------------------------------
        //      dispose
        //------------------------------------------------------------------------
        override public function dispose():void {
            disposeBackground();
            disposeHeader();
            disposeFooter();
        }
        //------------------------------------------------------------------------
        //      init Background
        //------------------------------------------------------------------------
        private function initBackground():void {
            _background = new Shape();
            _rectangle1 = new Shape();
            _rectangle2 = new Shape();

            _background.graphics.beginFill(0x666666);
            _background.graphics.drawRect(0, 0, 800, 600);
            _background.graphics.endFill();

            _rectangle1.graphics.beginFill(0x333333);
            _rectangle1.graphics.drawRect(0, 0, 800, 140);
            _rectangle1.graphics.endFill();

            _rectangle2.graphics.beginFill(0x333333);
            _rectangle2.graphics.drawRect(0, 0, 800, 140);
            _rectangle2.graphics.endFill();

            _background.x = 0;
            _background.y = 0;

            _rectangle1.x = 0;
            _rectangle1.y = 90;

            _rectangle2.x = 0;
            _rectangle2.y = 370;

            this.addChild(_background);    
            this.addChild(_rectangle1); 
            this.addChild(_rectangle2); 
        }
        //------------------------------------------------------------------------
        //      init Background
        //------------------------------------------------------------------------
        private function initHeader():void {
            _header = new InstructionsHeader_mc();
            _header.x = 30;
            _header.y = 25;
            this.addChild(_header);
        }
        //------------------------------------------------------------------------
        //      init Footer
        //------------------------------------------------------------------------
        private function initFooter():void {
            _footer = new InstructionPressAnyBtn_mc();
			_footer.scaleX = 1.2;
			_footer.scaleY = 1.2;
            _footer.x = 50;
            _footer.y = 540;
            this.addChild(_footer);
        }
        //------------------------------------------------------------------------
        //      dispose Background
        //------------------------------------------------------------------------
        private function disposeBackground():void {
            this.removeChild(_background);
            _background = null;
            _rectangle1 = null;
            _rectangle2 = null;
        }
        //------------------------------------------------------------------------
        //      dispose Header
        //------------------------------------------------------------------------
        private function disposeHeader():void {
            this.removeChild(_header);
            _header = null;
        }
        //------------------------------------------------------------------------
        //      dispose Footer
        //------------------------------------------------------------------------
        private function disposeFooter():void {
            this.removeChild(_footer);
            _footer = null;
        }
    }
}