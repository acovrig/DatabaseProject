//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DatabaseProject
{
    using System;
    using System.Collections.Generic;
    
    public partial class Bank
    {
        public Bank()
        {
            this.BankAccounts = new HashSet<BankAccount>();
        }
    
        public int BankID { get; set; }
        public string Name { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public int ZIP { get; set; }
        public long Phone { get; set; }
    
        public virtual ICollection<BankAccount> BankAccounts { get; set; }
    }
}
