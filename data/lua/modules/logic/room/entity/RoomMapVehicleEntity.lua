module("modules.logic.room.entity.RoomMapVehicleEntity", package.seeall)

slot0 = class("RoomMapVehicleEntity", RoomBaseEntity)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0)

	slot0.id = slot1
	slot0.entityId = slot0.id
	slot0._isShow = true
end

function slot0.getTag(slot0)
	return SceneTag.Untagged
end

function slot0.init(slot0, slot1)
	slot0.containerGO = gohelper.create3d(slot1, RoomEnum.EntityChildKey.ContainerGOKey)
	slot0.staticContainerGO = slot0.containerGO
	slot0.containerGOTrs = slot0.containerGO.transform
	slot0.goTrs = slot1.transform

	uv0.super.init(slot0, slot1)

	slot0._scene = GameSceneMgr.instance:getCurScene()

	slot0:refreshVehicle()
end

function slot0.refreshVehicle(slot0)
	if RoomController.instance:isObMode() then
		slot1 = slot0._lastVehicleId
		slot3 = slot0:getMO() and slot2:getReplaceDefideCfg()

		if not slot0.effect:isHasEffectGOByKey(RoomEnum.EffectKey.VehicleGOKey) or slot3 and slot1 ~= slot3.id then
			slot0._lastVehicleId = slot3.id

			slot0.effect:addParams({
				[slot4] = {
					deleteChildPath = "0",
					res = slot0:getRes(),
					localRotation = Vector3(0, slot3 and slot3.rotate or 0, 0)
				}
			})
			slot0.effect:refreshEffect()
		end

		if slot1 and slot1 ~= slot0._lastVehicleId then
			slot0:dispatchEvent(RoomEvent.VehicleIdChange)
		end
	end
end

function slot0.refreshReplaceType(slot0)
	if slot0:getMO() and slot0.vehickleTransport then
		slot1:setReplaceType(slot0.vehickleTransport:checkIsInRiver() and RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land)
	end
end

function slot0.getRes(slot0)
	slot2 = slot0:getMO() and slot1:getReplaceDefideCfg()

	return RoomResHelper.getVehiclePath(slot2 and slot2.id)
end

function slot0.changeVehicle(slot0)
end

function slot0.initComponents(slot0)
	slot0:addComp("vehiclemove", RoomVehicleMoveComp)
	slot0:addComp("vehiclefollow", RoomVehicleFollowComp)
	slot0:addComp("effect", RoomEffectComp)
	slot0:addComp("nightlight", RoomNightLightComp)
	slot0.nightlight:setEffectKey(RoomEnum.EffectKey.VehicleGOKey)
	slot0:addComp("cameraFollowTargetComp", RoomCameraFollowTargetComp)

	if slot0:getMO() and slot1.ownerType == RoomVehicleEnum.OwnerType.TransportSite then
		slot0:addComp("vehickleTransport", RoomVehicleTransportComp)
	end
end

function slot0.onStart(slot0)
	uv0.super.onStart(slot0)
end

function slot0.setLocalPos(slot0, slot1, slot2, slot3)
	transformhelper.setLocalPos(slot0.goTrs, slot1, slot2, slot3)
end

function slot0.getMO(slot0)
	return RoomMapVehicleModel.instance:getById(slot0.id)
end

function slot0.getVehicleMO(slot0)
	return slot0:getMO()
end

function slot0.setShow(slot0, slot1)
	slot0._isShow = slot1 and true or false

	gohelper.setActive(slot0.containerGO, slot1)

	if slot1 then
		slot0.vehiclemove:restart()
		slot0.vehiclefollow:restart()
	else
		slot0.vehiclemove:stop()
	end

	slot0.vehiclefollow:setShow(slot1)
end

function slot0.getIsShow(slot0)
	return slot0._isShow
end

function slot0.beforeDestroy(slot0)
	uv0.super.beforeDestroy(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.stop_amb_home, slot0.go)
end

function slot0.getMainEffectKey(slot0)
	return RoomEnum.EffectKey.VehicleGOKey
end

return slot0
