module("modules.logic.room.entity.comp.RoomCameraFollowTargetComp", package.seeall)

slot0 = class("RoomCameraFollowTargetComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectKey = slot1:getMainEffectKey() or RoomEnum.EffectKey.VehicleGOKey
	slot0._followGOPathKey = RoomEnum.EntityChildKey.FirstPersonCameraGOKey
	slot0.__willDestroy = false
	slot0._offsetY = 0
	slot0._posZ = 0
	slot0._posY = 0
	slot0._posX = 0
	slot0._roZ = 0
	slot0._roY = 0
	slot0._roX = 0
	slot0._forwardZ = 0
	slot0._forwardY = 0
	slot0._forwardX = 0
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goTrs = slot1.transform
	slot0.goFollowPos = slot1
	slot0.goFollowPosTrs = slot0.goTrs
end

function slot0.setOffsetY(slot0, slot1)
	slot0._offsetY = tonumber(slot1)
end

function slot0.setEffectKey(slot0, slot1)
	slot0._effectKey = slot1
end

function slot0.setFollowGOPath(slot0, slot1)
	slot0._followGOPathKey = slot1

	slot0:_updateFollowGO()
end

function slot0.getPositionXYZ(slot0)
	if not slot0.__willDestroy then
		slot0._posX, slot0._posY, slot0._posZ = transformhelper.getPos(slot0.goFollowPosTrs)
		slot0._posY = slot0._posY + slot0._offsetY
	end

	return slot0._posX, slot0._posY, slot0._posZ
end

function slot0.getRotateXYZ(slot0)
	if not slot0.__willDestroy then
		slot0._roX, slot0._roY, slot0._roZ = transformhelper.getLocalRotation(slot0.goTrs)
	end

	return slot0._roX, slot0._roY, slot0._roZ
end

function slot0.getForwardXYZ(slot0)
	if not slot0.__willDestroy then
		slot0._forwardX, slot0._forwardY, slot0._forwardZ = transformhelper.getForward(slot0.goTrs)
	end

	return slot0._forwardX, slot0._forwardY, slot0._forwardZ
end

function slot0.setCameraFollow(slot0, slot1)
	if slot0.__willDestroy then
		return
	end

	slot0._cameraFollowComp = slot1
end

function slot0.beforeDestroy(slot0)
	slot0.__willDestroy = true

	if slot0._cameraFollowComp then
		slot0._cameraFollowComp = nil

		slot0._cameraFollowComp:removeFollowTarget(slot0)
	end
end

function slot0._updateFollowGO(slot0)
	if slot0.__willDestroy then
		return
	end

	slot2 = nil

	if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) and slot0._followGOPathKey ~= nil and not slot1:getGameObjectByPath(slot0._effectKey, slot0._followGOPathKey) and slot1:getGameObjectsByName(slot0._effectKey, slot0._followGOPathKey) and #slot3 > 0 then
		slot2 = slot3[1]
	end

	if slot2 then
		slot0.goFollowPos = slot2
		slot0.goFollowPosTrs = slot2.transform
	else
		slot0.goFollowPos = slot0.go
		slot0.goFollowPosTrs = slot0.goTrs
	end
end

function slot0.isWillDestory(slot0)
	return slot0.__willDestroy
end

function slot0.onEffectReturn(slot0, slot1, slot2)
	if slot0._effectKey == slot1 then
		slot0:_updateFollowGO()
	end
end

function slot0.onEffectRebuild(slot0)
	if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) and not slot1:isSameResByKey(slot0._effectKey, slot0._effectRes) then
		slot0._effectRes = slot1:getEffectRes(slot0._effectKey)

		slot0:_updateFollowGO()
	end
end

return slot0
