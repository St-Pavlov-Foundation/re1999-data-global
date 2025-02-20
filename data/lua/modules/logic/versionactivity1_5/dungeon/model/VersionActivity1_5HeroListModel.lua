module("modules.logic.versionactivity1_5.dungeon.model.VersionActivity1_5HeroListModel", package.seeall)

slot0 = class("VersionActivity1_5HeroListModel", ListScrollModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onOpenDispatchView(slot0, slot1)
	slot0:initHeroList()
	slot0:initSelectedHeroList(slot1.id)

	slot0.maxSelectCount = slot1.maxCount
end

function slot0.resetSelectHeroList(slot0)
	slot0.selectedHeroList = {}
	slot0.selectedHeroIndexDict = {}
end

function slot0.onCloseDispatchView(slot0)
	slot0:clearSelectedHeroList()
end

function slot0.initHeroList(slot0)
	if slot0.heroList then
		return
	end

	slot0.heroList = {}
	slot3 = HeroModel.instance
	slot5 = slot3

	for slot4, slot5 in ipairs(slot3.getList(slot5)) do
		slot6 = VersionActivity1_5DispatchHeroMo.New()

		slot6:init(slot5)
		table.insert(slot0.heroList, slot6)
	end
end

function slot0.initSelectedHeroList(slot0, slot1)
	slot0.selectedHeroList = {}
	slot0.selectedHeroIndexDict = {}

	if slot1 and VersionActivity1_5DungeonModel.instance:getDispatchMo(slot1) then
		for slot6, slot7 in ipairs(slot2.heroIdList) do
			if slot0:getDispatchHeroMo(slot7) then
				table.insert(slot0.selectedHeroList, slot8)

				slot0.selectedHeroIndexDict[slot8] = slot6
			else
				logError("not found dispatched hero id : " .. tostring(slot7))
			end
		end
	end
end

function slot0.getDispatchHeroMo(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.heroList) do
		if slot6.heroId == slot1 then
			return slot6
		end
	end
end

function slot0.refreshHero(slot0)
	slot0:resortHeroList()
	slot0:setList(slot0.heroList)
end

function slot0.resortHeroList(slot0)
	table.sort(slot0.heroList, uv0._sortFunc)
end

function slot0._sortFunc(slot0, slot1)
	if slot0:isDispatched() ~= slot1:isDispatched() then
		return slot3
	end

	if slot0.level ~= slot1.level then
		return slot1.level < slot0.level
	end

	if slot0.rare ~= slot1.rare then
		return slot1.rare < slot0.rare
	end

	return slot1.heroId < slot0.heroId
end

function slot0.canAddMo(slot0)
	return #slot0.selectedHeroList < slot0.maxSelectCount
end

function slot0.canChangeHeroMo(slot0)
	return slot0.dispatchViewStatus == VersionActivity1_5DungeonEnum.DispatchStatus.NotDispatch
end

function slot0.selectMo(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot0.selectedHeroList) do
		if slot6.heroId == slot1.heroId then
			return
		end
	end

	table.insert(slot0.selectedHeroList, slot1)

	slot0.selectedHeroIndexDict[slot1] = #slot0.selectedHeroList

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeSelectedHero)
end

function slot0.deselectMo(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = 0

	for slot6, slot7 in ipairs(slot0.selectedHeroList) do
		if slot7.heroId == slot1.heroId then
			slot2 = slot6
		end
	end

	if slot2 > 0 then
		slot6 = slot2

		table.remove(slot0.selectedHeroList, slot6)

		slot0.selectedHeroIndexDict[slot1] = nil

		for slot6, slot7 in ipairs(slot0.selectedHeroList) do
			slot0.selectedHeroIndexDict[slot7] = slot6
		end

		VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.ChangeSelectedHero)
	end
end

function slot0.getSelectedIndex(slot0, slot1)
	return slot0.selectedHeroIndexDict[slot1]
end

function slot0.getSelectedMoByIndex(slot0, slot1)
	return slot0.selectedHeroList[slot1]
end

function slot0.getSelectedHeroCount(slot0)
	return #slot0.selectedHeroList
end

function slot0.getSelectedHeroList(slot0)
	return slot0.selectedHeroList
end

function slot0.getSelectedHeroIdList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.selectedHeroList) do
		table.insert(slot1, slot6.heroId)
	end

	return slot1
end

function slot0.setDispatchViewStatus(slot0, slot1)
	slot0.dispatchViewStatus = slot1
end

function slot0.clearSelectedHeroList(slot0)
	slot0.selectedHeroList = nil
	slot0.selectedHeroIndexDict = nil
	slot0.dispatchViewStatus = nil
end

function slot0.clear(slot0)
	slot0:clearSelectedHeroList()

	slot0.heroList = nil
end

slot0.instance = slot0.New()

return slot0
