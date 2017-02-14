<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FieldNew.aspx.cs" Inherits="Schedule.FieldInsert" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
     Field Create Page:<br />
        <table id="tbl_fieldDetails">
            <tr>
                <td>Field Name:</td>
                <td>
                    <b><asp:TextBox ID="txt_fieldName" runat="server" Width="255px"></asp:TextBox></b>
                </td>
            </tr>
            <tr>
                <td>Address:</td>
                <td><asp:TextBox ID="txt_addr1" runat="server" Width="255px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Address 2:</td>
                <td><asp:TextBox ID="txt_addr2" runat="server" Width="255px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Address 3:</td>
                <td><asp:TextBox ID="txt_addr3" runat="server" Width="255px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>City:</td>
                <td><asp:TextBox ID="txt_city" runat="server" Width="255px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>State:</td>
                <td><asp:TextBox ID=txt_state runat="server" Width="27px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Zip Code:</td>
                <td><asp:TextBox ID="txt_zip" runat="server" Width="50px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Primary Contact:</td>
                <td><asp:DropDownList ID="dd_primaryContact" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>Secondary Contact:</td>
                <td><asp:DropDownList ID="dd_secondaryContact" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>Phone:</td>
                <td><asp:TextBox ID="txt_phone" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td><center><asp:Button ID="btn_cancel" runat="server" Text="Cancel" /></center></td>
                <td><center><asp:Button ID="btn_save" runat="server" Text="save" Width="60px" /></center></td>
            </tr>
        </table>
    </div>
    </div>
    </form>
</body>
</html>
