module("modules.logic.room.entity.comp.placeeff.RoomPlaceBlockEffectComp", package.seeall)

local var_0_0 = class("RoomPlaceBlockEffectComp", RoomBaseBlockEffectComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._hexPointList = {}

	tabletool.addValues(arg_1_0._hexPointList, RoomMapHexPointModel.instance:getHexPointList())
end

function var_0_0.addEventListeners(arg_2_0)
	RoomMapController.instance:registerCallback(RoomEvent.SelectBlock, arg_2_0._refreshCanPlaceEffect, arg_2_0)
	RoomMapController.instance:registerCallback(RoomEvent.TransportPathViewShowChanged, arg_2_0._refreshCanPlaceEffect, arg_2_0)
	RoomWaterReformController.instance:registerCallback(RoomEvent.WaterReformShowChanged, arg_2_0._refreshCanPlaceEffect, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.SelectBlock, arg_3_0._refreshCanPlaceEffect, arg_3_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TransportPathViewShowChanged, arg_3_0._refreshCanPlaceEffect, arg_3_0)
	RoomWaterReformController.instance:unregisterCallback(RoomEvent.WaterReformShowChanged, arg_3_0._refreshCanPlaceEffect, arg_3_0)
end

function var_0_0._refreshCanPlaceEffect(arg_4_0)
	local var_4_0 = arg_4_0:_isCanShowPlaceEffect()
	local var_4_1 = RoomMapBlockModel.instance
	local var_4_2
	local var_4_3
	local var_4_4 = arg_4_0.entity.effect

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._hexPointList) do
		local var_4_5 = arg_4_0:getEffectKeyById(iter_4_0)

		if var_4_0 and arg_4_0:_checkByXY(iter_4_1.x, iter_4_1.y, var_4_1) then
			if not var_4_4:isHasKey(var_4_5) then
				if var_4_2 == nil then
					var_4_2 = {}
				end

				local var_4_6 = HexMath.hexToPosition(iter_4_1, RoomBlockEnum.BlockSize)

				var_4_2[var_4_5] = {
					res = RoomScenePreloader.ResEffectD03,
					localPos = Vector3(var_4_6.x, -0.12, var_4_6.y)
				}
			end
		elseif var_4_4:getEffectRes(var_4_5) then
			if var_4_3 == nil then
				var_4_3 = {}
			end

			table.insert(var_4_3, var_4_5)
		end
	end

	if var_4_2 then
		var_4_4:addParams(var_4_2)
		var_4_4:refreshEffect()
	end

	if var_4_3 then
		arg_4_0:removeParamsAndPlayAnimator(var_4_3, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function var_0_0._checkByBlockMO(arg_5_0, arg_5_1)
	if RoomEnum.IsBlockNeedConnInit then
		if arg_5_1 and arg_5_1:canPlace() then
			return true
		end
	elseif not arg_5_1 or arg_5_1:canPlace() then
		return true
	end

	return false
end

function var_0_0._checkByXY(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_3:getBlockMO(arg_6_1, arg_6_2)

	if var_6_0 and var_6_0.blockState == RoomBlockEnum.BlockState.Map then
		return false
	end

	for iter_6_0 = 1, 6 do
		local var_6_1 = HexPoint.directions[iter_6_0]
		local var_6_2 = arg_6_3:getBlockMO(arg_6_1 + var_6_1.x, arg_6_2 + var_6_1.y)

		if var_6_2 and var_6_2.blockState == RoomBlockEnum.BlockState.Map then
			return true
		end
	end

	return false
end

function var_0_0._isCanShowPlaceEffect(arg_7_0)
	if RoomBlockHelper.isCanPlaceBlock() then
		local var_7_0 = RoomInventoryBlockModel.instance:getSelectInventoryBlockId()

		if var_7_0 and var_7_0 > 0 then
			return true
		end
	end

	return false
end

function var_0_0.formatEffectKey(arg_8_0, arg_8_1)
	return arg_8_1
end

return var_0_0
