module("modules.logic.dispatch.model.DispatchHeroListModel", package.seeall)

slot0 = class("DispatchHeroListModel", ListScrollModel)

function slot1(slot0, slot1)
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

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.onOpenDispatchView(slot0, slot1, slot2)
	slot0:initHeroList()
	slot0:initSelectedHeroList(slot2, slot1 and slot1.id)

	slot0.maxSelectCount = slot1 and slot1.maxCount or 0
end

function slot0.initHeroList(slot0)
	if slot0.heroList then
		return
	end

	slot0.heroList = {}

	for slot5, slot6 in ipairs(HeroModel.instance:getList()) do
		slot7 = DispatchHeroMo.New()

		slot7:init(slot6)
		table.insert(slot0.heroList, slot7)
	end
end

function slot0.getDispatchHeroMo(slot0, slot1)
	if not slot0.heroList then
		return
	end

	for slot5, slot6 in ipairs(slot0.heroList) do
		if slot6.heroId == slot1 then
			return slot6
		end
	end
end

function slot0.refreshHero(slot0)
	if not slot0.heroList then
		return
	end

	table.sort(slot0.heroList, uv0)
	slot0:setList(slot0.heroList)
end

function slot0.resetSelectHeroList(slot0)
	slot0.selectedHeroList = {}
	slot0.selectedHeroIndexDict = {}
end

function slot0.initSelectedHeroList(slot0, slot1, slot2)
	slot0:resetSelectHeroList()

	if not slot1 or not slot2 then
		return
	end

	if not DispatchModel.instance:getDispatchMo(slot1, slot2) then
		return
	end

	for slot7, slot8 in ipairs(slot3.heroIdList) do
		if slot0:getDispatchHeroMo(slot8) then
			table.insert(slot0.selectedHeroList, slot9)

			slot0.selectedHeroIndexDict[slot9] = slot7
		else
			logError(string.format("DispatchHeroListModel:initSelectedHeroList error, not found dispatched hero id: %s ", slot8))
		end
	end
end

function slot0.canAddMo(slot0)
	return #slot0.selectedHeroList < slot0.maxSelectCount
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

	DispatchController.instance:dispatchEvent(DispatchEvent.ChangeSelectedHero)
end

function slot0.deselectMo(slot0, slot1)
	if not slot1 then
		return
	end

	if slot0:getSelectedIndex(slot1) and slot2 > 0 then
		table.remove(slot0.selectedHeroList, slot2)

		slot0.selectedHeroIndexDict[slot1] = nil

		for slot6, slot7 in ipairs(slot0.selectedHeroList) do
			slot0.selectedHeroIndexDict[slot7] = slot6
		end

		DispatchController.instance:dispatchEvent(DispatchEvent.ChangeSelectedHero)
	end
end

function slot0.getSelectedIndex(slot0, slot1)
	return slot0.selectedHeroIndexDict[slot1]
end

function slot0.getSelectedMoByIndex(slot0, slot1)
	return slot0.selectedHeroList[slot1]
end

function slot0.getSelectedHeroIdList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.selectedHeroList) do
		table.insert(slot1, slot6.heroId)
	end

	return slot1
end

function slot0.getSelectedHeroCount(slot0)
	return #slot0.selectedHeroList
end

function slot0.getSelectedHeroList(slot0)
	return slot0.selectedHeroList
end

function slot0.setDispatchViewStatus(slot0, slot1)
	slot0.dispatchViewStatus = slot1
end

function slot0.canChangeHeroMo(slot0)
	return slot0.dispatchViewStatus == DispatchEnum.DispatchStatus.NotDispatch
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	slot0:resetSelectHeroList()

	slot0.heroList = nil
	slot0.dispatchViewStatus = nil
end

slot0.instance = slot0.New()

return slot0
