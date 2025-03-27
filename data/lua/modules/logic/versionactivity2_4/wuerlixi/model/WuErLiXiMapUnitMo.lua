module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapUnitMo", package.seeall)

slot0 = pureTable("WuErLiXiMapUnitMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.x = 0
	slot0.y = 0
	slot0.unitType = 0
	slot0.dir = 0
	slot0.isActive = false
end

function slot0.init(slot0, slot1)
	slot0.id = slot1[1]
	slot0.x = slot1[2]
	slot0.y = slot1[3]
	slot0.unitType = slot1[4]
	slot0.dir = slot1[5]
	slot0.outDir = slot0.dir
	slot0.isActive = slot0.unitType == WuErLiXiEnum.UnitType.SignalStart or slot0.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function slot0.initByActUnitMo(slot0, slot1, slot2, slot3)
	slot0.id = slot1.id
	slot0.x = slot2
	slot0.y = slot3
	slot0.unitType = slot1.type
	slot0.dir = slot1.dir
	slot0.outDir = slot0.dir
	slot0.isActive = slot0.unitType == WuErLiXiEnum.UnitType.SignalStart or slot0.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function slot0.initByUnitMo(slot0, slot1, slot2, slot3)
	slot0.id = slot1.id
	slot0.x = slot2
	slot0.y = slot3
	slot0.unitType = slot1.unitType
	slot0.dir = slot1.dir
	slot0.outDir = slot1.outDir
	slot0.isActive = slot0.unitType == WuErLiXiEnum.UnitType.SignalStart or slot0.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function slot0.getId(slot0)
	return slot0.id
end

function slot0.isUnitActive(slot0, slot1)
	if slot0.unitType == WuErLiXiEnum.UnitType.SignalStart then
		slot0.isActive = true
	elseif slot0.unitType == WuErLiXiEnum.UnitType.KeyStart then
		slot0.isActive = true
	end

	if slot1 and slot0.unitType == WuErLiXiEnum.UnitType.Reflection then
		return slot1 == WuErLiXiHelper.getOppositeDir(slot0.dir) or slot1 == WuErLiXiHelper.getNextDir(slot0.dir)
	end

	if slot1 and slot0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		return slot1 == slot0.dir
	end

	return slot0.isActive
end

function slot0.couldSetRay(slot0, slot1)
	if slot0.unitType == WuErLiXiEnum.UnitType.SignalStart then
		return false
	elseif slot0.unitType == WuErLiXiEnum.UnitType.KeyStart then
		return false
	elseif slot0.unitType == WuErLiXiEnum.UnitType.Obstacle then
		return false
	elseif slot0.unitType == WuErLiXiEnum.UnitType.Key then
		return slot1 == WuErLiXiEnum.RayType.SwitchSignal
	elseif slot0.unitType == WuErLiXiEnum.UnitType.Switch then
		return slot0.isActive
	end

	return true
end

function slot0.setUnitActive(slot0, slot1, slot2, slot3)
	if not slot1 then
		slot0.isActive = false

		return
	end

	if slot0.unitType == WuErLiXiEnum.UnitType.SignalEnd then
		slot0.isActive = slot2 == WuErLiXiEnum.RayType.NormalSignal
	elseif slot0.unitType == WuErLiXiEnum.UnitType.Reflection then
		if not slot3 then
			slot0.isActive = false

			return
		end

		slot0.isActive = slot3 == WuErLiXiHelper.getOppositeDir(slot0.dir) or slot3 == WuErLiXiHelper.getNextDir(slot0.dir)

		if slot3 == WuErLiXiHelper.getNextDir(slot0.dir) then
			slot0.outDir = slot0.dir
		elseif slot3 == WuErLiXiHelper.getOppositeDir(slot0.dir) then
			slot0.outDir = WuErLiXiHelper.getNextDir(slot3)
		else
			slot0.outDir = nil
		end
	elseif slot0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		slot0.outDir = slot3 == slot0.dir and slot0.dir or nil
		slot0.isActive = slot3 == slot0.dir
	elseif slot0.unitType == WuErLiXiEnum.UnitType.Key then
		slot0.isActive = slot2 == WuErLiXiEnum.RayType.SwitchSignal
	elseif slot0.unitType == WuErLiXiEnum.UnitType.Switch then
		slot0.isActive = true
	elseif slot0.unitType == WuErLiXiEnum.UnitType.SignalStart then
		slot0.isActive = true
	elseif slot0.unitType == WuErLiXiEnum.UnitType.KeyStart then
		slot0.isActive = true
	else
		slot0.isActive = false
	end
end

function slot0.setDir(slot0, slot1)
	slot0.dir = slot1

	if not slot0.isActive then
		slot0.ourDir = nil

		return
	end

	slot0.outDir = slot0.dir
end

function slot0.setUnitOutDirByRayDir(slot0, slot1)
	if not slot0.isActive then
		slot0.outDir = nil

		return
	end

	if slot0.unitType == WuErLiXiEnum.UnitType.Reflection then
		if slot1 == WuErLiXiHelper.getNextDir(slot0.dir) then
			slot0.outDir = slot0.dir
		elseif slot1 == WuErLiXiHelper.getOppositeDir(slot0.dir) then
			slot0.outDir = WuErLiXiHelper.getNextDir(slot1)
		else
			slot0.outDir = nil
		end

		return
	end

	slot0.outDir = slot0.isActive and slot0.dir or nil
end

function slot0.getUnitSignalOutDir(slot0)
	if not slot0.isActive then
		return
	end

	return slot0.outDir
end

function slot0.getUnitDir(slot0)
	return slot0.dir
end

function slot0.isIgnoreSignal(slot0)
	if slot0.isActive and slot0.unitType == WuErLiXiEnum.UnitType.Switch then
		return true
	end

	return false
end

function slot0.getUnitSignals(slot0, slot1)
	if not slot0.isActive then
		return {}
	end

	if slot0.unitType == WuErLiXiEnum.UnitType.SignalStart then
		table.insert({}, {
			slot0.x,
			slot0.y
		})
	elseif slot0.unitType == WuErLiXiEnum.UnitType.KeyStart then
		table.insert(slot2, {
			slot0.x,
			slot0.y
		})
	elseif slot0.unitType == WuErLiXiEnum.UnitType.Reflection then
		if slot1 then
			if slot1 == WuErLiXiHelper.getNextDir(slot0.dir) or slot1 == WuErLiXiHelper.getOppositeDir(slot0.dir) then
				table.insert(slot2, {
					slot0.x,
					slot0.y
				})
			end
		elseif slot0.outDir then
			table.insert(slot2, {
				slot0.x,
				slot0.y
			})
		end
	elseif slot0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if slot1 then
			if slot1 == slot0.dir then
				if slot0.dir == WuErLiXiEnum.Dir.Up or slot0.dir == WuErLiXiEnum.Dir.Down then
					table.insert(slot2, {
						slot0.x - 1,
						slot0.y
					})
					table.insert(slot2, {
						slot0.x + 1,
						slot0.y
					})
				else
					table.insert(slot2, {
						slot0.x,
						slot0.y - 1
					})
					table.insert(slot2, {
						slot0.x,
						slot0.y + 1
					})
				end
			end
		elseif slot0.dir == WuErLiXiEnum.Dir.Up or slot0.dir == WuErLiXiEnum.Dir.Down then
			table.insert(slot2, {
				slot0.x - 1,
				slot0.y
			})
			table.insert(slot2, {
				slot0.x + 1,
				slot0.y
			})
		else
			table.insert(slot2, {
				slot0.x,
				slot0.y - 1
			})
			table.insert(slot2, {
				slot0.x,
				slot0.y + 1
			})
		end
	end

	return slot2
end

return slot0
