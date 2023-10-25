/// <summary>
/// component: Data Providers
/// </summary>
table 50002 "API MD Data Provider"
{
    Caption = 'API MD Data Provider';
    DataClassification = CustomerContent;
    LookupPageId = "API MD Data Provider List";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Name; Text[250])
        {
            Caption = 'Name';
        }
        field(3; "Auth Type"; Enum "API MD Auth. Type")
        {
            Caption = 'Auth Type';
        }
        field(4; "User Name"; Text[250])
        {
            Caption = 'User Name';
        }
        field(5; Password; Text[250])
        {
            Caption = 'Password';
        }
        field(6; "Api Key"; Text[1024])
        {
            Caption = 'Api Key';
        }
        field(7; Domain; Text[250])
        {
            Caption = 'Domain';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}
