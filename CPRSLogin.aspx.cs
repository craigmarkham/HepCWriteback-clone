using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using URF;
using HepCWriteback.gov.va.medora;
using HepCWriteback.Helpers;
using System.Globalization;
using System.Configuration;
using HepCWriteback;
using HepCWriteback.domain;

namespace URF
{
    public partial class CPRSLogin : System.Web.UI.Page
    {
        HcvDataContext db = new HcvDataContext();

        MySession _mySession;
        EmrSvc wsEMR;
               

        protected void Page_Load(object sender, EventArgs e)
        {
           var ID = Request.QueryString["localpid"];
           var PatientSID = Request.QueryString["PatientSID"];
            var localPid = (from pc in db.PatientCohorts
                            where pc.PatientIEN == ID
                            select pc.PatientIEN).First();
            
            if (!IsPostBack)
            {
         
                if (!(Session["CPRSLogin"] == null))
                {
                    if (Session["CPRSLogin"].ToString() == "OK")
                        Response.Redirect("CPRSNote.aspx?localpid="+ID+"&PatientSID="+PatientSID);//("CPRSNoteConfirmation.aspx");
                }
  

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
            }

            else
            {
                Session["CPRSUserName"] = txtCPRSName.Text;
                Session["CPRSPW"] = txtCPRSPW.Text;

                String CPRSUserName = String.Empty;
                String CPRSPW = String.Empty;

                if (!(Session["CPRSUserName"] == null))
                {
                    CPRSUserName = Session["CPRSUserName"].ToString();
                }

                if (!(Session["CPRSPW"] == null))
                {
                    CPRSPW = Session["CPRSPW"].ToString();
                }

                if (CPRSUserName != String.Empty && CPRSPW != String.Empty)
                {
                    EmrSvc wsEMR = ServiceHelper.GetEmrSvcSoapClient();
                 
                  
                    try
                    {
                        DataSourceArray connect = wsEMR.connect("541");
                        UserTO User = wsEMR.login(CPRSUserName, CPRSPW, "");

                        if (User.DUZ != String.Empty && User.DUZ != null)
                        {

                            Session[SessionVariables.UserDUZ] = User.DUZ;
                            Session[SessionVariables.Name] = User.name;
                            Session[SessionVariables.EmrCookie] = wsEMR.CookieContainer;
                            Session[SessionVariables.Site] = "541";
                            Session[SessionVariables.Service] = wsEMR; 
                            

                            Session["CPRSLogin"] = "OK";
                            Response.Redirect("CPRSNote.aspx?localpid="+ID+"&PatientSID="+PatientSID, false);
                        }
                        else
                        {
                            lblError.Visible = true;
                            lblError.ForeColor = System.Drawing.Color.Red;
                            lblError.Text = "Login Fail! Please reenter your username and password and try again.<br />";
                            lblError.Text += "Is your password expired? Please login to the CPRS Application to change your password.<br />";
                        }
                    }
                    catch(Exception ex)
                    {
                        wsEMR.disconnect();
                        lblError.Visible = true;
                        lblError.Text += "There was a problem connecting to the MDWS Web Service.<br />";
                    }
                }
            }
        }
       
    }
}