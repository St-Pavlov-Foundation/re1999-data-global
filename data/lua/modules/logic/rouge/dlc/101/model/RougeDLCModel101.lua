module("modules.logic.rouge.dlc.101.model.RougeDLCModel101", package.seeall)

local var_0_0 = class("RougeDLCModel101", BaseModel)

function var_0_0.clear(arg_1_0)
	arg_1_0._tmpClientMo = nil
	arg_1_0._preFogPosX = 0
	arg_1_0._preFogPosY = 0
end

function var_0_0.initLimiterInfo(arg_2_0, arg_2_1)
	arg_2_0:clear()

	if not arg_2_1 then
		return
	end

	local var_2_0 = arg_2_1.limiterInfo
	local var_2_1 = RougeLimiterMO.New()

	var_2_1:init(var_2_0)

	arg_2_0._tmpClientMo = LuaUtil.deepCopy(var_2_1:getLimiterClientMo())

	arg_2_0:_buildNewUnlockedLimiterGroupMap(arg_2_0._limiterMo, var_2_1)

	arg_2_0._limiterMo = var_2_1
end

function var_0_0.getLimiterMo(arg_3_0)
	return arg_3_0._limiterMo
end

function var_0_0.getLimiterClientMo(arg_4_0)
	return arg_4_0._tmpClientMo
end

