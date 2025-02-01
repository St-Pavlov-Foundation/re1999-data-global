module("modules.logic.versionactivity2_0.common.AudioEnum2_0", package.seeall)

AudioEnum.VersionActivity2_0Enter = {
	play_ui_feichi_open = 20200002
}
slot2 = {
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

for slot6, slot7 in pairs({
	Act2_0DungeonBgm = 3200152,
	play_ui_feichi_noise_yure_20200116 = 20200116,
	stop_ui_feichi_noise_yure_20200117 = 20200117
}) do
	if isDebugBuild and slot0.Bgm[slot6] then
		logError("AudioEnum.Bgm重复定义" .. slot6)
	end

	slot0.Bgm[slot6] = slot7
end

for slot6, slot7 in pairs(slot2) do
	if isDebugBuild and slot0.UI[slot6] then
		logError("AudioEnum.UI重复定义" .. slot6)
	end

	slot0.UI[slot6] = slot7
end

function slot0.activate()
end

return slot0
