module("modules.logic.room.entity.comp.RoomVehicleTransportComp", package.seeall)

slot0 = class("RoomVehicleTransportComp", RoomBaseEffectKeyComp)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goTrs = slot1.transform
	slot0._nextRunTime = 0

	slot0:initTransport()
	TaskDispatcher.runRepeat(slot0._onCheckTransportRepeate, slot0, 0.1)

	slot3, slot4, slot5 = slot0:getVehicleMO():findNextWeightNode()

	transformhelper.setLocalRotation(slot0.goTrs, 0, (slot5 - 1) * 60, 0)
end

function slot0.initTransport(slot0)
	slot2 = slot0:getVehicleMO() and slot1:getReplaceDefideCfg()
	slot0._siteType = slot1.ownerId
	slot0._useType = slot2 and slot2.useType
	slot0._takeoffTime = slot2 and slot2.takeoffTime or 5000
	slot0._takeoffTime = tonumber(slot0._takeoffTime) * 0.001
	slot0._vehicleCfgId = slot2 and slot2.id
	slot0._waterOffsetY = slot2 and slot2.waterOffseY or -80
	slot0._waterOffsetY = tonumber(slot0._waterOffsetY) * 0.001
	slot0._fromType, slot0._toType = RoomTransportHelper.getSiteFromToByType(slot0._siteType)
end

function slot0.addEventListeners(slot0)
	slot0.entity:registerCallback(RoomEvent.VehicleStartMove, slot0._onVehicleStartMove, slot0)
	slot0.entity:registerCallback(RoomEvent.VehicleStopMove, slot0._onVehicleStopMove, slot0)
	slot0.entity:registerCallback(RoomEvent.VehicleIdChange, slot0._onVehicleIdChange, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportCritterChanged, slot0._onCritterChanged, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportCritterChanged, slot0._onCritterChanged, slot0)
end

function slot0.beforeDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayVheicleMove, slot0)
	TaskDispatcher.cancelTask(slot0._onCheckTransportRepeate, slot0)
	slot0:removeEventListeners()
end

function slot0.getVehicleMO(slot0)
	return slot0.entity:getVehicleMO()
end

function slot0.getTransportPathMO(slot0)
	return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot0._fromType, slot0._toType)
end

function slot0._isHasCritter(slot0)
	if slot0:getTransportPathMO() and slot1.critterUid and slot1.critterUid ~= 0 then
		return true
	end

	return false
end

function slot0._isBuildingAreaWorking(slot0, slot1)
	return RoomBuildingAreaHelper.isHasWorkingByType(slot1)
end

function slot0._isTransportWorking(slot0)
	if not slot0:_isHasCritter() then
		return false
	end

	if slot0:_isBuildingAreaWorking(slot0._fromType) or slot0:_isBuildingAreaWorking(slot0._toType) then
		return true
	end

	return false
end

function slot0._setProdeuce(slot0, slot1)
	slot0._lastIsProduce = slot1

	slot0:_setActiveChildByKeyName(slot1, RoomEnum.EntityChildKey.ProduceGOKey)
end

function slot0._setActiveChildByKeyName(slot0, slot1, slot2)
	if slot0.entity.effect:getGameObjectsByName(slot0._effectKey, slot2) then
		for slot7, slot8 in ipairs(slot3) do
			gohelper.setActive(slot8, slot1)
		end
	end
end

function slot0._onCritterChanged(slot0)
	if slot0._lastIsProduce ~= slot0:_isHasCritter() then
		slot0:_setProdeuce(slot1)
	end
end

function slot0._onVehicleStartMove(slot0)
	slot1 = slot0._isWorking
	slot0._isWorking = slot0:_isTransportWorking()

	if not slot0._isWorking then
		slot0._isMove = false

		slot0.entity.vehiclemove:stop()

		return
	end

	slot0._isMove = true

	if slot0._useType == RoomVehicleEnum.UseType.Aircraft then
		if slot0._aircraftIsLand ~= false and slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) then
			if not slot0.entity.vehiclemove:getIsStop() then
				slot0.entity.vehiclemove:stop()
			end

			slot2 = math.max(0.1, slot0._takeoffTime)

			slot0:_setDelayRunTime(slot2)
			TaskDispatcher.cancelTask(slot0._onDelayVheicleMove, slot0)
			TaskDispatcher.runDelay(slot0._onDelayVheicleMove, slot0, slot2)

			slot0._aircraftIsLand = false

			slot0.entity.effect:playEffectAnimator(slot0._effectKey, RoomBuildingEnum.AnimName.Takeoff)
		end
	elseif not slot1 and slot0.entity:getIsShow() then
		slot0.entity.vehiclemove:restart()
	end
