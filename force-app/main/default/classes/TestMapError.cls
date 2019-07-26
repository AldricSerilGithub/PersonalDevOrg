public with sharing class TestMapError {

  public Map<Id, Product2> prodMap { get; set; }
  public Map<Id, Product2> selectedMap { get; set; }

    public TestMapError() {
    prodMap = new Map<Id, Product2>([SELECT Id, Name FROM Product2 WHERE isActive = true LIMIT 100]);
    selectedMap = new Map<Id, Product2>();
    }

  public void toggleSelect()
  {
    String pId = Apexpages.currentPage().getParameters().get('pid');
    String Aldric = Apexpages.currentPage().getParameters().get('aldric');

    //System.assertequals('hello', aldric + pId );

    if( selectedMap.containsKey(pId) )
    {
      selectedMap.remove(pId);
    }
    else
    {
      selectedMap.put(pId, prodMap.get(pId) );
    }
  }

}