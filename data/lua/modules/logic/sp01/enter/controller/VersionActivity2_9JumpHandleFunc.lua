module("modules.logic.sp01.enter.controller.VersionActivity2_9JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_9JumpHandleFunc")

function var_0_0.jumpTo12102(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[2]
	local var_1_1 = arg_1_1[3]

	table.insert(arg_1_0.closeViewNames, ViewName.VersionActivity2_1DungeonMapLevelView)
	VersionActivity2_1DungeonModel.instance:setMapNeedTweenState(true)

	if var_1_1 then
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1, function()
			ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
				isJump = true,
				episodeId = var_1_1
			})
		end)
	else
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView()
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13010(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[2] or 13010

	table.insert(arg_3_0.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_3_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_0Enum.ActivityId.Reactivity)
	end, nil, var_3_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12104(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, function()
			Activity165Controller.instance:openActivity165EnterView()
		end)
	end, nil, var_5_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130502(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1[2]
	local var_8_1 = arg_8_1[3]
	local var_8_2 = ViewName.VersionActivity2_9EnterView
	local var_8_3 = ViewName.VersionActivity2_9DungeonMapLevelView

	table.insert(arg_8_0.waitOpenViewNames, var_8_2)
	table.insert(arg_8_0.closeViewNames, var_8_3)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	if var_8_1 then
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_9DungeonController.instance:openVersionActivityDungeonMapView(nil, var_8_1, function()
				ViewMgr.instance:openView(var_8_3, {
					isJump = true,
					episodeId = var_8_1
				})
			end)
		end, nil, var_8_0, true)
	else
		VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_9DungeonController.openVersionActivityDungeonMapView, VersionActivity2_9DungeonController.instance, var_8_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130503(arg_11_0, arg_11_1)
	table.insert(arg_11_0.waitOpenViewNames, ViewName.VersionActivity2_9StoreView)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_9DungeonController.openStoreView, VersionActivity2_9DungeonController.instance, VersionActivity2_9Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130504(arg_12_0, arg_12_1)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		var_0_0._handleJumpTo130504(arg_12_1)
	end, nil, VersionActivity2_9Enum.ActivityId.Outside, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0._handleJumpTo130504(arg_14_0)
	local var_14_0 = arg_14_0[3]

	if var_14_0 == 1 then
		local var_14_1

		if arg_14_0[4] then
			var_14_1 = tonumber(arg_14_0[4])
		end

		AssassinController.instance:openAssassinMapView({
			buildingType = var_14_1
		})
	elseif var_14_0 == 2 then
		AssassinController.instance:openAssassinMapView({
			questMapId = tonumber(arg_14_0[3])
		})
	elseif var_14_0 == 3 then
		AssassinController.instance:openAssassinMapView({
			questId = tonumber(arg_14_0[3])
		})
	else
		logError("not define type : %s", var_14_0)
	end
end

function var_0_0.jumpTo130507(arg_15_0, arg_15_1)
	VersionActivity2_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(OdysseyDungeonController.openDungeonView, OdysseyDungeonController.instance, VersionActivity2_9Enum.ActivityId.Dungeon2, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130518(arg_16_0, arg_16_1)
	Activity204Controller.instance:jumpToActivity(arg_16_1[2])

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo130519(arg_17_0, arg_17_1)
	Activity204Controller.instance:jumpToActivity(arg_17_1[2])

	return JumpEnum.JumpResult.Success
end

return var_0_0
