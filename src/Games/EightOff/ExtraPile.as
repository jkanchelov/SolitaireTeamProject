package Games.EightOff
{
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.Pile;
	
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
		
		//PUSH CARD IN EXTRA PILES : IN ARRAY AND IN DISPLAY LIST 
		public function pushCard(card:Card):void
		{
			this.card.push(card);
			this.addChild(card);
		}
		
		//EXTRA PILES RETURNS ITS CARD AND THE CARD IS REMOVED FROM DISPLAY LIST 
		public function giveCard():Card
		{
			var cardForGive:Card = card[0];
			this.removeChild(cardForGive);
			this.card.pop();
			return cardForGive;
		}
		
		//CHECK IF EXTRA PILE IS EMPTY
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
		
		//RETURNS ITS CARD
		public function get itsCard():Card
		{
			return this.card[0];
		}
	
	}

}