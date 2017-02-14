<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeamEdit.aspx.cs" Inherits="Schedule.TeamEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HyperLink ID="lnk_leagueHome" runat="server" NavigateUrl="~/LeagueHome.aspx" Font-Italic="True" Font-Size="Small">Back to League Home</asp:HyperLink>
        <br />
        <br />
        Team New/Edit Page <br />
        <br />
        <table>
            <tr>
                <td rowspan ="3" valign="top">
                    <table>
                        <tr style="height:20px">
                            <td>
                                Team Name:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:TextBox ID="txt_leagueName" runat="server" Text="(Team Name)" Width="298px" Height="25px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td>
                                Conference:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:DropDownList ID="dd_conference" runat="server" Height="25px" Width="300px" AutoPostBack="True" DataSourceID="SqlDataSource_Conference" DataTextField="conference_name" DataValueField="conference_id"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Conference" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_conference_getall" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td>
                                Primary Contact:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:DropDownList ID="dd_primaryContact" runat="server" Height="25px" Width="300px" AutoPostBack="True" DataSourceID="SqlDataSource_Contact" DataTextField="contact_name" DataValueField="contact_id"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Contact" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_contact_dropdown" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr style="height:20px">
                            <td>
                                Secondary Contact:
                            </td>
                            <td style="width:20px"></td>
                            <td>
                                <asp:DropDownList ID="dd_secondaryContact" runat="server" Height="25px" Width="300px" AutoPostBack="True" DataSourceID="SqlDataSource_Contact" DataTextField="contact_name" DataValueField="contact_id"></asp:DropDownList>
                            </td>
                        </tr>
                        <tr style="height:20px"><td></td></tr>
                        <tr>
                            <td colspan="3">
                                <center><table>
                                    <tr>
                                        <td><asp:Button ID="btn_cancel" runat="server" Text="Cancel" OnClick="btn_cancel_Click" /></td>
                                        <td style="width:10px"></td>
                                        <td><asp:Button ID="btn_save" runat="server" Text="Save" Width="60px" OnClick="btn_save_Click" /></td>
                                    </tr>
                                </table></center>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width:5px"></td>
                <td>
                    <table>
                        <tr>
                            <td colspan="2"><b>Home Fields:</b></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:GridView ID="grd_HomeField" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_HomeField" OnRowCommand="grd_homeField_RowCommand" Width="280px">
                                    <Columns>
                                        <asp:BoundField DataField="team_id" HeaderText="team_id" SortExpression="team_id" Visible="False" />
                                        <asp:BoundField DataField="team_name" HeaderText="Team" SortExpression="team_name" Visible="False" >
                                        <ControlStyle Width="200px" />
                                        <FooterStyle Width="200px" />
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="field_id" HeaderText="field_id" SortExpression="field_id" Visible="False" />
                                        <asp:BoundField DataField="field_name" HeaderText="Field" SortExpression="field_name" >
                                        <ControlStyle Width="200px" />
                                        <FooterStyle Width="200px" />
                                        <HeaderStyle Width="200px" />
                                        <ItemStyle Width="200px" />
                                        </asp:BoundField>
                                        <asp:ButtonField ButtonType="Button" Text="Remove" CommandName="remove">
                                        <ControlStyle Width="80px" />
                                        <FooterStyle Width="80px" />
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                        </asp:ButtonField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource_HomeField" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_home_field_getall" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="team_id" SessionField="teamID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr style="height:5px"><td></td></tr>
                        <tr>
                            <td>Add Home Field:</td>
                            <td>
                                <asp:DropDownList ID="dd_field" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSource_Field" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_field_available_by_team" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="team_id" SessionField="teamID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:Button ID="btn_addField" runat="server" Text="Add" OnClick="btn_addField_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2"><asp:Label ID="lbl_homeField" runat="server" Text=""></asp:Label></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="height:5px"></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <table>
                        <tr>
                            <td colspan="2"><b>Requested Days Off:</b></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:GridView ID="grd_offDay" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_OffDay" OnRowCommand="grd_offDay_RowCommand" Width="160px">
                                    <Columns>
                                        <asp:BoundField DataField="team_id" HeaderText="team_id" SortExpression="team_id" Visible="False" />
                                        <asp:BoundField DataField="off_day" HeaderText="Off Day" ReadOnly="True" SortExpression="off_day">
                                        <ControlStyle Width="80px" />
                                        <FooterStyle Width="80px" />
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                        </asp:BoundField>
                                        <asp:ButtonField ButtonType="Button" CommandName="remove" Text="Remove">
                                        <ControlStyle Width="80px" />
                                        <FooterStyle Width="80px" />
                                        <HeaderStyle Width="80px" />
                                        <ItemStyle Width="80px" />
                                        </asp:ButtonField>
                                    </Columns>
                                </asp:GridView>
                                <asp:SqlDataSource ID="SqlDataSource_OffDay" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_team_day_off_getall" SelectCommandType="StoredProcedure">
                                    <SelectParameters>
                                        <asp:SessionParameter Name="team_id" SessionField="teamID" Type="Int32" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="txt_offDay" runat="server" Height="25px" Width="100px"></asp:TextBox>
                                <asp:Button ID="btn_addOffDay" runat="server" Text="Add" OnClick="btn_addOffDay_Click" />
                            </td>
                        </tr>
                        <tr><td>
                            <asp:Label ID="lbl_dayOff" runat="server" Text=""></asp:Label></td></tr>
                    </table>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
