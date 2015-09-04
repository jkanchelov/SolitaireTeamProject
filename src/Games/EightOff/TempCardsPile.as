package Games.EightOff 
{
	import flash.display.Sprite;
	import SharedClasses.Card;
	
	/**
	 * ...
	 * @author Kolarov
	 */
	public class TempCardsPile extends Sprite
	{
		private var cards:Array;
		private var firstCard:Card;
		private var cardsCount:int = 0;
		
		private var interval:int = 20;

		//CREATE NEW ARRAY AND PUSH CARD IN IT AND ADD IT IN DISPLAY LIST. AT THE END TOP CARD IS DETERMINE //KOLAROV
		public function pushCard(card:Card):void
		{
			this.cards = [];
			this.cards.push(card);
			this.addChild(card);
			determineFirstCard();
		}
		
		//RETURNS CARD. IT IS REMOVED FROM ARRAY AND FROM DISPLAY LIST //KOLAROV
		public function giveCard():Card
		{
			var cardForGive:Card = this.cards.pop();
			this.removeChild(cardForGive);
			this.cards = null;
			return cardForGive;
		}
		
		// PUSH CARDS IN TEMP PILE. THE CARDS ARE PUSHED IN NEW ARRAY AND ADDED IN DISPLAY LIST //KOLAROV
		public function pushCards(choosenCards:Array):void
		{
			this.cards = [];
			for (var cardIndex:int = 0; cardIndex < choosenCards.length; cardIndex++)
			{
				var currentCard:Card = choosenCards[cardIndex];
				this.addChild(currentCard);
				currentCard.y = this.cards.length * interval;
				this.cards.push(currentCard);
			}
			determineFirstCard();
		}
		
		//TEMP PILE OBJECT RETURNS CARDS THAT CONTAINS AS ARRAY //KOLAROV
		public function giveCards():Array
		{
			var cardsForGive:Array = [];
			for (var cardIndex:int = 0; cardIndex < cards.length; cardIndex++)
			{
				var currentCard:Card = this.cards[cardIndex];
				cardsForGive.push(currentCard);
				this.removeChild(currentCard);
			}
			this.cards = null;
			return cardsForGive;
		}
		
		// DETERMINE FIRST CARD IN SEQUENCE //KOLAROV
		private function determineFirstCard():void
		{
			this.firstCard = this.cards[0];
		}
		
		//RETURNS FIRST CARD IN TEMP PILE 
		public function get FirstCard():Card
		{
			return this.firstCard;
		}
		
		//RETURNS COUNT OF CARDS THAT TEMP PILE CONTAINS
		public function get CardsCount():int
		{
			return this.cards.length;
		}
		
		public function get Cards():Array {
			return this.cards;	
		}
	
	}

}