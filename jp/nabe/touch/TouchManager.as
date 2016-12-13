package jp.nabe.touch 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TouchEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author nab
	 */
	public class TouchManager extends Sprite
	{

		///////////////////////////////////////////////////
		//	singleton
		///////////////////////////////////////////////////
		function TouchManager() {
			if (__instance) { throw new ArgumentError("error!!!!!!"); }
		}
		
		public static var __instance:TouchManager
		public static function getInstance():TouchManager {
			if ( __instance === null ) {
				__instance = new TouchManager;
				
			}
			return __instance;
		}
		
		////////////////////////////////////////////////////

		private var _stage:Stage;
		private var text_field:TextField;
		private var _touches:Object = { };
		
		public function init(stage:Stage):void {
			
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			text_field = new TextField();
			addChild(text_field);
			text_field.textColor = 0x00ff00;
			text_field.scaleX = text_field.scaleY = 1.5;
			text_field.autoSize = TextFieldAutoSize.LEFT;
			
			/*
			stage.addEventListener(TouchEvent.TOUCH_BEGIN,function (e:TouchEvent):void{
				text_field.text = "タッチの開始 ID:" + e.touchPointID + "\n" + text_field.text;
			});

			stage.addEventListener(TouchEvent.TOUCH_MOVE,function (e:TouchEvent):void{
				text_field.text = "タッチしながら移動中 ID:" + e.touchPointID + "\n" + text_field.text;
			});

			stage.addEventListener(TouchEvent.TOUCH_END,function (e:TouchEvent):void{
				text_field.text = "タッチを終了 ID:" + e.touchPointID + "\n" + text_field.text;
			});

			stage.addEventListener(TouchEvent.TOUCH_OUT,function (e:TouchEvent):void{
				text_field.text = "タッチしながらインスタンス外へ移動（子は外扱い） ID:" + e.touchPointID + "\n" + text_field.text;
			});

			stage.addEventListener(TouchEvent.TOUCH_OVER,function (e:TouchEvent):void{
				text_field.text = "タッチしながらインスタンス内へ移動（子は外扱い） ID:" + e.touchPointID + "\n" + text_field.text;
			});

			stage.addEventListener(TouchEvent.TOUCH_ROLL_OUT,function (e:TouchEvent):void{
				text_field.text = "タッチしながらインスタンス外へ移動（子は内扱い） ID:" + e.touchPointID + "\n" + text_field.text;
			});

			stage.addEventListener(TouchEvent.TOUCH_ROLL_OVER,function (e:TouchEvent):void{
				text_field.text = "タッチしながらインスタンス内へ移動（子は内扱い） ID:" + e.touchPointID + "\n" + text_field.text;
			});

			stage.addEventListener(TouchEvent.TOUCH_TAP,function (e:TouchEvent):void{
				text_field.text = "タップ操作 ID:" + e.touchPointID + "\n" + text_field.text;
			});
			*/
			
			addEventListener(Event.ENTER_FRAME, _onUpdate);
			stage.addEventListener(TouchEvent.TOUCH_MOVE, _onMove);

		}
		
		private function _onMove(e:TouchEvent):void 
		{
			 e.touchPointID
			
		}
		
		private function _onUpdate(e:Event):void 
		{
			
		}
		
	}

}