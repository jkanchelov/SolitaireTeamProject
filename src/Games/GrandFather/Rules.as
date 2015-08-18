package Games.GrandFather 
{
	import flash.display.*;
	import flash.text.*;
	
	/**
	 * ...
	 * @author Kolarov
	 */
	public class Rules extends Sprite
	{
		private var rules:String = "	This solitaire uses 104 cards (2 decks). You have 20 tableau piles with one card per pile and 8 foundations. \n Aces (one of each suit) are moved to the left four foundations as they become available. \n Kings (one of each suit) are moved to the right four foundations as they become available. \n The object of the game: To build the foundation Aces up in suit to Kings, to build the foundation Kings down in suit to Aces. \n The rules: The top cards of tableau piles are available for play on foundations. You can move the cards from the waste pile to any tableau pile regardless of suit or rank. Each pile may contain up to 2 cards. Spaces are filled automatically from the waste or the stock piles. Cards cannot be moved from one tableau pile to another. \n When you have made all the moves initially available, begin turning over cards from the stock to the waste pile. The top card of the waste pile is available for play on the foundations or the tableau. \n There is one redeal.";
		
		private var backgroundPath:String = "Data/images/RulesBackgrounds/rulesbg0.png";
		
		public function Rules() 
		{
			Assistant.fillContainerWithImg(this as Sprite, backgroundPath, 800, 515);
			writeRules();
			
		}
		
		private function writeRules():void {
			
			var rulesTxtField:TextField = new TextField();
			rulesTxtField.defaultTextFormat = new TextFormat('Comic Sans MS', 15,0x000000, 'bold');
			rulesTxtField.text = rules;
			addChild(rulesTxtField);
			rulesTxtField.height = 400;
			rulesTxtField.width = 580;
			rulesTxtField.x = 105;
			rulesTxtField.y = 80;
			rulesTxtField.selectable = false;
			rulesTxtField.wordWrap = true;
		}
	}

}