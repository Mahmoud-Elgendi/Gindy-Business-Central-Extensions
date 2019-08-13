report 50110 "Voucher"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {



        dataitem(DataItemName; "Gen. Journal Line")

        {

            RequestFilterFields = "Journal Template Name", "Journal Batch Name", "Document No.";
            // RequestFilterHeading 


            column(Add_Payee; "Add Payee")
            {
                IncludeCaption = true;

            }
            column(Posting_Date; "Posting Date")
            {
                IncludeCaption = true;

            }

            column(Document_No_; "Document No.")
            {


                IncludeCaption = true;
            }
            column(External_Document_No_; "External Document No.")
            {
                IncludeCaption = true;

            }
            column(Description; Description)
            {
                IncludeCaption = true;

            }

            column(Account_No_; "Account No.")

            {
                IncludeCaption = true;

            }
            column(Bal__Account_No_; "Bal. Account No.")
            {
                IncludeCaption = true;

            }


            column(Shortcut_Dimension_1_Code; "Shortcut Dimension 1 Code")
            {
                IncludeCaption = true;

            }
            column(Shortcut_Dimension_2_Code; "Shortcut Dimension 2 Code")
            {
                IncludeCaption = true;


            }

            column(Amount; Amount)
            {
                IncludeCaption = true;

            }
            column(Debit_Amount; "Debit Amount")
            {
            }
            column(Credit_Amount; "Credit Amount")
            {
            }
            column(Company; CompanyProperty.DisplayName())
            {

            }

            column(Journal_Template_Name; "Journal Template Name")
            {

            }
            column(Journal_Batch_Name; "Journal Batch Name")
            {
            }

            column(AmountInwords; noText[1])
            {

            }
            column(Currency_Code; "Currency Code")
            {

            }
            column(UserName; UserName)
            {

            }

            column(NetPay; NetPay)
            {

            }




            trigger OnPreDataItem()
            begin
                SetCurrentKey("Document No.");
                SetAscending("Document No.", true);

                // SetAscending("Document No.");
                // SetRange("Journal Template Name", "Journal Template Name");
                // SetRange("Journal Batch Name", "Journal Batch Name");
                // // "Gen. Journal Line".COPYFILTER("Journal Batch Name", Name);
                // "Gen. Journal Line".COPYFILTER("Journal Template Name", "Journal Template Name");
                UserRec.SETRANGE("User Name", USERID);
                IF UserRec.FINDFIRST THEN
                    UserName := UserRec."Full Name";
            end;

            trigger OnAfterGetRecord();

            begin


                NewDoc := "Document No.";

                IF OldDoc = NewDoc then
                    TotalAmt += Amount
                ELSE BEGIN
                    TotalAmt := 0;
                    TotalAmt := Amount;
                END;
                IF OldDoc = NewDoc then
                    NetPay += "Credit Amount"
                ELSE BEGIN
                    NetPay := 0;
                    NetPay := "Credit Amount";
                end;
                ReportINIT.InitTextVariable();
                ReportINIT.FormatNoText(noText, TotalAmt, '');
                ReportINIT.FormatNoText(noText2, NetPay, '');


                IF "Currency Code" = '' then
                    "Currency Code" := 'SAR';
                OldDoc := "Document No.";
            end;

            trigger OnPostDataItem();
            begin
                // MESSAGE('%1..%2', noText[1], notext[2]);

            end;


        }
    }

    requestpage
    {

        SaveValues = true;

        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    //     // field(Name; SourceExpression)
                    //     // {
                    //    //     ApplicationArea = All;

                    //     }


                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    var
        COINFO: Record "Company Information";
        ReportINIT: Report Check;
        noText: Array[2] of text;
        noText2: Array[2] of text;

        TotalAmt: Decimal;
        NetPay: Decimal;
        UserRec: Record User;
        UserName: Text;
        OldDoc: Code[50];
        NewDoc: Code[50];
}