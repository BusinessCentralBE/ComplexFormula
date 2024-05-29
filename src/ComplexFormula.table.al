table 50100 "STA Complex Formula"
{
    DataClassification = CustomerContent;
    DataPerCompany = false;
    Extensible = false;

    fields
    {
        field(1; Formula; Enum "STA Complex Formulas")
        {
        }
        field(2; "Table No."; Integer)
        {
        }
        field(3; "Record ID"; Guid)
        {
        }
        field(4; Result; Text[250])
        {
        }
    }

    keys
    {
        key(PK; Formula, "Table No.", "Record ID")
        {
            Clustered = true;
        }
    }

    procedure SaveResult(Result: Text)
    begin
        Rec.Validate("Result", CopyStr(Result, 1, MaxStrlen("Result")));
        Rec.Modify(true);
    end;

    procedure Create(ComplexFormulas: Enum "STA Complex Formulas"; TableNo: Integer; RecordId: Guid)
    begin
        Rec.Init();
        Rec.Formula := ComplexFormulas;
        Rec."Table No." := TableNo;
        Rec."Record ID" := RecordId;
        Rec.Insert(true);
    end;

}