<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CPRSNoteConfirmation.aspx.cs" Inherits="URF.CPRSNoteConfirmation" MasterPageFile="Site.Master" %>
<%@ Register Assembly="AjaxControlToolkit, Version=3.5.60501.0, Culture=neutral, PublicKeyToken=28f01b0e84b6d53e" Namespace="AjaxControlToolkit"  TagPrefix="ajaxControlToolkit"%>


<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">
     <script type="text/javascript" src="Scripts/jquery-1.7.1.min.js"></script>
    <script type="text/javascript">
        $(document).ready(
            function () { // JQuery
                $('input').keypress(
                    function (event) { // Prevents form submit/postback when ENTER is pressed
                        if (event.keyCode == 13 || event.charCode == 13) {
                            return false;
                        }
                    }
                );
                $("#ctl00_ContentPlaceHolder2_txtNoteSig").keyup(function (event) { // Clicks "Get Services" button on when ENTER pressed when email textbox in focus
                    if (event.keyCode == 13) {
                        $('#ctl00_ContentPlaceHolder2_btnSubmit').click();
                    }
                });
                $('#ctl00_ContentPlaceHolder2_btnCancel').click(function (event) {
                    window.navigate("ActivePatients.aspx");
                    return false;
                    
                });
            }
          );
    </script>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="FeaturedContent" runat="Server">
    <asp:Label ID="lblDataSource" runat="server" Text="You are currently in TEST data mode"
        ForeColor="#FF3300">
    </asp:Label>
    <br />
    
    <asp:Label ID="ErrorMsgTextBox" runat="server" ForeColor="#FF3300"></asp:Label>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
     <div id="Mainbox">
           <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
              <ContentTemplate>
    <h2>Test Note Confirmation: Save to CPRS</h2>
        <br />
        <asp:Label ID="lblError" runat="server" Font-Size="16px" Visible="False"></asp:Label> 
         <br /><br />
        <asp:HyperLink ID="ToActivePats" runat="server" Font-Size="18px" Visible="false" NavigateUrl="~/ActivePatients.aspx">Back to Active Patients</asp:HyperLink>
         <br />
       
     <asp:Table ID="tblImages" runat="server" Font-Size="12px" Font-Bold="false" CellPadding="5"
                CellSpacing="8">
                <asp:TableRow>
                    <asp:TableCell Width="150" >PATIENT NAME: </asp:TableCell>
                    <asp:TableCell><asp:Label ID="lblPatientName" runat="server"></asp:Label></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="150">LOCATION: </asp:TableCell>
                    <asp:TableCell>W TEST</asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="150">NOTE TITLE: </asp:TableCell>
                    <asp:TableCell>COMMUNITY HEALTH INTERDISCIPLINARY MEMBERS   </asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="150">DATE OF NOTE: </asp:TableCell>
                    <asp:TableCell><asp:Label ID="lblDateOfNote" runat="server"></asp:Label></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="150">AUTHOR: </asp:TableCell>
                    <asp:TableCell><asp:Label ID="lblAuthor" runat="server"></asp:Label></asp:TableCell>
                </asp:TableRow>
                <%-- <asp:TableRow>
                    <asp:TableCell Width="150">ADD A COSIGNER (<em>optional</em>): </asp:TableCell>
                    <asp:TableCell><asp:DropDownList ID="ddlCosigner" runat="server"></asp:DropDownList></asp:TableCell>
                </asp:TableRow>--%>
                 <asp:TableRow>
                    <asp:TableCell Width="150">SIGN NOTE NOW : (<em>optional</em>): </asp:TableCell>
                    <asp:TableCell><asp:TextBox ID="txtNoteSig" runat="server"></asp:TextBox></asp:TableCell>
                </asp:TableRow>
                <asp:TableRow>
                    <asp:TableCell Width="150">CMT TASK NOTE: </asp:TableCell>
                    <asp:TableCell> <asp:Label ID="lblTaskNote" runat="server"></asp:Label></asp:TableCell>
                </asp:TableRow>
               <asp:TableRow>
               <asp:TableCell>
                     <asp:Button ID="btnSubmit" width="100" runat="server" Text="Submit"/>
              </asp:TableCell>
                    <asp:TableCell>
                        <asp:Button ID="btnCancel" width="100" OnClick="btnCancel_Click" runat="server" Text="Cancel" /> 
                        </asp:TableCell>
           </asp:TableRow>
              
     </asp:Table>
                  </ContentTemplate>
               </asp:UpdatePanel>
               
    </div>
      <asp:UpdateProgress ID="updateProgress" runat="server">
            <ProgressTemplate>
                <div class="Loading" style="height: 100px; width:300px;">
                                <br />Connecting to CPRS...
                    <br /><br />
                            <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="~/images/ajax-loader.gif"
                                AlternateText="Loading ..." ToolTip="Loading ..." />
                    <br />
                                
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>
   </asp:Content>
