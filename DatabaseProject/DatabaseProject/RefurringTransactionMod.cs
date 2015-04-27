namespace DatabaseProject
{
    using System;
    using System.Collections.Generic;

    public partial class RecurringTransaction
    {
        public String Value {
            get {
                if (ExpectedAmount < 0)
                {
                    return "-$" + (ExpectedAmount * -1);
                }
                else
                {
                    return "$" + ExpectedAmount;
                }
            }
        }
    }
}
