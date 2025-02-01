module("modules.logic.versionactivity1_8.common.AudioEnum1_8", package.seeall)

slot0 = AudioEnum
slot0.Warmup1_8 = {
	play_wrong = 20180003,
	play_caption = 20180002,
	play_noise = 20180001
}
slot0.VersionActivity1_8Enter = {
	play_ui_jinye_open = 20180107,
	play_ui_jinye_unfold = 20180108
}
slot2 = {
	play_activitystorysfx_shiji_receive_2 = 20180202,
	Act157FactoryNodeShow = 20180101,
	play_activitystorysfx_shiji_receive = 20180201,
	play_activitystorysfx_shiji_type = 20180203,
	Act157OpenBlueprintView = 20180105,
	play_activitystorysfx_shiji_unlock = 20180204,
	Act157UnlockFactoryComponent = 20180106,
	Act157GetBubbleReward = 20180102,
	Act157FactoryNodeLineShow = 20180103
}

for slot6, slot7 in pairs({
	Act1_8DungeonBgm = 3200127
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
