/// <summary>
/// component: Common
/// </summary>
page 50001 "API MD Setup Card"
{
    ApplicationArea = All;
    Caption = 'API MD Setup Card';
    PageType = Card;
    SourceTable = "API MD Setup";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field(PK; Rec.PK)
                {
                    ToolTip = 'Specifies the value of the PK field.';
                    Visible = false;
                }
            }
        }
    }
}
