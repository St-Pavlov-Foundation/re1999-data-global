module("modules.logic.versionactivity2_3.common.VersionActivity2_3JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_3JumpHandleFunc")

function var_0_0.jumpTo12301(arg_1_0)
	VersionActivity2_3EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12302(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[2]
	local var_2_1 = arg_2_1[3]

	table.insert(arg_2_0.waitOpenViewNames, ViewName.VersionActivity2_3EnterView)
	table.insert(arg_2_0.closeViewNames, ViewName.VersionActivity2_3DungeonMapLevelView)
	VersionActivity2_3DungeonModel.instance:setMapNeedTweenState(true)

	if var_2_1 then
		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapLevelView, {
					isJump = true,
					episodeId = var_2_1
				})
			end)
		end, nil, var_2_0, true)
	else
		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openVersionActivityDungeonMapView, VersionActivity2_3DungeonController.instance, var_2_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12303(arg_5_0, arg_5_1)
	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openStoreView, VersionActivity2_3DungeonController.instance, VersionActivity2_3Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12305(arg_6_0, arg_6_1)
	table.insert(arg_6_0.closeViewNames, ViewName.ActDuDuGuTaskView)
	table.insert(arg_6_0.closeViewNames, ViewName.ActDuDuGuLevelView)

	local var_6_0 = arg_6_1[2]

	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_6_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12306(arg_7_0, arg_7_1)
	table.insert(arg_7_0.closeViewNames, ViewName.ZhiXinQuanErTaskView)
	table.insert(arg_7_0.closeViewNames, ViewName.ZhiXinQuanErLevelView)

	local var_7_0 = arg_7_1[2]

	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_7_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12315(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1[2]

	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_8_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.enterRoleActivity(arg_9_0)
	RoleActivityController.instance:enterActivity(arg_9_0)
end

return var_0_0
