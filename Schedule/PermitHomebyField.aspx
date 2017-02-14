<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermitHomebyField.aspx.cs" Inherits="Schedule.PermitHomebyField" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

 <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>

<script type="text/javascript">
function confirmDelete()
{
  if (confirm("Are you sure you want to delete this Permit?")==true)
    return true;
  else
    return false;
}
</script>

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
                <td>Permit Home by Field:</td>
                <td style="width:10px"></td>
                <td><asp:DropDownList ID="dd_field" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id" Height="25px" Width="250px" AutoPostBack="True" OnSelectedIndexChanged="dd_field_SelectedIndexChanged"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Field" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_field_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="0" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td style="width:20px"></td>
                <td>
                    <asp:HyperLink ID="lnk_permitsByTeam" runat="server" Font-Italic="True" Font-Size="Small" NavigateUrl="~/PermitHomebyTeam.aspx">Manage Permits by Team</asp:HyperLink>
                </td>
            </tr>
        </table>
        <table>
            <tr>
                <td><asp:Label ID="lbl_field" runat="server" Text="(Field)"></asp:Label></td>
                <td><asp:Label ID="lbl_numberofPermits" runat="server" Text="(numberofPermits)"></asp:Label></td>
                <td><asp:LinkButton ID="lnk_permitsAdd" runat="server" Font-Italic="True" Font-Size="Small" OnClick="lnk_permitsAdd_Click">Add Permits</asp:LinkButton></td>
            </tr>
            <tr>
                <td colspan="3">
                    <asp:GridView ID="grd_permitDetail" runat="server" AutoGenerateColumns="False" DataKeyNames="permit_id" DataSourceID="SqlDataSource_PermitbyTeam" OnRowCommand="grd_permitDetail_RowCommand" Width="520px" >
                        <Columns>
                            <asp:BoundField DataField="permit_id" HeaderText="permit_id" InsertVisible="False" ReadOnly="True" SortExpression="permit_id" Visible="False" />
                            <asp:BoundField DataField="permit_date" HeaderText="permit_date" SortExpression="permit_date" Visible="False" />
                            <asp:BoundField DataField="permit_date_desc" HeaderText="Date" ReadOnly="True" SortExpression="permit_date_desc" >
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
                            <asp:BoundField DataField="home_team_id" HeaderText="home_team_id" SortExpression="home_team_id" Visible="False" />
                            <asp:BoundField DataField="team_name" HeaderText="Acquiring Team" ReadOnly="True" SortExpression="team_name" >
                            <ControlStyle Width="200px" />
                            <FooterStyle Width="200px" />
                            <HeaderStyle Width="200px" />
                            <ItemStyle Width="200px" />
                            </asp:BoundField>
                            <asp:ButtonField ButtonType="Button" Text="Edit" CommandName="Edit" >
                            <ControlStyle Width="80px" />
                            <FooterStyle Width="80px" />
                            <HeaderStyle Width="80px" />
                            <ItemStyle Width="80px" />
                            </asp:ButtonField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="btn_delete" runat="server" Text="Delete" CommandName="Del" OnClientClick="return confirmDelete();" CommandArgument='<%# Container.DataItemIndex %>' Width="80" />
                                </ItemTemplate>
                                <ControlStyle Width="80px" />
                                <FooterStyle Width="80px" />
                                <HeaderStyle Width="80px" />
                                <ItemStyle Width="80px" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource_PermitbyTeam" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_permit_field" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                            <asp:SessionParameter Name="field_id" SessionField="fieldID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
