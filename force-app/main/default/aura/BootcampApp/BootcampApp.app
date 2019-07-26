<aura:application extends="force:slds">
    <aura:attribute name="parentChange" type="String" default="Parent"/>
    
    <c:Bootcamp childChange="{!v.parentChange}"/>
    {!v.parentChange}
</aura:application>