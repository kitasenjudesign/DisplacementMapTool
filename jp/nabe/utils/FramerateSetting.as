package jp.nabe.utils 
{
	import flash.display.Stage;
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author nab
	 */
	public class FramerateSetting 
	{
		
		public function FramerateSetting() 
		{
			
		}
		
		public static function init(stage:Stage):void {
			
			var os:String = Capabilities.os;
			
			if ( os.indexOf("iPhone5") >= 0 || os.indexOf("iPhone6") >= 0) {
				stage.frameRate = 30;
			}else {
				stage.frameRate = 15;
			}
			
			
			
		}
		
	}

}