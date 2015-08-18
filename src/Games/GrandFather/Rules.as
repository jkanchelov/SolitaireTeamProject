package Games.GrandFather 
{
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Kolarov
	 */
	public class Rules extends Sprite
	{
		private var rules:String = "aaaaa";
		private var backgroundPath:String = "Data/images/RulesBackgrounds/rulesbg0.png";
		
		public function Rules() 
		{
			Assistant.fillContainerWithImg(this as Sprite, backgroundPath, 600, 400);
			writeRules();
		}
		
		private function writeRules():void {
			
		}
	}

}