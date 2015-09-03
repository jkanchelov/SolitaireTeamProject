package Games.EightOff
{
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.Pile;
	
	/**
	 * ...
	 * @author Kolarov
	 */
	public class FieldPile extends Pile
	{
		private var cards:Array = [];
		private var topCard:Card = null;
		
		private var interval:int = 40;
		
		public function FieldPile()
		{
			super();
		}
		
		public function pushCard(card:Card):void
		{
			this.addChild(card);
			card.y = this.cards.length * interval;
			this.cards.push(card);
			determineTopCard();
		}
		
		public function pushCards(cardsForPushing:Array):void
		{
			for (var cardIndex:int = 0; cardIndex < cardsForPushing.length; cardIndex++)
			{
				var currentCard:Card = cardsForPushing[cardIndex];
				this.addChild(currentCard);
				currentCard.y = this.cards.length * interval;
				this.cards.push(currentCard);
			}
			determineTopCard();
		}
		
		public function giveCards(startCard:Card):Array
		{
			var cardsForGive:Array = [];
			var indexOfStartCard:int = this.cards.indexOf(startCard);
			var numberOfCardsForGive:int = 0;
			for (var cardIndex:int = indexOfStartCard; cardIndex < cards.length; cardIndex++)
			{
				var currentCard:Card = this.cards[cardIndex];
				cardsForGive.push(currentCard);
				this.removeChild(currentCard);
				numberOfCardsForGive++;
			}
			this.cards.splice(indexOfStartCard, numberOfCardsForGive);
			determineTopCard();
			return cardsForGive;
		}
		
		public function giveCard():Card
		{
			var cardForGive:Card = this.cards.pop();
			this.removeChild(cardForGive);
			determineTopCard();
			return cardForGive;
		}
		
		public function isSequenceFrom(card:Card):Boolean
		{
			var isSequence:Boolean = true;
			var indexOfCardCard:int = this.cards.indexOf(card);
			var value:int = card.CardValue;
			
			for (var cardIndex:int = indexOfCardCard; cardIndex < this.cards.length; cardIndex++)
			{
				
				var currentCard:Card = this.cards[cardIndex];
				
				if (!(currentCard.CardValue == value && currentCard.CardSign == card.CardSign))
				{
					
					isSequence = false;
					break;
				}
				value--;
			}
			return isSequence;
		}
		
		public function countOfChoosenCards(card:Card):int {
			var indexOfChoosenCard:int = this.cards.indexOf(card);
			var countOfCards:int = 0;
			for (var cardIndex:int = indexOfChoosenCard; cardIndex < this.cards.length; cardIndex++) {
				countOfCards++;
			}
			return countOfCards;
		}
		
		private function determineTopCard():void
		{
			this.topCard = this.cards[this.cards.length - 1];
		}
		
		public function get TopCard():Card
		{
			return this.topCard;
		}
		
		public function get CardsCount():int
		{
			return this.cards.length;
		}
		
		public function get Cards():Array
		{
			return this.cards;
		}
	}

}