module("modules.logic.room.model.map.building.RoomFormulaListModel", package.seeall)

slot0 = class("RoomFormulaListModel", ListScrollModel)
slot1 = true
slot0.FormulaItemAnimationName = {
	collapse = "collapse",
	unfold = "unfold",
	idle = "idle"
}
slot0.ANIMATION_WAIT_TIME = 0.15
slot0.SET_DATA_WAIT_TIME = 0.01

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	slot0:_clearData()
	uv0.super.clear(slot0)
end

function slot0._clearData(slot0)
	slot0._formulaShowType = nil

	slot0:resetSelectFormulaStrId()
	slot0:resetIsInList()
end

function slot0.isSelectedFormula(slot0, slot1)
	if not slot1 then
		return false
	end

	return slot1 == slot0:getSelectFormulaStrId()
end

function slot0.changeSelectFormulaToTopLevel(slot0)
	if not slot0:getSelectFormulaStrId() then
		return
	end

	if uv0.instance:getSelectFormulaMo():getFormulaTreeLevel() == RoomFormulaModel.DEFAULT_TREE_LEVEL then
		return
	end

	slot5 = RoomFormulaModel.instance:getFormulaMo(RoomProductionHelper.getTopLevelFormulaStrId(slot1))

	if slot2 and slot5 then
		slot5:setFormulaCombineCount(slot2:getFormulaCombineCount())
		slot0:setSelectFormulaStrId(slot4)
		RoomMapController.instance:dispatchEvent(RoomEvent.ChangeSelectFormulaToTopLevel)
	end
end

function slot0.setFormulaList(slot0, slot1)
	slot0:resetAllShowFormulaIsExpandTree()

	slot2 = {}

	for slot7, slot8 in ipairs(RoomFormulaModel.instance:getTopTreeLevelFormulaMoList(slot0._formulaShowType)) do
		table.insert(slot2, slot8)
	end

	slot0.level = slot1

	table.sort(slot2, slot0._sortFunction)
	slot0:setList(slot0:listAddTreeFormula(slot2))
end

function slot0._sortFunction(slot0, slot1)
	slot2 = uv0.instance:getOrder()
	slot3 = uv0.instance.level
	slot4, slot5, slot6, slot7 = RoomProductionHelper.isFormulaUnlock(slot0.config.id, slot3)
	slot8, slot9, slot10, slot11 = RoomProductionHelper.isFormulaUnlock(slot1.config.id, slot3)

	if slot4 and not slot8 then
		return true
	elseif not slot4 and slot8 then
		return false
	end

	if slot4 and slot8 then
		if slot2 == RoomBuildingEnum.FormulaOrderType.RareUp and slot0.config.rare ~= slot1.config.rare then
			return slot0.config.rare < slot1.config.rare
		elseif slot2 == RoomBuildingEnum.FormulaOrderType.RareDown and slot0.config.rare ~= slot1.config.rare then
			return slot1.config.rare < slot0.config.rare
		elseif slot2 == RoomBuildingEnum.FormulaOrderType.CostTimeUp and slot0.config.costTime ~= slot1.config.costTime then
			return slot0.config.costTime < slot1.config.costTime
		elseif slot2 == RoomBuildingEnum.FormulaOrderType.CostTimeDown and slot0.config.costTime ~= slot1.config.costTime then
			return slot1.config.costTime < slot0.config.costTime
		elseif slot2 == RoomBuildingEnum.FormulaOrderType.OrderUp and slot0.config.order ~= slot1.config.order then
			return slot0.config.order < slot1.config.order
		elseif slot2 == RoomBuildingEnum.FormulaOrderType.OrderDown and slot0.config.order ~= slot1.config.order then
			return slot1.config.order < slot0.config.order
		end
	elseif not slot4 and not slot8 then
		if slot6 and not slot10 then
			return false
		elseif not slot6 and slot10 then
			return true
		elseif slot6 and slot10 then
			if slot6 ~= slot10 then
				return slot6 < slot10
			end

			if slot7 and not slot11 then
				return false
			elseif not slot7 and slot11 then
				return true
			end
		end
	end

	if slot0.config.order ~= slot1.config.order then
		return slot0.config.order < slot1.config.order
	end

	return slot0.id < slot1.id
