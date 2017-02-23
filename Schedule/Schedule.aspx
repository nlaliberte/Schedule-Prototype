<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Schedule.aspx.cs" Inherits="Schedule.Schedule" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">


<script type="text/javascript">
function confirmCreate()
{
  if (confirm("This may take up to 2 minutes PER schedule, please be patient. Are you sure you would like to proceed?")==true)
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
        <a name="top"></a>
        <asp:HyperLink ID="link_home" runat="server" NavigateUrl="~/LeagueHome.aspx" Font-Italic="True" Font-Size="Smaller">Back to League Home</asp:HyperLink>
        <br />
        <br />
        <asp:Label ID="lbl_scheduleName" runat="server" Text="Manage Schedule" Font-Bold="True" Font-Size="Larger"></asp:Label>
        <br />
        <br />
        <asp:Label ID="lbl_currentSchedule" runat="server" Text="Current Schedule:" Font-Size="Large"></asp:Label>
        <br />
        <table style="width:2200px">
            <tr style="width:2200px">
                <td style="width:155px"></td>
                <td style="width:30px"></td>
                <td style="width:80px"></td>
                <td colspan="5" style="width:450px; background-color: #CCE6FF;"><center>Games on Subsequent Days in a Row (Total / Max / Avg per)</center></td>
                <td colspan="8" style="width:720px; background-color: Wheat;"><center>Games in a Week (Total / Max / Avg)</center></td>
                <td colspan="4" style="width:480px; background-color: #A4FFA4;"><center>Games in the Month of: (Total / Avg / Max / Min )</center></td>
                <td style="width:190px"></td>
            </tr>
            <tr style="width:2200px">
                    <td style="width:155px"></td>
                    <td style="width:30px"><center>ID</center></td>
                    <td style="width:80px"><center>Un- scheduled</center></td>
                    <td style="width:90px; background-color:#CCE6FF;"><center>2</center></td>
                    <td style="width:90px"><center>3</center></td>
                    <td style="width:90px; background-color:#CCE6FF;"><center>4</center></td>
                    <td style="width:90px"><center>5</center></td>
                    <td style="width:90px; background-color:#CCE6FF;"><center>6</center></td>
                    <td style="width:90px; background-color: Wheat;"><center>0</center></td>
                    <td style="width:90px"><center>1</center></td>
                    <td style="width:90px; background-color: Wheat;"><center>2</center></td>
                    <td style="width:90px"><center>3</center></td>
                    <td style="width:90px; background-color: Wheat;"><center>4</center></td>
                    <td style="width:90px"><center>5</center></td>
                    <td style="width:90px; background-color: Wheat;"><center>6</center></td>
                    <td style="width:90px"><center>7</center></td>
                    <td style="width:120px; background-color: #A4FFA4;"><center>May</center></td>
                    <td style="width:120px"><center>June</center></td>
                    <td style="width:120px; background-color: #A4FFA4;"><center>July</center></td>
                    <td style="width:120px"><center>August</center></td>
                    <td style="width:190px">Created Date</td>
            </tr>
        </table>
        <asp:GridView ID="grd_scheduleChosen" runat="server" AutoGenerateColumns="False" ShowHeader="False" DataSourceID="SqlDataSource_stgScheduleChosen" OnRowCommand="grd_scheduleChosen_RowCommand" Width="2200px">
            <Columns>
                <asp:ButtonField ButtonType="Button" CommandName="export" Text="Export">
                <ControlStyle Width="80px" />
                <FooterStyle Width="80px" />
                <HeaderStyle Width="80px" />
                <ItemStyle Width="80px" Font-Size="Smaller" />
                </asp:ButtonField>
                <asp:ButtonField ButtonType="Button" CommandName="preview" Text="Preview" >
                <ControlStyle Width="80px" />
                <FooterStyle Width="80px" />
                <HeaderStyle Height="0px" Width="80px" />
                <ItemStyle Width="80px" Font-Size="Smaller" />
                </asp:ButtonField>
                <asp:BoundField DataField="stg_id" SortExpression="stg_id" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="remaining_matchups_to_schedule" ReadOnly="True" SortExpression="remaining_matchups_to_schedule" >
                <ControlStyle Width="90px" />
                <FooterStyle Width="90px" />
                <HeaderStyle Height="0px" Width="90px" />
                <ItemStyle ForeColor="Red" Width="90px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="two_row" ReadOnly="True" SortExpression="two_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="two_row_max" ReadOnly="True" SortExpression="two_row_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Font-Italic="True" Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="two_row_avg" ReadOnly="True" SortExpression="two_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="three_row" ReadOnly="True" SortExpression="three_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"/>
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="three_row_max" ReadOnly="True" SortExpression="three_row_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="three_row_avg" ReadOnly="True" SortExpression="three_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"/>
                <ItemStyle Width="30px" Font-Size="Smaller"  />
                </asp:BoundField>
                <asp:BoundField DataField="four_row" ReadOnly="True" SortExpression="four_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="four_row_max" ReadOnly="True" SortExpression="four_row_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Font-Italic="True" Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="four_row_avg" ReadOnly="True" SortExpression="four_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="five_row" ReadOnly="True" SortExpression="five_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" Font-Size="Smaller" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="five_row_max" ReadOnly="True" SortExpression="five_row_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="five_row_avg" ReadOnly="True" SortExpression="five_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="six_row" ReadOnly="True" SortExpression="six_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="six_row_max" ReadOnly="True" SortExpression="six_row_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Font-Italic="True" Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="six_row_avg" ReadOnly="True" SortExpression="six_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF"/>
                <ItemStyle Width="30px" BackColor="#CCE6FF" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="no_week" ReadOnly="True" SortExpression="no_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="no_week_max" ReadOnly="True" SortExpression="no_week_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Font-Italic="True" Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="no_week_avg" ReadOnly="True" SortExpression="no_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="one_week" ReadOnly="True" SortExpression="one_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"/>
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="one_week_max" ReadOnly="True" SortExpression="one_week_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="one_week_avg" ReadOnly="True" SortExpression="one_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="two_week" ReadOnly="True" SortExpression="two_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="two_week_max" ReadOnly="True" SortExpression="two_week_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Font-Italic="True" Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="two_week_avg" ReadOnly="True" SortExpression="two_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="three_week" ReadOnly="True" SortExpression="three_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px"  Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="three_week_max" ReadOnly="True" SortExpression="three_week_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="three_week_avg" ReadOnly="True" SortExpression="three_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="four_week" ReadOnly="True" SortExpression="four_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="four_week_max" ReadOnly="True" SortExpression="four_week_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Font-Italic="True" Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="four_week_avg" ReadOnly="True" SortExpression="four_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="five_week" ReadOnly="True" SortExpression="five_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="five_week_max" ReadOnly="True" SortExpression="five_week_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="five_week_avg" ReadOnly="True" SortExpression="five_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="six_week" ReadOnly="True" SortExpression="six_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="six_week_max" ReadOnly="True" SortExpression="six_week_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Font-Italic="True" Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="six_week_avg" ReadOnly="True" SortExpression="six_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat"/>
                <ItemStyle Width="30px"  BackColor="Wheat" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="seven_week" ReadOnly="True" SortExpression="seven_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="seven_week_max" ReadOnly="True" SortExpression="seven_week_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="seven_week_avg" ReadOnly="True" SortExpression="seven_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="may_games" ReadOnly="True" SortExpression="may_games" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#A4FFA4" />
                <ItemStyle Width="30px" BackColor="#A4FFA4" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="may_games_avg" ReadOnly="True" SortExpression="may_games_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#A4FFA4" />
                <ItemStyle Width="30px" BackColor="#A4FFA4" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="may_games_max" ReadOnly="True" SortExpression="may_games_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#A4FFA4" />
                <ItemStyle Width="30px" BackColor="#A4FFA4" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="may_games_min" ReadOnly="True" SortExpression="may_games_min" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#A4FFA4" />
                <ItemStyle Width="30px" BackColor="#A4FFA4" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="june_games" ReadOnly="True" SortExpression="june_games" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="june_games_avg" ReadOnly="True" SortExpression="june_games_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="june_games_max" ReadOnly="True" SortExpression="june_games_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="june_games_min" ReadOnly="True" SortExpression="june_games_min" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="july_games" ReadOnly="True" SortExpression="july_games" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#A4FFA4" />
                <ItemStyle Width="30px" BackColor="#A4FFA4" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="july_games_avg" ReadOnly="True" SortExpression="july_games_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#A4FFA4" />
                <ItemStyle Width="30px" BackColor="#A4FFA4" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="july_games_max" ReadOnly="True" SortExpression="july_games_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#A4FFA4" />
                <ItemStyle Width="30px" BackColor="#A4FFA4" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="july_games_min" ReadOnly="True" SortExpression="july_games_min" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#A4FFA4" />
                <ItemStyle Width="30px" BackColor="#A4FFA4" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="august_games" ReadOnly="True" SortExpression="august_games" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="august_games_avg" ReadOnly="True" SortExpression="august_games_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="august_games_max" ReadOnly="True" SortExpression="august_games_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="august_games_min" ReadOnly="True" SortExpression="august_games_min" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" Font-Size="Smaller" />
                </asp:BoundField>
                <asp:BoundField DataField="chosen_stg" HeaderText="chosen_stg" ReadOnly="True" SortExpression="chosen_stg" Visible="False" />
                <asp:BoundField DataField="create_date" HeaderText="create_date" ReadOnly="True" SortExpression="create_date" >
                <ControlStyle Width="200px" />
                <FooterStyle Width="200px" />
                <HeaderStyle Height="0px" Width="200px" />
                <ItemStyle Width="200px" Font-Size="Smaller" />
                </asp:BoundField>
            </Columns>
            <HeaderStyle Height="0px"/>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource_stgScheduleChosen" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="sch_stats_getleague" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                <asp:Parameter DefaultValue="1" Name="chosen" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <br />
        <asp:Label ID="lbl_potentialSchedules" runat="server" Text="Potential Schedules:" Font-Size="Large"></asp:Label>
        <br />
        <table style="width:2290px">
            <tr style="width:2290px">
                <td style="width:225px">
                    <table>
                        <tr>
                            <td>
                                <asp:Label ID="lbl_createSchedule1" runat="server" Text="Create  " Font-Size="Smaller"></asp:Label>
                                <asp:TextBox ID="txt_numSchedule" runat="server" Width="30px"></asp:TextBox>
                                <asp:Label ID="lbl_createSchedule2" runat="server" Text=" New Potential Schedules" Width="135px" Font-Size="Smaller"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
                <td style="width:40px"><asp:Button ID="btn_createSchedule" runat="server" width="40px" Text="GO" OnClientClick="return confirmCreate();" OnClick="btn_createSchedule_Click" /></td>
                <td style="width:80px"></td>
                <td colspan="5" style="width:450px; background-color: #CCE6FF;"><center>Games on Subsequent Days in a Row (Total / Max / Avg )</center></td>
                <td colspan="8" style="width:720px; background-color: Wheat;"><center>Games in a Week (Total / Max / Avg )</center></td>
                <td colspan="4" style="width:480px; background-color: #A4FFA4;"><center>Games in the Month of: (Total / Avg / Max / Min )</center></td>
                <td style="width:195px"></td>
            </tr>
            <tr style="width:2290px">
                    <td style="width:225px"></td>
                    <td style="width:40px"><center>  ID</center></td>
                    <td style="width:70px"><center>Un- scheduled</center></td>
                    <td style="width:90px; background-color: #CCE6FF;"><center>2</center></td>
                    <td style="width:90px"><center>3</center></td>
                    <td style="width:90px; background-color: #CCE6FF;"><center>4</center></td>
                    <td style="width:90px"><center>5</center></td>
                    <td style="width:90px; background-color: #CCE6FF;"><center>6</center></td>
                    <td style="width:90px; background-color: Wheat;"><center>0</center></td>
                    <td style="width:90px"><center>1</center></td>
                    <td style="width:90px; background-color: Wheat;"><center>2</center></td>
                    <td style="width:90px"><center>3</center></td>
                    <td style="width:90px; background-color: Wheat;"><center>4</center></td>
                    <td style="width:90px"><center>5</center></td>
                    <td style="width:90px; background-color: Wheat;"><center>6</center></td>
                    <td style="width:90px"><center>7</center></td>
                    <td style="width:120px; background-color: #A4FFA4;"><center>May</center></td>
                    <td style="width:120px"><center>June</center></td>
                    <td style="width:120px; background-color: #A4FFA4;"><center>July</center></td>
                    <td style="width:120px"><center>August</center></td>
                    <td style="width:195px">Created Date</td>
            </tr>
        </table>
        <asp:GridView ID="grd_schedule" runat="server" AutoGenerateColumns="False" ShowHeader="false" DataSourceID="SqlDataSource_stgSchedule" OnRowCommand="grd_schedule_RowCommand" Width="2280px">
            <Columns>
                <asp:ButtonField ButtonType="Button" CommandName="preview" Text="Preview" >
                <ControlStyle Width="80px" />
                <FooterStyle Width="80px" />
                <HeaderStyle Height="0px" Width="80px" />
                <ItemStyle Width="80px" />
                </asp:ButtonField>
                <asp:ButtonField ButtonType="Button" CommandName="select" Text="Select" >
                <ControlStyle Width="80px" />
                <FooterStyle Width="80px" />
                <HeaderStyle Height="0px" Width="80px" />
                <ItemStyle Width="80px" />
                </asp:ButtonField>
                <asp:ButtonField ButtonType="Button" CommandName="Delete" Text="Delete" >
                <ControlStyle Width="80px" />
                <FooterStyle Width="80px" />
                <HeaderStyle Height="0px" Width="80px" />
                <ItemStyle Width="80px" />
                </asp:ButtonField>
                <asp:BoundField DataField="stg_id" SortExpression="stg_id" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="remaining_matchups_to_schedule" ReadOnly="True" SortExpression="remaining_matchups_to_schedule">
                <ControlStyle Width="90px" />
                <FooterStyle Width="90px" />
                <HeaderStyle Height="0px" Width="90px" />
                <ItemStyle ForeColor="Red" Width="90px" />
                </asp:BoundField>
                <asp:BoundField DataField="two_row" ReadOnly="True" SortExpression="two_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="two_row_max" ReadOnly="True" SortExpression="two_row_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Font-Italic="True" Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="two_row_avg" ReadOnly="True" SortExpression="two_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="three_row" ReadOnly="True" SortExpression="three_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="three_row_max" ReadOnly="True" SortExpression="three_row_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="three_row_avg" ReadOnly="True" SortExpression="three_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="four_row" ReadOnly="True" SortExpression="four_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="four_row_max" ReadOnly="True" SortExpression="four_row_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Font-Italic="True" Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="four_row_avg" ReadOnly="True" SortExpression="four_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="five_row" ReadOnly="True" SortExpression="five_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="five_row_max" ReadOnly="True" SortExpression="five_row_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="five_row_avg" ReadOnly="True" SortExpression="five_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="six_row" ReadOnly="True" SortExpression="six_row" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="six_row_max" ReadOnly="True" SortExpression="six_row_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Font-Italic="True" Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="six_row_avg" ReadOnly="True" SortExpression="six_row_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" BackColor="#CCE6FF" />
                <ItemStyle Width="30px" BackColor="#CCE6FF" />
                </asp:BoundField>
                <asp:BoundField DataField="no_week" ReadOnly="True" SortExpression="no_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Width="30px"  BackColor="Wheat" />
                </asp:BoundField>
                <asp:BoundField DataField="no_week_max" ReadOnly="True" SortExpression="no_week_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Font-Italic="True" Width="30px"  BackColor="Wheat" />
                </asp:BoundField>
                <asp:BoundField DataField="no_week_avg" ReadOnly="True" SortExpression="no_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Width="30px"  BackColor="Wheat" />
                </asp:BoundField>
                <asp:BoundField DataField="one_week" ReadOnly="True" SortExpression="one_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="one_week_max" ReadOnly="True" SortExpression="one_week_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="one_week_avg" ReadOnly="True" SortExpression="one_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="two_week" ReadOnly="True" SortExpression="two_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Width="30px"  BackColor="Wheat" />
                </asp:BoundField>
                <asp:BoundField DataField="two_week_max" ReadOnly="True" SortExpression="two_week_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Font-Italic="True" Width="30px"  BackColor="Wheat" />
                </asp:BoundField>
                <asp:BoundField DataField="two_week_avg" ReadOnly="True" SortExpression="two_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Width="30px"  BackColor="Wheat" />
                </asp:BoundField>
                <asp:BoundField DataField="three_week" ReadOnly="True" SortExpression="three_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="three_week_max" ReadOnly="True" SortExpression="three_week_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="three_week_avg" ReadOnly="True" SortExpression="three_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="four_week" ReadOnly="True" SortExpression="four_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Width="30px"   BackColor="Wheat"/>
                </asp:BoundField>
                <asp:BoundField DataField="four_week_max" ReadOnly="True" SortExpression="four_week_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Font-Italic="True" Width="30px"  BackColor="Wheat" />
                </asp:BoundField>
                <asp:BoundField DataField="four_week_avg" ReadOnly="True" SortExpression="four_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="Wheat" />
                <ItemStyle Width="30px"  BackColor="Wheat" />
                </asp:BoundField>
                <asp:BoundField DataField="five_week" ReadOnly="True" SortExpression="five_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="five_week_max" ReadOnly="True" SortExpression="five_week_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="five_week_avg" ReadOnly="True" SortExpression="five_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="six_week" ReadOnly="True" SortExpression="six_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"   BackColor="Wheat"/>
                <ItemStyle Width="30px"   BackColor="Wheat"/>
                </asp:BoundField>
                <asp:BoundField DataField="six_week_max" ReadOnly="True" SortExpression="six_week_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"   BackColor="Wheat"/>
                <ItemStyle Font-Italic="True" Width="30px"   BackColor="Wheat"/>
                </asp:BoundField>
                <asp:BoundField DataField="six_week_avg" ReadOnly="True" SortExpression="six_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"   BackColor="Wheat"/>
                <ItemStyle Width="30px"   BackColor="Wheat"/>
                </asp:BoundField>
                <asp:BoundField DataField="seven_week" ReadOnly="True" SortExpression="seven_week" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="seven_week_max" ReadOnly="True" SortExpression="seven_week_max">
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Font-Italic="True" Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="seven_week_avg" ReadOnly="True" SortExpression="seven_week_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="may_games" ReadOnly="True" SortExpression="may_games" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="#A4FFA4" />
                <ItemStyle Width="30px"  BackColor="#A4FFA4" />
                </asp:BoundField>
                <asp:BoundField DataField="may_games_avg" ReadOnly="True" SortExpression="may_games_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="#A4FFA4" />
                <ItemStyle Width="30px"  BackColor="#A4FFA4" />
                </asp:BoundField>
                <asp:BoundField DataField="may_games_max" ReadOnly="True" SortExpression="may_games_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="#A4FFA4" />
                <ItemStyle Width="30px"  BackColor="#A4FFA4" />
                </asp:BoundField>
                <asp:BoundField DataField="may_games_min" ReadOnly="True" SortExpression="may_games_min" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="#A4FFA4" />
                <ItemStyle Width="30px"  BackColor="#A4FFA4" />
                </asp:BoundField>
                <asp:BoundField DataField="june_games" ReadOnly="True" SortExpression="june_games" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="june_games_avg" ReadOnly="True" SortExpression="june_games_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="june_games_max" ReadOnly="True" SortExpression="june_games_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="june_games_min" ReadOnly="True" SortExpression="june_games_min" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="july_games" ReadOnly="True" SortExpression="july_games" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="#A4FFA4" />
                <ItemStyle Width="30px"  BackColor="#A4FFA4" />
                </asp:BoundField>
                <asp:BoundField DataField="july_games_avg" ReadOnly="True" SortExpression="july_games_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="#A4FFA4" />
                <ItemStyle Width="30px"  BackColor="#A4FFA4" />
                </asp:BoundField>
                <asp:BoundField DataField="july_games_max" ReadOnly="True" SortExpression="july_games_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="#A4FFA4" />
                <ItemStyle Width="30px"  BackColor="#A4FFA4" />
                </asp:BoundField>
                <asp:BoundField DataField="july_games_min" ReadOnly="True" SortExpression="july_games_min" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px"  BackColor="#A4FFA4" />
                <ItemStyle Width="30px"  BackColor="#A4FFA4" />
                </asp:BoundField>
                <asp:BoundField DataField="august_games" ReadOnly="True" SortExpression="august_games" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="august_games_avg" ReadOnly="True" SortExpression="august_games_avg" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="august_games_max" ReadOnly="True" SortExpression="august_games_max" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="august_games_min" ReadOnly="True" SortExpression="august_games_min" >
                <ControlStyle Width="30px" />
                <FooterStyle Width="30px" />
                <HeaderStyle Height="0px" Width="30px" />
                <ItemStyle Width="30px" />
                </asp:BoundField>
                <asp:BoundField DataField="create_date" ReadOnly="True" SortExpression="create_date" >
                <ControlStyle Width="200px" />
                <FooterStyle Width="200px" />
                <HeaderStyle Height="0px" Width="200px" />
                <ItemStyle Width="200px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
    
    
    
        <asp:SqlDataSource ID="SqlDataSource_stgSchedule" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="sch_stats_getleague" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="chosen" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <br />
        <br />
        <a name="preview"></a>
        <%--<a href="#preview"><i>Back to Top</i></a>--%>
        <asp:HyperLink ID="lnk_top" runat="server" NavigateUrl="~/Schedule.aspx#top" Font-Italic="True" Font-Size="Smaller">Back to Top</asp:HyperLink>
        <br />
        <br />
        <asp:Label ID="lbl_preview" runat="server" Text="Schedule Preview:" Font-Size="Large"></asp:Label>
        <br />
        <asp:Label ID="lbl_stgID" runat="server" Text="(Schedule ID)"></asp:Label>
        <br />
        <br />
        <asp:DropDownList ID="ddl_team" runat="server" DataSourceID="SqlDataSource_team" DataTextField="team_name" DataValueField="team_id" OnSelectedIndexChanged="ddl_team_SelectedIndexChanged" AutoPostBack="True"></asp:DropDownList>
    
        <asp:SqlDataSource ID="SqlDataSource_team" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_team_getall" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                <asp:Parameter DefaultValue="0" Name="include_unknown" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="grd_scheduleByTeam" runat="server" ShowHeader="True" AutoGenerateColumns="False" DataSourceID="SqlDataSource_scheduleByTeam">
            <Columns>
                <asp:BoundField DataField="matchup_id" HeaderText="matchup_id" ReadOnly="True" SortExpression="matchup_id" Visible="False" />
                <asp:BoundField DataField="permit_date" HeaderText="Date" ReadOnly="True" SortExpression="permit_date" />
                <asp:BoundField DataField="permit_time" HeaderText="Time" ReadOnly="True" SortExpression="permit_time" />
                <asp:BoundField DataField="team" HeaderText="Team" ReadOnly="True" SortExpression="team" />
                <asp:BoundField DataField="vs" HeaderText="vs" ReadOnly="True" SortExpression="vs" />
                <asp:BoundField DataField="opponent" HeaderText="Opponent" ReadOnly="True" SortExpression="opponent" />
                <asp:BoundField DataField="field_name" HeaderText="Field" ReadOnly="True" SortExpression="field_name" />
            </Columns>
        </asp:GridView>
        <br />
        <asp:SqlDataSource ID="SqlDataSource_scheduleByTeam" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="sch_schedule_getbyteam" SelectCommandType="StoredProcedure">
            <SelectParameters>
                <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                <asp:SessionParameter DefaultValue="" Name="stg_id" SessionField="stgID" Type="Int32" />
                <asp:SessionParameter DefaultValue="" Name="team_id" SessionField="teamID" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
