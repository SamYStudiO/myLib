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
package myLib.assets
{
	import myLib.utils.ClassUtils;

	import flash.system.ApplicationDomain;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public function getTextFieldAsset( id : * , applicationDomain : ApplicationDomain = null ) : ITextFieldAsset
	{
		if( !ClassUtils.isEither( id , Class , String ) || id == "" ) return null;
			
		try
		{
			var AssetClass : Class = id is Class ? id : ClassUtils.getClassByName( id , applicationDomain );
			
			return new AssetClass() as ITextFieldAsset;
		}
		catch( error : Error ) { }
		
		return null;
	}
}
