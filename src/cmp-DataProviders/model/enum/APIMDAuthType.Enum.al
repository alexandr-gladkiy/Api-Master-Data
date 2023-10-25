/// <summary>
/// component: Data Providers
/// </summary>
enum 50002 "API MD Auth. Type"
{
    Extensible = true;

    value(0; Basic)
    {
        Caption = 'Basic';
    }
    value(1; "Api Key")
    {
        Caption = 'Api Key';
    }
    value(2; NTLM)
    {
        Caption = 'NTLM';
    }
    value(3; " Auth 2.0")
    {
        Caption = ' Auth 2.0';
    }
}
