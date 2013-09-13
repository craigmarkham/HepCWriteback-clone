<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CPRSLogin.aspx.cs" Inherits="URF.CPRSLogin" MasterPageFile="Site.Master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="HeadContent" runat="Server">


<%--    <script type="text/javascript">
        $(document).ready(
            function () { // JQuery
                $('input').keypress(
                    function (event) { // Prevents form submit/postback when ENTER is pressed
                        if (event.keyCode == 13 || event.charCode == 13) {
                            return false;
                        }
                    }
                );
                $("#ctl00_ContentPlaceHolder2_txtCPRSName").focus();// Sets email textbox on focus at page load -- no JS will be needed for HTML5 (autofocus)
                $("#ctl00_ContentPlaceHolder2_txtCPRSPW").keyup(function (event) { // Clicks "Get Services" button on when ENTER pressed when email textbox in focus
                    if (event.keyCode == 13) {
                        $('#ctl00_ContentPlaceHolder2_btnSubmit').click();
                    }
                });
            }
          );
    </script>--%>

</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="FeaturedContent" runat="Server">
    <h3>
        <asp:Label ID="lblDataSource" runat="server" Text="You are currently in TEST data mode"
            ForeColor="#FF3300">
        </asp:Label></h3>
    <br />

    <asp:Label ID="ErrorMsgTextBox" runat="server" ForeColor="#FF3300"></asp:Label>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="Mainbox">
        <asp:UpdatePanel ID="UpdatePanel1" UpdateMode="Conditional" runat="server">
            <ContentTemplate>
                <h2>CPRS LOGIN</h2>
                <br />
                <asp:Label ID="lblError" runat="server" Visible="False"></asp:Label>
                <br />
                <br /><center>
                    <strong>Welcome to the LOUIS STOKES CLEVELAND VA MEDICAL CENTER.&nbsp;<br />This is a FEDERAL SYSTEM for authorized users ONLY. See message below.</strong><br /> Access is granted to this system for OFFICIAL PURPOSES ONLY. UNAUTHORIZED ACCESS
                <br />
                OR MISUSE OF THIS SYSTEM IS A FEDERAL CRIME! Auditors monitor and record use of this
                <br />
                system; by using this system you consent to such monitoring. Any use of this system implies
                <br />
                compliance with all rules and regulations governing access to internal and external resources.<br /></center>
                <asp:Table ID="tblImages" runat="server" Font-Size="12px" Font-Bold="false" CellPadding="5"
                    CellSpacing="8">
                    <asp:TableRow>
                        <asp:TableCell>CPRS Access Code:</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="txtCPRSName" Width="200" TextMode="password" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell ToolTip="Enter your password here">CPRS Verify Code:</asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ToolTip="Enter your password here" Width="200" TextMode="password" ID="txtCPRSPW" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Button ID="btnSubmit" Width="100" runat="server" Text="Submit" />
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:Button ID="btnCancel" Width="100" runat="server" Text="Cancel" />
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
                &nbsp; 
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>

    <asp:UpdateProgress ID="updateProgress" runat="server">
        <ProgressTemplate>
            <div class="Loading" style="height: 215px; width: 233px;">
                <br />
                Connecting to CPRS...
                    <br />
                <br />
                <asp:Image ID="imgUpdateProgress" runat="server" ImageUrl="~/images/loading.gif"
                    AlternateText="Loading ..." ToolTip="Loading ..." Height="165px" Width="226px" />
                <br />
                <br />

            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
