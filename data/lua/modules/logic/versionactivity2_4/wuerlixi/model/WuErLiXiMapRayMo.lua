module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapRayMo", package.seeall)

slot0 = pureTable("WuErLiXiMapRayMo")

function slot0.ctor(slot0)
	slot0.rayId = 0
	slot0.rayParent = 0
	slot0.rayDir = 0
	slot0.rayType = WuErLiXiEnum.RayType.NormalSignal
	slot0.rayTime = ServerTime.now()
end

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.rayId = slot1
	slot0.rayType = slot2
	slot0.rayDir = slot3
	slot0.rayParent = slot4
	slot0.rayTime = ServerTime.now()
end

function slot0.reset(slot0, slot1, slot2, slot3, slot4)
	if slot0.rayId ~= slot1 or slot0.rayType ~= slot2 then
		slot0.rayTime = ServerTime.now()
	end

	slot0.rayId = slot1
	slot0.rayType = slot2
	slot0.rayDir = slot3
	slot0.rayParent = slot4
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

function slot0.setRayParent(slot0, slot1)
	slot0.rayParent = slot1
end

return slot0
