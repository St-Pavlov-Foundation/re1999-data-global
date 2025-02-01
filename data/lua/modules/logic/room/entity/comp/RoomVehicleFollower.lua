module("modules.logic.room.entity.comp.RoomVehicleFollower", package.seeall)

slot0 = class("RoomVehicleFollower")

function slot0.ctor(slot0, slot1)
	slot0.vehicleMoveComp = slot1
	slot0._cacheDataDic = {}
	slot0._pathPosList = {}
	slot0._childList = {}
end

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.__isDispose = false
	slot0._coypNameKey = slot4
	slot0.go = slot1
	slot0.goTrs = slot1.transform
	slot0.followDistance = slot3
	slot0._vehiceMeshRotate = slot5 or 0
	slot0.radius = slot2 or 0
	slot0._isVehiceForward = true
	slot0._goNightList = {}
end

function slot0.onEffectRebuild(slot0)
	slot1 = slot0.vehicleMoveComp.entity.effect

	if not string.nilorempty(slot0._coypNameKey) and slot1 and slot1:isHasEffectGOByKey(RoomEnum.EffectKey.VehicleGOKey) and gohelper.isNil(slot0._vehiceMeshGo) then
		if not gohelper.isNil(gohelper.findChild(slot1:getEffectGO(RoomEnum.EffectKey.VehicleGOKey), slot0._coypNameKey)) then
			slot0._vehiceMeshGo = gohelper.clone(slot3, slot0.go)

			transformhelper.setLocalPos(slot0._vehiceMeshGo.transform, 0, 0.04, 0)
			transformhelper.setLocalRotation(slot0._vehiceMeshGo.transform, 0, slot0:_getVehiceRotate(), 0)
			RoomHelper.getGameObjectsByNameInChildren(slot0._vehiceMeshGo, RoomEnum.EntityChildKey.NightLightGOKey, slot0._goNightList)
		elseif slot0.vehicleMoveComp:getVehicleMO() and slot4.config then
			logError(string.format("交通工具[%s-%s], 子节点[%s]找不到", slot4.config.name, slot4.config.id, slot0._coypNameKey))
		end
	end
end

function slot0.setParentFollower(slot0, slot1)
	slot0._parentFollower = slot1
end

function slot0.setVehiceForward(slot0, slot1)
	if slot0._isVehiceForward ~= slot1 then
		slot0._isVehiceForward = slot1

		if not gohelper.isNil(slot0._vehiceMeshGo) then
			transformhelper.setLocalRotation(slot0._vehiceMeshGo.transform, 0, slot0:_getVehiceRotate(), 0)
		end
	end
end

function slot0._getVehiceRotate(slot0)
	if slot0._isVehiceForward then
		return slot0._vehiceMeshRotate
	end

	return slot0._vehiceMeshRotate + 180
end

function slot0.addPathPos(slot0, slot1)
	table.insert(slot0._pathPosList, 1, slot1)
end

function slot0.setPathList(slot0, slot1)
	slot0._pathPosList = {}

	tabletool.addValues(slot0._pathPosList, slot1)
end

function slot0.moveByPathData(slot0)
	if slot0.vehicleMoveComp:getPathData():getPosCount() < 1 then
		return
	end

	slot2, slot3 = nil
	slot6 = slot0.followDistance - Vector3.Distance(slot0.vehicleMoveComp.targetTrs.position, slot1:getFirstPos())
	slot7 = slot6 - slot0.radius
	slot2 = (slot6 > 0 or Vector3.Lerp(slot4, slot1:getFirstPos(), slot0.followDistance / slot5)) and slot1:getPosByDistance(slot6)

	if slot0.radius > 0 then
		slot3 = (slot7 > 0 or Vector3.Lerp(slot4, slot1:getFirstPos(), (slot0.followDistance - slot0.radius) / slot5)) and slot1:getPosByDistance(slot7)
	end

	if slot2 then
		transformhelper.setPos(slot0.goTrs, slot2.x, slot2.y, slot2.z)
	end

	if slot3 then
		slot0.goTrs:LookAt(slot3)
	end
end

function slot0.nightLight(slot0, slot1)
	if slot0._goNightList then
		for slot5, slot6 in ipairs(slot0._goNightList) do
			gohelper.setActive(slot6, slot1)
		end
	end
end

function slot0.dispose(slot0)
	slot0.__isDispose = true
	slot0.go = nil
	slot0.goTrs = nil

	if slot0._vehiceMeshGo then
		gohelper.destroy(slot0._vehiceMeshGo)

		slot0._vehiceMeshGo = nil
	end

	if slot0.endGo then
		gohelper.destroy(slot0.endGo)

		slot0.endGo = nil
		slot0.endGoTrs = nil
	end

	slot0._parentFollower = nil

	if slot0._goNightList then
		for slot4 in pairs(slot0._goNightList) do
			rawset(slot0._goNightList, slot4, nil)
		end

		slot0._goNightList = nil
	end
end

return slot0
