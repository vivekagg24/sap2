// ActionScript file
// Methods to be implemented to be focusalbe - i.e. to implement the interface IFocusManagerComponent
import flash.display.DisplayObject;

    //----------------------------------
    //  focusEnabled
    //----------------------------------

    /**
     *  Indicates whether the component can receive focus when clicked on.
     *  If this property is <code>false</code>, focus will be transferred to
     *  the first parent that is <code>mouseFocusEnable</code> 
     *  set to <code>true</code>.
     *  
     *  @default true
     */
    private var _focusEnabled:Boolean = true;
    [Inspectable(defaultValue="true")]
    public function get focusEnabled():Boolean
    {
        return _focusEnabled;
    }
    public function set focusEnabled(value:Boolean):void
    {
        _focusEnabled =  value;
    }
    
    
    //----------------------------------
    //  mouseFocusEnabled
    //----------------------------------

    /**
     *  @private
     *  Storage for the mouseFocusEnabled property.
     */
    private var _mouseFocusEnabled:Boolean = true;

    [Inspectable(defaultValue="true")]

    /**
     *  Whether you can receive focus when clicked on.
     *  If <code>false</code>, focus will be transferred to
     *  the first parent that is <code>mouseFocusEnable</code> 
     *  set to <code>true</code>.
     *
     *  @default true
     */
    public function get mouseFocusEnabled():Boolean
    {
        return _mouseFocusEnabled;
    }

    /**
     *  @private
     */
    public function set mouseFocusEnabled(value:Boolean):void
    {
        _mouseFocusEnabled =  value;
    }    
    
    /**
     *  Shows or hides the focus indicator around this component.
     *
     *  <p>UIComponent implements this by creating an instance of the class
     *  specified by the <code>focusSkin</code> style and positioning it
     *  appropriately.</p>
     */
    public function drawFocus(isFocused:Boolean):void
    {
      
    } 
    