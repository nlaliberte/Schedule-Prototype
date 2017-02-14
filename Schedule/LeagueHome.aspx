<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeagueHome.aspx.cs" Inherits="Schedule.LeagueHome" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>

<script type="text/javascript">
function confirmDelete()
{
  if (confirm("Are you sure you want to delete this Team?")==true)
    return true;
  else
    return false;
}
</script>

<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
        .auto-style2 {
            width: 245px;
        }
    </style>

   
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HyperLink ID="link_home" runat="server" NavigateUrl="~/Default.aspx" Font-Italic="True" Font-Size="Smaller">Back to Home</asp:HyperLink>
        <br />
        <br />
    </div>
        <table>
            <tr>
                <td><asp:Label ID="lbl_leagueName" runat="server" Text="(League Name)" Font-Bold="True" Font-Size="Large"></asp:Label></td>
                <td style="width:20px"></td>
                <td><asp:Button ID="btn_editLeague" runat="server" Text="Edit League" Font-Size="Smaller" OnClick="btn_editLeague_Click" /></td>
                <td style="width:20px"></td>
                <td><asp:Button ID="btn_managePermits" runat="server" Text="Manage Permits" Font-Size="Smaller" OnClick="btn_managePermits_Click"/></td>
                <td style="width:20px"></td>
                <td><asp:Button ID="btn_manageSchedule" runat="server" Text="Manage Schedule" Font-Size="Smaller" /></td>
            </tr>
        </table>
        <br />
        <table>
            <tr>
                <td valign="top" rowspan="3">
                    <table>
                        <tr style="height:20px">
                            <td>
                                Number of Teams:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_numberTeams" runat="server" Text="(Number of Teams)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td>
                                Number of Games:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_numberGames" runat="server" Text="(Number of Games)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td class="auto-style1">
                                Number of Permits:
                            </td>
                            <td style="width:20px"></td>
                            <td class="auto-style1">
                                <asp:Label ID="lbl_numberPermits" runat="server" Text="(Number of Permits)"></asp:Label>
                            &nbsp;
                                <asp:Label ID="lbl_minimumPermits" runat="server" Text="(Minimum Number of Permits)" Font-Italic="True" Font-Size="Small" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr style="height:20px">
                            <td style="font-size: small; font-style: italic">(for scheduling only)</td>
                        </tr>
                        <tr style="height:20px">
                            <td>
                                Number of Conferences:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_numberConferences" runat="server" Text="(Number of Conferences)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td>
                                Games Played vs. Conference:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_numberConferenceGames" runat="server" Text="(Number of Games Played vs. Conference)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr style="height:20px">
                            <td>
                                Primary Contact:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_PrimaryContact" runat="server" Text="(Primary Contact)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td></td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_PrimaryContactEmail" runat="server" Text="(Primary Contact Email)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td></td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_PrimaryContactPhone" runat="server" Text="(Primary Contact Phone)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr style="height:20px">
                            <td>
                                Secondary Contact:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_secondaryContact" runat="server" Text="(Secondary Contact)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td></td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_secondaryContactEmail" runat="server" Text="(Secondary Contact Email)"></asp:Label>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td></td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:Label ID="lbl_secondaryContactPhone" runat="server" Text="(Secondary Contact Phone)"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width:20px">&nbsp;</td>
                <td valign="top" class="auto-style2">
                    <asp:GridView ID="grd_Conference" runat="server" AutoGenerateColumns="False" CellPadding="3" DataSourceID="SqlDataSource_Conference" Width="320px">
                        <Columns>
                            <asp:BoundField DataField="conference_id" HeaderText="conference_id" SortExpression="conference_id" Visible="False" />
                            <asp:BoundField DataField="conference_name" HeaderText="Conference" SortExpression="conference_name">
                            <ControlStyle Width="200px" />
                            <FooterStyle Width="200px" />
                            <HeaderStyle Width="200px" />
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:ButtonField ButtonType="Button" Text="Edit">
                            <ControlStyle Width="60px" />
                            <FooterStyle Width="60px" />
                            <HeaderStyle Width="60px" />
                            <ItemStyle Width="60px" />
                            </asp:ButtonField>
                            <asp:ButtonField ButtonType="Button" Text="Delete">
                            <ControlStyle Width="60px" />
                            <FooterStyle Width="60px" />
                            <HeaderStyle Width="60px" />
                            <ItemStyle Width="60px" />
                            </asp:ButtonField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_Conference" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_conference_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HyperLink ID="HyperLink1" runat="server" Font-Italic="True" Font-Size="Smaller">(add Conference)</asp:HyperLink>
                    <br />
                </td>
            </tr>
            <tr style="height:20px"><td></td></tr>
            <tr>
                <td></td>
                <td class="auto-style2">
                    <asp:GridView ID="grd_team" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Teams" OnRowCommand="grd_team_RowCommand" Width="640px" >
                        <Columns>
                            <asp:BoundField DataField="team_id" HeaderText="team_id" SortExpression="team_id" Visible="False" />
                            <asp:BoundField DataField="team_name" HeaderText="Team" SortExpression="team_name" >
                            <ControlStyle Width="200px" />
                            <FooterStyle Width="200px" />
                            <HeaderStyle Width="200px" />
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="conference_id" HeaderText="conference_id" SortExpression="conference_id" Visible="False" />
                            <asp:BoundField DataField="conference_name" HeaderText="Conference" SortExpression="conference_name" >
                            <ControlStyle Width="200px" />
                            <FooterStyle Width="200px" />
                            <HeaderStyle Width="200px" />
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:ButtonField ButtonType="Button" Text="Permits" CommandName="Permits" >
                            <ControlStyle Width="80px" />
                            <FooterStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                            <ItemStyle Width="80px" HorizontalAlign="Center" />
                            </asp:ButtonField>
                            <asp:ButtonField ButtonType="Button" Text="Manage" CommandName="Edit" >
                            <ControlStyle Width="80px" />
                            <FooterStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                            <ItemStyle Width="80px" HorizontalAlign="Center" />
                            </asp:ButtonField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btn_delete" runat="server" Text="Delete" CommandName="Del" OnClientClick="return confirmDelete();" CommandArgument='<%# Container.DataItemIndex %>' Width="80" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_Teams" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_team_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                            <asp:Parameter DefaultValue="0" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:HyperLink ID="link_teamNew" runat="server" Font-Italic="True" Font-Size="Smaller" NavigateUrl="~/TeamEdit.aspx">(add Team)</asp:HyperLink>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
