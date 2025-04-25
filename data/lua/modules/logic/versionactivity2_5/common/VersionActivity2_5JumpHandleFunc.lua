module("modules.logic.versionactivity2_5.common.VersionActivity2_5JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity2_5JumpHandleFunc")

function slot0.jumpTo12301(slot0)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12502(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity2_5DungeonMapLevelView)
	VersionActivity2_5DungeonModel.instance:setMapNeedTweenState(true)

	if slot1[3] then
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity2_5DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_5DungeonController.openVersionActivityDungeonMapView, VersionActivity2_5DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12503(slot0, slot1)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_5DungeonController.openStoreView, VersionActivity2_5DungeonController.instance, VersionActivity2_5Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function slot0.enterRoleActivity(slot0)
	RoleActivityController.instance:enterActivity(slot0)
end

function slot0.jumpTo11602(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)

	if slot1[3] then
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_6DungeonController.openVersionActivityDungeonMapView, VersionActivity1_6DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12514(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_5Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12505(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(slot0.waitOpenViewNames, ViewName.Act183MainView)
	table.insert(slot0.waitOpenViewNames, ViewName.Act183DungeonView)
	table.insert(slot0.closeViewNames, ViewName.Act183TaskView)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		slot4 = Act183Helper.generateDungeonViewParams(Act183Config.instance:getEpisodeCo(uv0 and uv0[3]) and slot1.type, slot1 and slot1.groupId)

		if not ViewMgr.instance:isOpen(ViewName.Act183MainView) then
			Act183Controller.instance:openAct183MainView(nil, function ()
				Act183Controller.instance:openAct183DungeonView(uv0)
			end)
		else
			Act183Controller.instance:openAct183DungeonView(slot4)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12512(slot0, slot1)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12513(slot0, slot1)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12520(slot0, slot1)
	Activity187Controller.instance:openAct187View()

	return JumpEnum.JumpResult.Success
end

return slot0
