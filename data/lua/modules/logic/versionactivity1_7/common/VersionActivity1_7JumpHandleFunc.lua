module("modules.logic.versionactivity1_7.common.VersionActivity1_7JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity1_7JumpHandleFunc")

function var_0_0.jumpTo11720(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[2]

	if not ActivityModel.instance:isActOnLine(var_1_0) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_1_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
	ActivityModel.instance:setTargetActivityCategoryId(var_1_0)
	ActivityController.instance:openActivityBeginnerView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11701(arg_2_0, arg_2_1)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11702(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[2]

	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(nil, nil, var_3_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11703(arg_4_0, arg_4_1)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(VersionActivity1_7DungeonController.openStoreView, VersionActivity1_7DungeonController.instance, VersionActivity1_7Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11700(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[2]

	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(nil, nil, var_5_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11706(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1[2]

	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(ActIsoldeController.enterActivity, ActIsoldeController.instance, var_6_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11707(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1[2]

	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(ActMarcusController.enterActivity, ActMarcusController.instance, var_7_0)

	return JumpEnum.JumpResult.Success
end

return var_0_0
