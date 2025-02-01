module("modules.logic.versionactivity1_7.common.VersionActivity1_7JumpHandleFunc", package.seeall)

slot0 = class("VersionActivity1_7JumpHandleFunc")

function slot0.jumpTo11720(slot0, slot1)
	if not ActivityModel.instance:isActOnLine(slot1[2]) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(slot0.waitOpenViewNames, ViewName.ActivityBeginnerView)
	ActivityModel.instance:setTargetActivityCategoryId(slot2)
	ActivityController.instance:openActivityBeginnerView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11701(slot0, slot1)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11702(slot0, slot1)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11703(slot0, slot1)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(VersionActivity1_7DungeonController.openStoreView, VersionActivity1_7DungeonController.instance, VersionActivity1_7Enum.ActivityId.Dungeon)

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11700(slot0, slot1)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(nil, , slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11706(slot0, slot1)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(ActIsoldeController.enterActivity, ActIsoldeController.instance, slot1[2])

	return JumpEnum.JumpResult.Success
end

function slot0.jumpTo11707(slot0, slot1)
	VersionActivity1_7EnterController.instance:openVersionActivityEnterView(ActMarcusController.enterActivity, ActMarcusController.instance, slot1[2])

	return JumpEnum.JumpResult.Success
end

return slot0
