module("modules.logic.versionactivity1_8.common.VersionActivity1_8JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity1_8JumpHandleFunc")

function slot0.jumpTo11803(slot0, slot1)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11804(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_8EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_8DungeonMapLevelView)

	if slot1[3] then
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openVersionActivityDungeonMapView, VersionActivity1_8DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11805(slot0, slot1)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openStoreView, VersionActivity1_8DungeonController.instance, VersionActivity1_8Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11815(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_8EnterView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_8DungeonMapView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_8FactoryMapView)

	if not (slot1 and slot1[3] == 2) then
		table.insert(slot0.closeViewNames, ViewName.VersionActivity1_8FactoryBlueprintView)
	end

	function slot3()
		Activity157Controller.instance:openFactoryMapView(uv0)
	end

	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8DungeonMapView) then
			uv0()
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, , uv0)
		end
	end, nil, , true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11806(slot0, slot1)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterView(ActWeilaController.enterActivity, ActWeilaController.instance, slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11807(slot0, slot1)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterView(ActWindSongController.enterActivity, ActWindSongController.instance, slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11810(slot0, slot1)
	if not ActivityModel.instance:isActOnLine(slot1[2]) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.ActivityBeginnerView)
	ActivityModel.instance:setTargetActivityCategoryId(slot2)
	ActivityController.instance:openActivityBeginnerView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11811(slot0, slot1)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

return slot0
