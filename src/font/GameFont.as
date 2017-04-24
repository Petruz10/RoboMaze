package font {
    public class GameFont {
        public function GameFont():void {
            //-------------------------------------------------------------------------------------
            //  Filled
            //-------------------------------------------------------------------------------------
            [Embed(source="Enter-The-Grid.ttf", 
            fontName = "EnterTheGrid", 
            mimeType = "application/x-font", 
            unicodeRange="U+0020-U+007E", 
            advancedAntiAliasing="true", 
            embedAsCFF="false")]
            var EnterTheGrid:Class;
            //-------------------------------------------------------------------------------------
            //  Clock Font
            //-------------------------------------------------------------------------------------
            [Embed(source="digitalix.ttf", 
            fontName = "Digitalix", 
            mimeType = "application/x-font", 
            unicodeRange="U+0020-U+007E", 
            advancedAntiAliasing="true", 
            embedAsCFF="false")]
            var Digitalix:Class;
        }
    }
}