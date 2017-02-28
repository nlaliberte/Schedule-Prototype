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
                <td></td>
                <td>
                    <center><table>
                        <tr>
                            <td><asp:Button ID="btn_cancel" runat="server" Text="Cancel" Width="80px" OnClick="btn_cancel_Click" /></td>
                            <td width ="10"></td>
                            <td><asp:Button ID="btn_save" runat="server" Text="Save" Width="80px" OnClick="btn_save_Click" /></td>
                        </tr>
                    </table></center>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
