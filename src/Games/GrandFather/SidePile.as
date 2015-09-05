package Games.GrandFather
{
	import SharedClasses.Assistant;
	import flash.display.Sprite;
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.Pile;
	
	/**
	 * ...
	 * @author Dimitar Genov
	 */
	public class SidePile extends Pile
	{
		private var sidePileCards:Array = [];
		private var startValue:int;
		private var sign:String;
		private var topCard:Card = null;
		
		public function SidePile(startValuePar:int, signPar:String)
		{
			this.startValue = startValuePar;
			this.sign = signPar;								
			drawSign();
		}
		//DRAW SIGNS IN SIDEPILE
		private function drawSign():void
		{
			var signContainer:Sprite = new Sprite();
			var path:String = "Data/images/Suit/" + this.sign + ".png";
			Assistant.fillContainerWithImg(signContainer, path, 20, 20);
			this.addChild(signContainer);
			signContainer.x = 23;										//in the middle
			signContainer.y = 35;
		}
		// ADD CARD TO SIDE PILE
		public function pushCard(card:Card):void
		{
			if(card!=null){
				this.addChild(card);
				card.x = 0;
				card.y = 0;
				this.sidePileCards.push(card);
				this.topCard = card;
			}
		}
		
		public function get TopCard():Card
		{
			return this.topCard;
		}
		
		public function get Cards():Array
		{
			
			return this.sidePileCards;
		}
		
		public function get StartValue():int
		{
			
			return this.startValue;
		}
		
		public function get Sign():String
		{
			
			return this.sign;
		}
		
		public function get CardsCount():int
		{
			
			return this.sidePileCards.length;
		}
	
	}

}