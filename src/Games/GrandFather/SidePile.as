package Games.GrandFather
{
	import SharedClasses.Assistant;
	import flash.display.Sprite;
	import SharedClasses.Card;
	import SharedClasses.GrandFatherEightOff.Pile;
	
	/**
	 * ...
	 * @author Mitko
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
			super();
			drawSign();
		}
		
		//LOAD IMAGE OF SIDE PILE SUIT // Dimitar Genov
		private function drawSign():void
		{
			var signContainer:Sprite = new Sprite();
			var path:String = "Data/images/Suit/" + this.sign + ".png";
			Assistant.fillContainerWithImg(signContainer, path, 20, 20);
			this.addChild(signContainer);
			signContainer.x = 23;//in the middle
			signContainer.y = 35;
		}
		
		//PUSH CARD IN SIDE PILE.ADD IT IN ARRAY AND ADD IT IN DISPLAY LIST //Dimitar Genov
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
		
		//RETURNS TOP CARD //Dimitar Genov
		public function get TopCard():Card
		{
			return this.topCard;
		}
		
		//RETURNS CARDS THAT SIDE PILE CONTAINS //Dimitar Genov
		public function get Cards():Array
		{
			
			return this.sidePileCards;
		}
		
		//RETURNS VALUE OF THE FIRST CARD THAT CAN BE DROPPED //Dimitar Genov
		public function get StartValue():int
		{	
			return this.startValue;
		}
		
		//RETURN SUIT OF SIDE PILE //Dimitar Genov
		public function get Sign():String
		{
			return this.sign;
		}
		
		//RETURNS COUNT OF CARDS THAT SIDE PILE CONTAINS //Dimitar Genov
		public function get CardsCount():int
		{
			
			return this.sidePileCards.length;
		}
	}

}