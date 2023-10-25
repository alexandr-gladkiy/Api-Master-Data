/// <summary>
/// component: Common
/// </summary>
page 50004 "API MD Role Center"
{
    ApplicationArea = All;
    Caption = 'API MD Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(Control139; "Headline RC Business Manager")
            {
            }
            // part("Requests"; "AJE MD Request Statistics")
            // {
            // }
            part("User Tasks Activities"; "User Tasks Activities")
            {
            }
            part("Emails"; "Email Activities")
            {
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group("MainMenu")
            {
                Caption = 'Api Master Data';
                action("Data Structure")
                {
                    ApplicationArea = All;
                    Caption = 'Data Structure';
                    RunObject = Page "API MD Data Structure List";
                    RunPageMode = View;
                }
                action("Setup")
                {
                    ApplicationArea = All;
                    Caption = 'Setup';
                    RunObject = Page "API MD Setup Card";
                    RunPageMode = View;
                }
                action("Data Provider List")
                {
                    ApplicationArea = All;
                    Caption = 'Setup';
                    RunObject = Page "API MD Data Provider List";
                    RunPageMode = View;
                    Visible = false;
                }
            }
        }
    }
}
