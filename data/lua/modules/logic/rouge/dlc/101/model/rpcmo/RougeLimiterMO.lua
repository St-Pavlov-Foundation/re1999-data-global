module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterMO", package.seeall)

local var_0_0 = pureTable("RougeLimiterMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:_buildLimitBuffInfoMap(arg_1_1.unlockLimitBuffs)
	arg_1_0:_buildLimitGroupInfoMap(arg_1_1.unlockLimitGroupIds)
	arg_1_0:updateLimiterClientInfo(arg_1_1.clientNO)

	arg_1_0._totalEmblemCount = arg_1_1.emblem
end

function var_0_0._buildLimitBuffInfoMap(arg_2_0, arg_2_1)
	arg_2_0._unlockLimitBuff = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		local var_2_0 = iter_2_1.id
		local var_2_1 = iter_2_1.cd

		arg_2_0._unlockLimitBuff[var_2_0] = var_2_1
	end
end

function var_0_0._buildLimitGroupInfoMap(arg_3_0, arg_3_1)
	arg_3_0._unlockLimitGroupIds = {}
	arg_3_0._unlockLimitGroupIdMap = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1) do
		arg_3_0._unlockLimitGroupIdMap[iter_3_1] = true

		table.insert(arg_3_0._unlockLimitGroupIds, iter_3_1)
	end
end

function var_0_0.isBuffUnlocked(arg_4_0, arg_4_1)
	local var_4_0 = RougeDLCConfig101.instance:getLimiterBuffCo(arg_4_1)

	if var_4_0 and var_4_0.needEmblem <= 0 then
		return true
	end

	return (arg_4_0._unlockLimitBuff and arg_4_0._unlockLimitBuff[arg_4_1]) ~= nil
end

function var_0_0.isBuffCD(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._unlockLimitBuff and arg_5_0._unlockLimitBuff[arg_5_1]

	return var_5_0 and var_5_0 > 0
end

function var_0_0.getBuffCDRound(arg_6_0, arg_6_1)
	return arg_6_0._unlockLimitBuff and arg_6_0._unlockLimitBuff[arg_6_1] or 0
end

function var_0_0.isLimiterGroupUnlocked(arg_7_0, arg_7_1)
	return arg_7_0._unlockLimitGroupIdMap and arg_7_0._unlockLimitGroupIdMap[arg_7_1] ~= nil
end

function var_0_0.getAllUnlockLimiterGroupIds(arg_8_0)
	return arg_8_0._unlockLimitGroupIds
end

function var_0_0.getTotalEmblemCount(arg_9_0)
	return arg_9_0._totalEmblemCount
end

function var_0_0.updateTotalEmblemCount(arg_10_0, arg_10_1)
	arg_10_0._totalEmblemCount = arg_10_0._totalEmblemCount + arg_10_1
end

function var_0_0.getLimiterGroupState(arg_11_0, arg_11_1)
	return arg_11_0:isLimiterGroupUnlocked(arg_11_1) and RougeDLCEnum101.LimitState.Unlocked or RougeDLCEnum101.LimitState.Locked
end

function var_0_0.getLimiterClientMo(arg_12_0)
	return arg_12_0._clientMo
end

function var_0_0.updateLimiterClientInfo(arg_13_0, arg_13_1)
	if not arg_13_0._clientMo then
		arg_13_0._clientMo = RougeLimiterClientMO.New()
	end

	arg_13_0._clientMo:init(arg_13_1)
	arg_13_0:_checkCDAndRemoveLimitBuff()
end

function var_0_0.getLimiterBuffCD(arg_14_0, arg_14_1)
	return arg_14_0._unlockLimitBuff and arg_14_0._unlockLimitBuff[arg_14_1] or 0
end

function var_0_0.unlockLimiterBuff(arg_15_0, arg_15_1)
	if not arg_15_0._unlockLimitBuff[arg_15_1] then
		arg_15_0._unlockLimitBuff[arg_15_1] = 0
	end
end

function var_0_0.speedupLimiterBuff(arg_16_0, arg_16_1)
	if arg_16_0._unlockLimitBuff[arg_16_1] then
		arg_16_0._unlockLimitBuff[arg_16_1] = 0
	end
end

function var_0_0._checkCDAndRemoveLimitBuff(arg_17_0)
	if not arg_17_0._clientMo then
		return
	end

	local var_17_0 = arg_17_0._clientMo:getLimitBuffIds()

	if not var_17_0 then
		return
	end

	for iter_17_0 = #var_17_0, 1, -1 do
		local var_17_1 = var_17_0[iter_17_0]

		if arg_17_0:isBuffCD(var_17_1) then
			arg_17_0._clientMo:selectLimitBuff(var_17_1, false)
		end
	end
end

return var_0_0
