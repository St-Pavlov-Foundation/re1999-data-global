module("modules.logic.versionactivity1_2.dreamtail.view.Activity119ViewContainer", package.seeall)

local var_0_0 = class("Activity119ViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Activity119View.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	local var_2_0 = NavigateButtonsView.New({
		true,
		true,
		true
	}, 169)

	return {
		var_2_0
	}
end

function var_0_0.onContainerInit(arg_3_0)
	ActivityEnterMgr.instance:enterActivity(VersionActivity1_2Enum.ActivityId.DreamTail)
	ActivityRpc.instance:sendActivityNewStageReadRequest({
		VersionActivity1_2Enum.ActivityId.DreamTail
	})
end

function var_0_0.playOpenTransition(arg_4_0)
	local var_4_0 = Activity119Model.instance:getData()
	local var_4_1 = Activity119Config.instance:getConfig(VersionActivity1_2Enum.ActivityId.DreamTail, var_4_0.lastSelectDay)
	local var_4_2 = "nomal"

	if var_4_0.lastSelectModel == 2 and DungeonModel.instance:hasPassLevel(var_4_1.normalCO.id) then
		var_4_2 = "hard"
	end

	var_0_0.super.playOpenTransition(arg_4_0, {
		anim = var_4_2
	})
end

function var_0_0.playCloseTransition(arg_5_0)
	local var_5_0 = Activity119Model.instance:getData()
	local var_5_1 = "normalclose"

	if var_5_0.lastSelectModel == 2 then
		var_5_1 = "hardclose"
	end

	var_0_0.super.playCloseTransition(arg_5_0, {
		anim = var_5_1
	})
end

return var_0_0
