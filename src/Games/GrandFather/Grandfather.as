package Games.GrandFather 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Kolarov
	 */
	public class Grandfather extends Sprite
	{
		private var deck:Deck;
		private var deckPile:DeckPile;
		private var fieldPiles:Array = [];
		private var sidePiles:Array = [];
		
		private const FieldPilesInRow:int = 10;
		
		private const StartPointField:Point = new Point(140, 20);
		private const StartPointSide:Point = new Point(600, 20);
		private const CardWidth:int = 65;
		private const CardHeight:int = 100;
		
		private var gameEngine:Engine;
		
		private var cardSkinPath:String;
		
		private var buttonRules:GameButton;
		private var buttonScore:GameButton;
		
		private var isWin:Boolean = false;
		private var isGameRunning:Boolean = true;
		
		public function Grandfather(cardSkingPathPar:String = "Data/images/Cards/Skin1/0Back.png") 
		{
			this.cardSkinPath = cardSkingPathPar;
			loadInitialComponents();
			gameEngine = new Engine(this.deck,this.deckPile,this.fieldPiles,this.sidePiles,this as Sprite,this.IsGameRunning,this.isWin,this.buttonRules);
		}
		
		private function loadInitialComponents():void {
			loadDeck();
			loadDeckPile();
			loadFieldPiles();
			loadSidePiles();
			loadGameButtons();
		}
		
		private function loadGameButtons():void {
			this.buttonRules = new GameButton("How to play...");
			
			this.addChild(this.buttonRules);
			
			this.buttonRules.x = 0;
			this.buttonRules.y = 600 - this.buttonRules.height
		}
		
		private function loadDeck():void {
			this.deck = new Deck(this.cardSkinPath);
			this.addChild(this.deck);
			this.deck.x = 20;
			this.deck.y = 140;
		}
		
		private function loadDeckPile():void {
			this.deckPile = new DeckPile();
			this.addChild(this.deckPile);
			this.deckPile.x = 20;
			this.deckPile.y = 260;
		}
		
		private function loadFieldPiles():void {
			var pileIndex:int = 0;
			var interval:int = 20;
			
			for (var row:int = 0; row < 4; row++) {
				for (var col:int = 0; col < 5; col++) {
					pileIndex++;
					var fieldPile:FieldPile = new FieldPile(pileIndex);
					this.addChild(fieldPile);
					fieldPiles.push(fieldPile);
					fieldPile.x = this.StartPointField.x + col * (interval+CardWidth);
					fieldPile.y = this.StartPointField.y + row * (interval+CardHeight);
				}	
			}
		}
		
		private function loadSidePiles():void {
			var startValues:Array = [1, 13];
			var suits:Array = ["D", "H", "C", "S"];
			
			var interval:int = 20;
			
			for (var row:int = 0; row < 4; row++) {
				var currentSuit:String = suits[row];
				
					for (var col:int = 0; col < 2; col++) {
						var currentValue:int = startValues[col];
						var sidePile:SidePile = new SidePile(currentValue, currentSuit);
						this.addChild(sidePile);
						sidePile.y = StartPointSide.y + (interval+100) * row;
						sidePile.x = StartPointSide.x + (interval + 65) * col;
						this.sidePiles.push(sidePile);
					}	
			}
		}
		
		public function get IsWin():Boolean {
			return this.isWin;	
		}
		
		public function get IsGameRunning():Boolean {
			return this.isGameRunning;	
		}
	}

}