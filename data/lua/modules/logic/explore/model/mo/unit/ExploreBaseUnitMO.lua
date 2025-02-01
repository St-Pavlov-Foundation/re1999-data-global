module("modules.logic.explore.model.mo.unit.ExploreBaseUnitMO", package.seeall)

slot0 = pureTable("ExploreBaseUnitMO")
slot1 = {
	x = 0,
	y = 0
}

function slot0.init(slot0, slot1)
	slot2 = nil

	if slot0.nodePos and (slot0.nodePos.x ~= slot1[ExploreUnitMoFieldEnum.nodePos][1] or slot0.nodePos.y ~= slot1[ExploreUnitMoFieldEnum.nodePos][2]) then
		uv0.x = slot0.nodePos.x
		uv0.y = slot0.nodePos.y
		slot2 = uv0
	end

	slot0.hasInteract = false

	for slot6, slot7 in pairs(ExploreUnitMoFieldEnum) do
		slot0[slot6] = slot1[slot7] or slot1[slot7] == nil and slot0[slot6]
	end

	slot0.nodePos.x = slot0.nodePos[1]
	slot0.nodePos.y = slot0.nodePos[2]
	slot0.enterTriggerType = false
	slot0.defaultWalkable = slot0.defaultWalkable ~= false
	slot0.triggerEffects = slot0.triggerEffects or {}
	slot0.doneEffects = slot0.doneEffects or {}
	slot0.unitDir = slot0.unitDir or 0
	slot0.specialDatas = slot0.specialDatas or {
		1,
		1
	}
	slot0.offsetSize = slot0.offsetSize or {
		0,
		0,
		0,
		0
	}
	slot0.resRotation = slot0.resRotation or {
		0,
		0,
		0
	}
	slot0.resPosition = slot0.resPosition or {
		0,
		0,
		0
	}
	slot0.customIconType = nil

	for slot6, slot7 in pairs(slot0.triggerEffects) do
		if slot7[1] == ExploreEnum.TriggerEvent.ChangeIcon then
			slot0.customIconType = slot7[2]
		end
	end

	slot0:initTypeData()

	slot0.triggerEffectsCount = #slot0.triggerEffects + 1

	if ExploreModel.instance:hasInteractInfo(slot0.id) == false then
		slot0:setStatus(tonumber(slot0.interact) or 0)
	else
		slot3 = slot0:getInteractInfoMO()
		slot0.unitDir = slot3.dir
		slot0.nodePos.x = slot3.posx
		slot0.nodePos.y = slot3.posy
	end

	if slot0._hasInit ~= true then
		slot0:buildTriggerExData()
	end

	slot0._hasInit = true

	if slot2 then
		slot0:_updateNodeOpenKey(slot2, slot0.nodePos)
	end
end

function slot0.initTypeData(slot0)
end

function slot0.updateNO(slot0)
end

function slot0.activeStateChange(slot0, slot1)
	if not slot0._countSource then
		return
	end

	for slot5, slot6 in pairs(slot0._countSource) do
		if slot1 then
			ExploreCounterModel.instance:add(slot6, slot0.id)
		else
			ExploreCounterModel.instance:reduce(slot6, slot0.id)
		end
	end
end

function slot0.buildTriggerExData(slot0)
	for slot4, slot5 in ipairs(slot0.triggerEffects) do
		if slot5[1] == ExploreEnum.TriggerEvent.Counter then
			if not slot0._countSource then
				slot0._countSource = {}
			end

			slot7 = string.splitToNumber(tostring(slot5[2]), "#") or {}

			table.insert(slot0._countSource, slot7[1])
			ExploreCounterModel.instance:addCountSource(slot7[1], slot0.id)
		end
	end
end

function slot0.onEnterScene(slot0)
	slot0:updatePos(Vector2.New(slot0.nodePos.x, slot0.nodePos.y))
	ExploreMapModel.instance:addUnitMO(slot0)
end

function slot0.onRemoveScene(slot0)
	if slot0:isWalkable() == false then
		ExploreMapModel.instance:updateNodeOpenKey(ExploreHelper.getKey(slot0.nodePos), slot0.id, true)
	end

	ExploreMapModel.instance:removeUnit(slot0.id)
end

