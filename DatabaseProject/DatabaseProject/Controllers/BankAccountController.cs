using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DatabaseProject.Controllers
{
    public class BankAccountController : Controller
    {
        private MoneyEntities db = new MoneyEntities();

        //
        // GET: /BankAccount/

        public ActionResult Index()
        {
            var accounts = db.Accounts.Include(a => a.Bank);
            return View(accounts.ToList());
        }

        //
        // GET: /BankAccount/Details/5

        public ActionResult Details(int id = 0)
        {
            Account account = db.Accounts.Find(id);
            if (account == null)
            {
                return HttpNotFound();
            }
            return View(account);
        }

        //
        // GET: /BankAccount/Create

        public ActionResult Create()
        {
            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name");
            return View();
        }

        //
        // POST: /BankAccount/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Account account)
        {
            if (ModelState.IsValid)
            {
                db.Accounts.Add(account);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", account.BankID);
            return View(account);
        }

        //
        // GET: /BankAccount/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Account account = db.Accounts.Find(id);
            if (account == null)
            {
                return HttpNotFound();
            }
            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", account.BankID);
            return View(account);
        }

        //
        // POST: /BankAccount/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Account account)
        {
            if (ModelState.IsValid)
            {
                db.Entry(account).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", account.BankID);
            return View(account);
        }

        //
        // GET: /BankAccount/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Account account = db.Accounts.Find(id);
            if (account == null)
            {
                return HttpNotFound();
            }
            return View(account);
        }

        //
        // POST: /BankAccount/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Account account = db.Accounts.Find(id);
            db.Accounts.Remove(account);
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