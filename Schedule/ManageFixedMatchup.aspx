<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageFixedMatchup.aspx.cs" Inherits="Schedule.ManageFixedMatchup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HyperLink ID="link_home" runat="server" NavigateUrl="~/LeagueHome.aspx" Font-Italic="True" Font-Size="Smaller">Back to League Home</asp:HyperLink>
        <br />
        <br />
        <table>
            <tr>
                <td><asp:Label ID="lbl_header" runat="server" Text="Fixed Matchups:" Font-Bold="True" Font-Size="Large" /></td>
                <td style="width:10px"></td>
                <td><asp:HyperLink ID="link_fixedMatchupNew" runat="server" Font-Italic="True" Font-Size="Smaller" NavigateUrl="~/FixedMatchupEdit.aspx">(add Fixed Matchup)</asp:HyperLink></td>
            </tr>
        </table>
        <asp:GridView ID="grd_fixedMatchup" runat="server" OnRowCommand="grd_fixedMatchup_RowCommand" AutoGenerateColumns="False" DataSourceID="SqlDataSource_FixedMatchup" Width="810px">
            <Columns>
                <asp:ButtonField ButtonType="Button" CommandName="del" Text="Delete">
                    <ControlStyle Width="80px" />
                    <FooterStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                    <ItemStyle Width="80px" />
                </asp:ButtonField>
                <asp:ButtonField ButtonType="Button" CommandName="edit" Text="Edit">
                    <ControlStyle Width="80px" />
                    <FooterStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                    <ItemStyle Width="80px" />
                </asp:ButtonField>
                <asp:BoundField DataField="fixed_matchup_id" HeaderText="ID" InsertVisible="False" ReadOnly="True" SortExpression="fixed_matchup_id">
                    <ControlStyle Width="30px" />
                    <FooterStyle Width="30px" />
                    <HeaderStyle Width="30px" />
                    <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="home_team_id" HeaderText="home_team_id" SortExpression="home_team_id" Visible="False" />
                <asp:BoundField DataField="home_team_name" HeaderText="Home Team" SortExpression="home_team_name">
                    <ControlStyle Width="150px" />
                    <FooterStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="away_team_id" HeaderText="away_team_id" SortExpression="away_team_id" Visible="False" />
                <asp:BoundField DataField="away_team_name" HeaderText="Away Team" SortExpression="away_team_name">
                    <ControlStyle Width="150px" />
                    <FooterStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="field_id" HeaderText="field_id" SortExpression="field_id" Visible="False" />
                <asp:BoundField DataField="field_name" HeaderText="Field" ReadOnly="True" SortExpression="field_name">
                    <ControlStyle Width="150px" />
                    <FooterStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="matchup_date" HeaderText="Date" ReadOnly="True" SortExpression="matchup_date">
                    <ControlStyle Width="80px" />
                    <FooterStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                    <ItemStyle Width="80px" />
                </asp:BoundField>
                <asp:BoundField DataField="matchup_time" HeaderText="Time" ReadOnly="True" SortExpression="matchup_time">
                    <ControlStyle Width="80px" />
                    <FooterStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                    <ItemStyle Width="80px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource_FixedMatchup" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_fixed_matchup_getall" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lbl_noMatchupWarning" runat="server" Text="NOTE: No Fixed Matchups have been Saved." Font-Italic="True" ForeColor="Red"></asp:Label>
    </div>
    </form>
</body>
</html>
