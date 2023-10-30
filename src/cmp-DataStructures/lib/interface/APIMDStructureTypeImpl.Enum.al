/// <summary>
/// component: Data Structures
/// </summary>
enum 50006 "API MD Structure Type Impl." implements "API MD IStructure"
{
    Extensible = true;

    value(0; XML)
    {
        Caption = 'XML';
        Implementation = "API MD IStructure" = "API MD Structure XML Impl.";
    }
    value(1; JSON)
    {
        Caption = 'JSON';
        Implementation = "API MD IStructure" = "API MD Structure JSON Impl.";
    }
}
