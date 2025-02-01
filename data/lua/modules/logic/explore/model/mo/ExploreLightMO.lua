module("modules.logic.explore.model.mo.ExploreLightMO", package.seeall)

slot0 = pureTable("ExploreLightMO")

function slot0.ctor(slot0)
	slot0.curEmitUnit = nil
	slot0.dir = nil
	slot0.endEmitUnit = nil
	slot0.crossNodes = {}
	slot0.lightLen = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0.curEmitUnit = slot1
	slot0.dir = ExploreHelper.getDir(slot2)

	slot0:updateData()
end

slot1 = {
	[0] = {
		x = 0,
		y = 1
	},
	[45] = {
		x = 1,
		y = 1
	},
	[90] = {
		x = 1,
		y = 0
	},
	[135] = {
		x = 1,
		y = -1
	},
	[180] = {
		x = 0,
		y = -1
	},
	[225] = {
		x = -1,
		y = -1
	},
	[270] = {
		x = -1,
		y = 0
	},
	[315] = {
		x = -1,
		y = 1
	}
}
slot2 = {
	x = 0,
	y = 0
}
slot3 = math.sqrt(2)

function slot0.updateData(slot0)
	slot0.crossNodes = {}
	slot1 = ExploreController.instance:getMap()
	slot2 = ExploreController.instance:getMapLight()
	slot3 = slot0.curEmitUnit.nodePos
	uv0.y = slot3.y
	uv0.x = slot3.x
	slot4 = nil
	slot5 = 0
	slot6 = uv1[slot0.dir]

	while true do
		if not slot1:haveNodeXY(ExploreHelper.getKey(uv0)) then
			break
		end

		slot0.crossNodes[slot7] = true
		uv0.x = uv0.x + slot6.x
		uv0.y = uv0.y + slot6.y
		slot5 = slot5 + 1
		slot9 = false

		for slot13, slot14 in pairs(slot1:getUnitByPos(uv0)) do
			if not slot14:isPassLight() then
				slot9 = true
				slot4 = slot14

				break
			end
		end

		if slot9 then
			break
		end
	end

	if not slot4 then
		slot5 = slot5 - 0.5
	end

	if (slot0.dir + 360) % 90 == 45 then
		slot5 = slot5 * uv2
	end

	if slot4 and isTypeOf(slot4, ExploreBaseMoveUnit) and slot4:isMoving() then
		slot5 = Vector3.Distance(slot0.curEmitUnit:getPos(), slot4:getPos())
	end

	slot0.lightLen = slot5

	if slot4 ~= slot0.endEmitUnit then
		slot0.endEmitUnit = slot4

		if slot0.endEmitUnit then
			slot2:removeUnitLight(slot7, slot0)
		end

		if slot4 and (not slot4:getLightRecvDirs() or slot8[ExploreHelper.getDir(slot0.dir - 180)]) then
			if not slot2:haveLight(slot4, slot0) then
				slot4:onLightEnter(slot0)
			end

			slot4:onLightChange(slot0, true)
		end
	end

	slot0.curEmitUnit:onLightDataChange(slot0)
end

function slot0.isInLight(slot0, slot1)
	return slot0:getCrossNode()[ExploreHelper.getKey(slot1)] or false
end

function slot0.getCrossNode(slot0)
	return slot0.crossNodes
end

return slot0
