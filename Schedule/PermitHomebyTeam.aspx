<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermitHomebyTeam.aspx.cs" Inherits="Schedule.PermitHomebyTeam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HyperLink ID="lnk_LeagueHome" runat="server" Font-Italic="True" Font-Size="Smaller" NavigateUrl="~/LeagueHome.aspx">Back to League Home</asp:HyperLink>
        <br />
        <table>
            <tr>
                <td>Permit Home by Team:</td>
                <td style="width:10px"></td>
                <td><asp:DropDownList ID="dd_team" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="team_name" DataValueField="team_id" Height="25px" Width="250px" AutoPostBack="True" OnSelectedIndexChanged="dd_team_SelectedIndexChanged"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Field" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_team_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td style="width:20px"></td>
                <td>
                    <asp:HyperLink ID="lnk_permitsByField" runat="server" Font-Italic="True" Font-Size="Small" NavigateUrl="~/PermitHomebyField.aspx">Manage Permits by Field</asp:HyperLink>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td><asp:Label ID="lbl_team" runat="server" Text="(Team)"></asp:Label></td>
                <td><asp:Label ID="lbl_numberofPermits" runat="server" Text="(numberofPermits)"></asp:Label></td>
                <td><asp:LinkButton ID="lnk_permitsAdd" runat="server" Font-Italic="True" Font-Size="Small" OnClick="lnk_permitsAdd_Click">Add Permits</asp:LinkButton></td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:GridView ID="grd_permitDetail" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_PermitbyTeam" OnRowCommand="grd_permitDetail_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="permit_id" HeaderText="permit_id" InsertVisible="False" ReadOnly="True" SortExpression="permit_id" Visible="False" />
                            <asp:BoundField DataField="permit_date" HeaderText="permit_date" SortExpression="permit_date" Visible="False" />
                            <asp:BoundField DataField="permit_date_desc" HeaderText="Date" ReadOnly="True" SortExpression="permit_date_desc">
                                <ControlStyle Width="80px" />
                                <FooterStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                                <ItemStyle Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="permit_date_time" HeaderText="Time" ReadOnly="True" SortExpression="permit_date_time" >
                                <ControlStyle Width="80px" />
                                <FooterStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                                <ItemStyle Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="field_id" HeaderText="field_id" SortExpression="field_id" Visible="False" />
                            <asp:BoundField DataField="field_name" HeaderText="Field" SortExpression="field_name">
                                <ControlStyle Width="200px" />
                                <FooterStyle Width="200px" />
                                <HeaderStyle Width="200px" />
                                <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:ButtonField ButtonType="Button" Text="Edit" CommandName="edit">
                                <ControlStyle Width="80px" />
                                <FooterStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                                <ItemStyle Width="80px" />
                            </asp:ButtonField>
                            <asp:ButtonField ButtonType="Button" Text="Delete" CommandName="del">
                                <ControlStyle Width="80px" />
                                <FooterStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                                <ItemStyle Width="80px" />
                            </asp:ButtonField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_PermitbyTeam" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_permit_team" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="team_id" SessionField="teamID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
