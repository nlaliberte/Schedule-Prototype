<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PermitNew.aspx.cs" Inherits="Schedule.PermitNew" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table>
            <tr>
                <td style="font-weight:800">Enter New Permits</td>
                <td style="width:20px"></td>
                <td><asp:Button ID="btn_save" runat="server" Text="Save" style="width:60px; height:25px;" Font-Bold="True" OnClick="btn_save_Click" /></td>
                <td style="width:10px"></td>
                <td><asp:Button ID="btn_rest" runat="server" Text="Reset" style="width:60px; height:25px;" OnClick="btn_reset_Click" /></td>
                <td style="width:10px"></td>
                <td><asp:Button ID="btn_back" runat="server" Text="Back" style="width:60px; height: 25px;" OnClick="btn_back_Click" /></td>      
            </tr>


        </table>
        <br />
        <br />
        <table>
            <tr style="font-weight: bold">
                <td style="vertical-align:top" class="auto-style1">Team</td>
                <td style="vertical-align:top" class="auto-style1">Date</td>
                <td style="vertical-align:top" class="auto-style1">Time</td>
                <td style="vertical-align:top" class="auto-style1"></td>
                <td style="vertical-align:top" class="auto-style1">Field</td>
                <td style="vertical-align:top" class="auto-style1"></td>
            </tr>
            <tr runat="server" id="row1">
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  ID="dd_team1" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id" Height="25px"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Team" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_team_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:SessionParameter Name="league_id" SessionField="leagueID" Type="Int32" />
                            <asp:Parameter DefaultValue="2" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" ID="txt_date1" runat="server" Height="19px"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" ID="txt_time1" runat="server" Height="19px"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList ID="dd_ampm1" runat="server" Height="25px">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  ID="dd_field1" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id" Height="25px"></asp:DropDownList>
                    <asp:SqlDataSource ID="SqlDataSource_Field" runat="server" ConnectionString="<%$ ConnectionStrings:ScheduleConnectionString %>" SelectCommand="pr_field_getall" SelectCommandType="StoredProcedure">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="include_unknown" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error1" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr runat="server" id="row1_2" style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr runat="server" id="row2">
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team2" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date2" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time2" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm2" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field2" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error2" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr runat="server" id="row2_2" style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  ID="dd_team3" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" ID="txt_date3" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" ID="txt_time3" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList ID="dd_ampm3" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  ID="dd_field3" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error3" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team4" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date4" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time4" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm4" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field4" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error4" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team5" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date5" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time5" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm5" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field5" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error5" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team6" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date6" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time6" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm6" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field6" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error6" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team7" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date7" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time7" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm7" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field7" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error7" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team8" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date8" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time8" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm8" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field8" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error8" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team9" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date9" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time9" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm9" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field9" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error9" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team10" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date10" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time10" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm10" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field10" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error10" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team11" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date11" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time11" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm11" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field11" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error11" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team12" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date12" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time12" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm12" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field12" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error12" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team13" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date13" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time13" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm13" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field13" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error13" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team14" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date14" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time14" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm14" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field14" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error14" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team15" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date15" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time15" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm15" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field15" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error15" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team16" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date16" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time16" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm16" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field16" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error16" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team17" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date17" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time17" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm17" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field17" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error17" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team18" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date18" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time18" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm18" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field18" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error18" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team19" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date19" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time19" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm19" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field19" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error19" runat="server" Text=""></asp:Label></td>
            </tr>
            <tr style="height:5px"><td style="vertical-align:top"></td></tr>
            <tr>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_team20" runat="server" DataSourceID="SqlDataSource_Team" DataTextField="team_name" DataValueField="team_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_date20" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:TextBox Width="75px" Height="19px" ID="txt_time20" runat="server"></asp:TextBox></td>
                <td style="vertical-align:top"><asp:DropDownList Height="25px" ID="dd_ampm20" runat="server">
                    <asp:ListItem>AM</asp:ListItem>
                    <asp:ListItem Selected="True">PM</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="vertical-align:top"><asp:DropDownList Width="200px"  Height="25px" ID="dd_field20" runat="server" DataSourceID="SqlDataSource_Field" DataTextField="field_name" DataValueField="field_id"></asp:DropDownList></td>
                <td style="vertical-align:top"><asp:Label ID="lbl_error20" runat="server" Text=""></asp:Label></td>
            </tr>

        </table>



    </div>
    </form>
</body>
</html>
