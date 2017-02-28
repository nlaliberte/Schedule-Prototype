<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageContact.aspx.cs" Inherits="Schedule.ManageContact" %>

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
                <td><asp:Label ID="lbl_header" runat="server" Text="Contacts:" Font-Bold="True" Font-Size="Large" /></td>
                <td style="width:10px"></td>
                <td><asp:HyperLink ID="link_contactNew" runat="server" Font-Italic="True" Font-Size="Smaller" NavigateUrl="~/ContactEdit.aspx">(add Contact)</asp:HyperLink></td>
            </tr>
        </table>
        <asp:GridView ID="grd_contact" runat="server" AutoGenerateColumns="False" DataKeyNames="contact_id,first_name,last_name" DataSourceID="SqlDataSource_Contacts" OnRowCommand="grd_contact_RowCommand" Width="860px">
            <Columns>
                <asp:ButtonField ButtonType="Button" CommandName="edit" Text="Edit">
                    <ControlStyle Width="80px" />
                    <FooterStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                    <ItemStyle Width="80px" />
                </asp:ButtonField>
                <asp:ButtonField ButtonType="Button" CommandName="del" Text="Delete">
                    <ControlStyle Width="80px" />
                    <FooterStyle Width="80px" />
                    <HeaderStyle Width="80px" />
                    <ItemStyle Width="80px" />
                </asp:ButtonField>
                <asp:BoundField DataField="contact_id" HeaderText="contact_id" ReadOnly="True" SortExpression="contact_id" Visible="False" />
                <asp:BoundField DataField="first_name" HeaderText="First Name" ReadOnly="True" SortExpression="first_name">
                    <ControlStyle Width="150px" />
                    <FooterStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="last_name" HeaderText="Last Name" ReadOnly="True" SortExpression="last_name">
                    <ControlStyle Width="150px" />
                    <FooterStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="phone" HeaderText="Phone #" SortExpression="phone">
                    <ControlStyle Width="150px" />
                    <FooterStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="email" HeaderText="Email Address" SortExpression="email">
                    <ControlStyle Width="250px" />
                    <FooterStyle Width="250px" />
                    <HeaderStyle Width="250px" />
                    <ItemStyle Width="250px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>



        <asp:SqlDataSource ID="SqlDataSource_Contacts" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_contact_getall" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>



    </div>
    </form>
</body>
</html>
