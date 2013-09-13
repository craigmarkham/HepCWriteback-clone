using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//using WebApplication1.mdws;
using HepCWriteback.gov.va.medora;
//using CMT;
using URF;
using HepCWriteback.Helpers;

namespace URF

{
    public partial class CPRSNoteConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String UserName = String.Empty;
            if (!(Session["UserName"] == null))
                UserName = Session["UserName"].ToString();
            else
                Response.Redirect("Main.aspx");

            if (!IsPostBack) //Prevents selected index in drop-down from changing at button click
            {
                String tempVal = String.Empty;
                if (!(Session["TestPatientFlag"] == null))
                {
                    tempVal = Session["TestPatientFlag"].ToString();
                }
                if (tempVal.Equals("Y"))
                    lblDataSource.Visible = true;
                else if (tempVal.Equals("N"))
                    lblDataSource.Visible = false;
                else
                {
                    lblDataSource.Visible = false;
                    Session["TestPatientFlag"] = "N";
                }

                String PatientIEN = String.Empty;
                String cmtTask = String.Empty;
               
                try
                {
                    if (!(Session["PatientName"] == null))
                        lblPatientName.Text = Session["PatientName"].ToString();
                    else
                        lblPatientName.Text = "UNK";
                    if (!(Session["PatientIEN"] == null))
                        PatientIEN = Session["PatientIEN"].ToString();
                    else
                        PatientIEN = "UNK";

                    lblDateOfNote.Text = DateTime.Now.ToString();

                    /*
                    using (tURFDataContext db = new tURFDataContext())
                    {
                        var staffnames = from fac in db.URFStaffNames
                                         where fac.Sta3n == 648 // Remove when ready for more facilities
                                         orderby fac.StaffName
                                         select new { fac.StaffIEN, fac.StaffName };
                        ddlCosigner.DataSource = staffnames;
                        ddlCosigner.DataTextField = "StaffName";
                        ddlCosigner.DataValueField = "StaffIEN";
                        ddlCosigner.DataBind();
                        ddlCosigner.Items.Insert(0, new ListItem("", "0"));
                        // Set selected index
                        ddlCosigner.SelectedIndex = 0;
                        //lblScheduledDate.Text = Convert.ToString(enc.schedDate);
                        db.Dispose();
                    }*/

                    int EncounterID = 0;
                    if (!(Session["EncounterID"] == null))
                    {
                        EncounterID = Convert.ToInt32(Session["EncounterID"].ToString());
                    }
                    //Encounter_Controller ec = new Encounter_Controller();
                    //IccisEncounter enc = ec.getEncounter(EncounterID);

                    //String toDoNote = String.Empty;
                    //toDoNote = enc.ToDoNotes.ToString();
                    //toDoNote = toDoNote.Replace("\r\n", "<br />");

                    //String FinalNotes = String.Empty;
                    //FinalNotes = enc.Notes.ToString();
                    //FinalNotes = FinalNotes.Replace("\r\n", "<br />");

                    //cmtTask = "-----------------------------------<br /> <br />";
                    //cmtTask += "Care Management Task Note" + "<br />";
                    //cmtTask += "Scheduled Date: " + enc.schedDate.ToShortDateString() + "<br />";
                    //cmtTask += "With Whom: " + enc.WithWhomText.ToString() + "<br />";
                    //cmtTask += "By Whom: " + enc.ByWhomText.ToString() + "<br />";
                    //cmtTask += "Created By: " + enc.CreatedBy + "<br />";
                    //cmtTask += "Last Updated By: " + enc.UpdatedBy + "<br />";
                    //cmtTask += "Task Type: " + enc.TypeText + "<br />";
                    //cmtTask += "Task Reason: " + enc.ReasonText + "<br /><br />";
                    //cmtTask += "Task Note: <br />" + toDoNote + "<br /> <br />";
                    //cmtTask += "-----------------------------------<br /> <br />";

                    //if (enc.actual_date != String.Empty)
                    //    cmtTask += "Task Completion Date: " + enc.actual_date.ToString() + "<br />";

                    //if (enc.outcome != String.Empty)
                    //    cmtTask += "Task Outcome: " + enc.outcome + "<br />";

                    //if (enc.Notes != String.Empty)
                    //    cmtTask += "<br />Task Completion Note: <br /> " + FinalNotes + "<br /> <br />";
                    lblAuthor.Text = UserName;
                    lblTaskNote.Text = cmtTask;
                }
                catch (NullReferenceException exc)
                {
                    lblError.Text = exc.Message;
                    lblError.Text += "<br />This is a null reference exception<br />";
                    lblError.Visible = true;
                    lblError.ForeColor = System.Drawing.Color.Red;
                    btnSubmit.Enabled = false;
                    btnCancel.Enabled = false;

                }
                catch (Exception excall)
                {
                    lblError.Text = "Oops! Error: Please contact Jon Duckart ";
                    lblError.Text += excall.Message;
                    lblError.Visible = true;
                    lblError.ForeColor = System.Drawing.Color.Red;
                    btnSubmit.Enabled = false;
                    btnCancel.Enabled = false;
                }
            }

