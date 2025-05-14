module("modules.logic.versionactivity1_9.common.VersionActivity1_9JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity1_9JumpHandleFunc")

function var_0_0.jumpTo11901(arg_1_0)
	VersionActivity1_9EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11902(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(nil, nil, var_2_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11903(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(nil, nil, var_3_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11905(arg_4_0)
	if not ViewMgr.instance:isOpen(ViewName.DungeonMapView) then
		local var_4_0 = arg_4_0:jumpToDungeonViewWithEpisode("4#10730#1")

		if var_4_0 ~= JumpEnum.JumpResult.Success then
			return var_4_0
		end
	end

	ToughBattleController.instance:jumpToActView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11908(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(var_0_0.enterRoleActivity, var_5_0, var_5_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11909(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(var_0_0.enterRoleActivity, var_6_0, var_6_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.enterRoleActivity(arg_7_0)
	RoleActivityController.instance:enterActivity(arg_7_0)
end

function var_0_0.jumpTo11906(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_8_0, true)

	return JumpEnum.JumpResult.Success
end

return var_0_0
