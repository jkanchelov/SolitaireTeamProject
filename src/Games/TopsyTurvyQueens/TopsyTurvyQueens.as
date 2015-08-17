package Games.TopsyTurvyQueens
{
	
	import flash.display.*;
	import flash.media.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.net.*;
	import flash.geom.*;
	import com.greensock.*;
	import com.greensock.easing.*;
	import SharedClasses.*;
	import flash.html.HTMLLoader;
	
	
	/**
	 * ...
	 * @author SS
	 */
	public class TopsyTurvyQueens extends Sprite
	{
		
		private var backgroundContainer:Sprite = new Sprite();
		private var buttonsContainer:Sprite = new Sprite();
		private var rulesButton:TopsyMenuButton;
		private var rules:Sprite;
		private var html:HTMLLoader;
		
		public function TopsyTurvyQueens()
		{
			
			loadMenuButtons();
			var time:TimerCounter = new TimerCounter(0xFFFFFF);
			addChild(time);
		
		}
		
		private function loadMenuButtons():void
		{
			addChild(buttonsContainer);
			var newGameButton:TopsyMenuButton = new TopsyMenuButton(100, 20, 30, 30, "New game", true, 0, 0.5, -3);
			newGameButton.x = 100;
			newGameButton.y = 5;
			buttonsContainer.addChild(newGameButton);
			
			var statisticsButton:TopsyMenuButton = new TopsyMenuButton(100, 20, 30, 30, "Statistics", true, 0, 0.5, -3);
			statisticsButton.x = 202;
			statisticsButton.y = 5;
			buttonsContainer.addChild(statisticsButton);
			
			rulesButton = new TopsyMenuButton(100, 20, 30, 30, "Rules", true, 0, 0.5, -3);
			rulesButton.x = 304;
			rulesButton.y = 5;
			buttonsContainer.addChild(rulesButton);
			rulesButton.addEventListener(MouseEvent.CLICK, showRules, false, 0, true);
			
			var timerButton:TopsyMenuButton = new TopsyMenuButton(100, 20, 30, 30, "", true, 0, 0.5, -3);
			timerButton.x = 406;
			timerButton.y = 5;
			buttonsContainer.addChild(timerButton);
		
		}
		
		private function howToPlay():void
		{
			html = new HTMLLoader();
			var urlReq:URLRequest = new URLRequest("TopsyRules.txt");
			html.load(urlReq);
			html.x = 900;
			html.y = 65;
			html.width = 600;
			html.height = 500;
			html.alpha = 1;
			
			rules = new Sprite();
			rules.graphics.beginFill(0xFFFFFF);
			rules.graphics.drawRect(70, 40, 660, 550);
			rules.graphics.endFill();
			rules.alpha = 1;
			addChild(rules);
			rules.addChild(html);
			rules.addEventListener(MouseEvent.CLICK, closeRules, false, 0, true);
			
			TweenMax.to(html, 0.4, {x: 100, y: 65});
		}
		
		private function showRules(e:MouseEvent):void
		{
			howToPlay();
			rulesButton.removeEventListener(MouseEvent.CLICK, showRules);
			
		}
		
		private function closeRules(e:MouseEvent):void
		{
			rulesButton.addEventListener(MouseEvent.CLICK, showRules, false, 0, true);
			TweenMax.to(rules, 0.5, {x: 750, y: 0});
			setTimeout(dropChild, 500);
		
		}
		
		private function dropChild():void
		{
			removeChild(rules);
			
		}
		
	}

}