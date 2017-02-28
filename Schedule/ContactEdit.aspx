<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactEdit.aspx.cs" Inherits="Schedule.ContactEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 83px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Contact Edit Page:
        <br />
        <br />
        <table id="tbl_contactDetails">
            <tr>
                <td class="auto-style1">First Name:</td>
                <td>
                    <asp:TextBox ID="txt_firstName" runat="server" Width="150px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Last Name:</td>
                <td><asp:TextBox ID="txt_lastName" runat="server" Width="150px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style1">Phone:</td>
                <td><asp:TextBox ID="txt_phone" runat="server" Width="150px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style1">Email:</td>
                <td><asp:TextBox ID="txt_email" runat="server" Width="200px"></asp:TextBox></td>
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
    </div>
    </form>
</body>
</html>
