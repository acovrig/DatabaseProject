namespace DatabaseProject
{
	using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class Transaction
    {
        [DisplayFormat(DataFormatString = "{0:d}")]
		public DateTime Date {
			get { return TransDate; }
		}
        [DisplayFormat(DataFormatString = "{0:C}")]
        public Decimal FormattedAmount
        {
            get
            {
                return Amount;
            }
        }
	}
}
