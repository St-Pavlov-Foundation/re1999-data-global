module("modules.logic.explore.controller.ExploreHelper", package.seeall)

slot0 = _M
slot1 = LayerMask.GetMask("Scene")
slot2 = LayerMask.GetMask("SceneOpaque", "Unit", "Scene")
slot3 = LayerMask.GetMask(SceneLayer.UI3D, SceneLayer.UI3DAfterPostProcess)

function slot0.getXYByKey(slot0)
	slot1 = string.split(slot0, "_")

	return tonumber(slot1[1]), tonumber(slot1[2])
end

function slot0.getNavigateMask()
	return uv0
end

function slot0.getSceneMask()
	return uv0
end

function slot0.getTriggerMask()
	return uv0
end

function slot0.getKey(slot0)
	return uv0.getKeyXY(slot0.x, slot0.y)
end

function slot0.getKeyXY(slot0, slot1)
	return string.format("%s_%s", slot0, slot1)
end

function slot0.tileToPos(slot0)
	return Vector3(slot0.x * ExploreConstValue.TILE_SIZE + 0.5, 0, slot0.y * ExploreConstValue.TILE_SIZE + 0.5)
end

function slot0.posToTile(slot0)
	return Vector2(math.floor(slot0.x / ExploreConstValue.TILE_SIZE), math.floor(slot0.z / ExploreConstValue.TILE_SIZE))
end

function slot0.isPosEqual(slot0, slot1)
	return slot0 == slot1 or slot0.x == slot1.x and slot0.y == slot1.y
end

function slot0.getDistance(slot0, slot1)
	return math.abs(slot0.x - slot1.x) + math.abs(slot0.y - slot1.y)
end

function slot0.getDistanceRound(slot0, slot1)
	return math.max(math.abs(slot0.x - slot1.x), math.abs(slot0.y - slot1.y))
end

function slot0.getDir(slot0)
	return (slot0 + 360) % 360
end

slot4 = {
	[0] = {
		x = 0,
		y = 1
	},
	[90] = {
		x = 1,
		y = 0
	},
	[180] = {
		x = 0,
		y = -1
	},
	[270] = {
		x = -1,
		y = 0
	}
}

function slot0.dirToXY(slot0)
	return uv1[uv0.getDir(slot0)]
end

function slot0.xyToDir(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot6.x == slot0 and slot6.y == slot1 then
			return slot5
		end
	end

	return 0
end

function slot0.getCornerNum(slot0, slot1)
	if not slot0 or #slot0 <= 0 then
		return 0
	end

	slot2 = 0
	slot3 = slot0[1]
	slot4 = nil

	function slot5(slot0)
		slot1 = 0

		if uv0.x == slot0.x then
			slot1 = -1
		elseif uv0.y == slot0.y then
			slot1 = 1
		end

		if not uv1 or uv1 ~= slot1 then
			uv2 = uv2 + 1
			uv1 = slot1
		end
	end

	for slot9 = 2, #slot0 do
		slot10 = slot0[slot9]

		slot5(slot10)

		slot3 = slot10
	end

	slot5(slot1)

	return slot2 - 1
end

function slot0.getBit(slot0, slot1)
	return bit.band(slot0, bit.lshift(1, slot1 - 1))
end

function slot0.setBit(slot0, slot1, slot2)
	slot3 = bit.lshift(1, slot1 - 1)

	return (not slot2 or bit.bor(slot0, slot3)) and bit.band(bit.bor(slot0, slot3), bit.bnot(slot3))
end

function slot0.triggerAudio(slot0, slot1, slot2, slot3)
	if not slot0 or slot0 <= 0 then
		return
	end

	slot4 = nil

	if slot3 then
		GameSceneMgr.instance:getCurScene().audio:onTriggerAudio(slot3, (not slot1 or AudioMgr.instance:trigger(slot0, slot2)) and AudioMgr.instance:trigger(slot0))
	end
end

return slot0
