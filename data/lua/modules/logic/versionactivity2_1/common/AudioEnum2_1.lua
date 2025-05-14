module("modules.logic.versionactivity2_1.common.AudioEnum2_1", package.seeall)

local var_0_0 = AudioEnum

var_0_0.VersionActivity2_1Enter = {
	play_ui_open = 20210103
}
var_0_0.Activity156 = {
	play_ui_wangshi_fill_win = 20211203,
	play_ui_wangshi_generate = 20211205,
	play_ui_wangshi_fill = 20211202,
	play_ui_wangshi_review = 20211206,
	play_ui_wangshi_fill_fail = 20211204,
	play_ui_wangshi_enter = 20211201
}
var_0_0.VersionActivity2_1ChessGame = {
	play_ui_molu_jlbn_move = 20211301,
	play_ui_molu_monster_awake = 20211302,
	play_ui_activity_box_push = 20211303,
	play_ui_wangshi_bad = 20211304
}
var_0_0.Activity163 = {
	play_ui_wangshi_argus_level_error = 20211504,
	play_ui_wangshi_argus_level_pop = 20211506,
	play_ui_wangshi_argus_level_over = 20211502,
	play_ui_wangshi_argus_level_ask = 20211505,
	play_ui_wangshi_argus_level_hybrid = 20211507,
	play_ui_wangshi_argus_level_open = 20211503,
	play_ui_wangshi_argus_level_slide = 20211501,
	play_ui_wangshi_argus_level_finish = 20211508
}

local var_0_1 = {
	Act2_1DungeonBgm = 3200162,
	play_ui_preheat_2_1_music_20211601 = 20211601,
	stop_ui_preheat_2_1_music_20211602 = 20211602
}
local var_0_2 = {
	play_ui_wangshi_carton_open_20211603 = 20211603
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
