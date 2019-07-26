<aura:application >
    
    <ltng:require styles="{!$Resource.SLDS213 +
                          '/assets/styles/salesforce-lightning-design-system.css'}"/>
 
 	<div class="slds">   
		<c:LightningPortal />
    </div>
    <div align="Center">
    	<c:svgIcon svgPath="/resource/slds213/assets/icons/standard-sprite/svg/symbols.svg#user" category="standard" size="large" name="user" />
    </div>    
</aura:application>