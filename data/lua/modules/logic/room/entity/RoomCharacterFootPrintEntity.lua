module("modules.logic.room.entity.RoomCharacterFootPrintEntity", package.seeall)

slot0 = class("RoomCharacterFootPrintEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
	slot0._keyParamDict = {}
	slot0._resRightPath = RoomResHelper.getCharacterEffectPath(RoomCharacterEnum.CommonEffect.RightFoot)
	slot0._resRightAb = RoomResHelper.getCharacterEffectABPath(RoomCharacterEnum.CommonEffect.RightFoot)
	slot0._resLeftPath = RoomResHelper.getCharacterEffectPath(RoomCharacterEnum.CommonEffect.LeftFoot)
	slot0._resLeftAb = RoomResHelper.getCharacterEffectABPath(RoomCharacterEnum.CommonEffect.LeftFoot)
end

function slot0.getTag(slot0)
	return SceneTag.Untagged
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = slot0.containerGO
	slot0.goTrs = slot1.transform

	uv0.super.init(slot0, slot1)
	RoomMapController.instance:registerCallback(RoomEvent.AddCharacterFootPrint, slot0._addFootPrintEffect, slot0)
end

function slot0.initComponents(slot0)
	slot0:addComp("effect", RoomEffectComp)
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

function slot0.beforeDestroy(slot0)
	uv0.super.beforeDestroy(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.AddCharacterFootPrint, slot0._addFootPrintEffect, slot0)
end

function slot0._addFootPrintEffect(slot0, slot1, slot2, slot3)
	slot0.effect:addParams({
		[slot0:_findEffectKey()] = {
			res = slot3 and slot0._resLeftPath or slot0._resRightPath,
			ab = slot3 and slot0._resLeftAb or slot0._resRightAb,
			localPos = slot2,
			localRotation = slot1
		}
	}, 5)
	slot0.effect:refreshEffect()
end

function slot0._findEffectKey(slot0)
	slot1 = 1

	while slot0.effect:isHasEffectGOByKey(slot0:_getKeyByIndex(slot1)) do
		slot1 = slot1 + 1
	end

	return slot0:_getKeyByIndex(slot1)
end

function slot0._getKeyByIndex(slot0, slot1)
	if not slot0._keyParamDict[slot1] then
		slot0._keyParamDict[slot1] = string.format("footprint_%s", slot1)
	end

	return slot0._keyParamDict[slot1]
end

function slot0.onEffectRebuild(slot0)
end

return slot0
