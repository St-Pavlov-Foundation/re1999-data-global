module("modules.logic.herogroup.model.HeroGroupSnapshotModel", package.seeall)

slot0 = class("HeroGroupSnapshotModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0.curSnapshotId = nil
	slot0.curGroupIds = nil
	slot0.customSelectDict = {}
end

function slot0.onReceiveGetHeroGroupSnapshotListReply(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5 = 1, #slot1.heroGroupSnapshots do
		slot0:updateHeroGroupSnapshot(slot1.heroGroupSnapshots[slot5])
	end
end

function slot0.updateHeroGroupSnapshot(slot0, slot1)
	if not slot0:getById(slot1.snapshotId) then
		slot2 = HeroGroupSnapshotMo.New()

		slot2:init(slot1.snapshotId)
		slot0:addAtLast(slot2)
	end

	slot2:updateGroupInfoList(slot1.heroGroupSnapshots)
end

function slot0.getHeroGroupSnapshotList(slot0, slot1)
	return slot0:getById(slot1) and slot2:getHeroGroupSnapshotList()
end

function slot0.getHeroGroupInfo(slot0, slot1, slot2, slot3)
	return slot0:getById(slot1) and slot4:getHeroGroupInfo(slot2, slot3)
end

function slot0.setParam(slot0, slot1)
	slot0.curSnapshotId, slot0.curGroupIds = HeroGroupHandler.getSnapShot(slot1)
	slot0.episodeId = slot1
end

function slot0.getCurSnapshotId(slot0)
	return slot0.curSnapshotId
end

function slot0.getCurGroupId(slot0, slot1)
	return slot0.curGroupIds[slot0:getSelectIndex(slot1)]
end

function slot0.getCurGroup(slot0)
	return slot0:getHeroGroupInfo(slot0.curSnapshotId, slot0:getCurGroupId(slot0.curSnapshotId), true)
end

function slot0.getCurGroupList(slot0)
	return slot0:getHeroGroupSnapshotList(slot0.curSnapshotId)
end

function slot0.setSelectIndex(slot0, slot1, slot2)
	if (slot1 or slot0.curSnapshotId) == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		if slot0.customSelectDict[DungeonConfig.instance:getEpisodeCO(slot0.episodeId) and slot3.type or 0] == slot2 then
			return false
		end

		slot0.customSelectDict[slot4] = slot2

		return true
	end

	if slot0:getById(slot1) then
		return slot3:setSelectIndex(slot2)
	end
end

function slot0.getSelectIndex(slot0, slot1)
	if (slot1 or slot0.curSnapshotId) == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		if slot0.customSelectDict[DungeonConfig.instance:getEpisodeCO(slot0.episodeId) and slot2.type or 0] == nil then
			slot0.customSelectDict[slot3] = 1
		end

		return slot0.customSelectDict[slot3]
	end

	if slot0:getById(slot1) then
		return slot2:getSelectIndex()
	end
end

function slot0.getGroupName(slot0)
	return slot0:getHeroGroupInfo(slot0.curSnapshotId, slot0:getCurGroupId()) and slot2.name
end

function slot0.setGroupName(slot0, slot1, slot2, slot3)
	if slot0:getHeroGroupInfo(slot1, slot2) then
		slot4.name = slot3
	end
end

slot0.instance = slot0.New()

return slot0
