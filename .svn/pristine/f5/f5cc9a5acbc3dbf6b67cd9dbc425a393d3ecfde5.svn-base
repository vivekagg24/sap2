// ActionScript file
		import mx.printing.*;
		import flash.printing.PrintJob;
		import flash.printing.PrintJobOrientation;
	
        // The function to print the output.
        public function doPrint(gridDataProvider:Object, gridName:String, gridSite:String, gridText:String):void {
            var printJob:FlexPrintJob = new FlexPrintJob();
            if (printJob.start()) {
            	
                // Create a FormPrintView control as a child of the current view.
                var thePrintView:FormPrintView = new FormPrintView();
                Application.application.addChild(thePrintView);

                //Set the print view properties.
                thePrintView.width=1200; //printJob.pageWidth;
                thePrintView.height=printJob.pageHeight;
                //thePrintView.rotation = 90;
				thePrintView.title = gridName + " Report";
				thePrintView.site = "Site: " + gridSite;
				thePrintView.dtext = gridText;
                // Set the data provider of the FormPrintView component's data grid
                // to be the data provider of the displayed data grid.
                
				var ac:ArrayCollection = new ArrayCollection(thePrintView.grid.columns);
				var dgc:DataGridColumn = new DataGridColumn();
				if (gridName == "Goods Receipt" ) {
					dgc.headerText = "PO no.";  
					dgc.dataField = "EBELN";  
					dgc.width = 80;  
					ac.addItemAt(dgc, 0);  
					dgc = new DataGridColumn(); 
					dgc.headerText = "Line no.";  
					dgc.dataField = "EBELP";  
					dgc.width = 40;  
					ac.addItemAt(dgc, 1); 
					dgc = new DataGridColumn();  
					dgc.headerText = "Vendor";  
					dgc.dataField = "LIFNR";  
					dgc.width = 55;  
					ac.addItemAt(dgc, 2);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Vendor";  
					dgc.dataField = "NAME1";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 3);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Mill";  
					dgc.dataField = "MILL";  
					dgc.width = 44;  
					ac.addItemAt(dgc, 4);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Mill";  
					dgc.dataField = "MILL_NAME";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 5);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Material";  
					dgc.dataField = "MATNR";  
					dgc.width = 56;  
					ac.addItemAt(dgc, 6);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Material";  
					dgc.dataField = "MAKTX";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 7);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Delivery date";  
					dgc.dataField = "DEL_DATE";  
					dgc.width = 77; 
					ac.addItemAt(dgc, 8);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Delivery ticket";  
					dgc.dataField = "DEL_NOTE";  
					dgc.width = 100;  
					ac.addItemAt(dgc, 9);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Weight (ton)";  
					dgc.dataField = "WEIGHT";  
					dgc.width = 84;			
					dgc.setStyle("textAlign", "right");  
					ac.addItemAt(dgc, 10);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Reels";  
					dgc.dataField = "REEL";  
					dgc.width = 43; 
					dgc.setStyle("textAlign", "right");  
					ac.addItemAt(dgc, 11);					
					dgc = new DataGridColumn(); 										
					dgc.headerText = "Type";  
					dgc.dataField = "DEL_TYPE";  
					dgc.width = 37;  
					ac.addItemAt(dgc, 12);		
				} else if (gridName == "Stock Transfers" ) {
					dgc.headerText = "Date";  
					dgc.dataField = "TRANS_DATE";  
					dgc.width = 77;  
					ac.addItemAt(dgc, 0);  
					dgc = new DataGridColumn(); 
					dgc.headerText = "Material";  
					dgc.dataField = "MATNR";  
					dgc.width = 56;  
					ac.addItemAt(dgc, 1); 
					dgc = new DataGridColumn();  
					dgc.headerText = "Material";  
					dgc.dataField = "MAKTX";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 2);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Vendor";  
					dgc.dataField = "LIFNR";  
					dgc.width = 55;  
					ac.addItemAt(dgc, 3);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Vendor";  
					dgc.dataField = "NAME1";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 4);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Mill";  
					dgc.dataField = "MILL";  
					dgc.width = 44;  
					ac.addItemAt(dgc, 5);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Mill";  
					dgc.dataField = "MILL_NAME";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 6);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Weight (ton)";  
					dgc.dataField = "WEIGHT";  
					dgc.width = 84;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 7);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Reels";  
					dgc.dataField = "REEL";  
					dgc.width = 43;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 8);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Destination";  
					dgc.dataField = "DESTINATION";  
					dgc.width = 85;  
					ac.addItemAt(dgc, 9);
				} else if (gridName == "Stock Adjustments" ) {
					dgc.headerText = "Date";  
					dgc.dataField = "ADJUST_DATE";  
					dgc.width = 77;  
					ac.addItemAt(dgc, 0);  
					dgc = new DataGridColumn(); 
					dgc.headerText = "Material";  
					dgc.dataField = "MATNR";  
					dgc.width = 56;  
					ac.addItemAt(dgc, 1); 
					dgc = new DataGridColumn();  
					dgc.headerText = "Material Description";  
					dgc.dataField = "MAKTX";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 2);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Vendor";  
					dgc.dataField = "LIFNR";  
					dgc.width = 55;  
					ac.addItemAt(dgc, 3);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Vendor";  
					dgc.dataField = "NAME1";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 4);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Mill";  
					dgc.dataField = "MILL";  
					dgc.width = 44;  
					ac.addItemAt(dgc, 5);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Mill";  
					dgc.dataField = "MILL_NAME";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 6);
					dgc = new DataGridColumn(); 				
					dgc.headerText = "Dest Site";  
					dgc.dataField = "WERKS_REC";  
					dgc.width = 43;  
					ac.addItemAt(dgc, 7);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Reason";  
					dgc.dataField = "REASON";  
					dgc.width = 170;  
					ac.addItemAt(dgc, 8);					
					dgc = new DataGridColumn(); 
					dgc.headerText = "Comment";  
					dgc.dataField = "COMMENT";  
					dgc.width = 43;
					ac.addItemAt(dgc, 9);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Weight (ton)";  
					dgc.dataField = "WEIGHT";  
					dgc.width = 85;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 10);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Reels";  
					dgc.dataField = "REEL";  
					dgc.width = 43;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 11);
					
				} else if (gridName == "Stock Usage" ) {
					dgc.headerText = "Issue Date";  
					dgc.dataField = "ISSUE_DATE";  
					dgc.width = 80;  
					ac.addItemAt(dgc, 0);  
					dgc = new DataGridColumn(); 
					dgc.headerText = "Title";  
					dgc.dataField = "DESCRIPTION";  
					dgc.width = 200;  
					ac.addItemAt(dgc, 1); 
					dgc = new DataGridColumn();  
					dgc.headerText = "Print Date";  
					dgc.dataField = "PRINT_DATE";  
					dgc.width = 80;  
					ac.addItemAt(dgc, 2);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Print Order";  
					dgc.dataField = "PRINT_ORDER";  
					dgc.width = 90;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 3);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Pagination";  
					dgc.dataField = "PAGINATION";  
					dgc.width = 90;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 4);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Waste Allowance";  
					dgc.dataField = "WASTE_ALLOWANCE";  
					dgc.width = 70;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 5);
					dgc = new DataGridColumn(); 
					dgc.headerText = "GSM";  
					dgc.dataField = "GSM";  
					dgc.width = 40;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 6);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Start up waste";  
					dgc.dataField = "START_UP";  
					dgc.width = 80;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 7);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Contractual allowance";  
					dgc.dataField = "CONTRACT_ALLOW";  
					dgc.width = 80;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 8);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Allowance for colour changes";  
					dgc.dataField = "COLOUR_ALLOWANCE";  
					dgc.width = 80;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 9);
					dgc = new DataGridColumn(); 
					dgc.headerText = "P&amp;A total allowance";  
					dgc.dataField = "PA_ALLOWANCE";  
					dgc.width = 80;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 10);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Actual Usage";  
					dgc.dataField = "PAPER_USAGE";  
					dgc.width = 80;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 11);					
					dgc = new DataGridColumn(); 										
					dgc.headerText = "Under/over usage";  
					dgc.dataField = "UNDER_OVER";  
					dgc.width = 80;  
					dgc.setStyle("textAlign", "right"); 
					ac.addItemAt(dgc, 12);		
				} else if (gridName == "Closing Stock" ) {
					dgc.headerText = "Vendor";  
					dgc.dataField = "NAME1";  
					dgc.width = 80;  
					ac.addItemAt(dgc, 0);  
					dgc = new DataGridColumn(); 
					dgc.headerText = "Mill";  
					dgc.dataField = "MILL_NAME";  
					dgc.width = 80;  
					ac.addItemAt(dgc, 1); 
					dgc = new DataGridColumn();  
					dgc.headerText = "Material";  
					dgc.dataField = "MAKTX";  
					dgc.width = 80;  
					ac.addItemAt(dgc, 2);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Opening Weight";  
					dgc.dataField = "OPENING_WEIGHT";  
					dgc.width = 40;  
					dgc.setStyle("textAlign", "right");  
					ac.addItemAt(dgc, 3);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Opening Reels";  
					dgc.dataField = "OPENING_REEL";  
					dgc.width = 40;  
					dgc.setStyle("textAlign", "right");  
					ac.addItemAt(dgc, 4);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Del. Weight";  
					dgc.dataField = "DELIVERIES_WEIGH";  
					dgc.width = 40;  
					dgc.setStyle("textAlign", "right");  
					ac.addItemAt(dgc, 5);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Del. Reels";  
					dgc.dataField = "DELIVERIES_REEL";  
					dgc.width = 40;  
					dgc.setStyle("textAlign", "right");  
					ac.addItemAt(dgc, 6);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Adj. Weight";  
					dgc.dataField = "ADJUST_WEIGHT";  
					dgc.setStyle("textAlign", "right");  
					dgc.width = 40;  
					ac.addItemAt(dgc, 7);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Adj. Reels";  
					dgc.dataField = "ADJUST_REEL";  
					dgc.setStyle("textAlign", "right");  
					dgc.width = 40; 
					ac.addItemAt(dgc, 8);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Transf. Weight";  
					dgc.dataField = "TRANSFER_WEIGHT";  
					dgc.setStyle("textAlign", "right");  
					dgc.width = 40;  
					ac.addItemAt(dgc, 9);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Transf. Reels";  
					dgc.dataField = "TRANSFER_REEL";  
					dgc.setStyle("textAlign", "right");  
					dgc.width = 40;			
					ac.addItemAt(dgc, 10);
					dgc = new DataGridColumn(); 
					dgc.headerText = "Usage Weight";  
					dgc.dataField = "USAGE_WEIGHT";  
					dgc.setStyle("textAlign", "right");  
					dgc.width = 40; 
					ac.addItemAt(dgc, 11);					
					dgc = new DataGridColumn(); 										
					dgc.headerText = "Usage Reels";  
					dgc.dataField = "USAGE_REEL";  
					dgc.setStyle("textAlign", "right");  
					dgc.width = 40;  
					ac.addItemAt(dgc, 12);		
					dgc = new DataGridColumn(); 										
					dgc.headerText = "Closing Weight";  
					dgc.dataField = "CLOSING_WEIGHT";  
					dgc.setStyle("textAlign", "right");  
					dgc.width = 40;  
					ac.addItemAt(dgc, 13);
					dgc = new DataGridColumn(); 										
					dgc.headerText = "Closing Reels";  
					dgc.dataField = "CLOSING_REEL";  
					dgc.setStyle("textAlign", "right");  
					dgc.width = 40;  
					ac.addItemAt(dgc, 14);		
				}
				  								
				thePrintView.grid.columns = ac.toArray();  
			 	thePrintView.grid.dataProvider = gridDataProvider;              

                // Create a single-page image.
                thePrintView.showPage("single");
                
                // If the print image's data grid can hold all the provider's rows,
                // add the page to the print job.
                if(!thePrintView.grid.validNextPage)
                {
                    printJob.addObject(thePrintView);
                }
                // Otherwise, the job requires multiple pages.
                else
                {
                    // Create the first page and add it to the print job.
                    thePrintView.showPage("first");
                    printJob.addObject(thePrintView);
                    thePrintView.pageNumber++;
                    // Loop through the following code until all pages are queued.
                    while(true)
                    {
                        // Move the next page of data to the top of the print grid.
                        thePrintView.grid.nextPage();
                        thePrintView.showPage("last");
                        // If the page holds the remaining data, or if the last page
                        // was completely filled by the last grid data, queue it for printing.
                        // Test if there is data for another PrintDataGrid page.
                        if(!thePrintView.grid.validNextPage)
                        {
                            // This is the last page; queue it and exit the print loop.
                            printJob.addObject(thePrintView);
                            break;
                        }
                        else
                        // This is not the last page. Queue a middle page.
                        {
                            thePrintView.showPage("middle");
                            printJob.addObject(thePrintView);
                            thePrintView.pageNumber++;
                        }
                    }
                }
                // All pages are queued; remove the FormPrintView control to free memory.
                Application.application.removeChild(thePrintView);
            }
            // Send the job to the printer.
            printJob.send();
        }