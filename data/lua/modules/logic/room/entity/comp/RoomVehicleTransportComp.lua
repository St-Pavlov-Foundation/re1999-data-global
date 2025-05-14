module("modules.logic.room.entity.comp.RoomVehicleTransportComp", package.seeall)

local var_0_0 = class("RoomVehicleTransportComp", RoomBaseEffectKeyComp)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goTrs = arg_1_1.transform
	arg_1_0._nextRunTime = 0

	arg_1_0:initTransport()
	TaskDispatcher.runRepeat(arg_1_0._onCheckTransportRepeate, arg_1_0, 0.1)

	local var_1_0, var_1_1, var_1_2 = arg_1_0:getVehicleMO():findNextWeightNode()

	transformhelper.setLocalRotation(arg_1_0.goTrs, 0, (var_1_2 - 1) * 60, 0)
end

function var_0_0.initTransport(arg_2_0)
	local var_2_0 = arg_2_0:getVehicleMO()
	local var_2_1 = var_2_0 and var_2_0:getReplaceDefideCfg()

	arg_2_0._siteType = var_2_0.ownerId
	arg_2_0._useType = var_2_1 and var_2_1.useType
	arg_2_0._takeoffTime = var_2_1 and var_2_1.takeoffTime or 5000
	arg_2_0._takeoffTime = tonumber(arg_2_0._takeoffTime) * 0.001
	arg_2_0._vehicleCfgId = var_2_1 and var_2_1.id
	arg_2_0._waterOffsetY = var_2_1 and var_2_1.waterOffseY or -80
	arg_2_0._waterOffsetY = tonumber(arg_2_0._waterOffsetY) * 0.001
	arg_2_0._fromType, arg_2_0._toType = RoomTransportHelper.getSiteFromToByType(arg_2_0._siteType)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0.entity:registerCallback(RoomEvent.VehicleStartMove, arg_3_0._onVehicleStartMove, arg_3_0)
	arg_3_0.entity:registerCallback(RoomEvent.VehicleStopMove, arg_3_0._onVehicleStopMove, arg_3_0)
	arg_3_0.entity:registerCallback(RoomEvent.VehicleIdChange, arg_3_0._onVehicleIdChange, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportCritterChanged, arg_3_0._onCritterChanged, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportCritterChanged, arg_4_0._onCritterChanged, arg_4_0)
end

function var_0_0.beforeDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onDelayVheicleMove, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onCheckTransportRepeate, arg_5_0)
	arg_5_0:removeEventListeners()
end

function var_0_0.getVehicleMO(arg_6_0)
	return arg_6_0.entity:getVehicleMO()
end

function var_0_0.getTransportPathMO(arg_7_0)
	return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(arg_7_0._fromType, arg_7_0._toType)
end

function var_0_0._isHasCritter(arg_8_0)
	local var_8_0 = arg_8_0:getTransportPathMO()

	if var_8_0 and var_8_0.critterUid and var_8_0.critterUid ~= 0 then
		return true
	end

	return false
end

function var_0_0._isBuildingAreaWorking(arg_9_0, arg_9_1)
	return RoomBuildingAreaHelper.isHasWorkingByType(arg_9_1)
end

function var_0_0._isTransportWorking(arg_10_0)
	if not arg_10_0:_isHasCritter() then
		return false
	end

	if arg_10_0:_isBuildingAreaWorking(arg_10_0._fromType) or arg_10_0:_isBuildingAreaWorking(arg_10_0._toType) then
		return true
	end

	return false
end

function var_0_0._setProdeuce(arg_11_0, arg_11_1)
	arg_11_0._lastIsProduce = arg_11_1

	arg_11_0:_setActiveChildByKeyName(arg_11_1, RoomEnum.EntityChildKey.ProduceGOKey)
end