            else if (this.IsPostBack)
            {

                string PatientIEN = Session["PatientIEN"].ToString();
                string cmtTask = lblTaskNote.Text;
                cmtTask = cmtTask.Replace("<br />", "|");
               
                String CPRSPW = String.Empty;
                String AuthorDUZ = Session["UserDUZ"].ToString();

                String CPRSUserName = String.Empty;
                if (!(Session["CPRSUserName"] == null))
                    CPRSUserName = Session["CPRSUserName"].ToString();

                if (!(Session["CPRSPW"] == null))
                    CPRSPW = Session["CPRSPW"].ToString();

                DateTime ExamDateTime1 = DateTime.Now;
                String strExamDate1 = ExamDateTime1.Date.ToString("yyyyMMdd.HHmmss");
                EmrSvc wsEMR = ServiceHelper.GetEmrSvcSoapClient();
                NoteResultTO nrt = null;
                TextTO validsig = null;
                try
                {
                    DataSourceArray connect = wsEMR.connect("541");
                    UserTO User = wsEMR.login(CPRSUserName, CPRSPW, "");

                    validsig = wsEMR.isValidEsig(txtNoteSig.Text);
                    if (validsig.text != "TRUE" && txtNoteSig.Text !=String.Empty)
                    {
                        lblError.Text = "Invalid signature! Please try again or leave sig field blank to write an unsigned note";
                        lblError.ForeColor = System.Drawing.Color.Red;
                        lblError.Visible = true;
                        txtNoteSig.Focus();
                    }
                    else
                    {
                        PatientTO aPatient;
                        aPatient = wsEMR.select(PatientIEN);
                        TextTO sn = null;
                        String EncounterString = String.Empty;
                        EncounterString = "182;" + strExamDate1 + ";E";

                        if (aPatient != null)
                        {
                            /*if (ddlCosigner.SelectedValue != "0")
                                nrt = wsEMR.writeNote("5284", EncounterString, cmtTask, AuthorDUZ, ddlCosigner.SelectedValue, null, null);
                            else*/
                            nrt = wsEMR.writeNote("1971", EncounterString, cmtTask, AuthorDUZ, null, null, null);

                            if (nrt.totalPages > 0)
                            {
                                lblError.Visible = true;
                                lblError.ForeColor = System.Drawing.Color.Green;
                                lblError.Text = "Your note was successfully saved to CPRS.<br />";
                                ToActivePats.Visible = true;
                                tblImages.Visible = false;
                                btnSubmit.Enabled = false;
                                btnCancel.Enabled = false;
                            }
                            else
                            {
                                lblError.Visible = true;
                                lblError.ForeColor = System.Drawing.Color.Red;
                                lblError.Text = "There was a problem connecting to CPRS. Note not saved to CPRS.<br />";
                                txtNoteSig.Text = String.Empty; //Prevents sig note from displaying
                                tblImages.Visible = false;
                                ToActivePats.Visible = true;
                            }
                        }

                        if (txtNoteSig.Text != String.Empty)
                        {
                            try
                            {
                                sn = wsEMR.signNote(nrt.id, PatientIEN, txtNoteSig.Text);

                                if (sn.text.ToString() == "OK")
                                {
                                    lblError.Text += "Your note was successfully signed.<br />";
                                    lblError.Text += "The sign note message: " + sn.text.ToString() + "<br />";
                                }
                                else
                                {
                                    lblError.ForeColor = System.Drawing.Color.Red;
                                    lblError.Text += "There was a problem signing your note. Please sign it in CPRS.<br />";
                                    lblError.Text += "The sign note message: " + sn.text.ToString() + "<br />";
                                }
                            }
                            catch
                            {
                                lblError.ForeColor = System.Drawing.Color.Red;
                                lblError.Text += "There was a problem signing your note. Please sign it in CPRS.<br />";
                            }
                        }
                    }
                }
                catch
                {
                    lblError.Visible = true;
                    lblError.ForeColor = System.Drawing.Color.Red;
                    lblError.Text = "There was a problem connecting to the MDWS Web Service.<br />";
                }
                finally
                {
                    wsEMR.disconnect();
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ActivePatients.aspx");
        }
      
    }
}