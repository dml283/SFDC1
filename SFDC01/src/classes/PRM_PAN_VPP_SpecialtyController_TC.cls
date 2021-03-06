/*========================================================================================================================+
 |  HISTORY                                                                  
 |                                                                           
 |  DATE            DEVELOPER       WR/Req     DESCRIPTION                               
 |  ====            =========       ======     ===========  
 |  02.10.2012      Anand Sharma               Test class for Controller PRM_PAN_VPP_SpecialtyController of 
                                                the PRM_PAN_VPP_Specialty page.
+=========================================================================================================================*/
@isTest
private class PRM_PAN_VPP_SpecialtyController_TC {

    static testMethod void LogicalBlockUnitTest() {
        // TO DO: implement unit test
        PRM_PAN_VPP_PanLogicalDataHelper objPanlogHelp = new PRM_PAN_VPP_PanLogicalDataHelper();
        PRM_PAN_VPP_BlockResultDataContainer objBlockResultDC = new PRM_PAN_VPP_BlockResultDataContainer();
        PRM_PAN_VPP_RequirementDataContainer objRequDC = new PRM_PAN_VPP_RequirementDataContainer();
        
        User insertUser = [Select id from User where isActive=true and profile.Name='System Administrator' limit 1];            
        System.runAs(insertUser){
            PRM_VPP_JobDataHelper.createVPPCustomSettingData();   
        }
      
        list<Account_Groupings__c> lstGrouping = new list<Account_Groupings__c>(); 
        Map<Id,List<Account>> mapAccount = new Map<Id,List<Account>>();
        list<Id> lstGroupingId = new list<Id>();
        Map<Id,List<Account_Groupings__c>> mapGrouping = new Map<Id,List<Account_Groupings__c>>();
        list<Velocity_Rule_Results__c> lstVelocityRuleResult = new list<Velocity_Rule_Results__c>();
        PRM_PAN_VPP_VelocityRuleResultsUtils PANVelocityRuleResultsUtils = new PRM_PAN_VPP_VelocityRuleResultsUtils();
        PRM_PAN_VPP_VelocityRuleResults PANVelocityRuleResults = new PRM_PAN_VPP_VelocityRuleResults();
        PRM_PAN_VPP_RuleEvaluator PANRuleEvaluator = new PRM_PAN_VPP_RuleEvaluator();
        Account_Groupings__c PAN = PRM_PAN_VPP_TestClassHelper.CreatePANGrouping();
        Account_Groupings__c LogicalBlock = PRM_PAN_VPP_TestClassHelper.CreateLogicalGrouping(PAN);
        Account ProfiledAccount = PRM_PAN_VPP_TestClassHelper.createProfiledAccount();
        
        Account_Groupings__c Grouping = PRM_PAN_VPP_TestClassHelper.CreateCountryGrouping(ProfiledAccount,LogicalBlock);
        PRM_PAN_VPP_TestClassHelper.CreatePanVelocityRule();
        PRM_PAN_VPP_TestClassHelper.CreateLogicalBlockVelocityRule();
        lstGrouping.add(LogicalBlock);
        lstGroupingId.add(LogicalBlock.Id);
        lstVelocityRuleResult = PANVelocityRuleResults.createLogicalBlockVelocityRuleResults(lstGrouping);
        // My code
        string Batchid; 
        List<EMCException> emailerrors=new List<EMCException>();
        PANVelocityRuleResults.createLogicalBlockVelocityRuleResultswitherrors(lstGrouping,Batchid,emailerrors);
        
        Test.StartTest();    
        
        ApexPages.StandardController controller01 = new ApexPages.StandardController(ProfiledAccount); 
        ApexPages.currentPage().getParameters().put('id',ProfiledAccount.Id);
        PRM_PAN_VPP_SpecialtyController specialty = new PRM_PAN_VPP_SpecialtyController() ; 
        specialty.preferredDistributorCheck(ProfiledAccount.Id, ProfiledAccount.Id);
        specialty.cancelUpdates();
        Test.StopTest();
        
    }
    
