package  
{
	import com.adobe.images.PNGEncoder;
	import dmf.GunyaFilter;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author nab
	 */
	public class Main extends Sprite
	{
		public var brush:MovieClip;
		public var mc:MovieClip;
		private var _dmf:GunyaFilter;
		private var _isDown:Boolean=false;
		private var _map:Bitmap;
		private var _tf:TextField;
		
		public function Main() 
		{
			_dmf = new GunyaFilter();
			_dmf.init(stage.stageWidth, stage.stageHeight);
			_map = new Bitmap(_dmf.map);
			addChild(_map);
			_map.visible = false;
			
			brush.visible = true;
			
			_tf = new TextField();
			_tf.text = "[UP KEY] ERASER" + " / " + "[DOWN KEY] SAVE" +" / [LEFT KEY] SHOWMAP";
			_tf.textColor = 0xffffff;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			
			addChild(_tf);
			
			stage.addEventListener(MouseEvent.MOUSE_DOWN, _onDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, _onUp);
			
			addEventListener(Event.ENTER_FRAME, _update);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
		}
		
		private function _onKeyDown(e:KeyboardEvent):void 
		{
			
			if (e.keyCode == Keyboard.LEFT) {
				_map.visible = !_map.visible;
			}

			if (e.keyCode == Keyboard.UP) {
				_dmf.isErase = !_dmf.isErase;
				_tf.text = "isErase " + _dmf.isErase;
			}
			
			if (e.keyCode == Keyboard.DOWN) {
				
				var bb:BitmapData = new BitmapData(1024, 1024, true, 0);
				var mat:Matrix = new Matrix();
				mat.scale(1024/stage.stageWidth, 1024/stage.stageHeight);
				bb.draw( _map.bitmapData, mat);
				
				var f:FileReference = new FileReference();
				var ba:ByteArray = PNGEncoder.encode(bb);
				f.save(ba, "hoge.png");
				
			}
			
		}
		
		private function _onUp(e:MouseEvent):void 
		{
			_isDown = false;
		}
		
		private function _onDown(e:MouseEvent):void 
		{
			_isDown = true;
		}
		
		private function _update(e:Event):void 
		{
			if(_isDown){	
				_dmf.update(mouseX, mouseY, brush);
				
				if(_dmf.filter){
					mc.filters = [_dmf.filter];
				}

			}
			
		}
		
	}

}