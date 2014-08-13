﻿
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CPRSNote.aspx.cs" Inherits="GICprsLogin.CPRSNote" MasterPageFile="Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    </asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="MainContent">  
   <b>Time remaining until auto-logout:</b> <asp:Label ID="Label1" runat="server" Text="20"/> minute(s).<br /><br />
    <asp:Timer ID="Timer1" runat="server" Interval="60000" ontick="Timer1_Tick">
    </asp:Timer>
    <asp:Label ID="Label" runat="server" Text="Note Title: HEPATITIS C TREATMENT FOLLOW-UP"></asp:Label>
    <br />
    <asp:Label ID="Label2" runat="server" Text="Author:"></asp:Label>
&nbsp;<asp:Label ID="author" runat="server" Text=" "></asp:Label>
    <br />
    Patient Name:
    <asp:Label ID="Patient" runat="server" Text=" "></asp:Label>
    <br />
      Cycle week:
    <asp:DropDownList ID="drpWeek" runat="server" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>1</asp:ListItem>
        <asp:ListItem>2</asp:ListItem>
        <asp:ListItem>3</asp:ListItem>
        <asp:ListItem>4</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
        <asp:ListItem>6</asp:ListItem>
        <asp:ListItem>7</asp:ListItem>
        <asp:ListItem>8</asp:ListItem>
        <asp:ListItem>9</asp:ListItem>
        <asp:ListItem>10</asp:ListItem>
        <asp:ListItem>11</asp:ListItem>
        <asp:ListItem>12</asp:ListItem>
        <asp:ListItem>13</asp:ListItem>
        <asp:ListItem>14</asp:ListItem>
        <asp:ListItem>15</asp:ListItem>
        <asp:ListItem>16</asp:ListItem>
        <asp:ListItem>17</asp:ListItem>
        <asp:ListItem>18</asp:ListItem>
        <asp:ListItem>19</asp:ListItem>
        <asp:ListItem>20</asp:ListItem>
        <asp:ListItem>21</asp:ListItem>
        <asp:ListItem>22</asp:ListItem>
        <asp:ListItem>23</asp:ListItem>
        <asp:ListItem>24</asp:ListItem>
    </asp:DropDownList>
   Planned duration:
    <asp:DropDownList ID="drpDuration" runat="server" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>12</asp:ListItem>
        <asp:ListItem>16</asp:ListItem>
        <asp:ListItem>24</asp:ListItem>
        </asp:DropDownList>
    Treatment regimen:
    <asp:DropDownList ID="drpDrug" runat="server" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>sofosbuvir/ribavirin</asp:ListItem>
        <asp:ListItem>sofosbuvir/ribavirin/PEG-IFN</asp:ListItem>
        <asp:ListItem>sofosbuvir/simeprevir</asp:ListItem>
        <asp:ListItem>simeprevir/ribavirin/PEG-IFN</asp:ListItem>
    </asp:DropDownList> 
    <br />    
     Liver biopsy done:
    <asp:DropDownList ID="drpLiverBiopsy" runat="server" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>The liver biopsy results were </asp:ListItem>
        <asp:ListItem>Patient has not had a liver biopsy. </asp:ListItem>
    </asp:DropDownList> 
    <%--<br />--%>    
    <%--<input type="checkbox" runat="server" id="cbLiverBiopsy" value=" ">--%>
    <%--<input type="hidden" id="hide" name="user" />--%>
    <%--<asp:CheckBox ID ="cbLiverBiopsy" runat="server" Checked="false" OnCheckedChanged="BiopsyResults_SelectedIndexChanged"/>--%>
    <asp:HiddenField ID="hide" runat="server"/> 
    <script type="text/javascript">

        $(document).ready(function () {
            $("#cbLiverBiopsy").click(function () {
                $("#hide").val("The liver biopsy results were ");
            });
        });

        function countdown() {
            seconds = document.getElementById("timerLabel").innerHTML;
            if (seconds > 0) {
                document.getElementById("timerLabel").innerHTML = seconds - 1;
                setTimeout("countdown()", 1000);
            }
        }

        setTimeout("countdown()", 1000);
    </script>
    Liver biopsy results:
    <asp:DropDownList ID="drpBiopsyResults" AutoPostBack="true" runat="server"  EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <%--OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged"--%>
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>none</asp:ListItem>
        <asp:ListItem>F0</asp:ListItem>
        <asp:ListItem>F1</asp:ListItem>
        <asp:ListItem>F2</asp:ListItem>
        <asp:ListItem>F3</asp:ListItem>
        <asp:ListItem>F4</asp:ListItem>
    </asp:DropDownList>
    <br />
    Patient physical adverse drug effects:
    <asp:DropDownList ID="drpPhysical" runat="server" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>denies</asp:ListItem>
        <asp:ListItem>reports the following</asp:ListItem>
        </asp:DropDownList>
      Patient mental health adverse drug effects:
    <asp:DropDownList ID="drpMental" runat="server" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>denies</asp:ListItem>
        <asp:ListItem>reports the following</asp:ListItem>
        </asp:DropDownList>
    <br />
       Adherence to Therapy:
    <asp:DropDownList ID="drpTherapy" runat="server" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>excellent</asp:ListItem>
        <asp:ListItem>good</asp:ListItem>
        <asp:ListItem>fair</asp:ListItem>
        <asp:ListItem>poor</asp:ListItem>
    </asp:DropDownList>
      Missed Doses:
    <asp:DropDownList ID="drpDoses" runat="server" AutoPostBack="true" EnableViewState="true" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged">
        <asp:ListItem Selected="True"> </asp:ListItem>
        <asp:ListItem>0</asp:ListItem>
        <asp:ListItem>1</asp:ListItem>
        <asp:ListItem>2</asp:ListItem>
        <asp:ListItem>3</asp:ListItem>
        <asp:ListItem>4</asp:ListItem>
        <asp:ListItem>5</asp:ListItem>
        <asp:ListItem>6</asp:ListItem>
        <asp:ListItem>7</asp:ListItem>
        </asp:DropDownList>
    <br />
   <%-- Click here to document Physical Exam(you can edit in the space below): 
    <asp:CheckBox ID="PhysicalExam" runat="server" AutoPostBack ="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" />
    <br />
    <asp:Label ID="General" runat="server" Visible="false" Text="General:" Font-Bold="true"> </asp:Label> 
    <asp:CheckBox ID="Generalcb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="Generalcb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <br />
    <asp:Label ID="HEENT" runat="server" Visible="false" Text="HEENT:" Font-Bold="true"></asp:Label>
     <asp:CheckBox ID="HEENTcb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="HEENTcb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>  
    <br />
    <asp:Label ID="Neck" runat="server" Visible="false" Text="Neck:" Font-Bold="true"></asp:Label>
     <asp:CheckBox ID="Neckcb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="Neckcb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <asp:CheckBox ID="Neckcb3" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <br />
    <asp:Label ID="Cardiac" runat="server" Visible="false" Text="Cardiac:" Font-Bold="true"></asp:Label>
     <asp:CheckBox ID="Cardiaccb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="Cardiaccb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <br />
    <asp:Label ID="Lungs" runat="server" Visible="false" Text="Lungs:" Font-Bold="true"></asp:Label>
     <asp:CheckBox ID="Lungscb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="Lungscb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <br />
    <asp:Label ID="ABD" runat="server" Visible="false" Text="ABD:" Font-Bold="true"></asp:Label>
    <asp:CheckBox ID="ABDcb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="ABDcb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <asp:CheckBox ID="ABDcb3" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="ABDcb4" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <asp:CheckBox ID="ABDcb5" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="ABDcb6" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <asp:CheckBox ID="ABDcb7" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="ABDcb8" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <br />
    <asp:Label ID="Liver" runat="server" Visible="false" Text="Liver" Font-Bold="true"></asp:Label>
    <asp:CheckBox ID="Livercb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="Livercb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <asp:CheckBox ID="Livercb3" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <asp:CheckBox ID="Livercb4" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
     <br />
    <asp:Label ID="GU" runat="server" Visible="false" Text="GU" Font-Bold="true"></asp:Label>
   
     <br />
    <asp:Label ID="EXT" runat="server" Visible="false" Text="EXT:" Font-Bold="true"></asp:Label>
    <asp:CheckBox ID="EXTcb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="EXTcb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <asp:CheckBox ID="EXTcb3" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    
    <br />
    <asp:Label ID="Neuro" runat="server" Visible="false" Text="Neuro:" Font-Bold="true"></asp:Label>
    <asp:CheckBox ID="Neurocb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="Neurocb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
     <br />
    <asp:Label ID="Skin" runat="server" Visible="false" Text="Skin:" Font-Bold="true"></asp:Label>
    <asp:CheckBox ID="Skincb1" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="Skincb2" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
    <asp:CheckBox ID="Skincb3" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Alert and Oriented"> </asp:CheckBox>
    <asp:CheckBox ID="Skincb4" runat="server" visible="false" AutoPostBack="true" OnCheckedChanged="BiopsyResults_SelectedIndexChanged" Text=" Other (specify)"> </asp:CheckBox>
     --%>
    <br />
    Enter note text below:<br />
    <asp:TextBox ID="txtboxNote" runat="server" Height="226px" Width="601px" TextMode="MultiLine"></asp:TextBox>
    <br />
    <br />
    <asp:Label ID="Label3" runat="server" Text="Sign Note Now (Optional):"></asp:Label>
&nbsp;<br />
    <asp:TextBox TextMode="password" ID="txtSigCode" runat="server"></asp:TextBox>
    <br />
    <br />
    <asp:Button ID="submit" runat="server" OnClick="submit_Click" Text="Submit" />
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <asp:Button ID="cancel" runat="server" Text="Cancel" OnClick="cancel_Click" />
    <br />
    <script>

        $(function () {

            $('#MainContent_submit').on("click",NoteConfirm);
        });

        function NoteConfirm(event) {
            var confirmed = confirm("Upon clicking OK, this note will be submitted to CPRS. Cancel will return you to the note text for editing.\n Do you want to submit this note to CPRS?");
            if (!confirmed) {
                event.preventDefault();
            }

        }
        $(function () {

            $('#MainContent_cancel').on("click", CancelConfirm);
        });

        function CancelConfirm(event) {
            var cancelled = confirm("Clicking cancel will cancel this note entry. \n Are you sure you want to leave this page?");
            if (!cancelled) {
                event.preventDefault();
            }

        }
    </script>
</asp:Content>


