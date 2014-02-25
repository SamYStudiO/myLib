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
 * The Original Code is myLib.
 *
 * The Initial Developer of the Original Code is
 * Samuel EMINET (aka SamYStudiO) contact@samystudio.net.
 * Portions created by the Initial Developer are Copyright (C) 2008-2011
 * the Initial Developer. All Rights Reserved.
 *
 */
package myLib.displayUtils 
{
	import flash.display.MovieClip;					
	/**
	 * Test if the specified argument is a MovieClip with at least 2 frames and so considering as a movie object.
	 * @param o The object to test.
	 * @return A Boolean that indicates if specified object is a movie object.
	 * 
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public function isMovie( o : * ) : Boolean
	{
		return o is MovieClip && ( o as MovieClip ).totalFrames > 1;
	}
}