    static testMethod void PanBlockUnitTest() {
        // TO DO: implement unit test
        PRM_PAN_VPP_PanLogicalDataHelper objPanlogHelp = new PRM_PAN_VPP_PanLogicalDataHelper();
        PRM_PAN_VPP_BlockResultDataContainer objBlockResultDC = new PRM_PAN_VPP_BlockResultDataContainer();
        PRM_PAN_VPP_RequirementDataContainer objRequDC = new PRM_PAN_VPP_RequirementDataContainer();
        
        User insertUser = [Select id from User where isActive=true and profile.Name='System Administrator' limit 1];            
        System.runAs(insertUser){
            PRM_VPP_JobDataHelper.createVPPCustomSettingData();   
        }
      
        list<Account_Groupings__c> lstGrouping = new list<Account_Groupings__c>();
        list<Account_Groupings__c> lstLogicalGrouping = new list<Account_Groupings__c>();  
        Map<Id,List<Account>> mapAccount = new Map<Id,List<Account>>();
        list<Id> lstGroupingId = new list<Id>();
        list<Id> lstLogicalGroupingId = new list<Id>();
        Map<Id,List<Account_Groupings__c>> mapGrouping = new Map<Id,List<Account_Groupings__c>>();
        list<Velocity_Rule_Results__c> lstVelocityRuleResult = new list<Velocity_Rule_Results__c>();
        PRM_PAN_VPP_VelocityRuleResultsUtils PANVelocityRuleResultsUtils = new PRM_PAN_VPP_VelocityRuleResultsUtils();
        PRM_PAN_VPP_VelocityRuleResults PANVelocityRuleResults = new PRM_PAN_VPP_VelocityRuleResults();
       
        Account_Groupings__c PAN = PRM_PAN_VPP_TestClassHelper.CreatePANGrouping();
        PAN.Target_Tier__c = 'Signature';
        update PAN;
        Account_Groupings__c LogicalBlock = PRM_PAN_VPP_TestClassHelper.CreateLogicalGrouping(PAN);
        Account ProfiledAccount = PRM_PAN_VPP_TestClassHelper.createProfiledAccount();
        
        Account_Groupings__c Grouping = PRM_PAN_VPP_TestClassHelper.CreateCountryGrouping(ProfiledAccount,LogicalBlock);
        PRM_PAN_VPP_TestClassHelper.CreatePanVelocityRule();
        PRM_PAN_VPP_TestClassHelper.CreateLogicalBlockVelocityRule();
        lstGrouping.add(PAN);
        lstGroupingId.add(PAN.Id);
        lstLogicalGrouping.add(LogicalBlock);
        lstLogicalGroupingId.add(LogicalBlock.Id);
        lstVelocityRuleResult = PANVelocityRuleResults.createLogicalBlockVelocityRuleResults(lstLogicalGrouping);
        lstVelocityRuleResult = PANVelocityRuleResults.createPANLevelVelocityRuleResults(lstGrouping);
        // My code 
        string Batchid; 
        List<EMCException> emailerrors=new List<EMCException>();
        PANVelocityRuleResults.createPANLevelVelocityRuleResultswitherrors(lstGrouping,Batchid,emailerrors);
        
        
        Test.StartTest();    
        
        ApexPages.StandardController controller01 = new ApexPages.StandardController(ProfiledAccount); 
        ApexPages.currentPage().getParameters().put('id',ProfiledAccount.Id);
        PRM_PAN_VPP_SpecialtyController specialty = new PRM_PAN_VPP_SpecialtyController() ; 
        specialty.preferredDistributorCheck(ProfiledAccount.Id, ProfiledAccount.Id);
        specialty.cancelUpdates();
        
        if(specialty.lstPanContainer != null && specialty.lstPanContainer.size() >0 ){
            PRM_PAN_VPP_SpecialtyComponentController objspecialtyCompContrl = new PRM_PAN_VPP_SpecialtyComponentController();
            objspecialtyCompContrl.objPanLogicalContainer = specialty.lstPanContainer;
            objspecialtyCompContrl.getPanLogicalContainer();
            objspecialtyCompContrl.getPanLogicalContainerSingle();
            objspecialtyCompContrl.setobjPanLogicalContainer(objspecialtyCompContrl.objPanLogicalContainer);
            objspecialtyCompContrl.getobjPanLogicalContainer();
        }
            
        
        Test.StopTest();
        
    }
    
    static testMethod void DistributorUnitTest() {
       
        Account ProfiledAccount = PRM_PAN_VPP_TestClassHelper.createProfiledAccount();
        ProfiledAccount.Partner_Type__c ='Distributor'; 
        update ProfiledAccount;
        Test.StartTest();    
        
        ApexPages.StandardController controller01 = new ApexPages.StandardController(ProfiledAccount); 
        ApexPages.currentPage().getParameters().put('id',ProfiledAccount.Id);
        PRM_PAN_VPP_SpecialtyController specialty = new PRM_PAN_VPP_SpecialtyController() ; 
        
        Test.StopTest();
        
    }
    
    static testMethod void ClusterUnitTest() {
       
        Account ProfiledAccount = PRM_PAN_VPP_TestClassHelper.createProfiledAccount();
        ProfiledAccount.Cluster__c = null; 
        update ProfiledAccount;
        Test.StartTest();    
        
        ApexPages.StandardController controller01 = new ApexPages.StandardController(ProfiledAccount); 
        ApexPages.currentPage().getParameters().put('id',ProfiledAccount.Id);
        PRM_PAN_VPP_SpecialtyController specialty = new PRM_PAN_VPP_SpecialtyController() ; 
        
        Test.StopTest();
        
    }
}