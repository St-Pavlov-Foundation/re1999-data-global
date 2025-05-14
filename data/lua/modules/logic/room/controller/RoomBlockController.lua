module("modules.logic.room.controller.RoomBlockController", package.seeall)

local var_0_0 = class("RoomBlockController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._lastUpdatePathGraphicTimeDic = {}

	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	return
end

function var_0_0.refreshResourceLight(arg_4_0)
	local var_4_0 = arg_4_0:_isHasResourceLight()

	if arg_4_0._isLastHasResourceLight or var_4_0 then
		arg_4_0._isLastHasResourceLight = var_4_0

		RoomMapController.instance:dispatchEvent(RoomEvent.ResourceLight)
	end
end

function var_0_0._isHasResourceLight(arg_5_0)
	local var_5_0 = RoomMapBlockModel.instance:getTempBlockMO()

	if var_5_0 and var_5_0:isHasLight() then
		local var_5_1 = RoomResourceModel.instance
		local var_5_2 = var_5_0.hexPoint

		for iter_5_0 = 1, 6 do
			if var_5_1:isLightResourcePoint(var_5_2.x, var_5_2.y, iter_5_0) then
				return true
			end
		end
	end

	return false
end

function var_0_0.refreshNearLand(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = RoomBlockHelper.getNearBlockEntity(false, arg_6_1, 1, arg_6_2, false)

	RoomBlockHelper.refreshBlockEntity(var_6_0, "refreshLand")

	local var_6_1 = RoomBlockHelper.getNearBlockEntity(true, arg_6_1, 1, arg_6_2, true)

	RoomBlockHelper.refreshBlockEntity(var_6_1, "refreshWaveEffect")
end

function var_0_0.refreshBackBuildingEffect(arg_7_0)
	if not arg_7_0._ishasWaitBlockBuildingEffect then
		arg_7_0._ishasWaitBlockBuildingEffect = true

		TaskDispatcher.runDelay(arg_7_0._onRefreshBackBuildingEffect, arg_7_0, 0.01)
	end
end

function var_0_0._onRefreshBackBuildingEffect(arg_8_0)
	arg_8_0._ishasWaitBlockBuildingEffect = false

	local var_8_0 = RoomMapBlockModel.instance:getFullBlockMOList()
	local var_8_1 = GameSceneMgr.instance:getCurScene()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2 = var_8_0[iter_8_0]
		local var_8_3 = var_8_1.mapmgr:getBlockEntity(var_8_2.id, SceneTag.RoomMapBlock)

		if var_8_3 then
			var_8_3:refreshBackBuildingEffect(var_8_2)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
