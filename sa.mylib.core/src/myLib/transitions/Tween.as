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
package myLib.transitions 
{
	import myLib.transitions.easing.Linear;
	import myLib.utils.Timer;
	
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;	

	/**
	 * Dispatched when tween start running.
	 * 
	 * @eventType myLib.transitions.TweenEvent.TWEEN_START
     */
    [Event(name="tweenStart", type="myLib.transitions.TweenEvent")]
    
    /**
	 * Dispatched when tween stop.
	 * 
	 * @eventType myLib.transitions.TweenEvent.TWEEN_STOP
     */
    [Event(name="tweenStop", type="myLib.transitions.TweenEvent")]
    
    /**
	 * Dispatched when tween start running.
	 * 
	 * @eventType myLib.transitions.TweenEvent.TWEEN_RESUME
     */
    [Event(name="tweenResume", type="myLib.transitions.TweenEvent")]
    
    /**
	 * Dispatched when tween resume (start and current time is not 0).
	 * 
	 * @eventType myLib.transitions.TweenEvent.TWEEN_PROGRESS
     */
    [Event(name="tweenProgress", type="myLib.transitions.TweenEvent")]
    
    /**
	 * Dispatched when tween is complete. 
	 * 
	 * @eventType myLib.transitions.TweenEvent.TWEEN_COMPLETE
     */
    [Event(name="tweenComplete", type="myLib.transitions.TweenEvent")]
    
    /**
	 * Dispatched when tween is reversed. 
	 * 
	 * @eventType myLib.transitions.TweenEvent.TWEEN_REVERSE
     */
    [Event(name="tweenReverse", type="myLib.transitions.TweenEvent")]
    
    /**
	 * Dispatched when tween is looped. 
	 * 
	 * @eventType myLib.transitions.TweenEvent.TWEEN_LOOP
     */
    [Event(name="tweenLoop", type="myLib.transitions.TweenEvent")]
    	
	/**
	 * @private
	 * @author SamYStudiO ( contact@samystudio.net )
	 */
	public class Tween extends EventDispatcher 
	{
		/**
		 * @private
		 */
		protected var _prop : Array = new Array();
		
		/**
		 * @private
		 */
		protected var _func : Array = new Array();
		
		/**
		 * @private
		 */
		protected var _begin : Array = new Array();
		
		/**
		 * @private
		 */
		protected var _finish : Array = new Array();
		
		/**
		 * @private
		 */
		protected var _sens : int = 1;
		
		/**
		 * @private
		 */
		protected var _startTime : uint;
		
		/**
		 * @private
		 */
		protected var _timer : Timer = new Timer();
		
		/**
		 * @private
		 */
		protected var _startTimeout : uint;
		
		/**
		 * 
		 */
		public var durationAsMilliseconds : Boolean = true;
		
		/**
		 * A Booolean that indicates if tween loop when it is complete.
		 */
		public var loop : Boolean;
	
		/**
		 * A Booolean that indicates if tween reverse when it is complete.
		 */	
		public var yoyo : Boolean;
	
		/**
		 * Get or set the tween duration.
		 * This can be expressed either with frames or milliseconds depending of Tween initialisation (constructor durationAsMilliSeconds argument).
		 */	
		public var duration : uint;
		
		/**
		 * @private
		 */
		protected var _target : Object;
		
		/**
		 * Get the target Object that is affect by tween.
		 */
		public function get target () : Object
		{
			return _target;
		}
		
		/**
		 * @private
		 */
		protected var _countElapsed : uint;
	
		/**
		 * Get the current time elapsed (frames or milliseconds depending of Tween initialisation (constructor durationAsMilliSeconds argument).
		 */
		public function get time () : Number
		{
			return _countElapsed;
		}
		
		/**
		 * Get the current tween progression between 0 and 1.
		 */
		public function get progress () : Number
		{
			return _countElapsed / duration;
		}
	
		/**
		 * Get a Boolean that indicates if tween is currently running.
		 */
		public function get running () : Boolean
		{
			return _timer.running;
		}
		
		/**
		 * Build a new Tween instance.
		 * @param obj The object which contains properties to tween.
		 * @param prop The property or Array of properties to tween.
		 * @param ease The ease function or Array of ease Function used for tweening.
		 * @param begin The begin value or Array of begin values to used with property (if NaN current property value is used).		 * @param finish The finish value or Array of finish values to used with property.
		 * @param duration The tween duration expressed in frames or milliseconds depending next arguments.
		 * @param durationAsMilliSeconds Defined how is expressed duration (frames or milliseconds).
		 * @param startDelay A delay in milliseconds to wait before tween start. if startDelay is 0 tween start immediatly.
		 */
		public function Tween ( obj : Object , prop : * = null , ease : * = null , begin : * = null , finish : * = null ,
											duration : uint = 0 , durationAsMilliSeconds : Boolean = true , startDelay : uint = 0 )
		{
			_target = obj;
			this.durationAsMilliseconds = durationAsMilliSeconds;
		
			if( arguments.length > 1 )
			{
				setProp( prop , ease , begin , finish );
				this.duration = duration;
				
				if( startDelay == 0 ) start( );
				else _startTimeout = setTimeout( start , startDelay );
			}
		}
		
		/**
		 * Set target property/properties with this Tween object.
		 * @param prop The property or Array of properties to add.
		 * @param ease The ease function or Array of ease Function used for tweening.
		 * @param begin The begin value or Array of begin values to use with property (if NaN current property value is used).
		 * @param finish The finish value or Array of finish values to use with property.
		 */
		public function setProp ( prop : * , func : * , begin : * , finish : * ) : void
		{
			_prop = prop is Array ? prop as Array : [ prop ];
			_func = func == null ? new Array( ) : func is Array ? func as Array : [ func ];			_begin = !isNaN( Number( begin ) ) ? [ begin ] : begin is Array ? begin as Array : new Array( );
			_finish = finish is Array ? finish as Array : [ finish ];
			
			var i : int = -1;
			var l : uint = _func.length;
			
			while( ++i < l )
			{
				if( _func[ i ] == null ) _func[ i ] = Linear.easeNone;
			}
			
			while( _func.length < _prop.length ) _func.push( Linear.easeNone );
			while( _begin.length < _prop.length ) _begin.push( _target[ _prop [ _begin.length ] ] );
			while( _finish.length < _prop.length ) _finish.push( _finish[ 0 ] );
		}
	
		/**
		 * Add a property with this Tween object.
		 * @param prop The property to add.
		 * @param ease The ease function used for tweening.
		 * @param begin The begin value to use with property (if NaN current property value is used).
		 * @param finish The finish value to use with property.
		 */
		public function addProp ( prop : * , func : Function , begin : Number , finish : Number ) : void
		{
			var l : uint = _prop.length;

			for( var i : uint = 0; i < l; i++ )
			{
				if( _prop[ i ] == prop ) break;
			}
			
			_prop[ i ] = prop;
			_func[ i ] = func == null ? Linear.easeNone : func;
			_begin[ i ] = isNaN( begin ) ? _target[ prop ] : begin;
			_finish[ i ] = isNaN( finish ) ? _finish[ 0 ] : finish;
		}
	
		/**
		 * Remove a target property with this Tween object.
		 * 
		 * @param prop The prop name to remove.
		 * @return A Boolean that indicates is remove is successful
		 */
		public function removeProp ( prop : String ) : Boolean
		{
			var l : uint = _prop.length;
			
			for( var i : uint = 0; i < l; i++ )
			{
				if( _prop[ i ] == prop )
				{
					_prop.splice( i , 1 );
					_func.splice( i , 1 );
					_begin.splice( i , 1 );
					_finish.splice( i , 1 );
					
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 * Remove all properties associated with this Tween.
		 */
		public function clear ( ) : void
		{
			_prop = new Array();
			_func = new Array();
			_begin = new Array();
			_finish = new Array();
		}
	
		/**
		 * Start Tween at the specified time.
		 * @param time The current time where start Tween (frames or milliseconds depending of Tween initialisation (constructor durationAsMilliSeconds argument).
		 * @param runFirstIntervalNow A optional Boolean that indicates if first interval have to be execute at once (default is true).
		 */
		public function start ( time : uint = 0 , runFirstIntervalNow : Boolean = false ) : void
		{
			if( _timer.running ) return;
			
			if( duration == 0 ) throw new Error( this + " cannot start, duration must be greater than 0" );

			if( _prop.length )
			{
				clearTimeout( _startTimeout );
				
				_timer.addEventListener( TimerEvent.TIMER , _doInterval , false , 0 , true );
				_timer.start();
				
				_countElapsed = time;
				_startTime = getTimer();
	
				if( _countElapsed != 0 ) dispatchEvent( new TweenEvent( TweenEvent.TWEEN_RESUME , _countElapsed / duration ) );
				
				dispatchEvent( new TweenEvent( TweenEvent.TWEEN_START , _countElapsed / duration ) );
				
				if( runFirstIntervalNow ) _doInterval( null );
			}
		}
	
		/**
		 * Stop Tween.
		 */
		public function stop () : void
		{
			clearTimeout( _startTimeout );
			
			if( !_timer.running ) return;
			
			_timer.stop();
			_timer.removeEventListener( TimerEvent.TIMER , _doInterval );
			
			dispatchEvent( new TweenEvent( TweenEvent.TWEEN_STOP , _countElapsed / duration ) );
		}
	
		/**
		 * Resume Tween.
		 */
		public function resume () : void
		{
			if( _timer.running ) return;
			
			start( _countElapsed );
		}
	
		/**
		 * Reach Tween at the specified position.
		 * @param time The current time Tween must be updated (frames or milliseconds depending of Tween initialisation (constructor durationAsMilliSeconds argument).
		 */
		public function seek ( time : uint ) : void
		{
			time = time > duration ? duration : time;
			
			_countElapsed = time;
			
			if( !_timer.running ) _updateProperties( );
		}
	
		/**
		 * Reverse Tween direction, begin values and finish values are inverted.
		 */
		public function reverse () : void
		{
			_sens = -_sens;
			
			dispatchEvent( new TweenEvent( TweenEvent.TWEEN_REVERSE , _countElapsed / duration ) );
		}
	
		/**
		 * @private
		 */
		protected function _getValue ( id : uint ) : Number
		{
			return _func[ id ].apply( null , [ _countElapsed , _begin[ id ] , _finish[ id ] - _begin[ id ] , duration ] );
		}
	
		/**
		 * @private
		 */
		protected function _updateProperties () : void
		{
			var i : int = -1;
			var l : uint = _prop.length;
			
			while( ++i < l ) 
			{
				if( ( _prop[ i ] is Function ) || ( _target[ _prop[ i ] ] is Function ) ) _prop[ i ].apply( _target , [ _getValue( i ) ] );
				else if( _prop[ i ] is String  && _target.hasOwnProperty( _prop[ i ] ) ) _target[ _prop[ i ] ] = _getValue( i );
			}
		}
	
		/**
		 * @private
		 */
		protected function _doInterval ( e : TimerEvent ) : void
		{
			if( !_prop.length ) stop( );
			
			var elapsed : Number = _countElapsed;
			
			_countElapsed += durationAsMilliseconds ? ( getTimer() - _startTime ) * _sens : _sens;
			_countElapsed = _countElapsed > duration ? duration : _countElapsed < 0 ? 0 : _countElapsed;
			
			_startTime = getTimer();
			
			_updateProperties( );
			
			dispatchEvent( new TweenEvent( TweenEvent.TWEEN_PROGRESS , _countElapsed / duration ) );
	
			if( _countElapsed == duration || ( _countElapsed == 0 && elapsed > 0 ) )
			{
				if( yoyo && _sens == 1 ) reverse( );	
				else if( loop )
				{
					if( yoyo ) reverse( );
					
					_countElapsed = 0;
					dispatchEvent( new TweenEvent( TweenEvent.TWEEN_LOOP , _countElapsed / duration ) );
				}
				else
				{
					if( yoyo ) reverse( );
	
					stop( );
					dispatchEvent( new TweenEvent( TweenEvent.TWEEN_COMPLETE , _countElapsed / duration ) );
				}
			}
		}
	}
}
