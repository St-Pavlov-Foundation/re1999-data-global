module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapNodeMo", package.seeall)

slot0 = pureTable("WuErLiXiMapNodeMo")

function slot0.init(slot0, slot1)
	slot0.x = slot1[1]
	slot0.y = slot1[2]
	slot0.id = 100 * slot0.x + slot0.y
	slot0.nodeType = slot1[3]
	slot0.unit = nil
	slot0.ray = nil
	slot0.initUnit = 0
end

function slot0.hasActUnit(slot0)
	return slot0.initUnit == 0 and slot0.unit
end

function slot0.setUnit(slot0, slot1)
	if not slot0.unit then
		slot0.unit = WuErLiXiMapUnitMo.New()
	end

	slot0.unit:init(slot1)

	slot0.initUnit = slot0.unit.id
end

function slot0.setUnitByUnitMo(slot0, slot1, slot2, slot3)
	if not slot0.unit then
		slot0.unit = WuErLiXiMapUnitMo.New()
	end

	slot0.unit:initByUnitMo(slot1, slot2, slot3)
end

function slot0.getNodeUnit(slot0)
	return slot0.unit
end

function slot0.setUnitActive(slot0, slot1, slot2, slot3)
	if not slot0.unit then
		return
	end

	slot0.unit:setUnitActive(slot1, slot2, slot3)
end

function slot0.setDir(slot0, slot1, slot2)
	if not slot0.unit then
		return
	end

	slot0.unit:setDir(slot1)

	if not slot2 then
		return
	end

	slot0:setUnitOutDirByRayDir(slot2)
end

function slot0.setUnitOutDirByRayDir(slot0, slot1)
	if not slot0.unit or not slot1 then
		return
	end

	slot0.unit:setUnitOutDirByRayDir(slot1)
end

function slot0.isUnitActive(slot0, slot1)
	if not slot0.unit then
		return false
	end

	return slot0.unit:isUnitActive(slot1)
end

function slot0.clearUnit(slot0)
	slot0.unit = nil
end

function slot0.isNodeShowActive(slot0)
	if not slot0.unit then
		return false
	end

	if slot0.unit.unitType == WuErLiXiEnum.UnitType.SignalEnd then
		return slot0.ray
	elseif slot0.unit.unitType == WuErLiXiEnum.UnitType.Obstacle then
		return slot0.initUnit == 0
	end

	return slot0.unit:isUnitActive()
end

function slot0.isRayEmitterNode(slot0)
	if not slot0.unit then
		return false
	end

	return slot0.unit:isRayEmitterUnit()
end

function slot0.setUnitByActUnitMo(slot0, slot1, slot2, slot3)
	if not slot0.unit then
		slot0.unit = WuErLiXiMapUnitMo.New()
	end

	slot0.unit:initByActUnitMo(slot1, slot2, slot3)
end

function slot0.getUnitSignalOutDir(slot0)
	if not slot0.unit then
		return
	end

	return slot0.unit:getUnitSignalOutDir()
end

function slot0.setUnitOutDirByRayDir(slot0, slot1)
	if not slot0.unit then
		return
	end

	return slot0.unit:setUnitOutDirByRayDir(slot1)
end

function slot0.isUnitFreeType(slot0)
	if not slot0.unit then
		return false
	end

	return slot0.initUnit ~= 0
end

function slot0.couldSetRay(slot0, slot1)
	if slot0.unit then
		if slot0.x ~= slot0.unit.x or slot0.y ~= slot0.unit.y then
			return false
		end

		if not slot0.unit:couldSetRay(slot1) then
			return false
		end
	end

	return true
end

function slot0.setNodeRay(slot0, slot1, slot2, slot3, slot4)
	if slot0.unit and not slot0.unit:couldSetRay(slot2) then
		slot0.ray = nil

		return
	end

	if not slot0.ray then
		slot0.ray = WuErLiXiMapRayMo.New()

		slot0.ray:init(slot1, slot2, slot3, slot4)
	else
		slot0.ray:reset(slot1, slot2, slot3, slot4)
	end
end

function slot0.getNodeRay(slot0)
	return slot0.ray
end

function slot0.clearNodeRay(slot0, slot1)
	if not slot0.ray or slot0.ray.rayId ~= slot1 then
		return
	end

	slot0.ray = nil
end

return slot0
