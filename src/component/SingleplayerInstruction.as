package component
{	//------------------------------------------------------------------------
	// 	Flash
	//------------------------------------------------------------------------
	import flash.display.Shape;
	//------------------------------------------------------------------------
	//	Project Imports 
	//------------------------------------------------------------------------
	import component.Instruction;
	//------------------------------------------------------------------------
	// 
	//	SINGLEPLAYER INSTRUCTIONS - SUB CLASS
	//
	//------------------------------------------------------------------------
	public class SingleplayerInstruction extends Instruction {
		/*
		*	background graphics
		*/
        private var _rectangle1:Shape;
        private var _rectangle2:Shape;
        private var _rectangle3:Shape;
		/*
		*	background graphics
		*/
        private var _instTxt1:InstructionSingleplayer_joystick_mc;
        private var _instTxt2:InstructionSingleplayer_pickup_mc;
		/*
		*	animated graphics
		*/
        private var _joystick:InstructionsJoystick_mc;
        private var _battery:BatteryRefill_mc;

        public function SingleplayerInstruction() {

        }
        override public function init():void {
            super.init();
            initStripes();
            initText();
            initAnimations();
        }
        override public function update():void {

        }
        override public function dispose():void {
            super.dispose();
            disposeText();
            disposeAnimations();
        }
		private function initStripes():void {
			_rectangle1 = new Shape();
            _rectangle2 = new Shape();
            _rectangle3 = new Shape();

            _rectangle1.graphics.beginFill(0x333333);
            _rectangle1.graphics.drawRect(0, 0, 550, 200);
            _rectangle1.graphics.endFill();

            _rectangle2.graphics.beginFill(0x333333);
            _rectangle2.graphics.drawRect(0, 0, 250, 200);
            _rectangle2.graphics.endFill();

            _rectangle3.graphics.beginFill(0x333333);
            _rectangle3.graphics.drawRect(0, 0, 800, 100);
            _rectangle3.graphics.endFill();

            _rectangle1.x = 250;
            _rectangle1.y = 100;

            _rectangle2.x = 550;
            _rectangle2.y = 300;

            _rectangle3.x = 0;
            _rectangle3.y = 500;

            this.addChild(_rectangle1); 
            this.addChild(_rectangle2); 
            this.addChild(_rectangle3); 

            this.setChildIndex(_rectangle3, 1);
		}
        private function initText():void {
            _instTxt1 = new InstructionSingleplayer_joystick_mc();
            _instTxt2 = new InstructionSingleplayer_pickup_mc();

            _instTxt1.x = 65;
            _instTxt1.y = 380;

            _instTxt2.x = 360;
            _instTxt2.y = 170;

            this.addChild(_instTxt1);
            this.addChild(_instTxt2);
        }
        private function initAnimations():void {
            _joystick = new InstructionsJoystick_mc();
            _battery = new BatteryRefill_mc();

            _joystick.height = 180;
            _joystick.width = 118;

            _joystick.x = 64;
            _joystick.y = 110;

            _battery.width = 112;
            _battery.height = 35;

            _battery.x = 618;
            _battery.y = 350;

            this.addChild(_joystick);
            this.addChild(_battery);
        }
        private function disposeStripes():void {
            this.removeChild(_rectangle1);
            this.removeChild(_rectangle2);
            this.removeChild(_rectangle3);
            _rectangle1 = null;
            _rectangle2 = null;
            _rectangle3 = null;
        }
        private function disposeText():void {
            this.removeChild(_instTxt1);
            this.removeChild(_instTxt2);
            _instTxt1 = null;
            _instTxt2 = null;
        }
        private function disposeAnimations():void {
            this.removeChild(_joystick);
            this.removeChild(_battery);
            _joystick = null;
            _battery = null;
        }
    }
}