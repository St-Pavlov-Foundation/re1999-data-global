module("modules.logic.explore.model.ExploreMapModel", package.seeall)

slot0 = class("ExploreMapModel", BaseModel)
slot1 = {}

function slot0.createUnitMO(slot0, slot1)
	slot2 = nil

	if not uv0[slot1[2]] then
		if ExploreEnum.ItemTypeToName[slot3] then
			slot2 = _G[string.format("Explore%sUnitMO", ExploreEnum.ItemTypeToName[slot3])] or _G[string.format("Explore%sMO", ExploreEnum.ItemTypeToName[slot3])]
		end

		uv0[slot3] = slot2 or ExploreBaseUnitMO
	else
		slot2 = uv0[slot3]
	end

	slot4 = slot2.New()

	slot4:init(slot1)

	return slot4
end

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.updatHeroPos(slot0, slot1, slot2, slot3)
	slot0.posx = slot1
	slot0.posy = slot2
	slot0.dir = slot3
end

function slot0.getHeroPos(slot0)
	return slot0.posx or 0, slot0.posy or 0
end

function slot0.getHeroDir(slot0)
	return slot0.dir or 0
end

function slot0.initMapData(slot0, slot1, slot2)
	slot0._lightNodeDic = {}
	slot0._lightNodeShowDic = {}
	slot0._boundNodeShowDic = {}
	slot0._nodeDic = {}
	slot0._mapAreaDic = {}
	slot0._unitDic = {}
	slot0._areaUnitDic = {}
	slot0._mapIconDict = {}
	slot0._mapIconDictById = {}
	slot0.outLineCount = 0
	slot0.nowMapRotate = 0
	slot0._isShowReset = false
	slot3, slot4, slot5, slot6 = nil

	for slot10, slot11 in ipairs(slot1[1]) do
		slot12 = ExploreNode.New(slot11)
		slot3 = slot3 and math.min(slot3, slot11[1]) or slot11[1]
		slot4 = slot4 and math.max(slot4, slot11[1]) or slot11[1]
		slot5 = slot5 and math.min(slot5, slot11[2]) or slot11[2]
		slot6 = slot6 and math.max(slot6, slot11[2]) or slot11[2]
		slot0._nodeDic[slot12.walkableKey] = slot12
	end

	slot10 = slot4
	slot11 = slot5
	slot0.mapBound = Vector4(slot3, slot10, slot11, slot6)

	for slot10, slot11 in ipairs(slot1) do
		if slot10 > 1 then
			slot12 = ExploreMapAreaMO.New()

			slot12:init(slot11)

			slot0._mapAreaDic[slot12.id] = slot12
		end
	end

	slot12 = "(-?%d+)#(-?%d+)"

	for slot12, slot13 in string.gmatch(slot0.moveNodes or "", slot12) do
		slot0:setNodeLightXY(tonumber(slot12), tonumber(slot13))
	end

	slot0:_checkNodeBound()

	for slot12, slot13 in pairs(slot0._mapAreaDic) do
		slot0:updateAreaInfo(slot13)
	end
end

function slot0.updateAreaInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.unitList) do
		slot0:addUnitMO(slot6)

		if (slot6.type == ExploreEnum.ItemType.Ice or slot6.type == ExploreEnum.ItemType.Obstacle) and slot0._nodeDic[ExploreHelper.getKey(slot6.nodePos)] then
			if slot6.type == ExploreEnum.ItemType.Ice then
				slot8:setNodeType(ExploreEnum.NodeType.Ice)
			elseif slot6.type == ExploreEnum.ItemType.Obstacle then
				slot8:setNodeType(ExploreEnum.NodeType.Obstacle)
			end
		end
	end
end

function slot0.setSmallMapIconById(slot0, slot1, slot2, slot3)
	if slot0._mapIconDictById[slot1] == slot3 then
		return
	end

	slot0._mapIconDictById[slot1] = slot3

	slot0:setSmallMapIcon(slot2, slot3)
end

function slot0.setSmallMapIcon(slot0, slot1, slot2)
	if slot0._mapIconDict[slot1] == slot2 then
		return
	end

	slot0._mapIconDict[slot1] = slot2

	ExploreController.instance:dispatchEvent(ExploreEvent.UnitOutlineChange, slot1)
end

function slot0.getSmallMapIcon(slot0, slot1)
	return slot0._mapIconDict[slot1]
end

function slot0.getNodeDic(slot0)
	return slot0._nodeDic
end

function slot0.getNode(slot0, slot1)
	if not slot0._nodeDic then
		return
	end

	return slot0._nodeDic[slot1]
end

function slot0.getNodeIsShow(slot0, slot1)
	return slot0._lightNodeShowDic[slot1] and slot0:getNodeIsOpen(slot1)
end

function slot0.getNodeIsBound(slot0, slot1)
	return slot0:getNodeBoundType(slot1) and slot0:getNodeIsOpen(slot1)
end

function slot0.getNodeBoundType(slot0, slot1)
	return slot0._boundNodeShowDic[slot1]
end

function slot0.getNodeIsOpen(slot0, slot1)
	if slot0:getNode(slot1) and ExploreModel.instance:isAreaShow(slot2.areaId) then
		return true
	else
		return false
	end
end

function slot0.getNodeCanWalk(slot0, slot1)
	if slot0:getNode(slot1) and ExploreModel.instance:isAreaShow(slot2.areaId) and slot2:isWalkable() then
		return true
	else
		return false
	end
end

