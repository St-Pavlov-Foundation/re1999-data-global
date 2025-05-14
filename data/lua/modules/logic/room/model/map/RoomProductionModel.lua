module("modules.logic.room.model.map.RoomProductionModel", package.seeall)

local var_0_0 = class("RoomProductionModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._OnTimeNextFinish, arg_3_0)

	arg_3_0._unlockAnimLineIdDict = {}
	arg_3_0._unlockDetailAnimLineIdDict = {}
end

function var_0_0.updateProductionLines(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1.id ~= 0 then
			local var_4_1 = arg_4_0:getLineMO(iter_4_1.id)

			var_4_1:updateInfo(iter_4_1)
			table.insert(var_4_0, var_4_1)
		end
	end

	arg_4_0:addList(var_4_0)
	RoomController.instance:dispatchEvent(RoomEvent.UpdateProduceLineData)

	local var_4_2 = arg_4_0:getList()
	local var_4_3
	local var_4_4
	local var_4_5 = ServerTime.now()
	local var_4_6 = {}

	for iter_4_2, iter_4_3 in ipairs(var_4_2) do
		if iter_4_3.nextFinishTime > 0 and iter_4_3.pauseTime == 0 then
			if var_4_3 == nil or var_4_3 > iter_4_3.nextFinishTime then
				var_4_3 = iter_4_3.nextFinishTime
				var_4_4 = var_4_3 - var_4_5
				var_4_6 = {}

				table.insert(var_4_6, iter_4_3.id)
			elseif iter_4_3.nextFinishTime == var_4_3 then
				table.insert(var_4_6, iter_4_3.id)
			end
		end
	end

	arg_4_0:updateNextFinishList(var_4_6, var_4_4)
end

function var_0_0.updateNextFinishList(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._nextFinishList = arg_5_1

	TaskDispatcher.cancelTask(arg_5_0._OnTimeNextFinish, arg_5_0)

	if arg_5_2 then
		arg_5_2 = math.max(1, arg_5_2)

		TaskDispatcher.runDelay(arg_5_0._OnTimeNextFinish, arg_5_0, arg_5_2 + 0.5)
	end
end

function var_0_0._OnTimeNextFinish(arg_6_0, arg_6_1)
	RoomRpc.instance:sendProductionLineInfoRequest(arg_6_1)
end

function var_0_0.updateProductionLinesLevel(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:getLineMO(arg_7_1):updateLevel(arg_7_2)
	RoomController.instance:dispatchEvent(RoomEvent.UpdateProduceLineData)
	RoomController.instance:dispatchEvent(RoomEvent.ProduceLineLevelUp)
end

function var_0_0.getLineMO(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getById(arg_8_1)

	if var_8_0 == nil then
		var_8_0 = RoomProductionLineMO.New()

		var_8_0:init(arg_8_1)
	end

	return var_8_0
end

function var_0_0.updateLineMaxLevel(arg_9_0)
	local var_9_0 = arg_9_0:getList()

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		iter_9_1:updateMaxLevel()
	end
end

function var_0_0.checkUnlockLine(arg_10_0, arg_10_1)
	for iter_10_0, iter_10_1 in ipairs(lua_production_line.configList) do
		local var_10_0 = iter_10_1.id

		if not RoomProductionHelper.isLineUnlock(var_10_0, arg_10_1 - 1) and RoomProductionHelper.isLineUnlock(var_10_0, arg_10_1) then
			arg_10_0:setPlayLineUnlock(var_10_0, true)
			arg_10_0:setPlayLineUnlockDetail(var_10_0, true)
		end
	end
end

function var_0_0.shouldPlayLineUnlock(arg_11_0, arg_11_1)
	return arg_11_0._unlockAnimLineIdDict[arg_11_1]
end

function var_0_0.setPlayLineUnlock(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._unlockAnimLineIdDict[arg_12_1] = arg_12_2
end

function var_0_0.shouldPlayLineUnlockDetail(arg_13_0, arg_13_1)
	return arg_13_0._unlockDetailAnimLineIdDict[arg_13_1]
end

function var_0_0.setPlayLineUnlockDetail(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._unlockDetailAnimLineIdDict[arg_14_1] = arg_14_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
