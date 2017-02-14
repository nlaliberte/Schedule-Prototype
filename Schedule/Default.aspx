<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="Schedule.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Schedule Prototype</title>
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    <table>
        <tr>
            <td class="auto-style1">Schedule Prototpye</td>
        </tr>
    </table>
    </div>
        <asp:DropDownList ID="dd_league" runat="server" Height="25px" OnSelectedIndexChanged="dd_league_SelectedIndexChanged" Width="307px" AutoPostBack="True" DataSourceID="SqlDataSource_League" DataTextField="league_name" DataValueField="league_id">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource_League" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_league_getall" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <br />
        <br />
        <asp:Label ID="lbl_primaryContact" runat="server" Text="Primary Contact: "></asp:Label>
        <asp:Label ID="lbl_primaryContactValue" runat="server" Text="(placeholder)"></asp:Label>
        <br />
        <asp:Label ID="lbl_secondaryContact" runat="server" Text="Secondary Contact: "></asp:Label>
        <asp:Label ID="lbl_secondaryContactValue" runat="server" Text="(placeholder)"></asp:Label>
        <br />
        <br />
        <asp:Button ID="btn_manage" runat="server" Text="Manage" OnClick="btn_manage_Click" />
    </form>
</body>
</html>
