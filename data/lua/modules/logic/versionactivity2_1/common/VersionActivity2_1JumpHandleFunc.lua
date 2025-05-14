module("modules.logic.versionactivity2_1.common.VersionActivity2_1JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_1JumpHandleFunc")

function var_0_0.jumpTo12115(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[2]

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_1_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12101(arg_2_0, arg_2_1)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12102(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[2]
	local var_3_1 = arg_3_1[3]

	table.insert(arg_3_0.waitOpenViewNames, ViewName.VersionActivity2_1EnterView)
	table.insert(arg_3_0.closeViewNames, ViewName.VersionActivity2_1DungeonMapLevelView)
	VersionActivity2_1DungeonModel.instance:setMapNeedTweenState(true)

	if var_3_1 then
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, var_3_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					isJump = true,
					episodeId = var_3_1
				})
			end)
		end, nil, var_3_0, true)
	else
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openVersionActivityDungeonMapView, VersionActivity2_1DungeonController.instance, var_3_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12103(arg_6_0, arg_6_1)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openStoreView, VersionActivity2_1DungeonController.instance, VersionActivity2_1Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12104(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1[2]

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, function()
			Activity165Controller.instance:openActivity165EnterView()
		end)
	end, nil, var_7_0)
end

function var_0_0.jumpTo12105(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1[2]

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		AergusiController.instance:openAergusiLevelView()
	end, nil, var_10_0)
end

function var_0_0.jumpTo12114(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[2]

	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Activity164Rpc.instance:sendGetActInfoRequest(VersionActivity2_1Enum.ActivityId.LanShouPa, arg_12_0._onRecvMsg12114, arg_12_0)
	end, nil, var_12_0)
end

function var_0_0._onRecvMsg12114(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_2 == 0 then
		ViewMgr.instance:openView(ViewName.LanShouPaMapView)
	end
end

return var_0_0
