module("modules.logic.versionactivity1_8.common.AudioEnum1_8", package.seeall)

local var_0_0 = AudioEnum

var_0_0.Warmup1_8 = {
	play_wrong = 20180003,
	play_caption = 20180002,
	play_noise = 20180001
}
var_0_0.VersionActivity1_8Enter = {
	play_ui_jinye_open = 20180107,
	play_ui_jinye_unfold = 20180108
}

local var_0_1 = {
	Act1_8DungeonBgm = 3200127
}
local var_0_2 = {
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
