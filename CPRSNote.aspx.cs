using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HepCWriteback.gov.va.medora;
using HepCWriteback.Helpers;
using CDSTDataLayer.Models;
using System.Data.Entity;

namespace GICprsLogin
{
    public class PatientViewModel
    {
        public string localPid { get; set; }
        public string ssn { get; set; }
        public string patientName { get; set; }
        public string dob { get; set; }
        public bool IsSensitive { get; set; }

        public PatientViewModel(PatientTO patient)
        {
            localPid = patient.localPid;
            ssn = patient.ssn;
            patientName = patient.patientName;
            DateTime date;
           
        }
    }

    public class HepCLabs
    {
        public string HepCAntibody { get; set; }
        public string HepCQuantitative { get; set; }
        public string HepCQualitative { get; set; }   
    }

    
    public partial class CPRSNote : System.Web.UI.Page
    {
        EmrSvc wsEMR;
        protected void Page_Load(object sender, EventArgs e)
        {
            wsEMR = (EmrSvc)Session[SessionVariables.Service];
            if(!IsPostBack)
            {
                var patient = wsEMR.select(Request.QueryString["localPid"]);
                author.Text = Session[SessionVariables.Name].ToString();
                Patient.Text = patient.patientName;
            }                            
            
                else if (IsPostBack)
            {
                var patient = wsEMR.select(Request.QueryString["localPid"]);
                
                var context = new CohortDBContext();
                var pid = context.PatientCohorts.Where(p => p.PatientSSN == patient.ssn).SingleOrDefault();
                //var lab = pid.PatientLabs.OrderByDescending(Lab => Lab.LabChemSpecimenDateTime).Where(Lab => Lab.HepCAntibody != null)
                //    .Select(Lab => Lab.HepCAntibody).First();
                var lab = pid.PatientLabs.OrderByDescending(Lab => Lab.LabChemSpecimenDateTime).First();
                var br = BiopsyResults.Text;
                var week = drpWeek.Text;
                var drug = drpDrug.Text;
                var therapy = drpTherapy.Text;
                
                txtboxNote.Text = "Patient Name: " + patient.name.ToString() + " is currently on week " + week + 
                    " of " + drug + " treatment. Since last visit, adherence to therapy has been "+
                            //lab.HepCAntibody.ToString()   
                    therapy +". The liver biposy results were " + br +". The patients Hep C Antibody result was positive.";
            }
        }
        
        protected void submit_Click(object sender, EventArgs e)
        {
            if (wsEMR == null)
            {
                Response.Redirect("CPRSLogin.aspx");
            }
            String strExamDate1 = DateTime.Now.ToString("yyyyMMdd.HHmmss");           
            var EncounterString = "182;" + strExamDate1 + ";E";                 
            var NoteResult = wsEMR.writeNote("1971", EncounterString, txtboxNote.Text, Session[SessionVariables.UserDUZ].ToString(), "", "", "");
            if (!string.IsNullOrWhiteSpace(txtSigCode.Text))
            {
                var SignNote = wsEMR.signNote(NoteResult.id, Session[SessionVariables.UserDUZ].ToString(), txtSigCode.Text);
            }
            Session.Abandon();
            Session.Contents.RemoveAll();
            Response.Redirect("Success.aspx");
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Session.Contents.RemoveAll();
            Response.Redirect("https://mcad.v10.med.va.gov/CDSTTools");
        }

        protected void BiopsyResults_SelectedIndexChanged(object sender, EventArgs e)
        {
                   

        }

     
        
    }
}