end

function slot0._onDelayVheicleMove(slot0)
	if slot0.entity and slot0.entity.vehiclemove and slot0.entity:getIsShow() then
		slot0.entity.vehiclemove:restart()
	end
end

function slot0._onCheckTransportRepeate(slot0)
	if not slot0.entity:getIsShow() then
		return
	end

	if not slot0._isWorking then
		if slot0:_isTransportWorking() and not slot0:_checkDelayRunTime() then
			slot0:_onVehicleStartMove()
		end

		if slot0._isLastRiver ~= nil then
			return
		end
	end

	if slot0._useType ~= RoomVehicleEnum.UseType.Aircraft then
		slot0:_setIsRiver(slot0:checkIsInRiver())
	end
end

function slot0.checkIsInRiver(slot0)
	slot1, slot2, slot3 = transformhelper.getPos(slot0.goTrs)
	slot4, slot5 = HexMath.posXYToRoundHexYX(slot1, slot3, RoomBlockEnum.BlockSize)
	slot7 = false

	if RoomMapBlockModel.instance:getBlockMO(slot4, slot5) and slot6:hasRiver() then
		slot7 = true
	end

	return slot7
end

function slot0._onVehicleStopMove(slot0, slot1)
	slot0._isMove = false

	if slot0._useType == RoomVehicleEnum.UseType.Aircraft and slot0._aircraftIsLand ~= true and slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) then
		slot0._aircraftIsLand = true

		slot0.entity.effect:playEffectAnimator(slot0._effectKey, RoomBuildingEnum.AnimName.Landing)
	end

	slot0:_setDelayRunTime(slot1)
end

function slot0._onVehicleIdChange(slot0)
	slot0.entity.vehiclemove:initVehicleParam()
end

function slot0._isCurNodeIsEndNode(slot0)
	if (slot0:getVehicleMO() or slot0._mo) and slot1:getCurNode() and slot2:isEndNode() then
		return true
	end

	return false
end

function slot0._setDelayRunTime(slot0, slot1)
	if slot1 then
		slot0._nextRunTime = Time.time + slot1
	end
end

function slot0._checkDelayRunTime(slot0)
	if Time.time < slot0._nextRunTime then
		return true
	end

	return false
end

function slot0._setIsRiver(slot0, slot1)
	if slot0._isLastRiver ~= slot1 then
		slot0._isLastRiver = slot1

		slot0:_updateIsRiver()

		if slot0:getVehicleMO() then
			slot2:setReplaceType(slot1 and RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land)
			slot0.entity:refreshVehicle()
		end
	end
end

function slot0._updateIsRiver(slot0)
	slot1 = 0

	if slot0._useType ~= RoomVehicleEnum.UseType.Aircraft then
		if slot0._isLastRiver then
			slot1 = slot0._waterOffsetY
		end

		slot0:_setActiveChildByKeyName(slot0._isLastRiver, RoomEnum.EntityChildKey.WaterBlockEffectGOKey)
	end

	transformhelper.setLocalPos(slot0.entity.containerGOTrs, 0, slot1 or 0, 0)
end

function slot0.onRebuildEffectGO(slot0)
	slot0:initTransport()
	slot0:_setProdeuce(slot0:_isHasCritter())
	slot0:_updateIsRiver()

	if slot0._useType == RoomVehicleEnum.UseType.Aircraft then
		if slot0._isMove then
			slot0.entity.effect:playEffectAnimator(slot0._effectKey, RoomBuildingEnum.AnimName.Produce)
		end

		transformhelper.setLocalPos(slot0.entity.containerGOTrs, 0, 0, 0)
	else
		slot0.entity.effect:playEffectAnimator(slot0._effectKey, RoomBuildingEnum.AnimName.Produce)
	end

	slot0:_onDelayVheicleMove()
end

return slot0
