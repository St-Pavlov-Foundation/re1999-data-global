module("modules.logic.versionactivity1_9.common.VersionActivity1_9JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity1_9JumpHandleFunc")

function slot0.jumpTo11901(slot0)
	VersionActivity1_9EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11902(slot0, slot1)
	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11903(slot0, slot1)
	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11905(slot0)
	if not ViewMgr.instance:isOpen(ViewName.DungeonMapView) and slot0:jumpToDungeonViewWithEpisode("4#10730#1") ~= JumpEnum.JumpResult.Success then
		return slot1
	end

	ToughBattleController.instance:jumpToActView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11908(slot0, slot1)
	slot2 = slot1[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(uv0.enterRoleActivity, slot2, slot2)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11909(slot0, slot1)
	slot2 = slot1[2]

	VersionActivity1_9EnterController.instance:openVersionActivityEnterView(uv0.enterRoleActivity, slot2, slot2)

	return JumpEnum.JumpResult.Success
end

function slot0.enterRoleActivity(slot0)
	RoleActivityController.instance:enterActivity(slot0)
end

function slot0.jumpTo11906(slot0, slot1)
	VersionActivity1_9EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, , slot1[2], true)

	return JumpEnum.JumpResult.Success
end

return slot0
