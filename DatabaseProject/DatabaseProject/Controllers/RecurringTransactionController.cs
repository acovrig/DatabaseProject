using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DatabaseProject.Controllers
{
    public class RecurringTransactionController : Controller
    {
        private MoneyEntities db = new MoneyEntities();

        //
        // GET: /RecurringTransaction/

        public ActionResult Index()
        {
            var recurringtransactions = db.RecurringTransactions.Include(r => r.Category1);
            return View(recurringtransactions.ToList());
        }

        //
        // GET: /RecurringTransaction/Details/5

        public ActionResult Details(int id = 0)
        {
            RecurringTransaction recurringtransaction = db.RecurringTransactions.Find(id);
            if (recurringtransaction == null)
            {
                return HttpNotFound();
            }
            return View(recurringtransaction);
        }

        //
        // GET: /RecurringTransaction/Create

        public ActionResult Create()
        {
            ViewBag.Category = new SelectList(db.Categories, "CategoryID", "Name");
            return View();
        }

        //
        // POST: /RecurringTransaction/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(RecurringTransaction recurringtransaction)
        {
            if (ModelState.IsValid)
            {
                db.RecurringTransactions.Add(recurringtransaction);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.Category = new SelectList(db.Categories, "CategoryID", "Name", recurringtransaction.Category);
            return View(recurringtransaction);
        }

        //
        // GET: /RecurringTransaction/Edit/5

        public ActionResult Edit(int id = 0)
        {
            RecurringTransaction recurringtransaction = db.RecurringTransactions.Find(id);
            if (recurringtransaction == null)
            {
                return HttpNotFound();
            }
            ViewBag.Category = new SelectList(db.Categories, "CategoryID", "Name", recurringtransaction.Category);
            return View(recurringtransaction);
        }

        //
        // POST: /RecurringTransaction/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(RecurringTransaction recurringtransaction)
        {
            if (ModelState.IsValid)
            {
                db.Entry(recurringtransaction).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.Category = new SelectList(db.Categories, "CategoryID", "Name", recurringtransaction.Category);
            return View(recurringtransaction);
        }

        //
        // GET: /RecurringTransaction/Delete/5

        public ActionResult Delete(int id = 0)
        {
            RecurringTransaction recurringtransaction = db.RecurringTransactions.Find(id);
            if (recurringtransaction == null)
            {
                return HttpNotFound();
            }
            return View(recurringtransaction);
        }

        //
        // POST: /RecurringTransaction/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            RecurringTransaction recurringtransaction = db.RecurringTransactions.Find(id);
            db.RecurringTransactions.Remove(recurringtransaction);
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