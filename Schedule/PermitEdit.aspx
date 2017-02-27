<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermitEdit.aspx.cs" Inherits="Schedule.PermitEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HyperLink ID="lnk_PermitHome" runat="server" Font-Italic="True" Font-Size="Smaller" NavigateUrl="">(Permit Home URL)</asp:HyperLink>
        <br />
        <br />
        Permit Edit Page:<br />
        <table id="tbl_permitDetails">
            <tr>
                <td class="auto-style1">Field:</td>
                <td>
                    <asp:DropDownList ID="dd_field" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Field" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_field_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Permit Date:</td>
                <td><asp:TextBox ID="txt_date" runat="server" Width="120px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style1">Time:</td>
                <td><asp:TextBox ID="txt_time" runat="server" Width="87px"></asp:TextBox>
                    <asp:DropDownList ID="dd_ampm" runat="server">
                        <asp:ListItem>AM</asp:ListItem>
                        <asp:ListItem>PM</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Acquiring Team:</td>
                <td>
                    <asp:DropDownList ID="dd_team" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Team" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_team_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style1"></td>
                <td>
                    <center><table>
                        <tr>
                            <td><asp:Button ID="btn_cancel" runat="server" Text="Cancel" OnClick="btn_cancel_Click" /></td>
                            <td width ="10"></td>
                            <td><asp:Button ID="btn_save" runat="server" Text="Save" Width="60px" OnClick="btn_save_Click" /></td>
                        </tr>
                    </table></center>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
