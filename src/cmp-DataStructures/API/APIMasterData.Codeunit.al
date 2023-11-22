/// <summary>
/// component: Data Structure
/// </summary>
codeunit 50015 "API Master Data"
{
    Subtype = Normal;

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
    procedure GetData(apiKey: Text; endpoint: Text; filters: Text) data: Text
    begin
        exit('endpoint');
    end;
}