end

function slot0.expandOrHideTreeFormulaList(slot0, slot1, slot2)
	if not slot0.isInList then
		return false
	end

	slot4 = slot0:getSelectFormulaStrId()

	if not slot1 then
		slot0:expandTreeFormulaList()

		return slot3
	end

	if slot2 then
		slot5 = nil

		if string.nilorempty(slot4) then
			slot5 = slot0:getFormulaListAfterHideTree(RoomFormulaModel.DEFAULT_TREE_LEVEL)
		else
			if not slot0:getSelectFormulaMo() then
				return slot3
			end

			slot5 = slot0:getFormulaListAfterHideTree(slot6:getFormulaTreeLevel() + 1)
		end

		TaskDispatcher.runDelay(function ()
			uv0:setList(uv1)
		end, nil, uv0.ANIMATION_WAIT_TIME)

		return true
	end

	if not slot0:getSelectFormulaMo() then
		return slot3
	end

	if slot5:getIsExpandTree() then
		slot0:onModelUpdate()
	else
		slot8 = slot0:getFormulaListAfterHideTree(slot5:getFormulaTreeLevel())

		TaskDispatcher.runDelay(function ()
			uv0:expandTreeFormulaList(uv1)
		end, nil, uv0.ANIMATION_WAIT_TIME)

		slot3 = true
	end
end

function slot0.expandTreeFormulaList(slot0, slot1)
	slot3, slot4 = slot0:listAddTreeFormula(slot1 or slot0:getList(), true)

	slot0:setList(slot3)
	TaskDispatcher.runDelay(function ()
		RoomMapController.instance:dispatchEvent(RoomEvent.PlayFormulaAnimation, uv0, uv1.FormulaItemAnimationName.unfold)
	end, nil, uv0.SET_DATA_WAIT_TIME)
end

function slot0.getFormulaListAfterHideTree(slot0, slot1)
	slot2 = slot0:getList()

	if RoomFormulaModel.MAX_FORMULA_TREE_LEVEL < slot1 then
		return slot2
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot2) do
		if slot1 <= slot9:getFormulaTreeLevel() then
			slot9:setIsExpandTree(false)

			if slot1 < slot10 then
				-- Nothing
			end
		end

		if slot10 <= slot1 then
			table.insert(slot4, slot9)
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.PlayFormulaAnimation, {
		[slot9:getId()] = true
	}, uv0.FormulaItemAnimationName.collapse)

	return slot4
end

function slot0.listAddTreeFormula(slot0, slot1, slot2)
	if not slot0:getSelectFormulaStrId() or not slot0:getIsInList() then
		return slot1, {}
	end

	slot6, slot7 = nil

	for slot11, slot12 in ipairs(slot1) do
		if slot12:getId() == slot5 then
			slot6 = slot11
			slot7 = slot12

			break
		end
	end

	if not slot6 or not slot7 then
		if slot2 then
			logError("RoomFormulaListModel:listAddTreeFormula error,can't find select formula,id:" .. (slot0._selectFormulaStrId or "nil"))
		end

		return slot1, slot3
	end

	for slot12 = 1, slot6 do
		table.insert({}, slot1[slot12])
	end

	for slot14 = 1, #slot0:_getTreeLevelFormulaList(slot7:getId()) do
		slot15 = slot10[slot14]
		slot3[slot15:getId()] = true

		table.insert(slot8, slot15)
	end

	for slot14 = slot6 + 1, #slot1 do
		table.insert(slot8, slot1[slot14])
	end

	slot7:setIsExpandTree(true)

	return slot8, slot3
end

function slot0._getTreeLevelFormulaList(slot0, slot1)
	if not slot1 then
		return {}
	end

	slot3, slot4 = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(slot1)

	if RoomFormulaModel.MAX_FORMULA_TREE_LEVEL < slot4 + 1 then
		return slot2
	end

	slot6 = RoomProductionHelper.getCostMaterialFormulaList(slot3)

	for slot11, slot12 in ipairs(slot6) do
		if slot12 and slot12 ~= 0 then
			slot14 = RoomProductionHelper.getFormulaStrUID(slot12, slot5)

			if RoomFormulaModel.instance:getFormulaMoWithInfo(slot14, {
				id = slot14,
				isLast = slot11 == #slot6,
				parentStrId = slot1
			}) then
				table.insert(slot2, slot16)
			end
		end
	end

	return slot2
