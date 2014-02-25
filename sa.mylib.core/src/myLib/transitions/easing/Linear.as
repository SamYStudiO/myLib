// Copyright © 2007. Adobe Systems Incorporated. All Rights Reserved.
package myLib.transitions.easing
{

/**
 * @private
 * The Linear class defines easing functions to implement 
 * non-accelerated motion with ActionScript animations. 
 * Its methods all produce the same effect, a constant motion.
 * The various names <code>easeIn</code>, <code>easeOut</code> and so on,
 * are provided in the interest of polymorphism.
 */  
public class Linear
{


	//--------------------------------------------------------------------------
	//
	//  Class methods
	//
	//--------------------------------------------------------------------------
	
    /**
     *  The <code>easeNone()</code> method defines a constant motion 
     *  with no acceleration. 
     *
     *  @param t Specifies the current time, between 0 and duration inclusive.
	 *
     *  @param b Specifies the initial value of the animation property.
	 *
     *  @param c Specifies the total change in the animation property.
	 *
     *  @param d Specifies the duration of the motion.
     *
     *  @return The value of the interpolated property at the specified time.    
     */  
	public static function easeNone(t:Number, b:Number,
									c:Number, d:Number):Number
	{
		return c * t / d + b;
	}

    /**
     *  The <code>easeIn()</code> method defines a constant motion 
     *  with no acceleration. 
     *
     *  @param t Specifies the current time, between 0 and duration inclusive.
	 *
     *  @param b Specifies the initial value of the animation property.
	 *
     *  @param c Specifies the total change in the animation property.
	 *
     *  @param d Specifies the duration of the motion.
     *
     *  @return The value of the interpolated property at the specified time.    
     */  
	public static function easeIn(t:Number, b:Number,
								  c:Number, d:Number):Number
	{
		return c * t / d + b;
	}

    /**
     *  The <code>easeOut()</code> method defines a constant motion 
     *  with no acceleration. 
     *
     *  @param t Specifies the current time, between 0 and duration inclusive.
	 *
     *  @param b Specifies the initial value of the animation property.
	 *
     *  @param c Specifies the total change in the animation property.
	 *
     *  @param d Specifies the duration of the motion.
     *
     *  @return The value of the interpolated property at the specified time.     
     */  
	public static function easeOut(t:Number, b:Number,
								   c:Number, d:Number):Number
	{
		return c * t / d + b;
	}

    /**
     *  The <code>easeInOut()</code> method defines a constant motion 
     *  with no acceleration. 
     *
     *  @param t Specifies the current time, between 0 and duration inclusive.
	 *
     *  @param b Specifies the initial value of the animation property.
	 *
     *  @param c Specifies the total change in the animation property.
	 *
     *  @param d Specifies the duration of the motion.
     *
     *  @return The value of the interpolated property at the specified time.     
     */  
	public static function easeInOut(t:Number, b:Number,
									 c:Number, d:Number):Number
	{
		return c * t / d + b;
	}
}

}
