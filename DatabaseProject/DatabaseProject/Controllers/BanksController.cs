using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace DatabaseProject.Controllers
{
    public class BanksController : Controller
    {
        private MoneyEntities db = new MoneyEntities();

        //
        // GET: /Banks/

        public ActionResult Index()
        {
            return View(db.Banks.ToList());
        }

        //
        // GET: /Banks/Details/5

        public ActionResult Details(int id = 0)
        {
            Bank bank = db.Banks.Find(id);
            if (bank == null)
            {
                return HttpNotFound();
            }
            return View(bank);
        }

        //
        // GET: /Banks/Create

        public ActionResult Create()
        {
            return View();
        }

        //
        // POST: /Banks/Create

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(Bank bank)
        {
            if (ModelState.IsValid)
            {
                db.Banks.Add(bank);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(bank);
        }

        //
        // GET: /Banks/Edit/5

        public ActionResult Edit(int id = 0)
        {
            Bank bank = db.Banks.Find(id);
            if (bank == null)
            {
                return HttpNotFound();
            }
            return View(bank);
        }

        //
        // POST: /Banks/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Bank bank)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bank).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(bank);
        }

        //
        // GET: /Banks/Delete/5

        public ActionResult Delete(int id = 0)
        {
            Bank bank = db.Banks.Find(id);
            if (bank == null)
            {
                return HttpNotFound();
            }
            return View(bank);
        }

        //
        // POST: /Banks/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Bank bank = db.Banks.Find(id);
            db.Banks.Remove(bank);
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