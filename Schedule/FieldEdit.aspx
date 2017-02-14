<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FieldEdit.aspx.cs" Inherits="Schedule.FieldEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Field Edit Page:<br />
        <table id="tbl_fieldDetails">
            <tr>
                <td>Field Name:</td>
                <td><asp:TextBox ID="txt_fieldName" runat="server" Width="250px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><asp:TextBox ID="txt_addr1" runat="server" Width="250px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Address 2:</td>
                <td><asp:TextBox ID="txt_addr2" runat="server" Width="250px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Address 3:</td>
                <td><asp:TextBox ID="txt_addr3" runat="server" Width="250px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>City:</td>
                <td><asp:TextBox ID="txt_city" runat="server" Width="250px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>State:</td>
                <td><asp:TextBox ID=txt_state runat="server" Width="28px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Zip Code:</td>
                <td><asp:TextBox ID="txt_zip" runat="server" Width="75px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Primary Contact:</td>
                <td><asp:DropDownList ID="dd_primaryContact" runat="server" Height="16px" Width="200px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>Secondary Contact:</td>
                <td><asp:DropDownList ID="dd_secondaryContact" runat="server" Height="21px" Width="200px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>Phone:</td>
                <td><asp:TextBox ID="txt_phone" runat="server"></asp:TextBox></td>
            </tr>
             <tr>
                <td class="auto-style1"></td>
                <td>
                    <center><table>
                        <tr>
                            <td><asp:Button ID="btn_cancel" runat="server" Text="Cancel" /></td>
                            <td width ="10"></td>
                            <td><asp:Button ID="btn_save" runat="server" Text="Save" Width="60px" /></td>
                        </tr>
                    </table></center>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
