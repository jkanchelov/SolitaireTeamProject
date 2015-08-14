package Game
{
	import flash.display.Sprite;
	import flash.text.*
	
	/**
	 * ...
	 * @author SS
	 */
	public class MainMenuButton extends Sprite
	{
		private var buttonText:String;
		private var _width:int;
		private var _height:int;
		private var _alpha:Number;
		private var _buttonColor:uint;
		private var _textPaddingTop:int;
		
		public function MainMenuButton(width:int, height:int, text:String, buttonMode:Boolean = true, buttonColor:uint = 0, _alpha:Number = 0.5, textPaddingTop:Number = 10)
		{
			this._width = width;
			this._height = height;
			this._buttonColor = buttonColor;
			this._alpha = _alpha;
			this.buttonText = text;
			this._textPaddingTop = textPaddingTop;
			if (buttonMode)
			{
				this.buttonMode = true;
			}
			
			init();
			drawText();
		}
		
		private function init():void
		{
			var btn:Sprite = new Sprite();
			btn.graphics.lineStyle(1, 0, _alpha);
			btn.graphics.beginFill(_buttonColor, _alpha);
			btn.graphics.drawRect(0, 0, _width, _height);
			btn.graphics.endFill();
			addChild(btn);
		}
		
		private function drawText():void
		{
			var tField:TextField = new TextField();
			tField.y = _textPaddingTop;
			tField.height = 30;
			tField.width = _width - 10;
			tField.x = 10
			tField.defaultTextFormat = new TextFormat('Arial Black', 20, 0x000000);
			tField.mouseEnabled = false;
			tField.text = buttonText;
			
			addChild(tField);
		}
	
	}
}