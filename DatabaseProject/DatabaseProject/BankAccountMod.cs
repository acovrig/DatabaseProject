namespace DatabaseProject {
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;

    public partial class BankAccount {
        [DisplayFormat(DataFormatString="{0:C}")]
        public Decimal Balance {
            get {
                return AcctBalance();
            }
        }
        public Decimal AcctBalance() {
            Decimal Balance = 0;
            foreach(Transaction t in Transactions) {
                Balance += t.Amount;
            }
            return Balance;
        }
    }
}
