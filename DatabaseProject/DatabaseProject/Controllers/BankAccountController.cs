﻿using System;
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
            var bankaccounts = db.BankAccounts.Include(b => b.Bank);
            return View(bankaccounts.ToList());
        }

        //
        // GET: /BankAccount/Details/5

        public ActionResult Details(int id = 0)
        {
            BankAccount bankaccount = db.BankAccounts.Find(id);
            if (bankaccount == null)
            {
                return HttpNotFound();
            }
            return View(bankaccount);
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
        public ActionResult Create(BankAccount bankaccount)
        {
            if (ModelState.IsValid)
            {
                db.BankAccounts.Add(bankaccount);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", bankaccount.BankID);
            return View(bankaccount);
        }

        //
        // GET: /BankAccount/Edit/5

        public ActionResult Edit(int id = 0)
        {
            BankAccount bankaccount = db.BankAccounts.Find(id);
            if (bankaccount == null)
            {
                return HttpNotFound();
            }
            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", bankaccount.BankID);
            return View(bankaccount);
        }

        //
        // POST: /BankAccount/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(BankAccount bankaccount)
        {
            if (ModelState.IsValid)
            {
                db.Entry(bankaccount).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.BankID = new SelectList(db.Banks, "BankID", "Name", bankaccount.BankID);
            return View(bankaccount);
        }

        //
        // GET: /BankAccount/Delete/5

        public ActionResult Delete(int id = 0)
        {
            BankAccount bankaccount = db.BankAccounts.Find(id);
            if (bankaccount == null)
            {
                return HttpNotFound();
            }
            return View(bankaccount);
        }

        //
        // POST: /BankAccount/Delete/5

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            BankAccount bankaccount = db.BankAccounts.Find(id);
            db.BankAccounts.Remove(bankaccount);
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