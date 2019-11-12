*** Settings ***
Resource    ../../resources/SAREA/SAREA_RESOURSE.robot

*** Test Cases ***
 
SC New Start       
       Run SAREA Provision and Assign Request For SC newEVC
       Run SAREA SC Activate Request For SC newEVC
       Run SAREA Deactivate request
       Run SAREA Delete request

        
DC New Start        
       Run SAREA Provision and Assign Request For DC newEVC
       Run SAREA Activate Request For DC newEVC
       Run SAREA Deactivate request
       Run SAREA Delete request
   
                 
SC Rollback Rollforword
       Run SAREA Provision and Assign Request For SC newEVC
       Run SAREA Provision rollback for newEVC
       Run SAREA Provision Rollforword for newEVC              
       Run SAREA SC Activate Request For SC newEVC
       Run SAREA Deactivate request
       Run SAREA Delete request
       
       
DC Rollback Rollforword       
       Run SAREA Provision and Assign Request For DC newEVC
       Run SAREA Provision rollback for newEVC
       Run SAREA Provision Rollforword for newEVC
       Run SAREA Activate Request For DC newEVC 
       Run SAREA Deactivate request
       Run SAREA Delete request
       
       
SC newEVC CANCEL
       Run SAREA Provision and Assign Request For SC newEVC
       Run SAREA Provision rollback for newEVC
       
       
DC newEVC CANCEL
       Run SAREA Provision and Assign Request For DC newEVC
       Run SAREA Provision rollback for newEVC
       
       
       
SC Change CANCEL 
       Run SAREA Provision and Assign Request For SC newEVC
       Run SAREA SC Activate Request For SC newEVC
       Run SAREA Change Provision Request
       Run SAREA Change Provision Cancel Request  

       
DC Change CANCEL 
       Run SAREA Provision and Assign Request For DC newEVC
       Run SAREA Activate Request For DC newEVC
       Run SAREA Change Provision Request      
       Run SAREA Change Provision Cancel Request  

          
SC Supp Provision New EVC       
       Run SAREA Provision and Assign Request For SC newEVC
       Run SAREA Supp Provision for newEVC
       
       
DC Supp Provision New EVC
       Run SAREA Provision and Assign Request For DC newEVC
       Run SAREA Supp Provision for newEVC
       
       
SC Change-Provision and Change-activate    
       Run SAREA Provision and Assign Request For SC newEVC
       Run SAREA SC Activate Request For SC newEVC 
       Run SAREA Change Provision Request
       Run SAREA Change Activate Request
       Run SAREA Deactivate request
       Run SAREA Delete request
       
       
DC Change-Provision and Change-activate       
       Run SAREA Provision and Assign Request For DC newEVC
       Run SAREA Activate Request For DC newEVC 
       Run SAREA Change Provision Request
       Run SAREA Change Activate Request
       Run SAREA Deactivate request
       Run SAREA Delete request
       
       
SC Supp Change-Provision and Change-activate       
       Run SAREA Provision and Assign Request For SC newEVC
       Run SAREA SC Activate Request For SC newEVC 
       Run SAREA Change Provision Request
       Run SAREA Supp Change-Provision for newEVC
       Run SAREA Supp Change-Activation for newEVC       
       Run SAREA Deactivate request
       Run SAREA Delete request
       
       
DC Supp Change-Provision and Change-activate
       Run SAREA Provision and Assign Request For DC newEVC
       Run SAREA Activate Request For DC newEVC 
       Run SAREA Change Provision Request
       Run SAREA Supp Change-Provision for newEVC
       Run SAREA Supp Change-Activation for newEVC       
       Run SAREA Deactivate request
       Run SAREA Delete request
       
       
SC disconnect Rollback-Rollforward
       Run SAREA Provision and Assign Request For SC newEVC
       Run SAREA SC Activate Request For SC newEVC
       Run SAREA Deactivate request
       Run SAREA Deactivate-Rollback request
       Run SAREA Deactivate-RollForward request
       Run SAREA Delete request


DC disconnect Rollback-Rollforward
       Run SAREA Provision and Assign Request For DC newEVC
       Run SAREA Activate Request For DC newEVC
       Run SAREA Deactivate request
       Run SAREA Deactivate-Rollback request
       Run SAREA Deactivate-RollForward request
       Run SAREA Delete request



DC Rehome BG
    Run SAREA Assign Request For DC Rehome 
    Run SAREA Source Deactivate Request For Rehome
    Run SAREA Destination Activation Request For Rehome    
    Run SAREA complete Request For Rehome
    
DC Rehome non BG
    Run SAREA Assign Request For DC Rehome   
    Run SAREA Destination Activation Request For Rehome
    Run SAREA Source Deactivate Request For Rehome
    Run SAREA complete Request For Rehome

SC Rehome BG        
    Run SAREA Assign Request For SC Rehome
    Run SAREA Source Deactivate Request For Rehome
    Run SAREA Destination Activation Request For Rehome  
    Run SAREA complete Request For Rehome
    
SC Rehome non BG 
    Run SAREA Assign Request For SC Rehome
    Run SAREA Destination Activation Request For Rehome
    Run SAREA Source Deactivate Request For Rehome   
    Run SAREA complete Request For Rehome   
*** Keywords ***
























































 
