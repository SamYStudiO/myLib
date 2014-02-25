/*
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at 
 *
 *        http://www.mozilla.org/MPL/ 
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the License. 
 *
 * The Original Code is myLib Framework.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2012
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.assets.glossy
{
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;

	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public function getTexturePattern() : BitmapData
	{
		var s : Shape = new Shape();
		var g : Graphics = s.graphics;
		g.beginFill( 0x000000 , .08 );
		g.drawRect( 0 , 0 , 2 , 1 );
		g.drawRect( 0 , 1 , 1 , 1 );
		g.drawRect( 2 , 1 , 1 , 1 );
		g.drawRect( 1 , 2 , 2 , 1 );
		g.endFill();
		
		var bd : BitmapData = new BitmapData( 3 , 3 , true , 0x00000000 );
		bd.draw( s );
		
		return bd;
	}
}
