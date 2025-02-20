module("modules.logic.versionactivity2_3.common.VersionActivity2_3JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity2_3JumpHandleFunc")

function slot0.jumpTo12301(slot0)
	VersionActivity2_3EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12302(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_3EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity2_3DungeonMapLevelView)
	VersionActivity2_3DungeonModel.instance:setMapNeedTweenState(true)

	if slot1[3] then
		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity2_3DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity2_3DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openVersionActivityDungeonMapView, VersionActivity2_3DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12303(slot0, slot1)
	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openStoreView, VersionActivity2_3DungeonController.instance, VersionActivity2_3Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12305(slot0, slot1)
	table.insert(slot0.closeViewNames, ViewName.ActDuDuGuTaskView)
	table.insert(slot0.closeViewNames, ViewName.ActDuDuGuLevelView)
	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12306(slot0, slot1)
	table.insert(slot0.closeViewNames, ViewName.ZhiXinQuanErTaskView)
	table.insert(slot0.closeViewNames, ViewName.ZhiXinQuanErLevelView)
	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12315(slot0, slot1)
	VersionActivity2_3EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

function slot0.enterRoleActivity(slot0)
	RoleActivityController.instance:enterActivity(slot0)
end

return slot0
