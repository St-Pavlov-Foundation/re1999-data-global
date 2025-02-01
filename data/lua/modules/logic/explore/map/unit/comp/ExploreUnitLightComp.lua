module("modules.logic.explore.map.unit.comp.ExploreUnitLightComp", package.seeall)

slot0 = class("ExploreUnitLightComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.unit = slot1
	slot0.lights = {}
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
end

function slot0.addLight(slot0, slot1)
	if slot1 % 45 ~= 0 then
		return
	end

	slot2 = ExploreController.instance:getMapLight():addLight(slot0.unit, slot1)
	slot0.lights[#slot0.lights + 1] = {
		mo = slot2,
		lightItem = ExploreMapLightPool.instance:getInst(slot2, slot0.go)
	}
end

function slot0.haveLight(slot0)
	return #slot0.lights > 0
end

function slot0.onLightDataChange(slot0, slot1)
	for slot5 = 1, #slot0.lights do
		if slot0.lights[slot5].mo == slot1 then
			return slot0.lights[slot5].lightItem:updateLightMO(slot1)
		end
	end
end

function slot0.addLights(slot0, slot1, slot2)
	slot0:addLight(slot1)
	slot0:addLight(slot2)
end

function slot0.removeLightByDir(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.lights) do
		if slot6.mo.dir == slot1 then
			ExploreMapLightPool.instance:inPool(slot6.lightItem)
			table.remove(slot0.lights, slot5)

			break
		end
	end
end

function slot0.removeAllLight(slot0)
	for slot4, slot5 in pairs(slot0.lights) do
		ExploreMapLightPool.instance:inPool(slot5.lightItem)
	end

	slot0.lights = {}
end

function slot0.onDestroy(slot0)
	slot0:removeAllLight()

	slot0.go = nil
	slot0.unit = nil
end

return slot0
