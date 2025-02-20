module("modules.logic.herogroup.model.HeroGroupSnapshotMo", package.seeall)

slot0 = pureTable("HeroGroupSnapshotMo")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.groupInfoDict = {}
	slot0.groupInfoList = {}
	slot0.selectIndex = 1
end

function slot0.updateGroupInfoList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5 = 1, #slot1 do
		slot0:updateGroupInfo(slot1[slot5])
	end
end

function slot0.updateGroupInfo(slot0, slot1)
	if not slot0.groupInfoDict[slot1.groupId] then
		slot2 = HeroGroupMO.New()
		slot0.groupInfoDict[slot1.groupId] = slot2

		table.insert(slot0.groupInfoList, slot2)
	end

	slot2:init(slot1)
end

function slot0.getHeroGroupSnapshotList(slot0)
	return slot0.groupInfoList
end

function slot0.getHeroGroupInfo(slot0, slot1, slot2)
	if slot0.groupInfoDict[slot1] == nil and slot2 then
		slot0.groupInfoDict[slot1] = HeroGroupModel.instance:generateTempGroup(nil, , true)
	end

	return slot3
end

function slot0.setSelectIndex(slot0, slot1)
	if slot0.selectIndex == slot1 then
		return
	end

	slot0.selectIndex = slot1

	return true
end

function slot0.getSelectIndex(slot0)
	return slot0.selectIndex
end

return slot0
