using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using HepCWriteback.gov.va.medora;

namespace HepCWriteback.Helpers
{
    public class ServiceHelper
    {
        public static EmrSvc GetEmrSvcSoapClient()
        {

            return new EmrSvc { CookieContainer = new System.Net.CookieContainer() };
        }

    }
}