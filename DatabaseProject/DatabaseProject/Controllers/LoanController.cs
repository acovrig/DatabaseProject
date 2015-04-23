using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DatabaseProject.Controllers
{
    public class LoanController : Controller
    {
        private MoneyEntities db = new MoneyEntities();

        //
        // GET: /Loan/

        public ActionResult Index()
        {
            var loans = db.Loans.Include(l => l.Bank).Include(l => l.Payee);
            return View(loans.ToList());
        }

        //
        // GET: /Loan/Details/5

        public ActionResult Details(int id = 0)
        {
            Loan loan = db.Loans.Find(id);
            if (loan == null)
            {
                return HttpNotFound();
            }
            return View(loan);
        }

        //
        // GET: /Loan/Create

        public ActionResult Create()
        {
            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name");
            ViewBag.Company = new SelectList(db.Payees, "Name", "Category");
            return View();
        }

        //
        // POST: /Loan/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Loan loan)
        {
            if (ModelState.IsValid)
            {
                db.Loans.Add(loan);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", loan.BankID);
            ViewBag.Company = new SelectList(db.Payees, "Name", "Category", loan.Company);
            return View(loan);
        }

        //
        // GET: /Loan/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Loan loan = db.Loans.Find(id);
            if (loan == null)
            {
                return HttpNotFound();
            }
            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", loan.BankID);
            ViewBag.Company = new SelectList(db.Payees, "Name", "Category", loan.Company);
            return View(loan);
        }

        //
        // POST: /Loan/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Loan loan)
        {
            if (ModelState.IsValid)
            {
                db.Entry(loan).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", loan.BankID);
            ViewBag.Company = new SelectList(db.Payees, "Name", "Category", loan.Company);
            return View(loan);
        }

        //
        // GET: /Loan/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Loan loan = db.Loans.Find(id);
            if (loan == null)
            {
                return HttpNotFound();
            }
            return View(loan);
        }

        //
        // POST: /Loan/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Loan loan = db.Loans.Find(id);
            db.Loans.Remove(loan);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
    }
}