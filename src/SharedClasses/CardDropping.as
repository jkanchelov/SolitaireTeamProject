package SharedClasses 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Kolarov
	 */
	public class CardDropping 
	{
		protected var general:Sprite;
		protected var fieldPiles:Array;
		protected var sidePiles:Array;
		protected var isDropped:Boolean;
		
		public function CardDropping(generalPar:Sprite,fieldPilesPar:Array,sidePilesPar:Array) 
		{
			initFields(generalPar, fieldPilesPar, sidePilesPar);
		}
		
		private function initFields(generalPar:Sprite, fieldPilesPar:Array, sidepilesPar:Array):void {
			this.general = generalPar;
			this.fieldPiles = fieldPilesPar;
			this.sidePiles = sidepilesPar;
		}
		
		public function get IsDropped():Boolean {
			return this.isDropped;	
		}
		
		
	}

}