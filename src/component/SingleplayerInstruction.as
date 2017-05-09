package component
{	
	import component.Instruction;
	import flash.display.Shape;

	/*
	*
	* Instruction Screen
	* 
	*/ 
	public class SingleplayerInstruction extends Instruction {
        private var _instTxt1:InstructionSingleplayer_joystick_mc;
        private var _instTxt2:InstructionSingleplayer_pickup_mc;
        private var _joystick:InstructionsJoystick_mc;
        private var _battery:BatteryRefill_mc;

        public function SingleplayerInstruction() {

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
            _instTxt1 = new InstructionSingleplayer_joystick_mc();
            _instTxt2 = new InstructionSingleplayer_pickup_mc();

            _instTxt1.x = 270;
            _instTxt1.y = 220;

            _instTxt2.x = 170;
            _instTxt2.y = 390;

            this.addChild(_instTxt1);
            this.addChild(_instTxt2);
        }
        private function initAnimations():void {
            _joystick = new InstructionsJoystick_mc();
            _battery = new BatteryRefill_mc();

            _joystick.height = 200;
            _joystick.width = 133;

            _joystick.x = 75;
            _joystick.y = 150;

            _battery.width = 112;
            _battery.height = 35;

            _battery.x = 610;
            _battery.y = 350;

            this.addChild(_joystick);
             this.addChild(_battery);
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