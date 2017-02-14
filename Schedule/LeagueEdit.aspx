<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LeagueEdit.aspx.cs" Inherits="Schedule.LeagueEdit" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/LeagueHome.aspx">Back to League Home</asp:HyperLink>

        <br />
        <br />

        League Edit Page<br />
&nbsp;<table>
            <tr style="height:20px">
                <td>
                    League Name:
                </td>
                <td style="width:20px"></td>
                <td>
                    <asp:TextBox ID="txt_leagueName" runat="server" Text="(League Name)" Width="300px"></asp:TextBox>
                </td>
            </tr>
            <tr style="height:20px">
                <td>
                    Number of Games:
                </td>
                <td style="width:20px"></td>
                <td>
                    <asp:TextBox ID="txt_numberGames" runat="server" Text="(Number of Games)" Width="40px"></asp:TextBox>
                </td>
            </tr>
            <tr style="height:20px">
                <td>
                    Number of Conferences:
                </td>
                <td style="width:20px"></td>
                <td>
                    <asp:TextBox ID="txt_numberConferences" runat="server" Text="(Number of Conferences)" Width="40px"></asp:TextBox>
                </td>
            </tr>
            <tr style="height:20px">
                <td>
                    Games Played vs. Conference:
                </td>
                <td style="width:20px"></td>
                <td>
                    <asp:TextBox ID="txt_numberConferenceGames" runat="server" Text="(Number of Games Played vs. Conference)" Width="40px"></asp:TextBox>
                </td>
            </tr>
            <tr style="height:20px">
                <td>
                    Primary Contact:
                </td>
                <td style="width:20px"></td>
                <td>
                    <asp:DropDownList ID="dd_primaryContact" runat="server" Height="25px" Width="300px" AutoPostBack="True"></asp:DropDownList>
                </td>
            </tr>
            <tr style="height:20px">
                <td>
                    Secondary Contact:
                </td>
                <td style="width:20px"></td>
                <td>
                    <asp:DropDownList ID="dd_secondaryContact" runat="server" Height="25px" Width="300px" AutoPostBack="True"></asp:DropDownList>
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
    </div>
    </form>
</body>
</html>
