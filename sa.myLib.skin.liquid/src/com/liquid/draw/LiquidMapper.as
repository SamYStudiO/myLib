/**
*
*
*	LiquidMapper
*	
* 	This class is distributed under Creative Commons License.
* 	http://creativecommons.org/licenses/by/2.0/fr/
*	
*	@author		Didier Brun
*	@version	1.1
* 	@link		http://www.bytearray.org
*
*/

package com.liquid.draw
{
	import com.liquid.grid.*;

	import flash.display.*;
	import flash.geom.*;
	
	
	/**
	* @private
	*/
	public class LiquidMapper {
	
		// ------------------------------------------------
		//
		// ---o private properties
		//
		// ------------------------------------------------
		
		// ------------------------------------------------
		//
		// ---o constructor
		//
		// ------------------------------------------------
		
		public function LiquidMapper():void{
		}

		// ------------------------------------------------
		//
		// ---o static methods
		//
		// ------------------------------------------------
		
		/**
		* draw liquid map on shape
		*/
		public static function drawShape(grid:LiquidGrid,bmp:LiquidBitmap,g:Graphics,layer:int=0,addx:Number=0,addy:Number=0,ads:String=""):void{
			
			if (layer < 0 || layer > bmp.getNbLayers() - 1) layer = 0;
			
			var dw:Number;
			var dh:Number;
			
			var cols:LiquidRow=grid.getCols();
			var rows:LiquidRow=grid.getRows();
			var cells:Array=grid.getCells();
					
			var mat:Matrix=new Matrix();
			
			var destx:Number;
			var desty:Number;
			var destw:Number;
			var desth:Number;
			var lab:String;
			var bcell:Object;
			var dmx:int;
			var dmy:int;
			
			var texture:BitmapData;
						
			for (var dx:int=0;dx<cols.cells.length;dx++){
				for (var dy:int=0;dy<rows.cells.length;dy++){
					
					dw=Math.round(cols.cells[dx].size);
					dh=Math.round(rows.cells[dy].size);
			
					lab = "bmp_" + dx + "_" + dy + "_" + ads;
					
						
					if (cells[dx][dy].grid!=null){
						drawShape(cells[dx][dy].grid,bmp,g,layer,grid.x+addx,grid.y+addy,lab);
					}else{
						if (dw>0 && dh>0){
							
							destx=Math.floor(cols.cells[dx].pos+grid.x+addx);
							desty=Math.floor(rows.cells[dy].pos+grid.y+addy);
							
							destw=Math.ceil(dw);
							desth=Math.ceil(dh);
							
							bcell=bmp.getBitmapCell(lab);
													
							texture=bcell.bitmap[layer];
							dmx=bcell.cell.drawModeX;
							dmy=bcell.cell.drawModeY;
							mat.identity();
							
							if (dmx==LiquidCell.DRAW_STRETCH)mat.a=destw/texture.width;
							if (dmy==LiquidCell.DRAW_STRETCH)mat.d=desth/texture.height;
							
											
							mat.tx+=destx;
							mat.ty+=desty;
							
							g.beginBitmapFill(texture,mat,true,false);
							g.drawRect(destx,desty,destw,desth);
							g.endFill();
						}
					}	
				}
			}
		}
			
		

		
		
		
		
	}
	
}

