<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageField.aspx.cs" Inherits="Schedule.ManageField" %>

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
                <td><asp:Label ID="lbl_header" runat="server" Text="Fields:" Font-Bold="True" Font-Size="Large" /></td>
                <td style="width:10px"></td>
                <td><asp:HyperLink ID="link_fieldNew" runat="server" Font-Italic="True" Font-Size="Smaller" NavigateUrl="~/FieldEdit.aspx">(add Field)</asp:HyperLink></td>
            </tr>
        </table>
        <asp:GridView ID="grd_field" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource_Field" OnRowCommand="grd_field_RowCommand" Width="870px">
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
                <asp:BoundField DataField="field_id" HeaderText="field_id" ReadOnly="True" SortExpression="field_id" Visible="False" />
                <asp:BoundField DataField="field_name" HeaderText="Field Name" ReadOnly="True" SortExpression="field_name">
                    <ControlStyle Width="200px" />
                    <FooterStyle Width="200px" />
                    <HeaderStyle Width="200px" />
                    <ItemStyle Width="200px" />
                </asp:BoundField>
                <asp:BoundField DataField="addr" HeaderText="Address" ReadOnly="True" SortExpression="addr">
                    <ControlStyle Width="300px" />
                    <FooterStyle Width="300px" />
                    <HeaderStyle Width="300px" />
                    <ItemStyle Width="300px" />
                </asp:BoundField>
                <asp:BoundField DataField="addr_2" HeaderText="Addr 2" SortExpression="addr_2" ReadOnly="True" Visible="False">
                    <ControlStyle Width="150px" />
                    <FooterStyle Width="150px" />
                    <HeaderStyle Width="150px" />
                    <ItemStyle Width="150px" />
                </asp:BoundField>
                <asp:BoundField DataField="addr_3" HeaderText="Addr 3" SortExpression="addr_3" ReadOnly="True" Visible="False">
                    <ControlStyle Width="50px" />
                    <FooterStyle Width="50px" />
                    <HeaderStyle Width="50px" />
                    <ItemStyle Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="city" HeaderText="City" ReadOnly="True" SortExpression="city">
                    <ControlStyle Width="100px" />
                    <FooterStyle Width="100px" />
                    <HeaderStyle Width="100px" />
                    <ItemStyle Width="100px" />
                </asp:BoundField>
                <asp:BoundField DataField="state_code" HeaderText="State" ReadOnly="True" SortExpression="state_code">
                    <ControlStyle Width="50px" />
                    <FooterStyle Width="50px" />
                    <HeaderStyle Width="50px" />
                    <ItemStyle Width="50px" />
                </asp:BoundField>
                <asp:BoundField DataField="zip" HeaderText="Zip" ReadOnly="True" SortExpression="zip">
                    <ControlStyle Width="50px" />
                    <FooterStyle Width="50px" />
                    <HeaderStyle Width="50px" />
                    <ItemStyle Width="50px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource_Field" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_field_getall" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:Parameter DefaultValue="0" Name="include_unknown" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>
