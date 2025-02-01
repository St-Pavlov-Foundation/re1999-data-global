module("modules.logic.explore.map.light.ExploreMapLight", package.seeall)

slot0 = class("ExploreMapLight")

function slot0.initLight(slot0)
	slot0._checkCount = 0
	slot0._unitStatus = {}
	slot0._initDone = false
	slot0._lights = {}

	slot0:beginCheckStatusChange()

	for slot5, slot6 in pairs(ExploreController.instance:getMap()._unitDic) do
		if slot6:getLightRecvType() == ExploreEnum.LightRecvType.Custom then
			slot6:checkLight()
		end
	end

	slot0:endCheckStatus()

	slot0._initDone = true
end

function slot0.isInitDone(slot0)
	return slot0._initDone
end

function slot0.addLight(slot0, slot1, slot2)
	slot3 = ExploreLightMO.New()

	table.insert(slot0._lights, slot3)
	slot3:init(slot1, slot2)

	return slot3
end

function slot0.removeLight(slot0, slot1)
	tabletool.removeValue(slot0._lights, slot1)

	if slot1.endEmitUnit then
		slot0:removeUnitLight(slot2, slot1)
	end
end

function slot0.haveLight(slot0, slot1, slot2)
	slot3 = slot1:getLightRecvDirs()
	slot4 = ExploreEnum.PrismTypes[slot1:getUnitType()]

	for slot8, slot9 in ipairs(slot0._lights) do
		if slot9 ~= slot2 and slot9.endEmitUnit == slot1 and (not slot3 or slot3[ExploreHelper.getDir(slot9.dir - 180)]) then
			return true
		end
	end

	if slot4 then
		if ExploreController.instance:getMap():getUnitByType(ExploreEnum.ItemType.LightBall) and ExploreHelper.getDistance(slot6.nodePos, slot1.nodePos) <= 1 then
			return true
		end

		for slot11, slot12 in pairs(slot5:getUnitsByType(ExploreEnum.ItemType.Illuminant)) do
			if ExploreHelper.isPosEqual(slot12.nodePos, slot1.nodePos) then
				return true
			end
		end
	end

	return false
end

function slot0.haveLightDepth(slot0, slot1, slot2)
	if not slot1 or not slot1:isEnter() then
		return false
	end

	slot3 = ExploreController.instance:getMap()

	if slot0:haveIlluminant(slot1, slot3:getUnitByType(ExploreEnum.ItemType.LightBall), slot3:getUnitsByType(ExploreEnum.ItemType.Illuminant)) then
		return true
	end

	slot7 = {}

	while next({
		[slot1.id] = true
	}) do
		slot6 = {}

		for slot12 in pairs(slot6) do
			slot7[slot12] = true
			slot14 = slot3:getUnit(slot12):getLightRecvDirs()

			for slot18, slot19 in ipairs(slot0._lights) do
				if slot2 ~= slot19 and slot19.endEmitUnit == slot13 and (not slot14 or slot14[ExploreHelper.getDir(slot19.dir - 180)]) and not slot7[slot19.curEmitUnit.id] then
					slot6[slot19.curEmitUnit.id] = true
				end
			end
		end
	end

	for slot11 in pairs(slot7) do
		if slot0:haveIlluminant(slot3:getUnit(slot11), slot4, slot5) then
			return true
		end
	end

	return false
end

function slot0.haveIlluminant(slot0, slot1, slot2, slot3)
	if not slot1 then
		return false
	end

	if slot1:getIsNoEmitLight() then
		return false
	end

	if not ExploreEnum.PrismTypes[slot1:getUnitType()] then
		return false
	end

	if slot2 and ExploreHelper.getDistance(slot2.nodePos, slot1.nodePos) <= 1 then
		return true
	end

	for slot8, slot9 in pairs(slot3) do
		if ExploreHelper.isPosEqual(slot9.nodePos, slot1.nodePos) then
			return true
		end
	end
end

function slot0.removeUnitEmitLight(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot0._lights) do
		if slot7.curEmitUnit == slot1 then
			table.insert(slot2 or {}, slot7)
		end
	end

	if slot2 then
		for slot6, slot7 in pairs(slot2) do
			slot0:removeLight(slot7)
		end
	end
end

function slot0.removeUnitLight(slot0, slot1, slot2)
	slot1:onLightChange(slot2, false)

	if not slot0:haveLightDepth(slot1, slot2) then
		slot1:onLightExit(slot2)

		slot3 = nil

		for slot7, slot8 in ipairs(slot0._lights) do
			if slot8.curEmitUnit == slot1 then
				table.insert(slot3 or {}, slot8)
			end
		end

		if slot3 then
			for slot7, slot8 in pairs(slot3) do
				slot0:removeLight(slot8)
			end
		end
	end
end

function slot0.updateLightsByUnit(slot0, slot1)
	for slot5, slot6 in pairs(slot0._lights) do
		if slot6:isInLight(slot1.nodePos) or slot6.endEmitUnit == slot1 then
			slot6:updateData()
		end
	end
end

function slot0.getAllLightMos(slot0)
	return slot0._lights
end

function slot0.beginCheckStatusChange(slot0, slot1, slot2)
	slot0._checkCount = slot0._checkCount + 1

	if not slot1 then
		return
	end

	if not slot0._unitStatus[slot1] then
		slot0._unitStatus[slot1] = slot2
	end
end

function slot0.endCheckStatus(slot0)
	slot0._checkCount = slot0._checkCount - 1

	if slot0._checkCount == 0 then
		for slot5, slot6 in pairs(slot0._unitStatus) do
			if ExploreController.instance:getMap():getUnit(slot5) and slot7.setActiveAnim and slot7:haveLight() ~= slot6 then
				slot7:setActiveAnim(slot8)
			end
		end

		slot0._unitStatus = {}
	end
end

function slot0.unloadMap(slot0)
	slot0:destroy()
end

function slot0.destroy(slot0)
	slot0._lights = {}
end

return slot0
