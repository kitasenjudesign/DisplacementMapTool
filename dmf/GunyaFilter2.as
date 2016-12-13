package dmf 
{
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.filters.BlurFilter;
	import starling.textures.Texture;
	//import flash.filters.DisplacementMapFilter;
	import starling.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	
	
	/**
	 * ...
	 * @author nab
	 */
	public class GunyaFilter2 
	{

		private var _map:BitmapData;
		private var _mapTexture:Texture;
		private var _filter:DisplacementMapFilter;
		private var _brush:MovieClip;
		private var _oldX:Number = 0;
		private var _oldY:Number = 0;
		private var _map2:BitmapData;
		private var _isErase:Boolean = false;
		
		
		function GunyaFilter2():void {
			
		}
		
		public function init(ww:Number,hh:Number):void {
			if (_map) {
				_map.dispose();
				_mapTexture.dispose();
			}
			_map = new BitmapData(ww, hh, false, 0x808080);
			_map2= new BitmapData(ww, hh, false, 0x808080);
			_mapTexture = Texture.fromBitmapData(_map, false);
			
		}
		
		
		public function setErase(b:Boolean):void {
			_isErase = b;
		}
		
		
		public function update(mx:Number,my:Number,brush:MovieClip):void {
			// find the mouse movement:
			var dx:Number = mx - _oldX;
			var dy:Number = my - _oldY;
			
			_oldX = mx;
			_oldY = my;
			
			// position the mouse and rotate according to direction of motion:
			brush.rotation = (Math.atan2(dy,dx))*180/Math.PI;
			brush.x = mx;
			brush.y = my;
		
			
			
			// set up a color transform to color the brush according to direction of motion:
			var g:Number = 0x80+Math.min(0x79,Math.max(-0x80,  -dx*2  ));
			var b:Number = 0x80+Math.min(0x79,Math.max(-0x80,  -dy*2  ));
			
			// draw the brush onto the displacement map:
			var abs:Number = Math.sqrt(dx * dx + dy * dy) / 10;
			var lim:Number = 2
			if (abs > lim) abs = lim;
			brush.scaleX = abs;
			brush.scaleY = abs;
		
			var ct:ColorTransform;
		
			var alp:Number = 0.2 + 0.8 * abs / lim;
			
			if (brush.scaleX != 0) {
				
				if (_isErase) {
					ct = new ColorTransform(0, 0, 0, alp*0.8, 0x80, 0x80, 0x80);
					_map.draw(brush, brush.transform.matrix, ct, BlendMode.NORMAL, null, true);
				}else {
					ct = new ColorTransform(0,0,0,alp,0x80,g,b,0);
					_map.draw(brush, brush.transform.matrix, ct, "hardlight", null, true);
				}
			}
			
			
			//onUpした瞬間だけやればいい。
			
			
			// blur the displacement map to make the results more smooth:
			//blurredMapBmp.applyFilter(_out,rect,pt,blurF);
			//smoothing
			
			
			//if (_mapTexture)_mapTexture.dispose();
			//_mapTexture = Texture.fromBitmapData(_map, false);
			_mapTexture.root.uploadBitmapData(_map);
			
			if(!_filter){
				_filter = new DisplacementMapFilter(_mapTexture,new Point(),2,4,200,200,true);
				//_filter = new DisplacementMapFilter(_mapTexture,new Point(),2,4,100,100,true);
			}else {
				_filter.mapTexture = _mapTexture;
			}
			// do displacement:
			//img.filters = [dispMapF];
		}
		
		
		public function updateHQ():void {
			
			trace("updateHQ");
			_map2.copyPixels(_map, _map.rect, new Point());
			_map2.applyFilter(_map2, _map2.rect, new Point(), new BlurFilter(8, 8, 1));
			_mapTexture.root.uploadBitmapData(_map2);

		}
		
		public function reset():void 
		{
			_map.fillRect(_map.rect, 0x808080);
			_mapTexture.root.uploadBitmapData(_map);
		}
		
		public function get filter():DisplacementMapFilter 
		{
			return _filter;
		}
		
		
		public function get oldX():Number 
		{
			return _oldX;
		}
		
		public function set oldX(value:Number):void 
		{
			_oldX = value;
		}
		
		public function get oldY():Number 
		{
			return _oldY;
		}
		
		public function set oldY(value:Number):void 
		{
			_oldY = value;
		}
		
	
	}
		

}