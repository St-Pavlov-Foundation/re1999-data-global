module("modules.logic.room.model.map.building.RoomFormulaMO", package.seeall)

slot0 = pureTable("RoomFormulaMO")
slot1 = 1
slot2 = true
slot3 = false

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.formulaId, slot0.treeLevel = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(slot1.id)
	slot0.config = RoomConfig.instance:getFormulaConfig(slot0.formulaId)

	if not slot0.config then
		logError("找不到配方id: " .. tostring(slot0.formulaId))
	end

	slot0:setIsLast(slot1.isLast)
	slot0:setParentStrId(slot1.parentStrId)
	slot0:resetIsExpandTree()
end

function slot0.getId(slot0)
	return slot0.id
end

function slot0.getFormulaId(slot0)
	return slot0.formulaId
end

function slot0.getFormulaCombineCount(slot0)
	if not slot0.formulaCombineCount then
		slot0:resetFormulaCombineCount()
	end

	return slot0.formulaCombineCount
end

function slot0.getIsExpandTree(slot0)
	return slot0.isExpandTree
end

function slot0.getConfig(slot0)
	return slot0.config
end

function slot0.getFormulaTreeLevel(slot0)
	if not slot0.treeLevel then
		slot0:setFormulaTreeLevel(RoomFormulaModel.DEFAULT_TREE_LEVEL)
	end

	return slot0.treeLevel
end

function slot0.getIsLast(slot0)
	return slot0.isLast
end

function slot0.getParentStrId(slot0)
	return slot0.parentStrId
end

function slot0.isTreeFormula(slot0)
	return slot0.treeLevel ~= RoomFormulaModel.DEFAULT_TREE_LEVEL
end

function slot0.resetFormulaCombineCount(slot0)
	slot1 = uv0
	slot3 = RoomProductionHelper.getFormulaNeedQuantity(slot0:getId())
	slot4 = 0

	if RoomProductionHelper.getFormulaProduceItem(slot0:getFormulaId()) then
		slot4 = ItemModel.instance:getItemQuantity(slot6.type, slot6.id)
	end

	if slot4 - slot3 < 0 then
		slot1 = math.abs(slot7)
	end

	slot0:setFormulaCombineCount(slot1)
end

function slot0.resetIsExpandTree(slot0)
	slot0:setIsExpandTree(uv0)
end

function slot0.setFormulaCombineCount(slot0, slot1)
	slot0.formulaCombineCount = slot1 > 0 and slot1 or uv0

	slot0:syncChildFormulaCombineCount()
	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshFormulaCombineCount, slot0:getId())
end

function slot0.syncChildFormulaCombineCount(slot0)
	if not slot0:getIsExpandTree() then
		return
	end

	for slot9, slot10 in ipairs(RoomProductionHelper.getCostItemListWithFormulaId(slot0:getFormulaId())) do
		if slot10.formulaId and slot10.formulaId ~= 0 and RoomFormulaModel.instance:getFormulaMo(RoomProductionHelper.getFormulaStrUID(slot10.formulaId, slot0:getFormulaTreeLevel() + 1), true) then
			slot13 = uv0

			if ItemModel.instance:getItemQuantity(slot10.type, slot10.id) - slot10.quantity * slot0:getFormulaCombineCount() < 0 then
				slot13 = math.abs(slot16)
			end

			slot12:setFormulaCombineCount(slot13)
		end
	end
end

function slot0.setFormulaTreeLevel(slot0, slot1)
	if slot1 < 0 then
		slot1 = RoomFormulaModel.DEFAULT_TREE_LEVEL
	elseif RoomFormulaModel.MAX_FORMULA_TREE_LEVEL < slot1 then
		slot1 = RoomFormulaModel.MAX_FORMULA_TREE_LEVEL
	end

	slot0.treeLevel = slot1
end

function slot0.setIsLast(slot0, slot1)
	if slot1 == nil then
		slot1 = uv0
	end

	slot0.isLast = slot1
end

function slot0.setParentStrId(slot0, slot1)
	slot0.parentStrId = slot1
end

function slot0.setIsExpandTree(slot0, slot1)
	slot0.isExpandTree = slot1
end

return slot0
