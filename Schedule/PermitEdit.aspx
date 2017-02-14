<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermitEdit.aspx.cs" Inherits="Schedule.PermitEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        Permit Edit Page:<br />
        <table id="tbl_permitDetails">
            <tr>
                <td class="auto-style1">Field:</td>
                <td>
                    <asp:DropDownList ID="dd_field" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">Permit Date:</td>
                <td><asp:TextBox ID="txt_date" runat="server" Width="120px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style1">Time:</td>
                <td><asp:TextBox ID="txt_time" runat="server" Width="87px"></asp:TextBox></td>
            </tr>
            <tr>
                <td class="auto-style1">Acquiring Team:</td>
                <td>
                    <asp:DropDownList ID="dd_team" runat="server"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style1"></td>
                <td>
                    <center><table>
                        <tr>
                            <td><asp:Button ID="btn_cancel" runat="server" Text="Cancel" /></td>
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
