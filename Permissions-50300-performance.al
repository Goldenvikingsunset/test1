permissionset 50300 "Vendor Perf Run"
{
    Assignable = true;
    Caption = 'Vendor Performance';
    Permissions =
        tabledata "Vendor Performance History" = RIMD,
        table "Vendor Performance History" = X,
        page "Vendor Performance History" = X,
        page "Vendor Performance Factbox" = X,
        codeunit "Performance Calculation" = X,
        codeunit "Performance Data Collection" = X,
        codeunit "Vendor Perf. Integration" = X;
}

permissionset 50301 "Vendor Perf View"
{
    Assignable = true;
    Caption = 'Vendor Performance View';
    Permissions =
        tabledata "Vendor Performance History" = R,
        table "Vendor Performance History" = X,
        page "Vendor Performance History" = X,
        page "Vendor Performance Factbox" = X;
}