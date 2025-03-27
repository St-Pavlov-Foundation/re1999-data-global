module("modules.logic.versionactivity2_4.common.VersionActivity2_4JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity2_4JumpHandleFunc")

function slot0.jumpTo12401(slot0)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12402(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity2_4DungeonMapLevelView)
	VersionActivity2_4DungeonModel.instance:setMapNeedTweenState(true)

	if slot1[3] then
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_4DungeonController.openVersionActivityDungeonMapView, VersionActivity2_4DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12403(slot0, slot1)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_4DungeonController.openStoreView, VersionActivity2_4DungeonController.instance, VersionActivity2_4Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12404(slot0, slot1)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		PinballController.instance:openMainView()
	end, nil, slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12405(slot0, slot1)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicChapterView()
	end, nil, slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11804(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity1_8DungeonMapLevelView)

	if slot1[3] then
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openVersionActivityDungeonMapView, VersionActivity1_8DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11815(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_8DungeonMapView)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity1_8FactoryMapView)

	if not (slot1 and slot1[3] == 2) then
		table.insert(slot0.closeViewNames, ViewName.VersionActivity1_8FactoryBlueprintView)
	end

	function slot3()
		Activity157Controller.instance:openFactoryMapView(uv0)
	end

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8DungeonMapView) then
			uv0()
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, , uv0)
		end
	end, nil, , true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12408(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		table.insert(uv0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_4Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12400(slot0, slot1)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

return slot0
