module("modules.logic.room.entity.comp.placeeff.RoomTransportPathLinkEffectComp", package.seeall)

local var_0_0 = class("RoomTransportPathLinkEffectComp", RoomBaseBlockEffectComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0.entity = arg_1_1
	arg_1_0._effectPrefixKey = "transport_path_line"
	arg_1_0._lineParamPools = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._tRoomResourceModel = RoomResourceModel.instance

	arg_2_0:startWaitRunDelayTask()
end

function var_0_0.addEventListeners(arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathLineChanged, arg_3_0._refreshLineEffect, arg_3_0)
	RoomController.instance:registerCallback(RoomEvent.OnSwitchModeDone, arg_3_0.startWaitRunDelayTask, arg_3_0)
	RoomController.instance:registerCallback(RoomEvent.OnLateInitDone, arg_3_0.startWaitRunDelayTask, arg_3_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, arg_3_0.startWaitRunDelayTask, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathLineChanged, arg_4_0._refreshLineEffect, arg_4_0)
	RoomController.instance:unregisterCallback(RoomEvent.OnSwitchModeDone, arg_4_0.startWaitRunDelayTask, arg_4_0)
	RoomController.instance:unregisterCallback(RoomEvent.OnLateInitDone, arg_4_0.startWaitRunDelayTask, arg_4_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, arg_4_0.startWaitRunDelayTask, arg_4_0)
end

function var_0_0.onRunDelayTask(arg_5_0)
	arg_5_0:_refreshLineEffect()
end

function var_0_0._refreshLineEffect(arg_6_0)
	local var_6_0 = arg_6_0:_getLineTypeIndexDict()
	local var_6_1
	local var_6_2
	local var_6_3 = arg_6_0.entity.effect
	local var_6_4 = arg_6_0._lastIndexDict

	arg_6_0._lastIndexDict = var_6_0

	for iter_6_0, iter_6_1 in pairs(var_6_0) do
		local var_6_5 = var_6_4 and var_6_4[iter_6_0]

		if iter_6_1 and not arg_6_0:_checkParamsSame(iter_6_1, var_6_5) then
			local var_6_6 = arg_6_0:getEffectKeyById(iter_6_0)

			if var_6_1 == nil then
				var_6_1 = {}
			end

			local var_6_7 = HexMath.hexToPosition(iter_6_1.hexPoint, RoomBlockEnum.BlockSize)

			var_6_1[var_6_6] = {
				res = RoomResHelper.getTransportPathPath(iter_6_1.lineType, iter_6_1.styleId),
				localPos = Vector3(var_6_7.x, 0.111, var_6_7.y),
				localRotation = Vector3(0, iter_6_1.rotate * 60, 0)
			}
		end
	end

	if var_6_4 then
		for iter_6_2, iter_6_3 in pairs(var_6_4) do
			if not var_6_0 or not var_6_0[iter_6_2] then
				local var_6_8 = arg_6_0:getEffectKeyById(iter_6_2)

				if var_6_3:isHasKey(var_6_8) then
					if var_6_2 == nil then
						var_6_2 = {}
					end

					table.insert(var_6_2, var_6_8)
				end
			end

			arg_6_0:_pushLineParam(iter_6_3)
		end
	end

	if var_6_1 then
		var_6_3:addParams(var_6_1)
		var_6_3:refreshEffect()
	end

	if var_6_2 then
		var_6_3:removeParams(var_6_2)
		var_6_3:refreshEffect()
	end
end

function var_0_0._getResPath(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 and arg_7_1:checkHexPoint(arg_7_2) then
		-- block empty
	end
end

function var_0_0._checkParamsSame(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == nil or arg_8_2 == nil then
		return false
	end

	if arg_8_1.rotate ~= arg_8_2.rotate or arg_8_1.hexPoint ~= arg_8_2.hexPoint or arg_8_1.lineType ~= arg_8_2.lineType or arg_8_1.styleId ~= arg_8_2.styleId then
		return false
	end

	return true
end

function var_0_0._getSelectPathMO(arg_9_0)
	local var_9_0 = RoomMapTransportPathModel.instance:getTempTransportPathMO()

	if var_9_0 then
		return var_9_0
	end

	local var_9_1 = RoomMapTransportPathModel.instance:getSelectBuildingType()

	if var_9_1 then
		local var_9_2, var_9_3 = RoomTransportHelper.getSiteFromToByType(var_9_1)

		var_9_0 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_9_2, var_9_3)
	end

	return var_9_0
end

function var_0_0._getLineTypeIndexDict(arg_10_0)
	local var_10_0 = {}
	local var_10_1 = arg_10_0:_getSelectPathMO()
	local var_10_2 = RoomMapTransportPathModel.instance:getList()
	local var_10_3
	local var_10_4 = false
	local var_10_5

	if RoomController.instance:isObMode() then
		var_10_5 = {}
		var_10_4 = true
		var_10_3 = RoomTransportPathEnum.StyleId.ObWater
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_6 = RoomTransportPathEnum.StyleId.NoLink

		if iter_10_1:isLinkFinish() then
			var_10_6 = RoomTransportPathEnum.StyleId.EditLink

			if var_10_1 == iter_10_1 then
				var_10_6 = RoomTransportPathEnum.StyleId.Normal
			end
		end

		if var_10_4 then
			var_10_6 = RoomTransportPathEnum.StyleId.ObLink

			arg_10_0:_addSlotHexPointDict(var_10_5, iter_10_1)
		end

		arg_10_0:_addLineParamDict(var_10_0, iter_10_1:getHexPointList(), var_10_6, var_10_3, var_10_4)
	end

	if var_10_5 then
		for iter_10_2, iter_10_3 in pairs(var_10_5) do
			local var_10_7 = RoomTransportPathEnum.StyleId.ObLink

			if var_10_3 and arg_10_0:_isWaterBlock(iter_10_3.hexPoint) then
				var_10_7 = var_10_3
			end

			arg_10_0:_addHexPintLineParamDict(var_10_0, var_10_7, iter_10_3.hexPoint, iter_10_3.prevHexPoint, iter_10_3.nextHexPoint)
		end
	end

	return var_10_0
end

function var_0_0._addSlotHexPointDict(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2:getHexPointList()

	arg_11_0:_addLinkHexPointDict(arg_11_1, var_11_0[1], var_11_0[2])
	arg_11_0:_addLinkHexPointDict(arg_11_1, var_11_0[#var_11_0], var_11_0[#var_11_0 - 1])
end

function var_0_0._addLinkHexPointDict(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0._tRoomResourceModel:getIndexByXY(arg_12_2.x, arg_12_2.y)

	if arg_12_1[var_12_0] then
		arg_12_1[var_12_0].nextHexPoint = arg_12_3
	else
		arg_12_1[var_12_0] = {}
		arg_12_1[var_12_0].hexPoint = arg_12_2
		arg_12_1[var_12_0].prevHexPoint = arg_12_3
	end
end

function var_0_0._addLineParamDict(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	if arg_13_2 and #arg_13_2 > 0 then
		arg_13_3 = arg_13_3 or RoomTransportPathEnum.StyleId.Normal
		arg_13_2 = arg_13_2 or {}

		local var_13_0 = 1
		local var_13_1 = #arg_13_2

		if arg_13_5 == true then
			var_13_0 = var_13_0 + 1
			var_13_1 = var_13_1 - 1
		end

		for iter_13_0 = var_13_0, var_13_1 do
			local var_13_2 = arg_13_2[iter_13_0]
			local var_13_3 = arg_13_2[iter_13_0 - 1]
			local var_13_4 = arg_13_2[iter_13_0 + 1]

			if arg_13_4 and arg_13_0:_isWaterBlock(var_13_2) then
				arg_13_0:_addHexPintLineParamDict(arg_13_1, arg_13_4, var_13_2, var_13_3, var_13_4)
			else
				arg_13_0:_addHexPintLineParamDict(arg_13_1, arg_13_3, var_13_2, var_13_3, var_13_4)
			end
		end
	end
end

function var_0_0._addHexPintLineParamDict(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0, var_14_1 = RoomTransportPathLinkHelper.getPtahLineType(arg_14_3, arg_14_4, arg_14_5)

	if var_14_0 and var_14_1 then
		local var_14_2 = arg_14_0._tRoomResourceModel:getIndexByXY(arg_14_3.x, arg_14_3.y) * 10

		if arg_14_1[var_14_2] then
			while arg_14_1[var_14_2] do
				var_14_2 = var_14_2 + 1
			end
		end

		local var_14_3 = arg_14_0:_popLineParam()

		var_14_3.lineType = var_14_0
		var_14_3.rotate = var_14_1 or 0
		var_14_3.hexPoint = arg_14_3
		var_14_3.styleId = arg_14_2
		arg_14_1[var_14_2] = var_14_3
	end
end

function var_0_0._isWaterBlock(arg_15_0, arg_15_1)
	local var_15_0 = RoomMapBlockModel.instance:getBlockMO(arg_15_1.x, arg_15_1.y)

	if var_15_0 and var_15_0:hasRiver() then
		return true
	end

	return false
end

function var_0_0._popLineParam(arg_16_0)
	local var_16_0
	local var_16_1 = #arg_16_0._lineParamPools

	if var_16_1 > 0 then
		var_16_0 = arg_16_0._lineParamPools[var_16_1]

		table.remove(arg_16_0._lineParamPools, var_16_1)
	else
		var_16_0 = {}
	end

	return var_16_0
end

function var_0_0._pushLineParam(arg_17_0, arg_17_1)
	if arg_17_1 then
		table.insert(arg_17_0._lineParamPools, arg_17_1)
	end
end

return var_0_0
