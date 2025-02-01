module("modules.logic.versionactivity2_0.common.VersionActivity2_0JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity2_0JumpHandleFunc")

function slot0.jumpTo12002(slot0, slot1)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12003(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity2_0DungeonMapLevelView)
	VersionActivity2_0DungeonModel.instance:setMapNeedTweenState(true)

	if slot1[3] then
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				if VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
					ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
				end

				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openVersionActivityDungeonMapView, VersionActivity2_0DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12004(slot0, slot1)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openStoreView, VersionActivity2_0DungeonController.instance, VersionActivity2_0Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12005(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0DungeonMapView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0DungeonGraffitiView)

	function slot2()
		Activity161Controller.instance:openGraffitiView()
	end

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity2_0DungeonMapView) then
			uv0()
		else
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, , uv0)
		end
	end, nil, , true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12008(slot0, slot1)
	slot2 = slot1[2]

	VersionActivity2_0EnterController.instance:openVersionActivityEnterView(uv0.enterRoleActivity, slot2, slot2)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12009(slot0, slot1)
	slot2 = slot1[2]

	VersionActivity2_0EnterController.instance:openVersionActivityEnterView(uv0.enterRoleActivity, slot2, slot2)

	return JumpEnum.JumpResult.Success
end

function slot0.enterRoleActivity(slot0)
	RoleActivityController.instance:enterActivity(slot0)
end

function slot0.jumpTo12001(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(JumpEnum.ActIdEnum.Act1_5Dungeon)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12006(slot0, slot1)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

return slot0
