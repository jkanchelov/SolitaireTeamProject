package SharedClasses
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import com.greensock.TweenLite;
	import com.greensock.easing.*;
	
	/**
	 * ...
	 * @author Kaloqn
	 */
	public class HelpMenu extends Sprite
	{
		private var TxtBox:TextField = new TextField();
		private var backGround:Sprite = new Sprite();
		private var helpMenuText:String;
		
		public function HelpMenu(helpMenuText:String)
		{
			this.helpMenuText = helpMenuText;
			loadBackground();
			loadText();
		}
		
		private function loadBackground():void
		{
			addChild(backGround);
			backGround.alpha = 0.03;
			backGround.graphics.beginFill(0x000000);
			backGround.graphics.drawRect(0, 0, 410, 325);
			backGround.graphics.endFill();
		}
		
		private function loadText():void
		{
			//var TxtBoxTextFormat:TextFormat = new TextFormat(); - Izlishno
			//TxtBox.setTextFormat(TxtBoxTextFormat); - Izlishno
			TxtBox.defaultTextFormat = new TextFormat('Comic Sans MS', 20, 0xFFFFFF, 'bold');
			TxtBox.text = helpMenuText;
			TxtBox.wordWrap = true;
			//TxtBox.mouseEnabled = false;
			TxtBox.selectable = false;
			TxtBox.textColor = 0xFFFFFF;
			TxtBox.height = 350;
			TxtBox.width = 400;
			//TxtBox.border = false;
			//TxtBox.borderColor = 0X000000;
			addChild(TxtBox);
			//TxtBox.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownScroll); - Izlishno
		}
		
		/*private function mouseDownScroll(event:MouseEvent):void - Izlishno
		{
			TxtBox.scrollV++;
		}*/
	}
}