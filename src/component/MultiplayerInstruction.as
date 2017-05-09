package component
{	
	import component.Instruction;
	import flash.display.Shape;

	/*
	*
	* Instruction Screen
	* 
	*/ 
	public class MultiplayerInstruction extends Instruction {

        private var _instTxt1:InstructionMultiplayer_joystick_mc;
        private var _instTxt2:InstructionMultiplayer_pickup_mc;
        private var _instTxt3:InstructionMultiplayer_sabotage_mc;
        private var _instTxt4:InstructionMultiplayer_sabotage_items_mc;

        private var _joystick:InstructionsJoystick_mc;
        private var _battery:BatteryRefill_mc;
        private var _buttons:InstructionButtons_mc;
        private var _sabotage:SabotageItems_mc;

        public function MultiplayerInstruction() {

        }

        override public function init():void {
            super.init();
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

        private function initText():void {
            _instTxt1 = new InstructionMultiplayer_joystick_mc();
            _instTxt2 = new InstructionMultiplayer_pickup_mc();
            _instTxt3 = new InstructionMultiplayer_sabotage_mc();
            _instTxt4 = new InstructionMultiplayer_sabotage_items_mc();

            _instTxt1.x = 120;
            _instTxt1.y = 142;

            _instTxt2.x = 528;
            _instTxt2.y = 142;

            _instTxt3.x = 320;
            _instTxt3.y = 430;

            _instTxt4.x = 64;
            _instTxt4.y = 266;

            this.addChild(_instTxt1);
            this.addChild(_instTxt2);
            this.addChild(_instTxt3);
            this.addChild(_instTxt4);
        }
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

            _battery.x = 415;
            _battery.y = 130;

            _buttons.x = 105;
            _buttons.y = 395;

            _sabotage.x = 528;
            _sabotage.y = 256;

            this.addChild(_joystick);
            this.addChild(_battery);
            this.addChild(_buttons);
            this.addChild(_sabotage);
        }
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