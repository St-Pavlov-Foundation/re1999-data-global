module("modules.logic.versionactivity2_0.common.AudioEnum2_0", package.seeall)

local var_0_0 = AudioEnum

var_0_0.VersionActivity2_0Enter = {
	play_ui_feichi_open = 20200002
}

local var_0_1 = {
	Act2_0DungeonBgm = 3200152,
	play_ui_feichi_noise_yure_20200116 = 20200116,
	stop_ui_feichi_noise_yure_20200117 = 20200117
}
local var_0_2 = {
	play_ui_common_click_20200111 = 20200111,
	play_ui_feichi_dooreye_20200112 = 20200112,
	play_ui_feichi_yure_caption_20200114 = 20200114,
	play_ui_resonate_fm = 20200203,
	play_ui_feichi_zoom_20200113 = 20200113,
	stop_ui_feichi_spray_loop = 20200004,
	stop_ui_feichi_yure_caption_20200115 = 20200115,
	play_ui_feichi_spray_loop = 20200003,
	play_ui_resonate_unlock_01 = 20200202,
	play_ui_feichi_spray_finish = 20200005,
	play_ui_resonate_unlock_02 = 20200201
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
