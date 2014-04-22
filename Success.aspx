<%@ Page Title="CPRS Note Success" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Success.aspx.cs" Inherits="WebApplication1._Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            <hgroup class="title">
                <h1><%: Title %></h1>
            </hgroup>
        </div>
    </section>
</asp:Content>
<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <p>
        Your note has been written to CPRS. Please check CPRS to make sure your note is correct.</p>
<p>
       <%-- <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/PatientSearch.aspx">Click here to select another patient</asp:HyperLink>--%>
</p>
<p>
        &nbsp;</p>
<p>
        &nbsp;</p>
</asp:Content>
