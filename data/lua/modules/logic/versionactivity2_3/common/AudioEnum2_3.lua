module("modules.logic.versionactivity2_3.common.AudioEnum2_3", package.seeall)

local var_0_0 = AudioEnum

var_0_0.VersionActivity2_3Store = {
	play_ui_jinye_chess_talk = 20170010,
	play_ui_jinye_click_stage = 20170011,
	stop_ui_jinye_chess_talk = 20170012,
	play_ui_jinye_chess_enter = 20170009
}
var_0_0.VersionActivity2_3Enter = {
	play_ui_jinye_open = 20230011,
	play_ui_jinye_unfold = 20230012
}
var_0_0.Act174 = {
	play_ui_home_door_effect_put = 20233014,
	play_ui_shenghuo_dqq_fight_result = 20233005,
	play_artificial_buff_curses_up = 20233013,
	play_ui_mln_page_turn = 20233007,
	play_ui_home_door_effect_move = 20233015,
	play_ui_shenghuo_dqq_lose = 20233002,
	play_ui_shenghuo_dqq_match_start = 20233006,
	play_artificial_ui_carddisappear = 20233009,
	play_ui_shuori_qiyuan_reset = 20233008,
	play_ui_shenghuo_dqq_dice = 20233011,
	play_ui_shenghuo_dqq_match_success = 20233010,
	play_ui_shuori_qiyuan_down = 20233012,
	play_ui_shenghuo_dqq_move = 20233017,
	stop_ui_shenghuo_dqq_match_success = 20233016,
	play_ui_shenghuo_dqq_draw = 20233003,
	play_ui_shenghuo_dqq_fight_end = 20233001,
	play_ui_shenghuo_dqq_win = 20233004
}

local var_0_1 = {
	stop_ui_bus_2000048 = 2000048,
	ui_shenghuo_discovery_amb_20234001 = 20234001,
	Act2_3DungeonBgm = 20230001,
	play_ui_shenghuo_preheat_amb_20234003 = 20234003
}
local var_0_2 = {
	play_ui_tags_2000013 = 2000013,
	Act176_RecyclePlane = 20211501,
	play_ui_common_click_25050217 = 25050217,
	play_ui_taskinterface_2000011 = 2000011,
	play_ui_activity_switch_20220009 = 20220009,
	Act176_ForbiddenGo = 20180003,
	play_ui_wulu_atticletter_read_over_25005506 = 25005506,
	play_ui_shenghuo_rudder_reset_20234006 = 20234006,
	play_ui_leimi_theft_open_25001023 = 25001023,
	stop_ui_shenghuo_rudder_turn_loop_20234005 = 20234005,
	play_ui_shenghuo_rudder_turn_loop_20234004 = 20234004,
	play_ui_shenghuo_building_collect_20234002 = 20234002,
	Act176_SwitchOn = 20200203,
	Act176_EnterView = 20001913,
	Act176_UnlockNewEpisode = 20200203,
	play_ui_wulu_atticletter_write_loop_25005507 = 25005507
}

var_0_0.CharacterDestinyStone = {
	play_ui_fate_lifestone_unlock = 20231007,
	play_ui_molu_sky_open = 20231002,
	play_ui_leimi_smalluncharted_refresh = 20231003,
	play_ui_fate_slots_unlock = 20231001,
	play_ui_fate_slots_charged = 20231005,
	play_ui_inking_preference_open = 20231004,
	play_ui_resonate_property_click = 20231008,
	play_ui_common_click = 20231010,
	play_ui_fate_runes_put = 20231009,
	play_ui_fate_slots_full = 20231005
}

for iter_0_0, iter_0_1 in pairs(var_0_1) do
	if isDebugBuild and var_0_0.Bgm[iter_0_0] then
		logError("AudioEnum.Bgm重复定义" .. iter_0_0)
	end

	var_0_0.Bgm[iter_0_0] = iter_0_1
end

for iter_0_2, iter_0_3 in pairs(var_0_2) do
	if isDebugBuild and var_0_0.UI[iter_0_2] then
		logError("AudioEnum.UI重复定义" .. iter_0_2)
	end

	var_0_0.UI[iter_0_2] = iter_0_3
end

function var_0_0.activate()
	return
end

return var_0_0
