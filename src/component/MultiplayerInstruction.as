package component
{	
	//------------------------------------------------------------------------
	//	Flash
	//------------------------------------------------------------------------
	import flash.display.Shape;
	//------------------------------------------------------------------------
	//	Project Imports
	//------------------------------------------------------------------------
	import component.Instruction;
	//------------------------------------------------------------------------
	// 
	//	MULTIPLAYER INSTRUCTIONS - SUB CLASS
	//
	//------------------------------------------------------------------------
	public class MultiplayerInstruction extends Instruction {
		/*
		*	background graphics
		*/
        private var _rectangle1:Shape;
        private var _rectangle2:Shape;
		/*
		*	instruction texts
		*/
        private var _instTxt1:InstructionMultiplayer_joystick_mc;
        private var _instTxt2:InstructionMultiplayer_pickup_mc;
        private var _instTxt3:InstructionMultiplayer_sabotage_mc;
        private var _instTxt4:InstructionMultiplayer_sabotage_items_mc;
		/*
		*	animated graphics
		*/
        private var _joystick:InstructionsJoystick_mc;
        private var _battery:BatteryRefill_mc;
        private var _buttons:InstructionButtons_mc;
        private var _sabotage:SabotageItems_mc;
		//------------------------------------------------------------------------
		//	Constructor
		//------------------------------------------------------------------------
        public function MultiplayerInstruction() {

        }
		//------------------------------------------------------------------------
		//	init
		//------------------------------------------------------------------------
        override public function init():void {
            super.init();
            initStripes();
            initText();
            initAnimations();
        }
		//------------------------------------------------------------------------
		//	update
		//------------------------------------------------------------------------
        override public function update():void {

        }
		//------------------------------------------------------------------------
		//	dispose
		//------------------------------------------------------------------------
        override public function dispose():void {
            super.dispose();
            disposeText();
            disposeAnimations();
			disposeStripes();
        }
		//------------------------------------------------------------------------
		//	init stripes // background graphics
		//------------------------------------------------------------------------
        private function initStripes():void {
            _rectangle1 = new Shape();
            _rectangle2 = new Shape();

            _rectangle1.graphics.beginFill(0x333333);
            _rectangle1.graphics.drawRect(0, 0, 800, 140);
            _rectangle1.graphics.endFill();

            _rectangle2.graphics.beginFill(0x333333);
            _rectangle2.graphics.drawRect(0, 0, 800, 140);
            _rectangle2.graphics.endFill();

            _rectangle1.x = 0;
            _rectangle1.y = 90;

            _rectangle2.x = 0;
            _rectangle2.y = 370;

            this.addChild(_rectangle1); 
            this.addChild(_rectangle2); 
        }
		//------------------------------------------------------------------------
		//	init instruction texts
		//------------------------------------------------------------------------
        private function initText():void {
            _instTxt1 = new InstructionMultiplayer_joystick_mc();
            _instTxt2 = new InstructionMultiplayer_pickup_mc();
            _instTxt3 = new InstructionMultiplayer_sabotage_mc();
            _instTxt4 = new InstructionMultiplayer_sabotage_items_mc();

            _instTxt1.x = 114;
            _instTxt1.y = 138;

            _instTxt2.x = 499;
            _instTxt2.y = 138;

            _instTxt3.x = 320;
            _instTxt3.y = 420;

            _instTxt4.x = 37;
            _instTxt4.y = 266;

            this.addChild(_instTxt1);
            this.addChild(_instTxt2);
            this.addChild(_instTxt3);
            this.addChild(_instTxt4);
        }
		//------------------------------------------------------------------------
		//	init animations
		//------------------------------------------------------------------------
        private function initAnimations():void {
            _joystick = new InstructionsJoystick_mc();
            _battery = new BatteryRefill_mc();
            _sabotage = new SabotageItems_mc();
            _buttons = new InstructionButtons_mc();

            _joystick.height = 100;
            _joystick.width = 67;

            _joystick.x = 30;
            _joystick.y = 110;

            _battery.width = 66;
            _battery.height = 20;

            _battery.x = 418;
            _battery.y = 160;

            _buttons.x = 105;
            _buttons.y = 395;

            _sabotage.x = 528;
            _sabotage.y = 256;

            this.addChild(_joystick);
            this.addChild(_battery);
            this.addChild(_buttons);
            this.addChild(_sabotage);
        }
		
		//------------------------------------------------------------------------
		//	dispose stripes // background graphics
		//------------------------------------------------------------------------
        private function disposeStripes():void {
            this.removeChild(_rectangle1);
            this.removeChild(_rectangle2);
            _rectangle1 = null;
            _rectangle2 = null;
        }
		//------------------------------------------------------------------------
		//	dispose instruction texts
		//------------------------------------------------------------------------
        private function disposeText():void {
            this.removeChild(_instTxt1);
            this.removeChild(_instTxt2);
            this.removeChild(_instTxt3);
            this.removeChild(_instTxt4);
            _instTxt1 = null;
            _instTxt2 = null;
            _instTxt3 = null;
            _instTxt4 = null;
        }
		//------------------------------------------------------------------------
		//	dispose animated items
		//------------------------------------------------------------------------
        private function disposeAnimations():void {
            this.removeChild(_joystick);
            this.removeChild(_battery);
            this.removeChild(_buttons);
            this.removeChild(_sabotage);
            _joystick = null;
            _battery = null;
            _buttons = null;
            _sabotage = null;
        }
    }
}