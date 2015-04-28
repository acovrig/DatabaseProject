namespace DatabaseProject
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class Bank
    {
        [DisplayFormat(DataFormatString = "{0:(###) ###-####}")]
        public long FormattedPhone { get { return Phone; } }
    }
}
