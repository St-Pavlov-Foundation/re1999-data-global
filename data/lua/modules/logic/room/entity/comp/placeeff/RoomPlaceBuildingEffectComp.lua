module("modules.logic.room.entity.comp.placeeff.RoomPlaceBuildingEffectComp", package.seeall)

local var_0_0 = class("RoomPlaceBuildingEffectComp", RoomBaseBlockEffectComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0.entity = arg_1_1
	arg_1_0._effectPrefixKey = RoomEnum.EffectKey.BuilidCanPlaceKey
end

function var_0_0.addEventListeners(arg_2_0)
	RoomMapController.instance:registerCallback(RoomEvent.BuildingCanConfirm, arg_2_0._refreshBuildingConfirmEffect, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BuildingCanConfirm, arg_3_0._refreshBuildingConfirmEffect, arg_3_0)
end

function var_0_0._refreshBuildingConfirmEffect(arg_4_0)
	local var_4_0 = RoomMapBuildingModel.instance:getTempBuildingMO()
	local var_4_1
	local var_4_2 = false

	if var_4_0 and RoomBuildingController.instance:isBuildingListShow() then
		var_4_2 = true
		var_4_1 = var_4_0.uid
	end

	if arg_4_0._lastBuildingUid == var_4_1 then
		return
	end

	arg_4_0._lastBuildingUid = var_4_1

	local var_4_3 = RoomMapBlockModel.instance
	local var_4_4 = RoomResourceModel.instance
	local var_4_5
	local var_4_6
	local var_4_7 = var_4_3:getFullBlockMOList()
	local var_4_8 = false
	local var_4_9

	if var_4_0 and var_4_0:isBuildingArea() and not var_4_0:isAreaMainBuilding() then
		var_4_8 = true
		var_4_9 = arg_4_0:_getRangesHexPointList(var_4_0)
	end

	local var_4_10 = arg_4_0.entity.effect

	for iter_4_0, iter_4_1 in ipairs(var_4_7) do
		local var_4_11 = iter_4_1.hexPoint
		local var_4_12 = var_4_4:getIndexByXY(var_4_11.x, var_4_11.y)
		local var_4_13 = true
		local var_4_14 = arg_4_0:getEffectKeyById(var_4_12)

		if var_4_2 and arg_4_0:_checkBuildingAreaShow(var_4_8, var_4_11, var_4_9) then
			local var_4_15 = arg_4_0:_isCanNotConfirm(iter_4_1, var_4_0)

			if not var_4_10:isHasKey(var_4_14) then
				if var_4_5 == nil then
					var_4_5 = {}
				end

				local var_4_16, var_4_17 = HexMath.hexXYToPosXY(var_4_11.x, var_4_11.y, RoomBlockEnum.BlockSize)

				var_4_5[var_4_14] = {
					res = var_4_15 and RoomScenePreloader.ResEffectD04 or RoomScenePreloader.ResEffectD03,
					localPos = Vector3(var_4_16, 0, var_4_17)
				}
			end
		elseif var_4_10:getEffectRes(var_4_14) then
			if var_4_6 == nil then
				var_4_6 = {}
			end

			table.insert(var_4_6, var_4_14)
		end
	end

	if var_4_5 then
		var_4_10:addParams(var_4_5)
		var_4_10:refreshEffect()
	end

	if var_4_6 then
		arg_4_0:removeParamsAndPlayAnimator(var_4_6, "close", RoomBlockEnum.PlaceEffectAnimatorCloseTime)
	end
end

function var_0_0._getRangesHexPointList(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1:isBuildingArea() and not arg_5_1:isAreaMainBuilding() then
		local var_5_0 = RoomMapBuildingAreaModel.instance:getAreaMOByBId(arg_5_1.buildingId)

		if var_5_0 then
			return var_5_0:getRangesHexPointList()
		end
	end

	return nil
end

function var_0_0._checkBuildingAreaShow(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 and not RoomBuildingHelper.isInInitBlock(arg_6_2) and (not arg_6_3 or not tabletool.indexOf(arg_6_3, arg_6_2)) and not RoomMapBuildingModel.instance:getBuildingParam(arg_6_2.x, arg_6_2.y) then
		return false
	end

	return true
end

function var_0_0._isCanNotConfirm(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_1.hexPoint

	if RoomBuildingHelper.isInInitBlock(var_7_0) then
		return true
	end

	local var_7_1 = RoomMapBuildingModel.instance:getBuildingParam(var_7_0.x, var_7_0.y)

	if not arg_7_2 then
		if var_7_1 then
			return true
		end
	else
		if var_7_1 and var_7_1.buildingUid ~= arg_7_2.uid then
			return true
		end

		if RoomTransportHelper.checkInLoadHexXY(var_7_0.x, var_7_0.y) then
			return true
		end

		return RoomBuildingHelper.checkBuildResId(arg_7_2.buildingId, arg_7_1:getResourceList(true)) == false
	end

	return false
end

return var_0_0