function slot0.setIsShowResetBtn(slot0, slot1)
	if slot0._isShowReset ~= slot1 then
		slot0._isShowReset = slot1

		ExploreController.instance:dispatchEvent(ExploreEvent.ShowResetChange)

		if not slot1 and ExploreModel.instance.isShowingResetBoxMessage then
			ExploreModel.instance.isShowingResetBoxMessage = false

			ViewMgr.instance:closeView(ViewName.MessageBoxView)
		end
	end
end

function slot0.getIsShowResetBtn(slot0)
	return slot0._isShowReset
end

function slot0.updateNodeHeight(slot0, slot1, slot2)
	if slot0:getNode(slot1) then
		slot3.height = slot2
	end
end

function slot0.updateNodeOpenKey(slot0, slot1, slot2, slot3, slot4)
	if slot0:getNode(slot1) then
		slot5:updateOpenKey(slot2, slot3)

		if slot4 and slot5:isWalkable() ~= slot5:isWalkable() then
			ExploreController.instance:dispatchEvent(ExploreEvent.OnNodeChange)
		end
	else
		logError("nodeKey not find:" .. slot1)
	end
end

function slot0.updateNodeCanPassItem(slot0, slot1, slot2)
	if slot0:getNode(slot1) then
		slot3:setCanPassItem(slot2)
	else
		logError("nodeKey not find:" .. slot1)
	end
end

function slot0.getUnitDic(slot0)
	return slot0._unitDic
end

function slot0.getMapAreaDic(slot0)
	return slot0._mapAreaDic
end

function slot0.getAreaAllUnit(slot0, slot1)
	return slot0:getMapAreaMO(slot1) and slot2.unitList or {}
end

function slot0.getMapAreaMO(slot0, slot1)
	return slot0._mapAreaDic[slot1]
end

function slot0.addUnitMO(slot0, slot1)
	slot0._unitDic[slot1.id] = slot1
end

function slot0.getUnitMO(slot0, slot1)
	return slot0._unitDic[slot1]
end

function slot0.removeUnit(slot0, slot1)
end

function slot0.getExploreProgress(slot0)
	slot1 = {
		[slot8] = 0
	}
	slot2 = {
		[slot8] = 0
	}
	slot3 = 0
	slot4 = 0

	for slot8, slot9 in pairs(ExploreEnum.ProgressType) do
		-- Nothing
	end

	for slot8, slot9 in pairs(slot0._unitDic) do
		if ExploreEnum.ProgressType[slot9.type] then
			if slot9:isInteractDone() then
				slot1[slot10] = slot1[slot10] + 1
				slot4 = slot4 + 1
			end

			slot2[slot10] = slot2[slot10] + 1
			slot3 = slot3 + 1
		end
	end

	return slot2, slot1, slot3, slot4
end

function slot0.setNodeLightXY(slot0, slot1, slot2, slot3)
	if slot0._lightNodeDic[ExploreHelper.getKeyXY(slot1, slot2)] then
		return
	end

	slot0._lightNodeDic[slot4] = true

	for slot8 = -4, 4 do
		for slot12 = -4, 4 do
			slot13 = ExploreHelper.getKeyXY(slot1 + slot8, slot2 + slot12)
			slot0._boundNodeShowDic[slot13] = nil
			slot0._lightNodeShowDic[slot13] = true
		end
	end

	if slot3 then
		slot0:_checkNodeBound()
	end
end

function slot0._checkNodeBound(slot0)
	slot1 = false

	for slot5, slot6 in pairs(slot0._nodeDic) do
		if not slot0._lightNodeShowDic[slot5] then
			if slot0:getNodeIsShow(ExploreHelper.getKeyXY(slot6.pos.x - 1, slot6.pos.y)) and slot0:getNodeIsShow(ExploreHelper.getKeyXY(slot6.pos.x + 1, slot6.pos.y)) or slot0:getNodeIsShow(ExploreHelper.getKeyXY(slot6.pos.x, slot6.pos.y + 1)) and slot0:getNodeIsShow(ExploreHelper.getKeyXY(slot6.pos.x, slot6.pos.y - 1)) then
				slot1 = true
				slot0._lightNodeShowDic[slot5] = true
				slot0._boundNodeShowDic[slot5] = nil

				break
			elseif slot11 or slot12 or slot13 or slot14 then
				slot0._boundNodeShowDic[slot5] = nil
				slot15 = 0

				if slot11 and slot13 then
					slot15 = 1
				elseif slot11 and slot14 then
					slot15 = 2
				elseif slot12 and slot13 then
					slot15 = 3
				elseif slot12 and slot14 then
					slot15 = 4
				elseif slot11 then
					slot15 = 5
				elseif slot12 then
					slot15 = 6
				elseif slot13 then
					slot15 = 7
				elseif slot14 then
					slot15 = 8
				end

				slot0._boundNodeShowDic[slot5] = slot15
			end
		end
	end

	if slot1 then
		slot0:_checkNodeBound()
	end
end

function slot0.setNodeLight(slot0, slot1)
	slot0:setNodeLightXY(slot1.x, slot1.y, true)
end

function slot0.changeOutlineNum(slot0, slot1)
	slot0.outLineCount = slot0.outLineCount + slot1
	RenderPipelineSetting.selectedOutlineToggle = slot0.outLineCount > 0
end

function slot0.clear(slot0)
	slot0._nodeDic = nil
	slot0._unitDic = nil
	slot0._mapAreaDic = nil
	slot0._lightNodeDic = nil
	slot0._lightNodeShowDic = nil
	slot0._boundNodeShowDic = nil
	slot0.moveNodes = nil
	slot0.outLineCount = 0
end

slot0.instance = slot0.New()

return slot0
