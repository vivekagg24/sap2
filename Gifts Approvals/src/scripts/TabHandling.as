// ActionScript file
// Functions for the tabstrip control
private var tab_to_display:int;

// Which tab will show if no data comes back?
private const c_default_md_tab:int = 1; // Pre-approved retainers
private const c_default_me_tab:int = 0; // Retainers to approve (pre-approval not required)

          private function getTableCurrentTab():XMLList {
          	return getTableTab(tabSelection.selectedIndex);
          }

          private function getTableTab(int:int):XMLList {
            	// Show all contracts for the selected tab
            	
            	// "tableReturned" contains all contracts returned by SAP
            	// "table" contains all contracts in the current tab
            	var l_table:XMLList = new XMLList;
            	for (var i:String in tableReturned) {
            			var l_include:Boolean = false;
            			// The tab selected tells us which items to include
            			switch (int) {
            				case 0:  // Retainer Approval / PreApproval (ME)
            						if ( tableReturned[i].PREAPPROVED != 'X')
            							l_include = true;
            					break;
            				case 1:  // Retainer Final Approval (MD)
            						if (tableReturned[i].PREAPPROVED == 'X') 
            							l_include = true;
            					break;           				
            			}
            			if (l_include == true) l_table = l_table + tableReturned[i];
				}            	
            	return l_table;
            }
            
            private function getTabsToDisplay():void {
            	// Hides or shows tabs based on contracts returned
            	// Only shows non-empty tabs
            	// The first non-empty tab should be shown
            	tab_to_display = -1;
            	
            	for (var i:int = tabSelection.numChildren - 1; i > -1; i--) {
            		var l_string:String = getTableTab(i).toString()
            		if (!l_string || l_string == "")
            		{
            			tabSelection.getChildAt(i).visible = false;
            			tabSelection.getTabAt(i).visible = false;
            		}	
            		else
            		{ 
            			tabSelection.getChildAt(i).visible = true;
            			tabSelection.getTabAt(i).visible = true;
            			tab_to_display = i;
            		}
            	}
            	tabSelection.enabled = true;
            	if (tab_to_display == -1) 
            	{
            		// All tabs are empty, which one do we display?
            	}
            	else
            	{
            		tabSelection.selectedIndex = tab_to_display;
            	}
            }
            
            private function handleTabSelect():void {
            	// When the user picks a tab, display retainer contracts for that tab
            	// Only need to do this if we are on the first screen	
            	if (!currentState || currentState == '' || currentState == ' ')
            	table = getTableCurrentTab();
            }