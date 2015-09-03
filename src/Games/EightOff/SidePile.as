package Games.EightOff
{
	import flash.display.Sprite;
	import flash.display.Shape;
	import SharedClasses.Assistant;
	import SharedClasses.Card;
	import SharedClasses.Pile;
	
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
		
		private function drawSign():void
		{
			var signContainer:Sprite = new Sprite();
			var path:String = "Data/images/Suit/" + this.suit + ".png";
			Assistant.fillContainerWithImg(signContainer, path, 20, 20);
			this.addChild(signContainer);
			signContainer.x = 23;//in the middle
			signContainer.y = 35;
		}
		
		public function pushCard(card:Card):void
		{
			this.addChild(card);
			card.x = 0;
			card.y = 0;
			this.cards.push(card);
			determineTopCard();
		}
		
		private function determineTopCard():void
		{
			this.topCard = this.cards[this.cards.length - 1];
		}
		
		public function get TopCard():Card
		{
			return this.topCard;
		}
		
		public function get Suit():String
		{
			return this.suit;
		}
		
		public function get CardsCount():int
		{
			return this.cards.length;
		}
	}

}