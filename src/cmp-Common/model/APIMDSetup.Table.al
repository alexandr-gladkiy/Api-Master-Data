/// <summary>
/// component: Common
/// </summary>
table 50001 "API MD Setup"
{
    Caption = 'API MD Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; PK; Integer)
        {
            Caption = 'PK';
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
