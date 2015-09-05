package Games.GrandFather
{
	import flash.text.TextField;
	import flash.geom.*;
	import flash.display.*;
	import flash.events.*;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Dimitar Genov
	 */
	public class GameButton extends Sprite
	{
		private var buttonText:String;
		
		public function GameButton(buttonTextPar:String)
		{
			drawButton(buttonTextPar);
		}
		//DRAW BUTTON
		private function drawButton(buttonTextPar:String) : void {
			this.buttonText = buttonTextPar;				
			
			var gradientType:String = GradientType.RADIAL;
			var gradientColors:Array = [0xF2290D, 0x000000];
			var gradientAlphas:Array = [1, 1];
			var gradientRatios:Array = [100, 250]; 										// the color of the elipse is more saturated
			var graeientSpreadMethod:String = SpreadMethod.PAD;
			var colorInterpolation:String = InterpolationMethod.RGB;
			var focalPointRatio:Number = 100;
			var matrix:Matrix = new Matrix();
			var boxWidth:Number = 200; 													// increases the width of the elipse
			var boxHeight:Number = 100;
			var boxRotation:Number = Math.PI / 2; 										
			var tx:Number = 0; 															// sets the position of the elipse
			var ty:Number = -20;
			
			matrix.createGradientBox(boxWidth, boxHeight, boxRotation, tx, ty);
			
			this.graphics.beginGradientFill(gradientType, gradientColors, gradientAlphas, gradientRatios, matrix, graeientSpreadMethod, colorInterpolation, focalPointRatio);
			this.graphics.drawRoundRect(0, 0, 80, 15, 20, 20);
			var buttonTxtFiled:TextField = new TextField();
			buttonTxtFiled.defaultTextFormat = new TextFormat('Comic Sans MS', 10, 0x80FF00, 'bold');
			buttonTxtFiled.text = this.buttonText;
			this.addChild(buttonTxtFiled);
			buttonTxtFiled.x = 13; 														
			buttonTxtFiled.y = -2;
			buttonTxtFiled.mouseEnabled = true;
			buttonTxtFiled.height = 50;
			buttonTxtFiled.width = 200;
			buttonTxtFiled.selectable = false;
		}
	
	}

}