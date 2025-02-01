module("modules.logic.versionactivity2_1.common.AudioEnum2_1", package.seeall)

slot0 = AudioEnum
slot0.VersionActivity2_1Enter = {
	play_ui_open = 20210103
}
slot0.Activity156 = {
	play_ui_wangshi_fill_win = 20211203,
	play_ui_wangshi_generate = 20211205,
	play_ui_wangshi_fill = 20211202,
	play_ui_wangshi_review = 20211206,
	play_ui_wangshi_fill_fail = 20211204,
	play_ui_wangshi_enter = 20211201
}
slot0.VersionActivity2_1ChessGame = {
	play_ui_molu_jlbn_move = 20211301,
	play_ui_molu_monster_awake = 20211302,
	play_ui_activity_box_push = 20211303,
	play_ui_wangshi_bad = 20211304
}
slot0.Activity163 = {
	play_ui_wangshi_argus_level_error = 20211504,
	play_ui_wangshi_argus_level_pop = 20211506,
	play_ui_wangshi_argus_level_over = 20211502,
	play_ui_wangshi_argus_level_ask = 20211505,
	play_ui_wangshi_argus_level_hybrid = 20211507,
	play_ui_wangshi_argus_level_open = 20211503,
	play_ui_wangshi_argus_level_slide = 20211501,
	play_ui_wangshi_argus_level_finish = 20211508
}
slot2 = {
	play_ui_wangshi_carton_open_20211603 = 20211603
}

for slot6, slot7 in pairs({
	Act2_1DungeonBgm = 3200162,
	play_ui_preheat_2_1_music_20211601 = 20211601,
	stop_ui_preheat_2_1_music_20211602 = 20211602
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
