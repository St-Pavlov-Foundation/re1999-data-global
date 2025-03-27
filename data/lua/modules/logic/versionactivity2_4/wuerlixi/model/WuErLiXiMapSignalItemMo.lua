module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapSignalItemMo", package.seeall)

slot0 = pureTable("WuErLiXiMapSignalItemMo")

function slot0.ctor(slot0)
	slot0.rayId = 0
	slot0.rayDir = 0
	slot0.rayType = WuErLiXiEnum.RayType.NormalSignal
	slot0.startNodeMo = {}
	slot0.endNodeMo = {}
	slot0.startPos = {}
	slot0.endPos = {}
end

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.rayId = slot1
	slot0.rayType = slot2
	slot0.rayDir = slot3
	slot0.startNodeMo = slot4
	slot0.endNodeMo = slot5
	slot0.startPos = {
		slot4.x,
		slot4.y
	}
	slot0.endPos = {
		slot5.x,
		slot5.y
	}
end

function slot0.reset(slot0, slot1, slot2, slot3, slot4)
	slot0.rayId = slot1
	slot0.rayType = slot2
	slot0.rayDir = slot3
	slot0.endNodeMo = slot4
	slot0.endPos = {
		slot4.x,
		slot4.y
	}
end

function slot0.setId(slot0, slot1)
	slot0.rayId = slot1
end

function slot0.setType(slot0, slot1)
	slot0.rayType = slot1
end

function slot0.setRayDir(slot0, slot1)
	slot0.rayDir = slot1
end

function slot0.resetEndNodeMo(slot0, slot1)
	slot0.endNodeMo = slot1
end

function slot0.getSignalLength(slot0)
	return math.abs(slot0.startPos[1] + slot0.startPos[2] - slot0.endPos[1] - slot0.endPos[2]) + 1
end

return slot0
