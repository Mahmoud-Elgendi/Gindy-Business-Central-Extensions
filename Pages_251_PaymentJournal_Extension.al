pageextension 50100 Payment_Journal extends "Payment Journal"
{
    layout
    {
        // Add changes to page layout here
        // addlast(Control1)
        addafter(Description)

        {
            field("Add Payee"; "Add Payee")
            {
                ApplicationArea = All;
                ToolTip = 'Type the Payee Name';
                Caption = 'Payee Name';
                // TableRelation = "Standard Text".Description;
            }
            field("Opportunity No."; "Opportunity No.")
            {
                ApplicationArea = All;
                ToolTip = 'Select The Opportunity No.';
                Caption = 'Opportunity No.';
                TableRelation = Opportunity."No.";
            }


            field("VAT Account No."; "VAT Payer Account No.")
            {
                ApplicationArea = All;
                ToolTip = 'Select Vendor VAT No. if not found please add new';
                Caption = 'Vendor VAT No.';
                TableRelation = "VAT Numbers";

                trigger OnValidate()
                var
                    VATNumber: Record "VAT Numbers";
                begin
                    VATNumber.SetRange("VAT Payer Account No.", "VAT Payer Account No.");
                    IF VATNumber.FindFirst then
                        Validate("Vendor Payer Name", VATNumber."VAT Payer Name");
                end;

            }
            field("VAT Payer Name"; "Vendor Payer Name")
            {
                ApplicationArea = All;
                ToolTip = 'Vendor Name.';
                Caption = 'Vendor Name';
                Enabled = false;



                trigger OnValidate()
                var
                    VATNumber: Record "VAT Numbers";
                begin
                    VATNumber.SetRange("VAT Payer Name", "Vendor Payer Name");
                    IF VATNumber.FindFirst then
                        Validate("VAT Payer Account No.", VATNumber."VAT Payer Account No.");
                end;



            }
        }
    }

    actions
    {


        // addlast (Creation) {

        //          group("Printing") {


        //  addlast("P&osting")

        // Add changes to page actions here
        addlast("P&osting")
        {
            // addfirst("P&osting")
            // addfirst("F&unctions")

            // {
            // group("Vouchers Printing")
            // {
            action("Print Payment Voucher")
            {

                ApplicationArea = All;
                Image = "Print";

                RunObject = report "Payment Voucher";
                trigger OnAction();

            
                begin
                    SetRange("Journal Template Name", "Journal Template Name");
                    SetRange("Journal Batch Name", "Journal Batch Name");
                    SetRange("Document No.", "Document No.");
                    SetAccountNoFromFilter();
                    CopyFilter("Journal Template Name", "Journal Template Name");
                
                end;


            }
        }
    }

}
// }