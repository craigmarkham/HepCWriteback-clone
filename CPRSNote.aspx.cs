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
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Timers;
using System.Windows.Forms;

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

    //public class CohortDBContext : DbContext
    //{
    //    public DbSet<PatientCohorts> PatientCohorts { get; set; }
    //    public DbSet<PatientLabs> PatientLabs { get; set; }
    //    protected override void OnModelCreating(DbModelBuilder modelBuilder)
    //    {
    //        modelBuilder.Entity<PatientLabs>().HasRequired(l => l.PatientCohorts);
    //        modelBuilder.Entity<PatientCohorts>().HasMany(p => p.PatientLabs);

    //        base.OnModelCreating(modelBuilder);
    //    }
    //}
   
    
    public partial class CPRSNote : System.Web.UI.Page
    {
        EmrSvc wsEMR;
        System.Timers.Timer aTimer = new System.Timers.Timer();
                  
        public void Page_Load(object sender, EventArgs e)
        {
            wsEMR = (EmrSvc)Session[SessionVariables.Service];
            
            var patient = wsEMR.select(Request.QueryString["localPid"]);
            
            author.Text = Session[SessionVariables.Name].ToString();
            Patient.Text = patient.patientName;
            
            //var ID = Request.QueryString["localpid"];
            //var PatientSID = Request.QueryString["PatientSID"];
            //System.Timers.Timer aTimer = new System.Timers.Timer();
            //aTimer.Elapsed += new ElapsedEventHandler(OnTimedEvent);
            //aTimer.Interval = 35000;
            //aTimer.Enabled = true;
            //aTimer.Start();
            
            //if (aTimer.Interval < 30000)
            //{
            //    MessageBox.Show("This session is ending in two minutes. Be sure to submit your note to CPRS, or you will be redirected to the login screen");
            //}

            //if (aTimer.Interval < 0001)
            //{
            //    aTimer.Stop();
            //    aTimer.Enabled = false;
            //    MessageBox.Show("This session has ended. You will now be redirected to the CPRS Login Page");
            //    Session.Abandon();
            //    wsEMR.disconnect();
            //    Session.Contents.RemoveAll();
            //    Response.Redirect("CPRSLogin.aspx?localpid=" + ID + "&PatientSID=" + PatientSID);
            //}           
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            var ID = Request.QueryString["localpid"];
            var PatientSID = Request.QueryString["PatientSID"];
            int minutes = int.Parse(Label1.Text);
            if (minutes != 0)
            {
                Label1.Text = (minutes - 1).ToString();

            }
            else
            {
                Session.Abandon();
                wsEMR.disconnect();
                Session.Contents.RemoveAll();
                Timer1.Enabled = false;
                Response.Redirect("CPRSLogin.aspx?localpid=" + ID + "&PatientSID=" + PatientSID);
                //Response.Redirect("http://www.google.com");
                MessageBox.Show("This Session has expired. You will now be redirected to the login page.");
            }
        }
    
        private static void OnTimedEvent(object source, ElapsedEventArgs e)
        {
                       
        }
       
        private void cbLiverBiopsy_Checked(object sender, EventArgs e)
        {
            // Add code to perform some action here.
        }

        protected void BiopsyResults_SelectedIndexChanged(object sender, EventArgs e)
        {
          try 
          {
              wsEMR = (EmrSvc)Session[SessionVariables.Service];
            if (!IsPostBack)
            {
                var patient = wsEMR.select(Request.QueryString["localPid"]);
                author.Text = Session[SessionVariables.Name].ToString();
                Patient.Text = patient.patientName;
            }

            else if (IsPostBack)
            {

                var patient = wsEMR.select(Request.QueryString["localPid"]);
                int pt = Convert.ToInt32(Request.QueryString["PatientSID"]);

                //author.Text = Session[SessionVariables.Name].ToString();
                //Patient.Text = patient.patientName;

                var context = new CohortDBContext();
                //Database.SetInitializer<CohortDBContext>(null);
                //var pid = context.PatientCohorts.Where(p => p.PatientSSN == patient.ssn).SingleOrDefault();
                var genotype = (from pc in context.PatientCohorts
                                where pc.PatientSID == pt
                                select pc.Genotype).First();

                //var lab = pid.PatientLabs.OrderByDescending(Lab => Lab.LabChemSpecimenDateTime).Where(Lab => Lab.HepCAntibody != null)
                //    .Select(Lab => Lab.HepCAntibody).First();
                //var lab = pid.PatientLabs.OrderByDescending(Lab => Lab.LabChemSpecimenDateTime).First();
                string br = drpBiopsyResults.Text;
                string week = drpWeek.Text;
                string drug = drpDrug.Text;
                string therapy = drpTherapy.Text;
                string duration = drpDuration.Text;
                string physical = drpPhysical.Text;
                string mental = drpMental.Text;
                string doses = drpDoses.Text;
                string biopsyDone = drpLiverBiopsy.Text;
                //string biopsyDone = hide.Value.ToString(); 
                string physExam = null;
                string GeneralcbAlert = null;

                string strPhysical = "";
                foreach(ListItem Item in PhysicalSymptoms.Items)
                {
                    if(Item.Selected)
                    {
                        if (strPhysical.StartsWith("Physical Symptoms: "))
                        {
                            strPhysical = strPhysical + ", " + Item.Value;
                        }
                        else strPhysical = "Physical Symptoms: " + Item.Value;
                    }
                
                }

              
                txtboxNote.Text = patient.name.ToString() + " is currently on week " + week +
                    " of a planned total duration of therapy of " + duration + " weeks for treatment of cHCV genotype " + genotype + " with \n" + drug +
                    ". " + biopsyDone + br + " \nPatient " + physical + " physical adverse drug effects " +
                    " \nPatient " + mental + " mental health adverse drug effects " +
                    " \nSince last visit, adherence to therapy has been " + therapy +
                    " as patient reports a total of " + doses + " missed doses.\n"
                    + physExam + GeneralcbAlert + strPhysical ;
            }        
        }
            catch(NullReferenceException ex)
             {
                 ScriptManager.RegisterStartupScript(this, typeof(Page), "alert", "alert('" + ex.Message + "')", true);
             }
        }
        protected void submit_Click(object sender, EventArgs e)
        {
            string connString = ConfigurationManager.ConnectionStrings["CDSTProductionConnectionString"].ConnectionString;
            SqlConnection Conn = null;
            

                var patient = wsEMR.select(Request.QueryString["localPid"]);
                Conn = new SqlConnection(connString);
                Conn.Open();                 
                using (SqlCommand cmd = new SqlCommand())
                {
                    cmd.Connection = Conn;
                    cmd.CommandType = CommandType.Text;
                    cmd.CommandText = "INSERT INTO HepCTracking(PatientSID, PatientIEN, PatientName, Author, CycleWeek, PlannedDuration, TreatmentRegimen, BiopsyResults, AdherenceToTherapy, MissedDoses, NoteDate) VALUES(@PatientSID, @PatientIEN, @PatientName, @Author, @CycleWeek, @PlannedDuration, @TreatmentRegimen, @BiopsyResults, @AdherenceToTherapy, @MissedDoses, @NoteDate)";
                    cmd.Parameters.AddWithValue("@PatientSID", Request.QueryString["PatientSID"]);
                    cmd.Parameters.AddWithValue("@PatientIEN", Request.QueryString["localPID"]);
                    cmd.Parameters.AddWithValue("@PatientName", patient.name.ToString());
                    cmd.Parameters.AddWithValue("@Author", Session[SessionVariables.Name].ToString());
                    cmd.Parameters.AddWithValue("@CycleWeek", drpWeek.SelectedValue);
                    cmd.Parameters.AddWithValue("@PlannedDuration", drpDuration.SelectedValue);
                    cmd.Parameters.AddWithValue("@TreatmentRegimen", drpDrug.SelectedValue);
                    cmd.Parameters.AddWithValue("@BiopsyResults", drpBiopsyResults.SelectedValue);
                    cmd.Parameters.AddWithValue("@AdherenceToTherapy", drpTherapy.SelectedValue);
                    cmd.Parameters.AddWithValue("@MissedDoses", drpDoses.SelectedValue);
                    cmd.Parameters.AddWithValue("@NoteDate",  DateTime.Now.ToString());
                    cmd.ExecuteReader();

                }
              
                if (Conn != null)
                {
                    Conn.Close();
                }

            wsEMR = (EmrSvc)Session[SessionVariables.Service];
            if (wsEMR == null)
            {
                Response.Redirect("CPRSLogin.aspx");
            }
            String strExamDate1 = DateTime.Now.ToString("yyyyMMdd.HHmmss");
            var EncounterString = "182;" + strExamDate1 + ";E";
            if (IsPostBack)
            {
                //1971 was the TIUDocumentDefinitionIEN for the 10-10 M note, 4514 Is the new IEN for the 
                //Hepatitis C Treatment Follow-up note
                var NoteResult = wsEMR.writeNote("4514", EncounterString, txtboxNote.Text, Session[SessionVariables.UserDUZ].ToString(), "", "", "");

                if (!string.IsNullOrWhiteSpace(txtSigCode.Text))
                {
                    var SignNote = wsEMR.signNote(NoteResult.id, Session[SessionVariables.UserDUZ].ToString(), txtSigCode.Text);
                }
            }
            Session.Abandon();
            wsEMR.disconnect();
            Session.Contents.RemoveAll();
            Response.Redirect("Success.aspx");
        }

        protected void cancel_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            wsEMR.disconnect();
            Session.Contents.RemoveAll();
            Response.Redirect("https://mcad.v10.med.va.gov/CDSTTools");
        }
       
    }
}