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

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	/**
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public function getAsset( id : * , applicationDomain : ApplicationDomain = null , loaderContext : LoaderContext = null ) : IAsset
	{
		if( id is IAsset ) return id;
			
		if( !ClassUtils.isEither( id , Class , String , BitmapData , Bitmap ) || id == "" ) return null;
		
		if( id is BitmapData ) return new BitmapAsset( id );
		if( id is Bitmap ) return new BitmapAsset( ( id as Bitmap ).bitmapData );
		
		var name : String = String( id );
		
		if( name.indexOf( "/" ) >= 0 || name.indexOf( "." ) > 0 ) return new LoaderAsset( name , loaderContext );
		
		try
		{
			var AssetClass : Class = id is Class ? id : ClassUtils.getClassByName( name , applicationDomain );
			
			var asset : * = new AssetClass( );
			if( asset is IAsset ) return asset; // IAsset definition
			else if( asset is BitmapData ) return new BitmapAsset( asset ); // BitmapData	
			else if( asset is Bitmap ) return new BitmapAsset( asset.bitmapData ); // Bitmap	
			else if( asset is DisplayObject ) return new ContainerAsset( asset ); // build new Asset	
		}
		catch( error : Error ) { }
		
		return null;
	}
}
