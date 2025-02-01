module("modules.logic.equip.model.EquipRefineListModel", package.seeall)

slot0 = class("EquipRefineListModel", ListScrollModel)
slot0.SelectStatusEnum = {
	Selected = 2,
	OutMaxRefineLv = 1,
	Success = 0
}

function slot0.onInit(slot0)
	slot0.selectedEquipMoList = {}
	slot0.selectedEquipUidDict = {}
end

function slot0.reInit(slot0)
	slot0.selectedEquipMoList = {}
	slot0.selectedEquipUidDict = {}
end

function slot0.initData(slot0, slot1)
	slot0.targetEquipMo = slot1
	slot0.targetEquipRefineLv = slot1.refineLv

	if not string.nilorempty(slot0.targetEquipMo.config.useSpRefine) then
		slot0.useSpRefineList = string.splitToNumber(slot2.useSpRefine, "#")
	end

	slot0.data = {}

	for slot7, slot8 in ipairs(EquipModel.instance:getEquips()) do
		if slot0:canAddToData(slot8) then
			table.insert(slot0.data, slot8)
		end
	end
end

function slot0.canAddToData(slot0, slot1)
	if slot1.equipId == EquipConfig.instance:getEquipUniversalId() then
		return true
	end

	if slot1.equipId == slot0.targetEquipMo.equipId and slot1.uid ~= slot0.targetEquipMo.uid and slot1.config.isExpEquip ~= 1 then
		return true
	end

	if slot0.useSpRefineList and tabletool.indexOf(slot0.useSpRefineList, slot1.equipId) then
		return true
	end

	return false
end

function slot0.sortData(slot0)
	table.sort(slot0.data, EquipHelper.sortRefineList)
end

function slot0.refreshData(slot0)
	slot0:setList(slot0.data)
end

function slot0.getDataCount(slot0)
	return GameUtil.getTabLen(slot0.data)
end

function slot0.selectEquip(slot0, slot1)
	if slot0.selectedEquipUidDict[slot1.uid] then
		return uv0.SelectStatusEnum.Selected
	end

	if EquipConfig.instance:getEquipRefineLvMax() <= slot0:getAddRefineLv() + slot0.targetEquipRefineLv then
		return uv0.SelectStatusEnum.OutMaxRefineLv
	end

	slot0.selectedEquipUidDict[slot1.uid] = true

	table.insert(slot0.selectedEquipMoList, slot1)
	slot0:setSelectedEquipMoList()
	EquipController.instance:dispatchEvent(EquipEvent.OnRefineSelectedEquipChange)

	return uv0.SelectStatusEnum.Success
end

function slot0.deselectEquip(slot0, slot1)
	slot0.selectedEquipUidDict[slot1.uid] = nil
	slot2 = {}

	for slot6, slot7 in ipairs(slot0.selectedEquipMoList) do
		if slot7.uid ~= slot1.uid then
			table.insert(slot2, slot7)
		end
	end

	slot0.selectedEquipMoList = slot2

	slot0:setSelectedEquipMoList()
	EquipController.instance:dispatchEvent(EquipEvent.OnRefineSelectedEquipChange)
end

function slot0.clearSelectedEquipList(slot0)
	slot0.selectedEquipMoList = {}
	slot0.selectedEquipUidDict = {}

	EquipRefineSelectedListModel.instance:updateList()
end

function slot0.setSelectedEquipMoList(slot0)
	EquipRefineSelectedListModel.instance:updateList(slot0.selectedEquipMoList)
end

function slot0.getSelectedEquipMoList(slot0)
	return slot0.selectedEquipMoList
end

function slot0.getSelectedEquipUidList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.selectedEquipMoList) do
		table.insert(slot1, slot6.uid)
	end

	return slot1
end

function slot0.getAddRefineLv(slot0)
	for slot5, slot6 in ipairs(slot0.selectedEquipMoList) do
		slot1 = 0 + slot6.refineLv
	end

	return slot1
end

function slot0.isSelected(slot0, slot1)
	if not slot1 then
		return false
	end

	return slot0.selectedEquipUidDict[slot1.uid]
end

function slot0.clearData(slot0)
	slot0:clear()

	slot0.selectedEquipMoList = {}
	slot0.selectedEquipUidDict = {}
	slot0.useSpRefineList = nil
end

slot0.instance = slot0.New()

return slot0
