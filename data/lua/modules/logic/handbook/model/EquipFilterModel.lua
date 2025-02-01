module("modules.logic.handbook.model.EquipFilterModel", package.seeall)

slot0 = class("EquipFilterModel")
slot0.ObtainEnum = {
	Get = 1,
	All = 0,
	NotGet = 2
}

function slot0.getAllTagList()
	return lua_equip_tag.configList
end

function slot0.generateFilterMo(slot0, slot1)
	slot0.filterMoDict = slot0.filterMoDict or {}
	slot2 = EquipFilterMo.New()

	slot2:init(slot1)

	slot0.filterMoDict[slot1] = slot2

	return slot2
end

function slot0.getFilterMo(slot0, slot1)
	return slot0.filterMoDict and slot0.filterMoDict[slot1]
end

function slot0.clear(slot0, slot1)
	if slot0.filterMoDict then
		slot0.filterMoDict[slot1] = nil
	end
end

function slot0.reset(slot0, slot1)
	if slot0.filterMoDict and slot0.filterMoDict[slot1] then
		slot2:init(slot1)
	end
end

function slot0.applyMo(slot0, slot1)
	if slot0.filterMoDict[slot1.viewName].obtainShowType ~= slot1.obtainShowType then
		slot3:updateMo(slot1)
		EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, slot2)

		return
	end

	if #slot1.selectTagList ~= #slot3.selectTagList then
		slot3:updateMo(slot1)
		EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, slot2)

		return
	else
		slot4 = {
			[slot9] = true
		}

		for slot8, slot9 in ipairs(slot3.selectTagList) do
			-- Nothing
		end

		for slot8, slot9 in ipairs(slot1.selectTagList) do
			if not slot4[slot9] then
				slot3:updateMo(slot1)
				EquipController.instance:dispatchEvent(EquipEvent.OnEquipTypeHasChange, slot2)

				return
			end
		end
	end
end

slot0.instance = slot0.New()

return slot0
