/// <summary>
/// component: Common
/// </summary>
enum 50001 "API MD Process Status"
{
    Extensible = true;

    value(0; Open)
    {
        Caption = 'Open';
    }
    value(1; Processing)
    {
        Caption = 'Processing';
    }
    value(2; Completed)
    {
        Caption = 'Completed';
    }
}
