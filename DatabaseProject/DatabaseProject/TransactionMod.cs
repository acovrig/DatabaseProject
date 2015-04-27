namespace DatabaseProject
{
	using System;
	using System.Collections.Generic;

	public partial class Transaction
	{
		public String Date {
			get { return TransDate.ToString("d"); }
		}
		public String Value {
			get {
				if(Amount < 0) {
					return "-$" + (Amount * -1);
				} else {
					return "$" + Amount;
				}
			}
		}
	}
}
