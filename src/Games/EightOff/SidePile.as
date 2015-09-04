package Games.EightOff
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import SharedClasses.Assistant;
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.Pile;
	
	/**
	 * ...
	 * @author Kolarov
	 */
	public class SidePile extends Pile
	{
		private var suit:String;
		private var cards:Array = [];
		private var topCard:Card = null;
		
		public function SidePile(suitPar:String)
		{
			this.suit = suitPar;
			super();
			drawSign();
		}
		
		//LOAD IMAGE OF  SIDE PILE SUIT 
		private function drawSign():void
		{
			var signContainer:Sprite = new Sprite();
			var path:String = "Data/images/Suit/" + this.suit + ".png";
			Assistant.fillContainerWithImg(signContainer, path, 20, 20);
			this.addChild(signContainer);
			signContainer.x = 23;//in the middle
			signContainer.y = 35;
		}
		
		//PUSH CARD IN SIDE PILE. ADD IT IN ARRAY AND IN DISPLAY LIST
		public function pushCard(card:Card):void
		{
			this.addChild(card);
			card.x = 0;
			card.y = 0;
			this.cards.push(card);
			determineTopCard();
		}
		
		//DETERMINE TOP CARD
		private function determineTopCard():void
		{
			this.topCard = this.cards[this.cards.length - 1];
		}

		//RETURNS TOP CARD 
		public function get TopCard():Card
		{
			return this.topCard;
		}
		
		//RETURNS SUIT OF PILE
		public function get Suit():String
		{
			return this.suit;
		}
		
		//RETURNS COUNT OF CARDS THAT SIDE PILE CONTAINS
		public function get CardsCount():int
		{
			return this.cards.length;
		}
	}

}