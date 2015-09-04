package SharedClasses.PrisonAlternation
{
	import flash.display.Sprite;
	import flash.text.*

	/**
	 * ...
	 * @author Kaloqn
	 */
	public class HelpMenu extends Sprite
	{
		private var txtBox:TextField = new TextField();
		private var background:Sprite = new Sprite();
		private var helpMenuText:String;
		
		public function HelpMenu(helpMenuText:String)
		{
			this.helpMenuText = helpMenuText;
			loadBackground();
			loadText();
		}
		      // made by Kaloqn
		private function loadBackground():void
		{
			addChild(background);
			background.alpha = 0.2;
			background.graphics.beginFill(0x000000);
			background.graphics.drawRect(0, 0, 500, 350);
			background.graphics.endFill();
		}
			// made by Kaloqn
		private function loadText():void
		{
			var txtBoxTextFormat:TextFormat = new TextFormat();
			txtBox.setTextFormat(txtBoxTextFormat);
			txtBox.defaultTextFormat = new TextFormat('Comic Sans MS', 20, 0xFFFFFF, 'bold');
			txtBox.text = helpMenuText ;
			txtBox.x = 65;
			txtBox.wordWrap = true;
			txtBox.mouseEnabled = false;
			txtBox.selectable = false;
			txtBox.textColor = 0xFFFFFF;
			txtBox.height = 350;
			txtBox.width = 400;
			txtBox.border = false;
			txtBox.borderColor = 0X000000;
			addChild(txtBox);
		}
	}
}