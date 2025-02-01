module("modules.logic.versionactivity2_1.common.VersionActivity2_1JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity2_1JumpHandleFunc")

function slot0.jumpTo12115(slot0, slot1)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12101(slot0, slot1)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12102(slot0, slot1)
	table.insert(slot0.waitOpenViewNames, ViewName.VersionActivity2_1EnterView)
	table.insert(slot0.closeViewNames, ViewName.VersionActivity2_1DungeonMapLevelView)
	VersionActivity2_1DungeonModel.instance:setMapNeedTweenState(true)

	if slot1[3] then
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, uv0, function ()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					isJump = true,
					episodeId = uv0
				})
			end)
		end, nil, slot1[2], true)
	else
		VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openVersionActivityDungeonMapView, VersionActivity2_1DungeonController.instance, slot2, true)
	end

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12103(slot0, slot1)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openStoreView, VersionActivity2_1DungeonController.instance, VersionActivity2_1Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo12104(slot0, slot1)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, , function ()
			Activity165Controller.instance:openActivity165EnterView()
		end)
	end, nil, slot1[2])
end

function slot0.jumpTo12105(slot0, slot1)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		AergusiController.instance:openAergusiLevelView()
	end, nil, slot1[2])
end

function slot0.jumpTo12114(slot0, slot1)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function ()
		Activity164Rpc.instance:sendGetActInfoRequest(VersionActivity2_1Enum.ActivityId.LanShouPa, uv0._onRecvMsg12114, uv0)
	end, nil, slot1[2])
end

function slot0._onRecvMsg12114(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		ViewMgr.instance:openView(ViewName.LanShouPaMapView)
	end
end

return slot0
