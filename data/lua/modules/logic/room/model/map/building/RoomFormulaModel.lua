module("modules.logic.room.model.map.building.RoomFormulaModel", package.seeall)

slot0 = class("RoomFormulaModel", BaseModel)
slot0.DEFAULT_TREE_LEVEL = 1
slot0.MAX_FORMULA_TREE_LEVEL = 4

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
end

function slot0.initFormula(slot0)
	slot0:clear()

	slot1 = {}

	for slot5, slot6 in ipairs(lua_formula.configList) do
		table.insert(slot1, {
			id = RoomProductionHelper.getFormulaStrUID(slot6.id, uv0.DEFAULT_TREE_LEVEL)
		})
	end

	slot0:addFormulaList(slot1)
end

function slot0.addFormulaList(slot0, slot1)
	if not slot1 or #slot1 <= 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0:addFormula(slot6)
	end
end

function slot0.addFormula(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = RoomFormulaMO.New()

	slot2:init(slot1)

	if not slot2:getConfig() then
		return
	end

	slot0:addAtLast(slot2)

	return slot2
end

function slot0.getAllTopTreeLevelFormulaMoList(slot0)
	slot1 = {}

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7:getFormulaTreeLevel() == uv0.DEFAULT_TREE_LEVEL then
			table.insert(slot1, slot7)
		end
	end

	return slot1
end

function slot0.getAllTopTreeLevelCount(slot0)
	return #slot0:getAllTopTreeLevelFormulaMoList()
end

function slot0.getTopTreeLevelFormulaMoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getAllTopTreeLevelFormulaMoList()) do
		if slot8.config.showType == slot1 then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0.getTopTreeLevelFormulaCount(slot0, slot1)
	return #slot0:getTopTreeLevelFormulaMoList(slot1)
end

function slot0.getFormulaMo(slot0, slot1, slot2)
	if not slot0:getById(slot1) and not slot2 then
		logError("RoomFormulaModel:getFormulaMo error, can't find RoomFormulaMo:" .. (slot1 or "nil"))
	end

	return slot3
end

function slot0.getFormulaMoWithInfo(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		return
	end

	if slot0:getById(slot1) then
		slot3:init(slot2)
		slot3:resetFormulaCombineCount()
	else
		slot3 = slot0:addFormula(slot2)
	end

	return slot3
end

function slot0.getFormulaIsLast(slot0, slot1)
	slot2 = true

	if slot0:getFormulaMo(slot1) then
		slot2 = slot3:getIsLast()
	end

	return slot2
end

function slot0.getFormulaParentStrId(slot0, slot1)
	slot2 = nil

	if uv0.instance:getFormulaMo(slot1) then
		slot2 = slot3:getParentStrId()
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
