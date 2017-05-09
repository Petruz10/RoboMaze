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
        private var _joystick:InstructionsJoystick_mc;
        private var _battery:BatteryRefill_mc;
        private var _buttons:InstructionButtons_mc;

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
            var posX = 400;
            _instTxt1 = new InstructionMultiplayer_joystick_mc();
            _instTxt2 = new InstructionMultiplayer_pickup_mc();
            _instTxt3 = new InstructionMultiplayer_sabotage_mc();

            _instTxt1.x = posX;
            _instTxt1.y = 175;

            _instTxt2.x = posX;
            _instTxt2.y = 300;

            _instTxt3.x = posX;
            _instTxt3.y = 405;

            this.addChild(_instTxt1);
            this.addChild(_instTxt2);
            this.addChild(_instTxt3);
        }
        private function initAnimations():void {
            _joystick = new InstructionsJoystick_mc();
            _battery = new BatteryRefill_mc();
            _buttons = new InstructionButtons_mc();

            _joystick.height = 100;
            _joystick.width = 67;

            _joystick.x = 200;
            _joystick.y = 145;

            _battery.width = 66;
            _battery.height = 20;

            _battery.x = 200;
            _battery.y = 280;

            _buttons.x = 140;
            _buttons.y = 380;

            this.addChild(_joystick);
            this.addChild(_battery);
            this.addChild(_buttons);
        }
        private function disposeText():void {
            this.removeChild(_instTxt1);
            this.removeChild(_instTxt2);
            this.removeChild(_instTxt3);
            _instTxt1 = null;
            _instTxt2 = null;
            _instTxt3 = null;
        }
        private function disposeAnimations():void {
            this.removeChild(_joystick);
            this.removeChild(_battery);
            this.removeChild(_buttons);
            _joystick = null;
            _battery = null;
            _buttons = null;
        }
    }
}