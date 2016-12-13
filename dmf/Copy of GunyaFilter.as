package dmf 
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.filters.DisplacementMapFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	
	
	
	/**
	 * ...
	 * @author nab
	 */
	public class GunyaFilter 
	{

		private var _map:BitmapData;
		private var _filter:DisplacementMapFilter;
		private var _brush:MovieClip;
		private var _oldX:Number = 0;
		private var _oldY:Number = 0;
		
		function GunyaFilter():void {
			
		}
		
		public function init(ww:Number,hh:Number):void {
			
			_map = new BitmapData(ww, hh, false, 0x808080);
			
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
			var ct:ColorTransform = new ColorTransform(0,0,0,1,0x80,g,b,0);
		
			// draw the brush onto the displacement map:
			_map.draw(brush,brush.transform.matrix,ct,"hardlight");
		
			// blur the displacement map to make the results more smooth:
			//blurredMapBmp.applyFilter(_out,rect,pt,blurF);
			//smoothing
			
			_filter = new DisplacementMapFilter(_map,new Point(),2,4,100,100,"clamp");
			
			// do displacement:
			//img.filters = [dispMapF];
		}
		
		public function get filter():DisplacementMapFilter 
		{
			return _filter;
		}
		
	
	}
		

}