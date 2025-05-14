module("modules.logic.versionactivity1_2.yaxian.view.YaXianFindToothViewContainer", package.seeall)

local var_0_0 = class("YaXianFindToothViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, YaXianFindToothView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	return
end

function var_0_0.onContainerInit(arg_3_0)
	AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_multiple)
end

return var_0_0
