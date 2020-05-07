@AbapCatalog.sqlViewName: 'ZAMATPLANT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Plant'
 
@VDM.viewType: #BASIC
@Search.searchable: true
 
@ObjectModel.usageType.serviceQuality: #A
@ObjectModel.usageType.sizeCategory : #L
@ObjectModel.usageType.dataClass: #MASTER
@ClientHandling.algorithm: #SESSION_VARIABLE
 
@Metadata.allowExtensions: true
 
define view ZAMaterialPlant
  as select from marc
    inner join   mara on marc.matnr = mara.matnr
  association [1..1] to I_Plant         as _Plant         
       on  $projection.Plant = _Plant.Plant
  association [0..*] to I_MaterialText  as _MaterialText  
       on  $projection.Material = _MaterialText.Material
  association [1..1] to I_MaterialGroup as _MaterialGroup 
       on  $projection.MaterialGroup = _MaterialGroup.MaterialGroup
{
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @ObjectModel.text.association: '_MaterialText'
  key marc.matnr as Material,
 
      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @ObjectModel.text.element: 'PlantName'
  key marc.werks as Plant,
      _Plant.PlantName,
 
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      marc.eisbe as MaterialSafetyStockQty,
 
      @Semantics.unitOfMeasure: true
      mara.meins as MaterialBaseUnit,
 
      @ObjectModel.foreignKey.association: '_MaterialGroup'
      mara.matkl as MaterialGroup ,
 
      _MaterialText,
      _MaterialGroup
}
