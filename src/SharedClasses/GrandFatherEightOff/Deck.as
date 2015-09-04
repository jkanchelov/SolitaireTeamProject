package SharedClasses.GrandFatherEightOff 
{
	import flash.display.Sprite;
	import SharedClasses.*
	/**
	 * ...
	 * @author Kolarov
	 */
	public class Deck extends Sprite
	{
		protected var deck:Array = [];
		private var cardSkin:String;
		
		public function Deck(cardSkinPar:String) 
		{
			this.cardSkin = cardSkinPar;
			Assistant.fillContainerWithImg(this as Sprite, "Data/images/Cards/" + this.cardSkin + "0Back.png", 65, 100);
		}
		
		//RETURNS RANDOM NUMBER 
		private function RandomNumber():int
		{
			return (Math.floor(Math.random() * ((this.deck.length - 1) - 0 + 1)) + 0);
		}
		
		//RETURN TOP CARD //KOLAROV
		public function giveTopCard():Card
		{
			var topCard:Card;
			var randomNumber:int = RandomNumber();
			topCard = this.deck[randomNumber];
			this.deck.splice(randomNumber, 1);
			return topCard;
		}
		
		//FILL ARRAY WITH 52 DIFFERENT CARDS
		protected function loadDeck():void
		{
			var cardUrl:String;
			var cardNumbers:int = 14;
			var cardColors:int = 4;
			
			for (var i:int = 0; i < cardNumbers; i++)
			{
				if (i == 0)
				{ //pass back card
					continue;
				}
				
				for (var j:int = 0; j < cardColors; j++)
				{
					var cardColor:String;
					
					if (i == 0)
					{
						cardColor = "Back";
						cardUrl = i + cardColor;
						break;
					}
					else
					{
						switch (j)
						{
						case 0: 
							cardColor = "C";
							break;
						case 1: 
							cardColor = "D";
							break;
						case 2: 
							cardColor = "H";
							break;
						case 3: 
							cardColor = "S";
							break;
						}
					}
					
					cardUrl = i + cardColor;
					
					var card:Card = new Card(cardUrl, i, this.cardSkin);
					this.deck.push(card);
				}
			}
		}
	}

}