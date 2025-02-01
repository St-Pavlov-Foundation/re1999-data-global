module("modules.logic.character.model.CharacterBackpackEquipListModel", package.seeall)

slot0 = class("CharacterBackpackEquipListModel", ListScrollModel)

function slot0.init(slot0)
	slot0._levelAscend = false
	slot0._qualityAscend = false
	slot0._timeAscend = false
	slot0._btnTag = 1
end

function slot0.getBtnTag(slot0)
	return slot0._btnTag
end

function slot0.getRankState(slot0)
	return slot0._levelAscend and 1 or -1, slot0._qualityAscend and 1 or -1, slot0._timeAscend and 1 or -1
end

function slot0.updateModel(slot0)
	slot0._equipList = slot0._equipList or {}

	slot0:setList(slot0._equipList)
end

function slot0.getCount(slot0)
	return slot0._equipList and #slot0._equipList or 0
end

function slot0.setEquipList(slot0)
	slot0._equipList = {}

	for slot5, slot6 in ipairs(EquipModel.instance:getEquips()) do
		if slot6.config then
			table.insert(slot0._equipList, slot6)
		end
	end

	slot0:sortEquipList()
	slot0:setList(slot0._equipList)
end

function slot0.setEquipListNew(slot0, slot1)
	slot0._equipList = slot1

	slot0:sortEquipList()
	slot0:setList(slot0._equipList)
end

function slot0.sortEquipList(slot0)
	if slot0._btnTag == 1 then
		slot0:_sortByLevel()
	elseif slot0._btnTag == 2 then
		slot0:_sortByQuality()
	elseif slot0._btnTag == 3 then
		slot0:_sortByTime()
	end
end

function slot0.sortByLevel(slot0)
	slot0._qualityAscend = false
	slot0._timeAscend = false

	if slot0._btnTag == 1 then
		slot0._levelAscend = not slot0._levelAscend
	else
		slot0._btnTag = 1
	end

	slot0:_sortByLevel()
	slot0:setList(slot0._equipList)
end

function slot0._sortByLevel(slot0)
	table.sort(slot0._equipList, EquipHelper.sortByLevelFunc)
end

function slot0.sortByQuality(slot0)
	slot0._levelAscend = false
	slot0._timeAscend = false

	if slot0._btnTag == 2 then
		slot0._qualityAscend = not slot0._qualityAscend
	else
		slot0._btnTag = 2
	end

	slot0:_sortByQuality()
	slot0:setList(slot0._equipList)
end

function slot0._sortByQuality(slot0)
	table.sort(slot0._equipList, EquipHelper.sortByQualityFunc)
end

function slot0.sortByTime(slot0)
	slot0._levelAscend = false
	slot0._qualityAscend = false

	if slot0._btnTag == 3 then
		slot0._timeAscend = not slot0._timeAscend
	else
		slot0._btnTag = 3
	end

	slot0:_sortByTime()
	slot0:setList(slot0._equipList)
end

function slot0._sortByTime(slot0)
	table.sort(slot0._equipList, EquipHelper.sortByTimeFunc)
end

function slot0._getEquipList(slot0)
	return slot0._equipList
end

function slot0.openEquipView(slot0)
	slot0:init()

	slot0.equipUidToHeroMo = {}
	slot1 = HeroGroupModel.instance:getCurGroupMO()

	for slot7, slot8 in pairs(slot1:getAllPosEquips()) do
		slot0.equipUidToHeroMo[slot8.equipUid[1]] = HeroModel.instance:getById(slot1.heroList[slot7 + 1])
	end
end

function slot0.getHeroMoByEquipUid(slot0, slot1)
	return slot0.equipUidToHeroMo and slot0.equipUidToHeroMo[slot1]
end

function slot0.clearEquipList(slot0)
	slot0._equipList = nil
	slot0.equipUidToHeroMo = nil

	slot0:clear()
end

slot0.instance = slot0.New()

return slot0
