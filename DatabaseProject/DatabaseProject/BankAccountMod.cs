namespace DatabaseProject {
    using System;
    using System.Collections.Generic;

    public partial class BankAccount {
        public String Balance {
            get {
                return AcctBalance();
            }
        }
        public String AcctBalance() {
            Decimal Balance = 0;
            foreach(Transaction t in Transactions) {
                Balance += t.Amount;
            }
            if (Balance < 0) {
                return "-$" + (Balance * -1);
            }
            else {
                return "$" + Balance;
            }
        }
    }
}