function var_0_0._setActiveChildByKeyName(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0.entity.effect:getGameObjectsByName(arg_12_0._effectKey, arg_12_2)

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			gohelper.setActive(iter_12_1, arg_12_1)
		end
	end
end

function var_0_0._onCritterChanged(arg_13_0)
	local var_13_0 = arg_13_0:_isHasCritter()

	if arg_13_0._lastIsProduce ~= var_13_0 then
		arg_13_0:_setProdeuce(var_13_0)
	end
end

function var_0_0._onVehicleStartMove(arg_14_0)
	local var_14_0 = arg_14_0._isWorking

	arg_14_0._isWorking = arg_14_0:_isTransportWorking()

	if not arg_14_0._isWorking then
		arg_14_0._isMove = false

		arg_14_0.entity.vehiclemove:stop()

		return
	end

	arg_14_0._isMove = true

	if arg_14_0._useType == RoomVehicleEnum.UseType.Aircraft then
		if arg_14_0._aircraftIsLand ~= false and arg_14_0.entity.effect:isHasEffectGOByKey(arg_14_0._effectKey) then
			if not arg_14_0.entity.vehiclemove:getIsStop() then
				arg_14_0.entity.vehiclemove:stop()
			end

			local var_14_1 = math.max(0.1, arg_14_0._takeoffTime)

			arg_14_0:_setDelayRunTime(var_14_1)
			TaskDispatcher.cancelTask(arg_14_0._onDelayVheicleMove, arg_14_0)
			TaskDispatcher.runDelay(arg_14_0._onDelayVheicleMove, arg_14_0, var_14_1)

			arg_14_0._aircraftIsLand = false

			arg_14_0.entity.effect:playEffectAnimator(arg_14_0._effectKey, RoomBuildingEnum.AnimName.Takeoff)
		end
	elseif not var_14_0 and arg_14_0.entity:getIsShow() then
		arg_14_0.entity.vehiclemove:restart()
	end
end

function var_0_0._onDelayVheicleMove(arg_15_0)
	if arg_15_0.entity and arg_15_0.entity.vehiclemove and arg_15_0.entity:getIsShow() then
		arg_15_0.entity.vehiclemove:restart()
	end
end

function var_0_0._onCheckTransportRepeate(arg_16_0)
	if not arg_16_0.entity:getIsShow() then
		return
	end

	if not arg_16_0._isWorking then
		if arg_16_0:_isTransportWorking() and not arg_16_0:_checkDelayRunTime() then
			arg_16_0:_onVehicleStartMove()
		end

		if arg_16_0._isLastRiver ~= nil then
			return
		end
	end

	if arg_16_0._useType ~= RoomVehicleEnum.UseType.Aircraft then
		local var_16_0 = arg_16_0:checkIsInRiver()

		arg_16_0:_setIsRiver(var_16_0)
	end
end

function var_0_0.checkIsInRiver(arg_17_0)
	local var_17_0, var_17_1, var_17_2 = transformhelper.getPos(arg_17_0.goTrs)
	local var_17_3, var_17_4 = HexMath.posXYToRoundHexYX(var_17_0, var_17_2, RoomBlockEnum.BlockSize)
	local var_17_5 = RoomMapBlockModel.instance:getBlockMO(var_17_3, var_17_4)
	local var_17_6 = false

	if var_17_5 and var_17_5:hasRiver() then
		var_17_6 = true
	end

	return var_17_6
end

function var_0_0._onVehicleStopMove(arg_18_0, arg_18_1)
	arg_18_0._isMove = false

	if arg_18_0._useType == RoomVehicleEnum.UseType.Aircraft and arg_18_0._aircraftIsLand ~= true and arg_18_0.entity.effect:isHasEffectGOByKey(arg_18_0._effectKey) then
		arg_18_0._aircraftIsLand = true

		arg_18_0.entity.effect:playEffectAnimator(arg_18_0._effectKey, RoomBuildingEnum.AnimName.Landing)
	end

	arg_18_0:_setDelayRunTime(arg_18_1)
end

function var_0_0._onVehicleIdChange(arg_19_0)
	arg_19_0.entity.vehiclemove:initVehicleParam()
end

function var_0_0._isCurNodeIsEndNode(arg_20_0)
	local var_20_0 = arg_20_0:getVehicleMO() or arg_20_0._mo

	if var_20_0 then
		local var_20_1 = var_20_0:getCurNode()

		if var_20_1 and var_20_1:isEndNode() then
			return true
		end
	end

	return false
end

function var_0_0._setDelayRunTime(arg_21_0, arg_21_1)
	if arg_21_1 then
		arg_21_0._nextRunTime = Time.time + arg_21_1
	end
end

function var_0_0._checkDelayRunTime(arg_22_0)
	if arg_22_0._nextRunTime > Time.time then
		return true
	end

	return false
end

function var_0_0._setIsRiver(arg_23_0, arg_23_1)
	if arg_23_0._isLastRiver ~= arg_23_1 then
		arg_23_0._isLastRiver = arg_23_1

		arg_23_0:_updateIsRiver()

		local var_23_0 = arg_23_0:getVehicleMO()

		if var_23_0 then
			var_23_0:setReplaceType(arg_23_1 and RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land)
			arg_23_0.entity:refreshVehicle()
		end
	end
end

function var_0_0._updateIsRiver(arg_24_0)
	local var_24_0 = 0

	if arg_24_0._useType ~= RoomVehicleEnum.UseType.Aircraft then
		if arg_24_0._isLastRiver then
			var_24_0 = arg_24_0._waterOffsetY
		end

		arg_24_0:_setActiveChildByKeyName(arg_24_0._isLastRiver, RoomEnum.EntityChildKey.WaterBlockEffectGOKey)
	end

	transformhelper.setLocalPos(arg_24_0.entity.containerGOTrs, 0, var_24_0 or 0, 0)
end

function var_0_0.onRebuildEffectGO(arg_25_0)
	arg_25_0:initTransport()

	local var_25_0 = arg_25_0:_isHasCritter()

	arg_25_0:_setProdeuce(var_25_0)
	arg_25_0:_updateIsRiver()

	if arg_25_0._useType == RoomVehicleEnum.UseType.Aircraft then
		if arg_25_0._isMove then
			arg_25_0.entity.effect:playEffectAnimator(arg_25_0._effectKey, RoomBuildingEnum.AnimName.Produce)
		end

		transformhelper.setLocalPos(arg_25_0.entity.containerGOTrs, 0, 0, 0)
	else
		arg_25_0.entity.effect:playEffectAnimator(arg_25_0._effectKey, RoomBuildingEnum.AnimName.Produce)
	end

	arg_25_0:_onDelayVheicleMove()
end

return var_0_0