function var_0_0.getCurLimiterGroupLv(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getLimiterClientMo()
	local var_5_1 = var_5_0 and var_5_0:getLimitIdInGroup(arg_5_1)
	local var_5_2 = 0

	if var_5_1 then
		local var_5_3 = RougeDLCConfig101.instance:getLimiterCo(var_5_1)

		var_5_2 = var_5_3 and var_5_3.level or 0
	end

	return var_5_2
end

function var_0_0.addLimiterGroupLv(arg_6_0, arg_6_1)
	arg_6_0:_changeLimiterGroupLv(arg_6_1, true)
end

function var_0_0.removeLimiterGroupLv(arg_7_0, arg_7_1)
	arg_7_0:_changeLimiterGroupLv(arg_7_1, false)
end

function var_0_0._changeLimiterGroupLv(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:getCurLimiterGroupLv(arg_8_1)
	local var_8_1 = RougeDLCConfig101.instance:getLimiterGroupMaxLevel(arg_8_1)
	local var_8_2 = arg_8_2 and var_8_0 + 1 or var_8_0 - 1
	local var_8_3 = GameUtil.clamp(var_8_2, 0, var_8_1)

	if var_8_0 == var_8_3 then
		return
	end

	local var_8_4 = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(arg_8_1, var_8_0)
	local var_8_5 = var_8_4 and var_8_4.id

	arg_8_0._tmpClientMo:selectLimit(var_8_5, false)

	local var_8_6 = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(arg_8_1, var_8_3)
	local var_8_7 = var_8_6 and var_8_6.id

	arg_8_0._tmpClientMo:selectLimit(var_8_7, true)

	if not arg_8_2 then
		arg_8_0:_tryRemoveBuff2MatchRisk()
	end

	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateLimitGroup, arg_8_1)
end

function var_0_0._tryRemoveBuff2MatchRisk(arg_9_0)
	local var_9_0 = arg_9_0._tmpClientMo:getLimitBuffIdsAndSortByType()

	for iter_9_0 = #var_9_0, 1, -1 do
		if arg_9_0:_checkIsLimiterRiskEnough() then
			break
		end

		local var_9_1 = var_9_0[iter_9_0]

		arg_9_0._tmpClientMo:selectLimitBuff(var_9_1, false)
	end
end

function var_0_0._checkIsLimiterRiskEnough(arg_10_0)
	local var_10_0 = arg_10_0:getTotalRiskValue()
	local var_10_1 = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(var_10_0)
	local var_10_2 = arg_10_0._tmpClientMo:getLimitBuffIds()

	return (var_10_2 and #var_10_2 or 0) <= (var_10_1 and var_10_1.buffNum or 0)
end

function var_0_0.getTotalRiskValue(arg_11_0)
	return (arg_11_0:_calcTotalRiskValue())
end

function var_0_0._calcTotalRiskValue(arg_12_0)
	local var_12_0 = arg_12_0:getLimiterClientMo()
	local var_12_1 = var_12_0 and var_12_0:getLimitIds()
	local var_12_2 = 0

	for iter_12_0, iter_12_1 in ipairs(var_12_1 or {}) do
		local var_12_3 = RougeDLCConfig101.instance:getLimiterCo(iter_12_1)

		var_12_2 = var_12_2 + (var_12_3 and var_12_3.riskValue or 0)
	end

	return var_12_2
end

function var_0_0.getCurLimiterGroupState(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getLimiterMo()

	return var_13_0 and var_13_0:getLimiterGroupState(arg_13_1)
end

function var_0_0.getSelectLimiterGroupIds(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = arg_14_0:getLimiterClientMo()
	local var_14_3 = var_14_2 and var_14_2:getLimitIds()

	for iter_14_0, iter_14_1 in ipairs(var_14_3) do
		local var_14_4 = RougeDLCConfig101.instance:getLimiterCo(iter_14_1)
		local var_14_5 = var_14_4 and var_14_4.group

		if var_14_5 and not var_14_1[var_14_5] then
			var_14_1[var_14_5] = true

			table.insert(var_14_0, var_14_5)
		end
	end

	return var_14_0
end

function var_0_0.isLimiterGroupSelected(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getLimiterMo()
	local var_15_1 = var_15_0 and var_15_0:getLimiterGroupState()
	local var_15_2 = arg_15_0:getCurLimiterGroupLv(arg_15_1)

	return var_15_1 == RougeDLCEnum101.LimitState.Unlocked and var_15_2 >= 1
end

function var_0_0.getAllLimiterBuffIds(arg_16_0)
	local var_16_0 = {}
	local var_16_1 = arg_16_0:getLimiterClientMo()
	local var_16_2 = var_16_1 and var_16_1:getLimitBuffIds()

	tabletool.addValues(var_16_0, var_16_2)

	return var_16_0
end

function var_0_0.getLimiterStateBuffIds(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = RougeDLCConfig101.instance:getAllLimiterBuffCos()

	for iter_17_0, iter_17_1 in ipairs(var_17_1 or {}) do
		local var_17_2 = iter_17_1.id

		if arg_17_0:getLimiterBuffState(var_17_2) == arg_17_1 then
			table.insert(var_17_0, var_17_2)
		end
	end

	return var_17_0
end

function var_0_0.getLimiterBuffState(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0:getLimiterMo()
	local var_18_1 = RougeDLCEnum101.BuffState.Locked

	if var_18_0 and var_18_0:isBuffUnlocked(arg_18_1) then
		var_18_1 = RougeDLCEnum101.BuffState.Unlocked

		local var_18_2 = arg_18_0:getLimiterClientMo()
		local var_18_3 = var_18_0 and var_18_0:isBuffCD(arg_18_1)
		local var_18_4 = var_18_2 and var_18_2:isSelectBuff(arg_18_1)

		if var_18_3 then
			var_18_1 = RougeDLCEnum101.BuffState.CD
		elseif var_18_4 then
			var_18_1 = RougeDLCEnum101.BuffState.Equiped
		end
	end

	return var_18_1
end

function var_0_0.try2EquipBuff(arg_19_0, arg_19_1)
	arg_19_0:getLimiterClientMo():selectLimitBuff(arg_19_1, true)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, arg_19_1)
end

function var_0_0.try2UnEquipBuff(arg_20_0, arg_20_1)
	arg_20_0:getLimiterClientMo():selectLimitBuff(arg_20_1, false)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, arg_20_1)
end

function var_0_0.getTotalEmblemCount(arg_21_0)
	local var_21_0 = arg_21_0:getLimiterMo()

	return var_21_0 and var_21_0:getTotalEmblemCount()
end

function var_0_0.getLimiterBuffCD(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0:getLimiterMo()

	return var_22_0 and var_22_0:getLimiterBuffCD(arg_22_1) or 0
end

function var_0_0.isModifySelectLimiterGroup(arg_23_0)
	local var_23_0 = arg_23_0:getLimiterMo()
	local var_23_1 = var_23_0 and var_23_0:getLimiterClientMo()
	local var_23_2 = arg_23_0:getLimiterClientMo()
	local var_23_3 = var_23_1:getLimitBuffIdMap()
	local var_23_4 = var_23_2:getLimitBuffIdMap()
	local var_23_5 = var_23_1:getLimitIdMap()
	local var_23_6 = var_23_2:getLimitIdMap()
	local var_23_7 = arg_23_0:_is2MapSame(var_23_3, var_23_4)
	local var_23_8 = arg_23_0:_is2MapSame(var_23_5, var_23_6)

	return not var_23_7 or not var_23_8
end

function var_0_0._is2MapSame(arg_24_0, arg_24_1, arg_24_2)
	if tabletool.len(arg_24_1) ~= tabletool.len(arg_24_2) then
		return false
	end

	for iter_24_0, iter_24_1 in pairs(arg_24_1) do
		if arg_24_2[iter_24_0] ~= iter_24_1 then
			return false
		end
	end

	return true
end

function var_0_0.onGetLimiterClientMo(arg_25_0, arg_25_1)
	arg_25_0:getLimiterMo():updateLimiterClientInfo(arg_25_1)

	arg_25_0._tmpClientMo = LuaUtil.deepCopy(arg_25_0._limiterMo:getLimiterClientMo())
end

function var_0_0.getFogPrePos(arg_26_0)
	return arg_26_0._preFogPosX or 0, arg_26_0._preFogPosY or 0
end

function var_0_0.setFogPrePos(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0._preFogPosX = arg_27_1
	arg_27_0._preFogPosY = arg_27_2
end

function var_0_0._buildNewUnlockedLimiterGroupMap(arg_28_0, arg_28_1, arg_28_2)
	arg_28_0._newUnlockedGroupMap = arg_28_0._newUnlockedGroupMap or {}

	if arg_28_1 and arg_28_2 then
		local var_28_0 = arg_28_2:getAllUnlockLimiterGroupIds()

		if var_28_0 then
			for iter_28_0, iter_28_1 in ipairs(var_28_0) do
				if not arg_28_1:isLimiterGroupUnlocked(iter_28_1) then
					arg_28_0._newUnlockedGroupMap[iter_28_1] = true
				end
			end
		end
	end
end

function var_0_0.isLimiterGroupNewUnlocked(arg_29_0, arg_29_1)
	return arg_29_0._newUnlockedGroupMap and arg_29_0._newUnlockedGroupMap[arg_29_1]
end

function var_0_0.resetLimiterGroupNewUnlockInfo(arg_30_0)
	arg_30_0._newUnlockedGroupMap = {}
end

function var_0_0.resetAllSelectLimitIds(arg_31_0)
	local var_31_0 = arg_31_0:getLimiterClientMo()

	if not var_31_0 then
		return
	end

	var_31_0:clearAllLimitIds()
	var_31_0:clearAllLimitBuffIds()
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateLimitGroup)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips)
end

var_0_0.instance = var_0_0.New()

return var_0_0
