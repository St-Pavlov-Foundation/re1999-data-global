module("modules.logic.versionactivity2_5.challenge.model.Act183InfoMO", package.seeall)

slot0 = pureTable("Act183InfoMO")

function slot0.init(slot0, slot1)
	slot0:_onGetGroupListInfo(slot1.groupList)
	slot0:_onGetBadgeNum(slot1.badgeNum)

	slot0._params = slot1.params
end

function slot0._onGetGroupListInfo(slot0, slot1)
	slot0._groupList = {}
	slot0._groupMap = {}
	slot0._groupTypeMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = Act183GroupEpisodeMO.New()

		slot7:init(slot6)
		table.insert(slot0._groupList, slot7)

		slot0._groupMap[slot7:getGroupId()] = slot7
		slot0._groupTypeMap[slot9] = slot0._groupTypeMap[slot7:getGroupType()] or {}

		table.insert(slot0._groupTypeMap[slot9], slot7)
	end

	table.sort(slot0._groupList, slot0._sortGroupMoById)

	for slot5, slot6 in pairs(slot0._groupTypeMap) do
		table.sort(slot6, slot0._sortGroupMoById)
	end
end

function slot0._sortGroupMoById(slot0, slot1)
	return slot0:getGroupId() < slot1:getGroupId()
end

function slot0._onGetBadgeNum(slot0, slot1)
	slot0._badgeNum = slot1 or 0
	slot0._unlockSupportHeros = {}
	slot0._unlockSupportHeroIds = {}

	for slot7, slot8 in ipairs(Act183Helper.getUnlockSupportHeroIds(Act183Model.instance:getActivityId(), slot1)) do
		slot9 = HeroMo.New()

		slot9:initFromTrial(slot8)
		table.insert(slot0._unlockSupportHeros, slot9)
		table.insert(slot0._unlockSupportHeroIds, slot8)
	end
end

function slot0.getGroupEpisodes(slot0)
	return slot0._groupList
end

function slot0.getBadgeNum(slot0)
	return slot0._badgeNum
end

function slot0.updateBadgeNum(slot0, slot1)
	slot0:_onGetBadgeNum(slot1)
end

function slot0.getGroupEpisodeMos(slot0, slot1)
	return slot0._groupTypeMap[slot1]
end

function slot0.getGroupEpisodeMo(slot0, slot1)
	return slot0._groupMap and slot0._groupMap[slot1]
end

function slot0.getUnlockSupportHeros(slot0)
	return slot0._unlockSupportHeros
end

function slot0.getUnlockSupportHeroIds(slot0)
	return slot0._unlockSupportHeroIds
end

function slot0.updateGroupMo(slot0, slot1)
	slot2 = Act183GroupEpisodeMO.New()

	slot2:init(slot1)

	if slot0:getGroupEpisodeMo(slot2:getGroupId()) then
		slot4:init(slot1)
	end

	return slot4
end

return slot0
