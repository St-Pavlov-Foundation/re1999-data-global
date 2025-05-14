module("modules.logic.room.model.layout.RoomLayoutModel", package.seeall)

local var_0_0 = class("RoomLayoutModel", BaseModel)

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
	arg_4_0._needRpcGetInfo = true
	arg_4_0._visitCopyName = nil
	arg_4_0._isPlayUnLock = nil
	arg_4_0._canUseShareCount = 0
	arg_4_0._canShareCount = 0
	arg_4_0._useCount = 0
end

function var_0_0.isNeedRpcGet(arg_5_0)
	return arg_5_0._needRpcGetInfo
end

function var_0_0.clearNeedRpcGet(arg_6_0)
	arg_6_0._needRpcGetInfo = true
end

function var_0_0.rpcGetFinish(arg_7_0)
	arg_7_0._needRpcGetInfo = false
end

function var_0_0.setRoomPlanInfoReply(arg_8_0, arg_8_1)
	local var_8_0 = {}
	local var_8_1 = arg_8_0:getById(RoomEnum.LayoutUsedPlanId)
	local var_8_2 = arg_8_1.infos

	if var_8_2 then
		for iter_8_0 = 1, #var_8_2 do
			local var_8_3 = var_8_2[iter_8_0]
			local var_8_4 = RoomLayoutMO.New()

			var_8_4:init(var_8_3.id)

			if var_8_1 and var_8_3.id == RoomEnum.LayoutUsedPlanId then
				var_8_4:updateInfo(var_8_1)
			end

			var_8_4:updateInfo(var_8_3)
			var_8_4:setEmpty(false)
			table.insert(var_8_0, var_8_4)
		end
	end

	arg_8_0._useCount = arg_8_1.totalUseCount or 0

	arg_8_0:setList(var_8_0)
	arg_8_0:setCanUseShareCount(arg_8_1.canUseShareCount)
	arg_8_0:setCanShareCount(arg_8_1.canShareCount)
end

function var_0_0.getUseCount(arg_9_0)
	local var_9_0 = arg_9_0:getList()
	local var_9_1 = 0

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		var_9_1 = var_9_1 + iter_9_1:getUseCount()
	end

	return math.max(arg_9_0._useCount, var_9_1)
end

function var_0_0.setCanShareCount(arg_10_0, arg_10_1)
	arg_10_0._canShareCount = arg_10_1 or 0
end

function var_0_0.getCanShareCount(arg_11_0)
	return arg_11_0._canShareCount
end

function var_0_0.setCanUseShareCount(arg_12_0, arg_12_1)
	arg_12_0._canUseShareCount = arg_12_1 or 0
end

function var_0_0.getCanUseShareCount(arg_13_0)
	return arg_13_0._canUseShareCount
end

function var_0_0.updateRoomPlanInfoReply(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getById(arg_14_1.id)

	if not var_14_0 then
		var_14_0 = RoomLayoutMO.New()

		var_14_0:init(arg_14_1.id)
		arg_14_0:addAtLast(var_14_0)
	end

	var_14_0:updateInfo(arg_14_1)
	var_14_0:setEmpty(false)
end

function var_0_0.setVisitCopyName(arg_15_0, arg_15_1)
	arg_15_0._visitCopyName = arg_15_1
end

function var_0_0.getVisitCopyName(arg_16_0)
	return arg_16_0._visitCopyName
end

function var_0_0.getMaxPlanCount(arg_17_0)
	return CommonConfig.instance:getConstNum(ConstEnum.RoomLayoutPlanMax)
end

local var_0_1 = "room_layoutplan_default_name"

function var_0_0.findDefaultName(arg_18_0)
	local var_18_0 = RoomEnum.LayoutPlanDefaultNames
	local var_18_1 = var_0_1
	local var_18_2 = ""

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		var_18_2 = formatLuaLang(var_18_1, iter_18_1)

		if not arg_18_0:isSameName(var_18_2) then
			return var_18_2
		end
	end

	return var_18_2 .. math.random(1, 10)
end

function var_0_0.isSameName(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getList()

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if iter_19_1.name == arg_19_1 then
			return true
		end
	end

	return false
end

function var_0_0._getPlayUnLockKey(arg_20_0)
	local var_20_0 = PlayerModel.instance:getPlayinfo().userId

	return string.format("RoomLayoutModel_PLAY_UNLOCK_KEY_%s", var_20_0)
end

function var_0_0.setPlayUnLock(arg_21_0, arg_21_1)
	arg_21_0._isPlayUnLock = arg_21_1 and 1 or 0

	PlayerPrefsHelper.setNumber(arg_21_0:_getPlayUnLockKey(), arg_21_0._isPlayUnLock)
end

function var_0_0.getPlayUnLock(arg_22_0)
	if arg_22_0._isPlayUnLock == nil then
		arg_22_0._isPlayUnLock = PlayerPrefsHelper.getNumber(arg_22_0:_getPlayUnLockKey(), 0)
	end

	return arg_22_0._isPlayUnLock == 1
end

function var_0_0.getLayoutCount(arg_23_0)
	local var_23_0 = 0
	local var_23_1 = arg_23_0:getList()

	if not var_23_1 then
		return var_23_0
	end

	for iter_23_0, iter_23_1 in ipairs(var_23_1) do
		if not iter_23_1:isEmpty() then
			var_23_0 = var_23_0 + 1
		end
	end

	return var_23_0
end

function var_0_0.getCurrentUsePlanName(arg_24_0)
	local var_24_0 = arg_24_0:getList()

	if not var_24_0 then
		return ""
	end

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1:isUse() then
			return iter_24_1.name
		end
	end

	return ""
end

function var_0_0.getCurrentPlotBagData(arg_25_0)
	local var_25_0 = arg_25_0:getList()

	if not var_25_0 then
		return {}
	end

	for iter_25_0, iter_25_1 in ipairs(var_25_0) do
		if iter_25_1:isUse() then
			return arg_25_0:getPlotBagData(iter_25_1)
		end
	end

	return {}
end

function var_0_0.getPlotBagData(arg_26_0, arg_26_1)
	local var_26_0 = {}
	local var_26_1, var_26_2 = RoomLayoutHelper.findBlockInfos(arg_26_1.infos)

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		local var_26_3 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.BlockPackage, iter_26_0)

		table.insert(var_26_0, {
			plot_name = var_26_3.name,
			plot_num = iter_26_1
		})
	end

	for iter_26_2, iter_26_3 in ipairs(var_26_2) do
		local var_26_4 = ItemModel.instance:getItemConfig(MaterialEnum.MaterialType.SpecialBlock, iter_26_3)

		table.insert(var_26_0, {
			plot_num = 1,
			plot_name = var_26_4.name
		})
	end

	return var_26_0
end

function var_0_0.getSharePlanCount(arg_27_0)
	local var_27_0 = 0
	local var_27_1 = arg_27_0:getList()

	if not var_27_1 then
		return var_27_0
	end

	for iter_27_0, iter_27_1 in ipairs(var_27_1) do
		if iter_27_1:isSharing() then
			var_27_0 = var_27_0 + 1
		end
	end

	return var_27_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
