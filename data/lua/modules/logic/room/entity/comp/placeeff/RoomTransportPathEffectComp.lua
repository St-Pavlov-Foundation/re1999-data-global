module("modules.logic.room.entity.comp.placeeff.RoomTransportPathEffectComp", package.seeall)

local var_0_0 = class("RoomTransportPathEffectComp", RoomBaseBlockEffectComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0.entity = arg_1_1
	arg_1_0._effectPrefixKey = "transport_path"
	arg_1_0._blockParamPools = {}
	arg_1_0.delayTaskTime = 0.05
	arg_1_0._effectId = {
		SiteCollect = 4,
		SiteProcess = 5,
		BlockManufacture = 3,
		BlockCollect = 1,
		BlockNotCan = 8,
		BlockProcess = 2,
		SiteManufacture = 6
	}
	arg_1_0._effectResMap = {
		[arg_1_0._effectId.BlockCollect] = RoomScenePreloader.ResEffectBlue01,
		[arg_1_0._effectId.BlockProcess] = RoomScenePreloader.ResEffectYellow01,
		[arg_1_0._effectId.BlockManufacture] = RoomScenePreloader.ResEffectGreen01,
		[arg_1_0._effectId.SiteCollect] = RoomScenePreloader.ResEffectBlue02,
		[arg_1_0._effectId.SiteProcess] = RoomScenePreloader.ResEffectYellow02,
		[arg_1_0._effectId.SiteManufacture] = RoomScenePreloader.ResEffectGreen02,
		[arg_1_0._effectId.BlockNotCan] = RoomScenePreloader.ResEffectRed01
	}
	arg_1_0._stieType2IdMap = {
		[RoomBuildingEnum.BuildingType.Collect] = arg_1_0._effectId.SiteCollect,
		[RoomBuildingEnum.BuildingType.Process] = arg_1_0._effectId.SiteProcess,
		[RoomBuildingEnum.BuildingType.Manufacture] = arg_1_0._effectId.SiteManufacture
	}
	arg_1_0._buildingType2IdMap = {
		[RoomBuildingEnum.BuildingType.Collect] = arg_1_0._effectId.BlockCollect,
		[RoomBuildingEnum.BuildingType.Process] = arg_1_0._effectId.BlockProcess,
		[RoomBuildingEnum.BuildingType.Manufacture] = arg_1_0._effectId.BlockManufacture
	}
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._tRoomResourceModel = RoomResourceModel.instance
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathConfirmChange, arg_3_0._refreshConfirmEffect, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, arg_3_0.startWaitRunDelayTask, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, arg_3_0.startWaitRunDelayTask, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathConfirmChange, arg_4_0._refreshConfirmEffect, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, arg_4_0.startWaitRunDelayTask, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, arg_4_0.startWaitRunDelayTask, arg_4_0)
end

function var_0_0.onRunDelayTask(arg_5_0)
	arg_5_0:_refreshConfirmEffect()
end

