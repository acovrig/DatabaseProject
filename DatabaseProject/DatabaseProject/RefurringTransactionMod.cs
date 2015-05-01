namespace DatabaseProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class RecurringTransaction
    {
        [DisplayFormat(DataFormatString = "{0:C}")]
        public Decimal Value {
            get {
                return ExpectedAmount;
                }
            }
        }
}