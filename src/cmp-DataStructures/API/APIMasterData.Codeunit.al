/// <summary>
/// component: Data Structure
/// </summary>
codeunit 50015 "API Master Data"
{
    Subtype = Normal;

    var
        sStructure: Codeunit "API MD Structure Service";
        sStructureMap: Codeunit "API MD Structure Map Service";
        sStructureTableSetup: Codeunit "API MD Struct Tbl Set. Service";

    /// <summary>
    /// Ping.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure Ping(): Text
    begin
        exit('Pong');
    end;

    /// <summary>
    /// GetData.
    /// </summary>
    /// <param name="apiKey">Text.</param>
    /// <param name="endpoint">Text.</param>
    /// <param name="filters">Text.</param>
    /// <returns>Return variable data of type Text.</returns>
    procedure GetData(apiKey: Text; endpoint: Text; filters: Text) Data: Text
    var
        RecRef: RecordRef;
        JsonFilters: JsonObject;
        jResponse: JsonObject;
        ErrorEndpointNotFound: Label 'Endpoint %1 not found.';
        ErrorEndpointIsNotActive: Label 'Endpoint %1 not found.';
        b64: Codeunit "Base64 Convert";
    begin
        //TODO: Validate Subscriber by apiKey

        Data := '"Data":{"items":[{"no": 1,"price": 10}{"no": 2,"price": 20}{"no": 3,"price": 30}]}';
        exit;
        if not sStructure.SetByEndpoint(endpoint) then
            Error(ErrorEndpointNotFound, endpoint);

        if not sStructure.IsActive() then
            Error(ErrorEndpointIsNotActive, endpoint);

        sStructureTableSetup.SetStructureCode(sStructure.GetCode());
        if not sStructureTableSetup.SetByBaseTable() then
            Error('Endpoint is not configured correctly');

        RecRef.Open(sStructureTableSetup.GetTableNo(true));
        JsonFilters.ReadFrom(filters);
        //TODO: Set filters from json filters
        sStructure.ExportDataAsTextImpl(sStructure.GetCode(), RecRef, Data);
    end;
}
