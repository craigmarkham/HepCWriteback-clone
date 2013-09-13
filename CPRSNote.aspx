<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CPRSNote.aspx.cs" Inherits="GICprsLogin.CPRSNote" MasterPageFile="Site.Master" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="FeaturedContent" runat="server">
    </asp:Content>

<asp:Content ID="Content3" runat="server" contentplaceholderid="MainContent">
    <asp:Label ID="Label1" runat="server" Text="Note Title: 10-10M"></asp:Label>
    <br />
    <asp:Label ID="Label2" runat="server" Text="Author:"></asp:Label>
&nbsp;<asp:Label ID="author" runat="server" Text=" "></asp:Label>
    <br />
    Patient Name:
    <asp:Label ID="Patient" runat="server" Text=" "></asp:Label>
    <br />
    Liver biopsy results:
    <asp:DropDownList ID="BiopsyResults" AutoPostBack="true" runat="server" OnSelectedIndexChanged="BiopsyResults_SelectedIndexChanged" ViewStateMode="Enabled">
        <asp:ListItem>none</asp:ListItem>
        <asp:ListItem>F0</asp:ListItem>
        <asp:ListItem>F1</asp:ListItem>
        <asp:ListItem>F2</asp:ListItem>
        <asp:ListItem>F3</asp:ListItem>
        <asp:ListItem>F4</asp:ListItem>
    </asp:DropDownList>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Treatment drug:
    <asp:DropDownList ID="drpDrug" runat="server" AutoPostBack="true">
        <asp:ListItem>sofusbuvir</asp:ListItem>
        <asp:ListItem>boceprivir</asp:ListItem>
        <asp:ListItem>telaprevir</asp:ListItem>
    </asp:DropDownList>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Adherence to Therapy:
    <asp:DropDownList ID="drpTherapy" runat="server" AutoPostBack="true" >
        <asp:ListItem>excellent</asp:ListItem>
        <asp:ListItem>good</asp:ListItem>
        <asp:ListItem>fair</asp:ListItem>
        <asp:ListItem>poor</asp:ListItem>
    </asp:DropDownList>
    <br />
    Cycle week:&nbsp;
    <asp:DropDownList ID="drpWeek" runat="server" AutoPostBack="true">
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
    </asp:DropDownList>
&nbsp;&nbsp;&nbsp;
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
            var confirmed = confirm("This is the end, you can never go back. \n Are you sure you want to do this?");
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