function slot0.getTriggerPos(slot0)
	if slot0.triggerDir == ExploreEnum.TriggerDir.Left then
		return {
			x = slot0.nodePos.x - 1,
			y = slot0.nodePos.y
		}
	elseif slot0.triggerDir == ExploreEnum.TriggerDir.Right then
		return {
			x = slot0.nodePos.x + 1,
			y = slot0.nodePos.y
		}
	elseif slot0.triggerDir == ExploreEnum.TriggerDir.Up then
		return {
			x = slot0.nodePos.x,
			y = slot0.nodePos.y + 1
		}
	elseif slot0.triggerDir == ExploreEnum.TriggerDir.Down then
		return {
			x = slot0.nodePos.x,
			y = slot0.nodePos.y - 1
		}
	end

	return slot0.nodePos
end

function slot0.canTrigger(slot0, slot1)
	if slot0.triggerDir == ExploreEnum.TriggerDir.Left then
		return slot1.x == slot0.nodePos.x - 1 and slot1.y == slot0.nodePos.y
	elseif slot0.triggerDir == ExploreEnum.TriggerDir.Right then
		return slot1.x == slot0.nodePos.x + 1 and slot1.y == slot0.nodePos.y
	elseif slot0.triggerDir == ExploreEnum.TriggerDir.Up then
		return slot1.x == slot0.nodePos.x and slot1.y == slot0.nodePos.y + 1
	elseif slot0.triggerDir == ExploreEnum.TriggerDir.Down then
		return slot1.x == slot0.nodePos.x and slot1.y == slot0.nodePos.y - 1
	end

	return true
end

function slot0.updatePos(slot0, slot1)
	slot0.nodeKey = ExploreHelper.getKey(slot1)

	slot0:_updateNodeOpenKey(slot0.nodePos, slot1)
	slot0:onPosChange(slot0.nodePos, slot1)

	slot0.nodePos.x = slot1.x
	slot0.nodePos.y = slot1.y
end

function slot0.removeFromNode(slot0)
	slot0:_updateNodeOpenKey(slot0.nodePos)
	slot0:onPosChange(slot0.nodePos)
end

function slot0.setNodeOpenKey(slot0, slot1)
	ExploreMapModel.instance:updateNodeOpenKey(slot0.nodeKey, slot0.id, slot1, true)
end

function slot0._updateNodeOpenKey(slot0, slot1, slot2)
	if slot0:isWalkable() == false then
		if slot1 then
			for slot6 = slot0.offsetSize[1], slot0.offsetSize[3] do
				for slot10 = slot0.offsetSize[2], slot0.offsetSize[4] do
					ExploreMapModel.instance:updateNodeOpenKey(ExploreHelper.getKeyXY(slot1.x + slot6, slot1.y + slot10), slot0.id, true)
				end
			end
		end

		if slot2 then
			for slot6 = slot0.offsetSize[1], slot0.offsetSize[3] do
				for slot10 = slot0.offsetSize[2], slot0.offsetSize[4] do
					ExploreMapModel.instance:updateNodeOpenKey(ExploreHelper.getKeyXY(slot2.x + slot6, slot2.y + slot10), slot0.id, false)
				end
			end
		end
	end
end

function slot0.getConfigId(slot0)
	return slot0.config.configId
end

function slot0.isWalkable(slot0)
	return slot0.defaultWalkable
end

function slot0.setStatus(slot0, slot1)
	slot0:getInteractInfoMO():updateStatus(slot1)
end

function slot0.getStatus(slot0)
	return slot0:getInteractInfoMO().status
end

function slot0.isEnter(slot0)
	return slot0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.IsEnter) == 1
end

function slot0.setEnter(slot0, slot1)
	if slot1 then
		slot0:onEnterScene()
	else
		slot0:onRemoveScene()
	end

	return slot0:getInteractInfoMO():setBitByIndex(ExploreEnum.InteractIndex.IsEnter, slot1 and 1 or 0)
end

function slot0.isInteractEnabled(slot0)
	return slot0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.InteractEnabled) == 1
end

function slot0.getInteractInfoMO(slot0)
	return ExploreModel.instance:getInteractInfo(slot0.id)
end

function slot0.isInteractDone(slot0)
	return true
end

function slot0.isInteractActiveState(slot0)
	return slot0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.ActiveState) == 1
end

function slot0.isInteractFinishState(slot0)
	return slot0:getInteractInfoMO():getBitByIndex(ExploreEnum.InteractIndex.IsFinish) == 1
end

function slot0.onPosChange(slot0, slot1, slot2)
end

slot2 = {}

function slot0.getUnitClass(slot0)
	if not uv0[ExploreEnum.ItemTypeToName[slot0.type]] then
		uv0[slot1] = _G[string.format("Explore%sUnit", slot1)] or _G[string.format("Explore%s", slot1)] or ExploreBaseMoveUnit
	end

	return uv0[slot1]
end

return slot0
