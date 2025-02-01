module("modules.logic.critter.model.CritterIncubateModel", package.seeall)

slot0 = class("CritterIncubateModel", BaseModel)

function slot0.onInit(slot0)
	slot0._selectParentCrittersIds = nil
end

function slot0.reInit(slot0)
	slot0._selectParentCrittersIds = {}
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
end

function slot0.getCanSelectCount(slot0)
	return 2
end

function slot0._getNullSelect(slot0)
	for slot4 = 1, slot0:getCanSelectCount() do
		if not slot0._selectParentCrittersIds[slot4] then
			return slot4
		end
	end
end

function slot0.addSelectParentCritter(slot0, slot1)
	if not slot0._selectParentCrittersIds then
		slot0._selectParentCrittersIds = {}
	end

	if slot0:_getNullSelect() then
		slot0._selectParentCrittersIds[slot2] = slot1

		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onSelectParentCritter, slot2, slot1)
	end
end

function slot0.removeSelectParentCritter(slot0, slot1)
	if not slot0._selectParentCrittersIds then
		slot0._selectParentCrittersIds = {}
	end

	if tabletool.indexOf(slot0._selectParentCrittersIds, slot1) then
		slot0._selectParentCrittersIds[slot2] = nil

		CritterSummonController.instance:dispatchEvent(CritterSummonEvent.onRemoveParentCritter, slot2, slot1)
	end
end

function slot0.isSelectParentCritter(slot0, slot1)
	return LuaUtil.tableContains(slot0._selectParentCrittersIds, slot1)
end

function slot0.getSelectParentCritterUIdByIndex(slot0, slot1)
	if not slot0._selectParentCrittersIds then
		return
	end

	if slot0._selectParentCrittersIds[slot1] and CritterModel.instance:getCritterMOByUid(slot2) then
		return slot2
	end

	slot0._selectParentCrittersIds[slot1] = nil
end

function slot0.getSelectParentCritterMoByid(slot0, slot1)
	if not slot0._selectParentCrittersIds then
		return
	end

	for slot5, slot6 in ipairs(slot0._selectParentCrittersIds) do
		if CritterModel.instance:getCritterMOByUid(slot6).defineId == slot1 then
			return slot7
		end
	end
end

function slot0.getSelectParentCritterCount(slot0)
	return slot0._selectParentCrittersIds and tabletool.len(slot0._selectParentCrittersIds) or 0, slot0:getCanSelectCount()
end

function slot0.getChildMOList(slot0)
	return slot0._previewChildCritters or {}
end

function slot0.setCritterPreviewInfo(slot0, slot1)
	slot0._previewChildCritters = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot7 = slot0:getById(slot6.uid) or CritterMO.New()

			slot7:init(slot6)
			table.insert(slot0._previewChildCritters, slot7)
		end
	end
end

function slot0.getCritterMOByUid(slot0, slot1)
	if not slot0._previewChildCritters then
		return
	end

	for slot5, slot6 in ipairs(slot0._previewChildCritters) do
		if slot6.uid == slot1 then
			return slot6
		end
	end
end

function slot0.notSummonToast(slot0)
	slot1, slot2, slot3, slot4 = slot0:getPoolCurrency()

	if CritterSummonModel.instance:isMaxCritterCount() then
		return ToastEnum.RoomCritterMaxCount
	end

	if not slot3 then
		return ToastEnum.RoomCritterNotEnough, slot4
	end

	slot5, slot6 = slot0:getSelectParentCritterCount()

	if slot5 < slot6 then
		return ToastEnum.RoomCritteNeedTwo
	end

	return ""
end

function slot0.getPoolCurrency(slot0)
	slot1 = 3

	if slot0._selectParentCrittersIds then
		for slot5, slot6 in ipairs(slot0._selectParentCrittersIds) do
			if CritterModel.instance:getCritterMOByUid(slot6) then
				slot1 = math.max(slot1, slot7:getDefineCfg().rare)
			end
		end
	end

	if CritterConfig.instance:getCritterRareCfg(slot1) then
		return CritterSummonModel.instance:getCostInfo(slot2.incubateCost)
	end
end

function slot0.getCostCurrency(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(lua_critter_rare.configList) do
		if not string.nilorempty(slot7.incubateCost) and string.split(slot7.incubateCost, "#")[1] and slot8[2] and not LuaUtil.tableContains(slot1, slot8[1] .. "#" .. slot8[2]) then
			table.insert(slot1, slot9)
		end
	end

	for slot6, slot7 in ipairs(slot1) do
		if string.split(slot7, "#")[1] and slot8[2] then
			if tonumber(slot8[1]) == MaterialEnum.MaterialType.Item then
				if not LuaUtil.tableContains(slot2, {
					isIcon = true,
					type = slot9,
					id = tonumber(slot8[2]),
					jumpFunc = SummonMainModel.jumpToSummonCostShop
				}) then
					table.insert(slot2, slot11)
				end
			elseif slot9 == MaterialEnum.MaterialType.Currency and not LuaUtil.tableContains(slot2, slot10) then
				table.insert(slot2, slot10)
			end
		end
	end

	return slot2
end

function slot0.setSortType(slot0, slot1)
	slot0._selectSortType = slot1
end

function slot0.getSortType(slot0)
	return slot0._selectSortType or CritterEnum.AttributeType.Efficiency
end

function slot0.setSortWay(slot0, slot1)
	slot0._selectSortWay = slot1
end

function slot0.getSortWay(slot0)
	return slot0._selectSortWay
end

slot0.instance = slot0.New()

return slot0
