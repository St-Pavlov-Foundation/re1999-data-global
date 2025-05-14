module("modules.logic.room.model.critter.RoomTrainSlotListModel", package.seeall)

local var_0_0 = class("RoomTrainSlotListModel", ListScrollModel)
local var_0_1 = 4

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0:clearData()
end

function var_0_0.clearData(arg_5_0)
	var_0_0.super.clear(arg_5_0)

	arg_5_0._selectId = nil
end

function var_0_0.setSlotList(arg_6_0)
	local var_6_0 = CritterModel.instance:getCultivatingCritters()
	local var_6_1 = {}
	local var_6_2

	for iter_6_0 = 1, var_0_1 do
		local var_6_3 = RoomTrainSlotMO.New()
		local var_6_4 = var_6_0 and var_6_0[iter_6_0]

		var_6_3:init({
			id = iter_6_0,
			isLock = arg_6_0:checkIsLock(iter_6_0)
		})
		var_6_3:setCritterMO(var_6_4)

		if not var_6_3:isFree() then
			var_6_2 = var_6_2 or var_6_3.id
		end

		if var_6_4 and var_6_4.id == arg_6_0._selectCritterUid then
			var_6_2 = var_6_3.id
		end

		table.insert(var_6_1, var_6_3)
	end

	arg_6_0._selectId = var_6_2 or arg_6_0._selectId

	arg_6_0:setList(var_6_1)
	arg_6_0:_refreshSelect()
end

function var_0_0.updateSlotList(arg_7_0)
	local var_7_0 = arg_7_0:getList()

	for iter_7_0 = 1, #var_7_0 do
		var_7_0[iter_7_0].isLock = arg_7_0:checkIsLock(iter_7_0)
	end

	arg_7_0:onModelUpdate()
end

function var_0_0.getTradeLevelCfgBySlotNum(arg_8_0, arg_8_1)
	if not arg_8_0._unLockDict then
		arg_8_0._unLockDict = {}
		arg_8_0._maxSloNum = 0

		local var_8_0 = lua_trade_level.configList

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			local var_8_1 = arg_8_0._unLockDict[iter_8_1.maxTrainSlotCount]

			if iter_8_1.maxTrainSlotCount > arg_8_0._maxSloNum then
				arg_8_0._maxSloNum = iter_8_1.maxTrainSlotCount
			end

			if not var_8_1 or var_8_1.level > iter_8_1.level then
				arg_8_0._unLockDict[iter_8_1.maxTrainSlotCount] = iter_8_1
			end
		end
	end

	return arg_8_0._unLockDict[arg_8_1]
end

function var_0_0.checkIsLock(arg_9_0, arg_9_1)
	if arg_9_1 > var_0_1 then
		return true
	end

	local var_9_0 = arg_9_0:getTradeLevelCfgBySlotNum(arg_9_1)
	local var_9_1 = ManufactureModel.instance:getTradeLevel() or 0

	if var_9_0 and var_9_1 < var_9_0.level then
		return true
	end

	return false
end

function var_0_0.clearSelect(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._scrollViews) do
		iter_10_1:setSelect(nil)
	end

	arg_10_0._selectId = nil
end

function var_0_0._refreshSelect(arg_11_0)
	local var_11_0
	local var_11_1 = arg_11_0:getList()

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		if iter_11_1.id == arg_11_0._selectId then
			var_11_0 = iter_11_1
		end
	end

	for iter_11_2, iter_11_3 in ipairs(arg_11_0._scrollViews) do
		iter_11_3:setSelect(var_11_0)
	end
end

function var_0_0.findFreeSlotMO(arg_12_0)
	local var_12_0 = arg_12_0:getList()

	for iter_12_0 = 1, #var_12_0 do
		local var_12_1 = var_12_0[iter_12_0]

		if var_12_1 and not var_12_1.isLock and not var_12_1.critterMO then
			return var_12_1
		end
	end
end

function var_0_0.setSelectCritterUid(arg_13_0, arg_13_1)
	arg_13_0._selectCritterUid = arg_13_1

	local var_13_0 = arg_13_0:getSlotMOByCritterUi(arg_13_1)

	if var_13_0 then
		arg_13_0:setSelect(var_13_0.id)
	end
end

function var_0_0.findWaitingSlotMOByUid(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getList()

	for iter_14_0 = 1, #var_14_0 do
		local var_14_1 = var_14_0[iter_14_0]

		if var_14_1.waitingTrainUid == arg_14_1 then
			return var_14_1
		end
	end
end

function var_0_0.getSlotMOByCritterUi(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getList()

	for iter_15_0 = 1, #var_15_0 do
		local var_15_1 = var_15_0[iter_15_0]

		if var_15_1.critterMO and var_15_1.critterMO.id == arg_15_1 then
			return var_15_1
		end
	end
end

function var_0_0.getSlotMOByHeroId(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getList()

	for iter_16_0 = 1, #var_16_0 do
		local var_16_1 = var_16_0[iter_16_0]

		if var_16_1.critterMO and var_16_1.critterMO.trainInfo and var_16_1.critterMO.trainInfo.heroId == arg_16_1 then
			return var_16_1
		end
	end
end

function var_0_0._getTrainAndFreeCount(arg_17_0)
	local var_17_0 = arg_17_0:getList()
	local var_17_1 = 0
	local var_17_2 = 0

	for iter_17_0 = 1, #var_17_0 do
		local var_17_3 = var_17_0[iter_17_0]

		if var_17_3 and not var_17_3.isLock then
			if var_17_3.critterMO then
				var_17_1 = var_17_1 + 1
			else
				var_17_2 = var_17_2 + 1
			end
		end
	end

	return var_17_1, var_17_2
end

function var_0_0.getTrarinAndFreeCount(arg_18_0)
	return arg_18_0:_getTrainAndFreeCount()
end

function var_0_0.getSelectMO(arg_19_0)
	return arg_19_0:getById(arg_19_0._selectId)
end

function var_0_0.getSelect(arg_20_0)
	return arg_20_0._selectId
end

function var_0_0.setSelect(arg_21_0, arg_21_1)
	arg_21_0._selectId = arg_21_1

	arg_21_0:_refreshSelect()
end

var_0_0.instance = var_0_0.New()

return var_0_0
