module("modules.logic.critter.model.CritterSummonModel", package.seeall)

slot0 = class("CritterSummonModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
end

function slot0.initSummonPools(slot0, slot1)
	slot2 = {}

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			slot8 = slot0:getById(slot7.poolId) or CritterSummonMO.New()

			slot8:init(slot7)
			table.insert(slot2, slot8)
		end
	end

	slot0:setList(slot2)
end

function slot0.setSummonPoolList(slot0, slot1)
	if slot0:getById(slot1) then
		RoomSummonPoolCritterListModel.instance:setDataList(slot2.critterMos)
	end
end

function slot0.onSummon(slot0, slot1, slot2)
	slot0:getById(slot1):onRefresh(slot2)
end

function slot0.getSummonPoolId(slot0)
	return 1
end

function slot0.getSummonCount(slot0)
	return 1
end

function slot0.isMaxCritterCount(slot0)
	return tonumber(CritterConfig.instance:getCritterConstStr(CritterEnum.ConstId.CritterBackpackCapacity) or 0) <= (#CritterModel.instance:getAllCritters() or 0)
end

function slot0.isCanSummon(slot0, slot1)
	if slot0:isMaxCritterCount() then
		return false, ToastEnum.RoomCritterMaxCount
	end

	if not slot0:isNullPool(slot1) then
		return true
	end

	return false, ToastEnum.RoomCritterPoolEmpty
end

function slot0.isNullPool(slot0, slot1)
	if slot0:getById(slot1) then
		for slot6, slot7 in pairs(slot2.critterMos) do
			if slot7:getPoolCount() > 0 then
				return false
			end
		end
	end

	return true
end

function slot0.isFullPool(slot0, slot1)
	if slot0:getById(slot1) then
		for slot6, slot7 in pairs(slot2.critterMos) do
			if not slot7:isFullPool() then
				return false
			end
		end
	end

	return true
end

function slot0.getPoolCurrency(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0:getCostInfo(CritterConfig.instance:getCritterSummonCfg(slot1).cost)
end

function slot0.notSummonToast(slot0, slot1)
	slot2, slot3 = slot0:isCanSummon(slot1)
	slot4, slot5, slot6, slot7 = slot0:getPoolCurrency(slot1)

	if not slot2 then
		return slot3
	elseif not slot6 then
		return ToastEnum.RoomCritterNotEnough, slot7
	end

	return ""
end

function slot0.getCostInfo(slot0, slot1)
	if string.nilorempty(slot1) then
		return
	end

	slot2, slot3, slot4 = SummonMainModel.getCostByConfig(slot1)
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot2, slot3)

	return slot6, luaLang("multiple") .. slot4, slot4 <= ItemModel.instance:getItemQuantity(slot2, slot3), slot5.name
end

function slot0.getCostCurrency(slot0)
	slot1 = {}
	slot2 = {}

	for slot6, slot7 in ipairs(lua_critter_summon.configList) do
		if not string.nilorempty(slot7.cost) and string.split(slot7.cost, "#")[1] and slot8[2] and not LuaUtil.tableContains(slot1, slot8[1] .. "#" .. slot8[2]) then
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

slot0.instance = slot0.New()

return slot0