function var_0_0._refreshConfirmEffect(arg_6_0)
	local var_6_0 = arg_6_0:_getBlackIndexDict()
	local var_6_1
	local var_6_2
	local var_6_3 = arg_6_0.entity.effect
	local var_6_4 = arg_6_0._lastIndexDict

	arg_6_0._lastIndexDict = var_6_0
	arg_6_0._tRoomResourceModel = RoomResourceModel.instance

	if var_6_0 then
		for iter_6_0, iter_6_1 in pairs(var_6_0) do
			local var_6_5 = var_6_4 and var_6_4[iter_6_0]

			if iter_6_1 and not arg_6_0:_checkParamsSame(iter_6_1, var_6_5) then
				local var_6_6 = arg_6_0:getEffectKeyById(iter_6_0)

				if var_6_1 == nil then
					var_6_1 = {}
				end

				local var_6_7, var_6_8 = HexMath.hexXYToPosXY(iter_6_1.hexPoint.x, iter_6_1.hexPoint.y, RoomBlockEnum.BlockSize)

				var_6_1[var_6_6] = {
					res = arg_6_0._effectResMap[iter_6_1.effectId],
					localPos = Vector3(var_6_7, 0, var_6_8)
				}
			end
		end
	end

	if var_6_4 then
		for iter_6_2, iter_6_3 in pairs(var_6_4) do
			if not var_6_0 or not var_6_0[iter_6_2] then
				local var_6_9 = arg_6_0:getEffectKeyById(iter_6_2)

				if var_6_3:isHasKey(var_6_9) then
					if var_6_2 == nil then
						var_6_2 = {}
					end

					table.insert(var_6_2, var_6_9)
				end
			end

			arg_6_0:_pushParam(iter_6_3)
		end
	end

	if var_6_1 then
		var_6_3:addParams(var_6_1)
		var_6_3:refreshEffect()
	end

	if var_6_2 then
		arg_6_0:removeParamsAndPlayAnimator(var_6_2, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function var_0_0._getBlackIndexDict(arg_7_0)
	if not RoomTransportController.instance:isTransportPathShow() then
		return nil
	end

	local var_7_0 = RoomMapTransportPathModel.instance
	local var_7_1 = RoomTransportHelper.getPathBuildingTypes(var_7_0:getSelectBuildingType())

	if not var_7_1 or #var_7_1 < 1 then
		return nil
	end

	local var_7_2 = {}
	local var_7_3 = RoomMapBuildingAreaModel.instance
	local var_7_4 = RoomMapHexPointModel.instance

	for iter_7_0 = 1, #var_7_1 do
		local var_7_5 = var_7_1[iter_7_0]
		local var_7_6 = var_7_0:getSiteHexPointByType(var_7_5)

		if var_7_6 then
			arg_7_0:_addParamDict(var_7_2, var_7_6, arg_7_0._buildingType2IdMap[var_7_5], true)
		end
	end

	for iter_7_1 = 1, #var_7_1 do
		local var_7_7 = var_7_1[iter_7_1]
		local var_7_8 = var_7_3:getAreaMOByBType(var_7_7)

		if var_7_8 and var_7_8.mainBuildingMO then
			local var_7_9 = var_7_8.mainBuildingMO.hexPoint
			local var_7_10 = RoomMapModel.instance:getBuildingPointList(var_7_8.mainBuildingMO.buildingId, var_7_8.mainBuildingMO.rotate)

			for iter_7_2, iter_7_3 in ipairs(var_7_10) do
				local var_7_11 = var_7_4:getHexPoint(iter_7_3.x + var_7_9.x, iter_7_3.y + var_7_9.y)

				arg_7_0:_addParamDict(var_7_2, var_7_11, arg_7_0._buildingType2IdMap[var_7_7], true)
			end
		end
	end

	local var_7_12 = RoomMapBlockModel.instance
	local var_7_13 = var_7_12:getFullBlockMOList()
	local var_7_14 = RoomMapTransportPathModel.instance:getIsRemoveBuilding()

	for iter_7_4, iter_7_5 in ipairs(var_7_13) do
		if not RoomTransportHelper.canPathByBlockMO(iter_7_5, var_7_14) then
			local var_7_15 = iter_7_5.hexPoint

			arg_7_0:_addParamDict(var_7_2, var_7_15, arg_7_0._effectId.BlockNotCan, true)
		end
	end

	local var_7_16 = arg_7_0._stieType2IdMap
	local var_7_17 = var_7_0.instance:getTempTransportPathMO() or var_7_0:getTransportPathMOBy2Type(var_7_1[1], var_7_1[2])

	if var_7_17 and var_7_17:isLinkFinish() then
		var_7_16 = arg_7_0._buildingType2IdMap
	end

	for iter_7_6 = 1, #var_7_1 do
		local var_7_18 = var_7_1[iter_7_6]
		local var_7_19 = var_7_3:getAreaMOByBType(var_7_18)
		local var_7_20 = var_7_19 and var_7_19:getRangesHexPointList()

		if var_7_20 then
			for iter_7_7, iter_7_8 in ipairs(var_7_20) do
				local var_7_21 = var_7_12:getBlockMO(iter_7_8.x, iter_7_8.y)

				if var_7_21 and var_7_21:isInMapBlock() then
					arg_7_0:_addParamDict(var_7_2, iter_7_8, var_7_16[var_7_18], false)
				end
			end
		end
	end

	return var_7_2
end

function var_0_0._checkParamsSame(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == nil or arg_8_2 == nil then
		return false
	end

	if arg_8_1.effectId ~= arg_8_2.effectId or arg_8_1.hexPoint ~= arg_8_2.hexPoint then
		return false
	end

	return true
end

function var_0_0._addParamDict(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	local var_9_0 = arg_9_0._tRoomResourceModel:getIndexByXY(arg_9_2.x, arg_9_2.y) * 10
	local var_9_1 = arg_9_1[var_9_0]

	if var_9_1 and (var_9_1.isOnly or arg_9_4 or var_9_1.effectId == arg_9_3) then
		return
	end

	if var_9_1 then
		while arg_9_1[var_9_0] do
			var_9_0 = var_9_0 + 1
		end
	end

	local var_9_2 = arg_9_0:_popParam()

	var_9_2.effectId = arg_9_3
	var_9_2.isOnly = arg_9_4
	var_9_2.index = var_9_0
	var_9_2.hexPoint = arg_9_2
	arg_9_1[var_9_0] = var_9_2
end

function var_0_0._popParam(arg_10_0)
	local var_10_0
	local var_10_1 = #arg_10_0._blockParamPools

	if var_10_1 > 0 then
		var_10_0 = arg_10_0._blockParamPools[var_10_1]

		table.remove(arg_10_0._blockParamPools, var_10_1)
	else
		var_10_0 = {}
	end

	return var_10_0
end

function var_0_0._pushParam(arg_11_0, arg_11_1)
	if arg_11_1 then
		table.insert(arg_11_0._blockParamPools, arg_11_1)
	end
end

return var_0_0
