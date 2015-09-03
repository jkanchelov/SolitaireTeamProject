package Games.EightOff
{
	import SharedClasses.Card;
	import SharedClasses.Pile;
	
	/**
	 * ...
	 * @author Kolarov
	 */
	public class ExtraPile extends Pile
	{
		private var card:Array = [];
		
		public function ExtraPile()
		{
			super();
		}
		
		public function pushCard(card:Card):void
		{
			this.card.push(card);
			this.addChild(card);
		}
		
		public function giveCard():Card
		{
			var cardForGive:Card = card[0];
			this.removeChild(cardForGive);
			this.card.pop();
			return cardForGive;
		}
		
		public function get isEmpty():Boolean
		{
			if (this.card.length == 0)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		public function get itsCard():Card
		{
			return this.card[0];
		}
	
	}

}