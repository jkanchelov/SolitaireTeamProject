package Games.GrandFather 
{
	import flash.text.TextField;
	import flash.geom.*;
    import flash.display.*;	
	import flash.events.*;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Mitko
	 */
	public class GameButton extends Sprite
	{
		private var buttonText:String;
		 
		
		public function GameButton(buttonTextPar:String) 
		{
			this.buttonText = buttonTextPar;
			
			var type:String = GradientType.RADIAL; 
			var colors:Array = [0xF2290D, 0x000000]; 
			var alphas:Array = [1, 1]; 
			var ratios:Array = [100, 250]; 						// цвета на елипсата в средата е по наситена
			var spreadMethod:String = SpreadMethod.PAD; 
			var interp:String = InterpolationMethod.RGB; 
			var focalPtRatio:Number = 0;
			var matrix:Matrix = new Matrix(); 
			var boxWidth:Number = 200; 							//увеличава площта на елипсата в средата
			var boxHeight:Number = 100; 
			var boxRotation:Number = Math.PI/2; // 90° 
			var tx:Number = 0; 								// от къде да започва червената елипса по Х
			var ty:Number = -20; 
			
			matrix.createGradientBox(boxWidth, boxHeight, boxRotation, tx, ty);; 
			this.graphics.beginGradientFill(type,colors,alphas,ratios, matrix, spreadMethod, interp, focalPtRatio);
			this.graphics.drawRoundRect(0,0,200,35,20,20)
			
			var buttonTxtFiled:TextField = new TextField();
			buttonTxtFiled.defaultTextFormat = new TextFormat('Comic Sans MS', 20,0x80FF00, 'bold');
			buttonTxtFiled.text = this.buttonText;
			this.addChild(buttonTxtFiled);
			buttonTxtFiled.x = this.x + (this.width / 2) - (buttonTxtFiled.textWidth / 2);
			buttonTxtFiled.mouseEnabled = true;
			buttonTxtFiled.selectable = true;			
			buttonTxtFiled.height = 50;
			buttonTxtFiled.width = 200;
			
			
			
		}
		
	}

}