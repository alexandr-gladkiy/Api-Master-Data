/// <summary>
/// component: Data Providers
/// </summary>
page 50003 "API MD Data Provider Card"
{
    ApplicationArea = All;
    Caption = 'API MD Data Provider Card';
    PageType = Card;
    SourceTable = "API MD Data Provider";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Api Key"; Rec."Api Key")
                {
                    ToolTip = 'Specifies the value of the Api Key field.';
                }
                field("Auth Type"; Rec."Auth Type")
                {
                    ToolTip = 'Specifies the value of the Auth Type field.';
                }
                field(Domain; Rec.Domain)
                {
                    ToolTip = 'Specifies the value of the Domain field.';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }
            }
        }
    }
}
