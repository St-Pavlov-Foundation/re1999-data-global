module("modules.logic.room.entity.RoomBlockCanPlaceEntity", package.seeall)

slot0 = class("RoomBlockCanPlaceEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
end

function slot0.getTag(slot0)
	return SceneTag.Untagged
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.StaticContainerGOKey)
	slot0.goTrs = slot1.transform

	uv0.super.init(slot0, slot1)
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)
	slot0:addComp("placeBuildingEffectComp", RoomPlaceBuildingEffectComp)
	slot0:addComp("placeBlockEffectComp", RoomPlaceBlockEffectComp)
	slot0:addComp("transportPathLinkEffectComp", RoomTransportPathLinkEffectComp)
	slot0:addComp("transportPathEffectComp", RoomTransportPathEffectComp)
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3)
	transformhelper.setLocalPos(slot0.goTrs, slot1, slot2, slot3)
end

function slot0.getMO(slot0)
	return nil
end

return slot0