end

function slot0.setSelectFormulaStrId(slot0, slot1)
	slot2 = nil

	if slot0:getTopExpandFormulaStrId() and slot3 ~= slot1 then
		slot2 = RoomFormulaModel.instance:getFormulaMo(slot3, true)
	end

	if slot1 then
		slot4, slot5 = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(slot1)

		if slot4 and slot4 ~= 0 then
			if slot5 == RoomFormulaModel.DEFAULT_TREE_LEVEL then
				if slot2 then
					slot2:resetFormulaCombineCount()
				end

				slot0:setTopExpandFormulaStrId(slot1)
			end

			slot0._selectFormulaStrId = slot1
		end
	else
		slot0._selectFormulaStrId = nil

		slot0:resetTopExpandFormulaStrId()

		if slot2 then
			slot2:resetFormulaCombineCount()
		end
	end
end

function slot0.setFormulaShowType(slot0, slot1)
	slot0._formulaShowType = slot1
end

function slot0.setOrder(slot0, slot1)
	slot0._order = slot1
end

function slot0.setTopExpandFormulaStrId(slot0, slot1)
	if slot1 then
		slot2, slot3 = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(slot1)

		if slot3 == RoomFormulaModel.DEFAULT_TREE_LEVEL then
			slot0._topExpandFormulaStrId = slot1
		else
			logError("RoomFormulaListModel:setTopExpandFormulaStrId error,id:" .. slot1 .. "isn't top formula")
		end
	else
		slot0._topExpandFormulaStrId = nil
	end
end

function slot0.setIsInList(slot0, slot1)
	slot0.isInList = slot1
end

function slot0.resetSelectFormulaStrId(slot0)
	slot0:setSelectFormulaStrId()
end

function slot0.resetAllShowFormulaIsExpandTree(slot0)
	for slot5, slot6 in ipairs(slot0:getList()) do
		slot6:resetIsExpandTree()
	end
end

function slot0.resetIsInList(slot0)
	slot0:setIsInList(uv0)
end

function slot0.resetTopExpandFormulaStrId(slot0)
	slot0:setTopExpandFormulaStrId()
end

function slot0.getSelectFormulaStrId(slot0)
	return slot0._selectFormulaStrId
end

function slot0.getSelectFormulaId(slot0)
	slot1 = 0

	if slot0:getSelectFormulaStrId() then
		slot1 = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(slot0._selectFormulaStrId)
	end

	return slot1
end

function slot0.getSelectFormulaMo(slot0)
	if slot0:getSelectFormulaStrId() then
		return RoomFormulaModel.instance:getFormulaMo(slot1)
	end
end

function slot0.getOrder(slot0)
	return slot0._order
end

function slot0.getTopExpandFormulaStrId(slot0)
	return slot0._topExpandFormulaStrId
end

function slot0.getIsInList(slot0)
	if slot0.isInList == nil then
		slot0:resetIsInList()
	end

	return slot0.isInList
end

function slot0.getSelectFormulaCombineCount(slot0)
	slot1 = 0

	if slot0:getSelectFormulaMo() then
		slot1 = slot2:getFormulaCombineCount()
	end

	return slot1
end

function slot0.getSelectFormulaStrIdIndex(slot0)
	slot1 = 0

	for slot7, slot8 in ipairs(slot0:getList()) do
		if slot8:getId() == slot0:getSelectFormulaStrId() then
			slot1 = slot7

			break
		end
	end

	return slot1
end

function slot0.refreshRankDiff(slot0)
	slot0._idIdxList = {}

	for slot5, slot6 in ipairs(slot0:getList()) do
		table.insert(slot0._idIdxList, slot6.id)
	end
end

function slot0.clearRankDiff(slot0)
	slot0._idIdxList = nil
end

function slot0.getRankDiff(slot0, slot1)
	if slot0._idIdxList and slot1 then
		slot3 = slot0:getIndex(slot1)

		if tabletool.indexOf(slot0._idIdxList, slot1.id) and slot3 then
			return slot3 - slot2
		end
	end

	return 0
end

slot0.instance = slot0.New()

return slot0
