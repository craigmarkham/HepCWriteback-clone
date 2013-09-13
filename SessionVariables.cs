using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace HepCWriteback.Helpers
{
    public class SessionVariables
    {
        public const string Site = "Site";
        public const string UserDUZ = "UserDUZ";
        public const string EmrCookie = "EmrCookie";
        public const string Name = "Name";
        public static string Service = "Service";
        public string HepCAntibody { get; set; }
    }
}