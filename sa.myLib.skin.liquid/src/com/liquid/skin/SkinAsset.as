/**
*
*
*	SkinAsset
*
* 	This class is distributed under Creative Commons License.
* 	http://creativecommons.org/licenses/by/2.0/fr/
*	
*	@author		Didier Brun
*	@version	1.1
* 	@link		http://www.bytearray.org
*
*/

package com.liquid.skin
{
	import com.liquid.draw.LiquidBitmap;
	import com.liquid.grid.LiquidCell;
	import com.liquid.grid.LiquidGrid;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	/**
	* @private
	*/
	public class SkinAsset{
		
		// -----------------------------------------------
		//
		// ---o static properties
		//
		// -----------------------------------------------
		
		private static var cache:Dictionary = new Dictionary();
		private static var bmps:Object = { };
		private static var bmp:BitmapData;
		
		// -----------------------------------------------
		//
		// ---o properties
		//
		// -----------------------------------------------
		
		public var grid:LiquidGrid;				// original grid
		public var liquidBitmap:LiquidBitmap;	// liquid bitmap
		public var colors:Array;				// colors 
		
		// -----------------------------------------------
		//
		// ---o constructor
		//
		// -----------------------------------------------
		
		function SkinAsset(pBmp:BitmapData):void {
			bmp = pBmp;
			if (cache[pBmp]) {
				grid = cache[pBmp].grid;
				liquidBitmap = cache[pBmp].liquidBitmap;
				colors = cache[pBmp].colors;
			}else {
				grid = getGrid(pBmp);
				liquidBitmap = getLiquidBitmap(pBmp, grid);
				colors = getColors(pBmp, grid);
				cache[pBmp] = this;
			}
		}
		
		// -----------------------------------------------
		//
		// ---o static methods
		//
		// -----------------------------------------------
		
		/**
		 *
		 */
		public function getScale9Grid(  ) : Rectangle
		{
			// Pwidth
			var pwidth:int = bmp.width;
			var pcol:Number;
			
			// Pheight
			var py:int=1;
			pcol=bmp.getPixel32(1,py);
			while (bmp.getPixel32(1,py)==pcol)py++;
			var pheight:int = py+1;
			
			// Grid center
			var cen:BitmapData=new BitmapData(pwidth-2,pheight-2,true,0);
			cen.copyPixels(bmp,new Rectangle(1,1,pwidth-2,pheight-2),new Point(0,0));
			return cen.getColorBoundsRect(0xFFFFFFFF,0,false);
		}
		
		/**
		 * get bitmap data
		 */
		public static function getBitmapData(name:String):BitmapData {
			if (bmps[name]) {
				return bmps[name];
			}else {
				try{
					var c:Class = ApplicationDomain.currentDomain.getDefinition(name) as Class;
					bmps[name] = new c(0, 0);
					return bmps[name];
				}catch (e:Error) { };
			}
			return null;
		}
	
		/**
		*	get grid
		*/
		private static function getGrid(pBmp:BitmapData):LiquidGrid{
			
			// Pwidth
			var pwidth:int = pBmp.width;
			var pcol:Number;
			
			// Pheight
			var py:int=1;
			pcol=pBmp.getPixel32(1,py);
			while (pBmp.getPixel32(1,py)==pcol)py++;
			var pheight:int = py+1;
			
			// Grid center
			var cen:BitmapData=new BitmapData(pwidth-2,pheight-2,true,0);
			cen.copyPixels(pBmp,new Rectangle(1,1,pwidth-2,pheight-2),new Point(0,0));
			var zon:Rectangle=cen.getColorBoundsRect(0xFFFFFFFF,0,false);
			var grid:LiquidGrid=LiquidGrid.scale9Grid(zon.x+1,
													  pwidth-zon.right-1,
													  zon.y+1,
													  pheight-zon.bottom-1,
													  pwidth,
													  pheight);
													  
			for (var i:int=0;i<3;i++){
				grid.getCell(1,i).drawModeX=LiquidCell.DRAW_STRETCH;
				grid.getCell(i,1).drawModeY=LiquidCell.DRAW_STRETCH;
			}
													 
			return grid;
		}
		
		/**
		*	get liquid bitmap
		*/
		private static function getLiquidBitmap(pBmp:BitmapData, pGrid:LiquidGrid):LiquidBitmap {
			
			var nbLayers:int = (pBmp.height - pGrid.height) / pGrid.height;
			var nBmp:BitmapData=new BitmapData(pGrid.width,nbLayers*pGrid.height,true,0x00FFFFFF);
			nBmp.copyPixels(pBmp,new Rectangle(0,pGrid.height,pGrid.width,pGrid.height*nbLayers),new Point(0,0));
			var lb:LiquidBitmap = new LiquidBitmap(pGrid, nBmp, nbLayers);
				
			return lb;
		}
		
		/**
		 * get colors
		 */
		private static function getColors(pBmp:BitmapData, pGrid:LiquidGrid):Array {
			
			var cols:Array;
			
			if (pBmp.height % pGrid.height == 1) {
				cols= [];
				var px:int = 0;
				while (pBmp.getPixel32(px, pBmp.height - 1) != 0) {
					cols.push(pBmp.getPixel(px, pBmp.height - 1));
					px++;
				}
			}
			
			return cols;
			
		}
		
		
	}
}