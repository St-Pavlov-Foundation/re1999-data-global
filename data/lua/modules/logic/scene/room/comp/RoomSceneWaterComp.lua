module("modules.logic.scene.room.comp.RoomSceneWaterComp", package.seeall)

local var_0_0 = class("RoomSceneWaterComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._waterGODict = {}
	arg_2_0._waterRes = RoomResHelper.getWaterPath()
	arg_2_0._waterRoot = arg_2_0._scene.go.waterRoot

	RoomMapController.instance:registerCallback(RoomEvent.UpdateWater, arg_2_0._updateWater, arg_2_0)
	arg_2_0:_refreshWaterGO()
end

function var_0_0._updateWater(arg_3_0)
	arg_3_0:_refreshWaterGO()
end

function var_0_0._refreshWaterGO(arg_4_0)
	local var_4_0 = RoomMapBlockModel.instance:getConvexHull()
	local var_4_1 = RoomMapBlockModel.instance:getConvexHexPointDict()

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			if RoomMapBlockModel.instance:getBlockMO(iter_4_0, iter_4_2) then
				var_4_1[iter_4_0][iter_4_2] = nil
			end
		end
	end

	for iter_4_4, iter_4_5 in pairs(var_4_1) do
		for iter_4_6, iter_4_7 in pairs(iter_4_5) do
			if not arg_4_0._waterGODict[iter_4_4] or not arg_4_0._waterGODict[iter_4_4][iter_4_6] then
				arg_4_0._waterGODict[iter_4_4] = arg_4_0._waterGODict[iter_4_4] or {}

				local var_4_2 = HexPoint(iter_4_4, iter_4_6)
				local var_4_3 = RoomGOPool.getInstance(arg_4_0._waterRes, arg_4_0._waterRoot, RoomResHelper.getBlockName(var_4_2))

				if var_4_3 then
					local var_4_4 = HexMath.hexToPosition(var_4_2, RoomBlockEnum.BlockSize)

					transformhelper.setLocalPos(var_4_3.transform, var_4_4.x, 0, var_4_4.y)

					arg_4_0._waterGODict[iter_4_4][iter_4_6] = var_4_3
				end
			end
		end
	end

	for iter_4_8, iter_4_9 in pairs(arg_4_0._waterGODict) do
		for iter_4_10, iter_4_11 in pairs(iter_4_9) do
			if not var_4_1[iter_4_8] or not var_4_1[iter_4_8][iter_4_10] then
				RoomGOPool.returnInstance(arg_4_0._waterRes, iter_4_11)

				arg_4_0._waterGODict[iter_4_8][iter_4_10] = nil
			end
		end
	end
end

function var_0_0.onSceneClose(arg_5_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.UpdateWater, arg_5_0._updateWater, arg_5_0)

	for iter_5_0, iter_5_1 in pairs(arg_5_0._waterGODict) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			RoomGOPool.returnInstance(arg_5_0._waterRes, iter_5_3)
		end
	end

	arg_5_0._waterGODict = nil
	arg_5_0._prefab = nil
	arg_5_0._waterRoot = nil
end

return var_0_0
