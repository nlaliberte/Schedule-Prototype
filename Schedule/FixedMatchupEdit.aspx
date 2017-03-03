<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FixedMatchupEdit.aspx.cs" Inherits="Schedule.FixedMatchupEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Fixed Matchup:
        <br />
        <br />
        <table id="tbl_matchupDetails">
            <tr>
                <td class="auto-style1">Home Team:</td>
                <td><asp:DropDownList style="width:250px" ID="dd_homeTeam" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id" OnSelectedIndexChanged="dd_homeTeam_SelectedIndexChanged"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Team" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_team_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                            <asp:Parameter DefaultValue="0" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Away Team:</td>
                <td><asp:DropDownList style="width:250px" ID="dd_awayTeam" runat="server" AutoPostBack="True" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id" OnSelectedIndexChanged="dd_awayTeam_SelectedIndexChanged"></asp:DropDownList></td>
            </tr>
            <tr>
                <td class="auto-style1">Field:</td>
                <td><asp:DropDownList style="width:250px" ID="dd_field" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Field" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_field_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Date*:</td>
                <td><asp:TextBox ID="txt_date" runat="server" Width="100px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style1">Time*:</td>
                <td>
                    <asp:TextBox ID="txt_time" runat="server" Width="100px"></asp:TextBox>
                    <asp:DropDownList ID="dd_ampm" runat="server">
                        <asp:ListItem>AM</asp:ListItem>
                        <asp:ListItem>PM</asp:ListItem>
                    </asp:DropDownList>
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
        <br />
        <asp:Label ID="lbl_note" runat="server" Text="* A permit is not required to save the matchup, but Date and Time fields require a Corresponding Field or they will not be saved with the record." Font-Italic="True" Font-Size="Smaller"></asp:Label>
    </div>
    </form>
</body>
</html>
