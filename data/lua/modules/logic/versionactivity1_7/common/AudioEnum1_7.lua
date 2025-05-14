module("modules.logic.versionactivity1_7.common.AudioEnum1_7", package.seeall)

local var_0_0 = AudioEnum

var_0_0.RoleActivity = {
	fight_switch = 20161044,
	star_show = 20170001,
	level_switch = 20161041,
	level_view_open = 20161047
}
var_0_0.VersionActivity1_7Store = {
	play_ui_jinye_chess_talk = 20170010,
	play_ui_jinye_click_stage = 20170011,
	stop_ui_jinye_chess_talk = 20170012,
	play_ui_jinye_chess_enter = 20170009
}
var_0_0.VersionActivity1_7Enter = {
	play_ui_jinye_open = 20170042,
	play_ui_jinye_unfold = 20170043
}

local var_0_1 = {
	Act1_7DungeonBgm = 3200118
}
local var_0_2 = {
	season123_stage_star = 20170037,
	season123_map_scale = 20170025,
	play_ui_mln_no_effect = 20170048,
	season123_entryview_open = 20170020,
	season123_stage_click = 20170022,
	season123_stage_switch = 20170040,
	season123_overview_open = 20170021,
	season123_stage_unlock = 20170023,
	play_ui_mln_page_turn = 20170008
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
