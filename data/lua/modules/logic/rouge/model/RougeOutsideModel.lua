module("modules.logic.rouge.model.RougeOutsideModel", package.seeall)

local var_0_0 = class("RougeOutsideModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_setRougeSeason(nil, RougeConfig1.instance:season())
end

function var_0_0.onReceiveGetRougeOutsideInfoReply(arg_3_0, arg_3_1)
	arg_3_0:updateRougeOutsideInfo(arg_3_1.rougeInfo)
end

function var_0_0.updateRougeOutsideInfo(arg_4_0, arg_4_1)
	arg_4_0:_setRougeSeason(arg_4_1)

	arg_4_0._rougeGameRecord = arg_4_0._rougeGameRecord or RougeGameRecordInfoMO.New()

	arg_4_0._rougeGameRecord:init(arg_4_1.gameRecordInfo)
	RougeFavoriteModel.instance:initReviews(arg_4_1.review)
	RougeOutsideController.instance:dispatchEvent(RougeEvent.OnUpdateRougeOutsideInfo)
end

function var_0_0.getRougeGameRecord(arg_5_0)
	return arg_5_0._rougeGameRecord
end

function var_0_0._setRougeSeason(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 ~= nil then
		arg_6_0._rougeInfo = arg_6_1
	else
		assert(tonumber(arg_6_2))

		arg_6_0._rougeInfo = RougeOutsideModule_pb.GetRougeOutsideInfoReply()

		rawset(arg_6_0._rougeInfo, "season", arg_6_2)
	end

	arg_6_2 = arg_6_2 or arg_6_0:season()

	if not arg_6_0._config or arg_6_0._config:season() ~= arg_6_2 then
		arg_6_0._config = _G["RougeConfig" .. arg_6_2].instance
	end
end

function var_0_0.config(arg_7_0)
	return arg_7_0._config
end

function var_0_0.openUnlockId(arg_8_0)
	return arg_8_0._config:openUnlockId()
end

function var_0_0.season(arg_9_0)
	local var_9_0

	if arg_9_0._rougeInfo then
		var_9_0 = arg_9_0._rougeInfo.season
	end

	if not var_9_0 and arg_9_0._config then
		var_9_0 = arg_9_0._config:season()
	end

	if not var_9_0 then
		return 1
	end

	return math.max(var_9_0, 1)
end

function var_0_0.isUnlock(arg_10_0)
	local var_10_0 = arg_10_0:openUnlockId()

	return OpenModel.instance:isFunctionUnlock(var_10_0)
end

function var_0_0.passedDifficulty(arg_11_0)
	if not arg_11_0._rougeGameRecord then
		return 0
	end

	return arg_11_0._rougeGameRecord.maxDifficulty or 0
end

function var_0_0.isPassedDifficulty(arg_12_0, arg_12_1)
	return arg_12_1 <= arg_12_0:passedDifficulty()
end

function var_0_0.isOpenedDifficulty(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._config:getDifficultyCO(arg_13_1)

	return arg_13_0:isPassedDifficulty(var_13_0.preDifficulty)
end

function var_0_0.isOpenedStyle(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	local var_14_0 = arg_14_0._config:getStyleConfig(arg_14_1)
	local var_14_1 = var_14_0.unlockType

	if not var_14_1 or var_14_1 == 0 then
		return true
	end

	return RougeMapUnlockHelper.checkIsUnlock(var_14_1, var_14_0.unlockParam)
end

function var_0_0.endCdTs(arg_15_0)
	if not arg_15_0._rougeGameRecord then
		return 0
	end

	local var_15_0 = arg_15_0._rougeGameRecord:lastGameEndTimestamp()

	if var_15_0 <= 0 then
		return 0
	end

	local var_15_1 = arg_15_0._config:getAbortCDDuration()

	if var_15_1 == 0 then
		return 0
	end

	return var_15_0 + var_15_1
end

function var_0_0.leftCdSec(arg_16_0)
	return arg_16_0:endCdTs() - ServerTime.now()
end

function var_0_0.isInCdStart(arg_17_0)
	return arg_17_0:leftCdSec() > 0
end

function var_0_0.getDifficultyInfoList(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_0._config:getDifficultyCOListByVersions(arg_18_1)
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_2 = iter_18_1.difficulty

		table.insert(var_18_1, {
			difficulty = var_18_2,
			difficultyCO = iter_18_1,
			isUnLocked = arg_18_0:isOpenedDifficulty(var_18_2)
		})
	end

	table.sort(var_18_1, function(arg_19_0, arg_19_1)
		local var_19_0 = arg_19_0.difficulty
		local var_19_1 = arg_19_1.difficulty

		if var_19_0 ~= var_19_1 then
			return var_19_0 < var_19_1
		end
	end)

	return var_18_1
end

function var_0_0.getStyleInfoList(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._config:getStyleCOListByVersions(arg_20_1)
	local var_20_1 = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		var_20_1[#var_20_1 + 1] = arg_20_0:_createStyleMo(iter_20_1)
	end

	table.sort(var_20_1, var_0_0._styleSortFunc)

	return var_20_1
end

function var_0_0._createStyleMo(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.id

	return {
		style = var_21_0,
		styleCO = arg_21_1,
		isUnLocked = arg_21_0:isOpenedStyle(var_21_0)
	}
end

function var_0_0._styleSortFunc(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0.isUnLocked and 1 or 0
	local var_22_1 = arg_22_1.isUnLocked and 1 or 0

	if var_22_0 ~= var_22_1 then
		return var_22_1 < var_22_0
	end

	return arg_22_0.style < arg_22_1.style
end

function var_0_0.getSeasonStyleInfoList(arg_23_0)
	local var_23_0 = arg_23_0._config:getSeasonStyleConfigs()
	local var_23_1 = {}

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		var_23_1[#var_23_1 + 1] = arg_23_0:_createStyleMo(iter_23_1)
	end

	table.sort(var_23_1, var_0_0._styleSortFunc)

	return var_23_1
end

local var_0_1 = 1
local var_0_2 = 0

function var_0_0.getIsNewUnlockDifficulty(arg_24_0, arg_24_1)
	return arg_24_0:_getUnlockDifficulty(arg_24_1, var_0_2) == var_0_1
end

function var_0_0.setIsNewUnlockDifficulty(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0:_saveUnlockDifficulty(arg_25_1, arg_25_2 and var_0_1 or var_0_2)
end

function var_0_0.getIsNewUnlockStyle(arg_26_0, arg_26_1)
	return arg_26_0:_getUnlockStyle(arg_26_1, var_0_2) == var_0_1
end

function var_0_0.setIsNewUnlockStyle(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0:_saveUnlockStyle(arg_27_1, arg_27_2 and var_0_1 or var_0_2)
end

local var_0_3 = "RougeOutside|"
local var_0_4 = "LastMark|"

function var_0_0._getPrefsKeyPrefix(arg_28_0)
	local var_28_0 = arg_28_0:season()
	local var_28_1 = RougeModel.instance:getVersion()
	local var_28_2 = table.concat(var_28_1, "#")

	return var_0_3 .. tostring(var_28_0) .. tostring(var_28_2)
end

function var_0_0._saveInteger(arg_29_0, arg_29_1, arg_29_2)
	GameUtil.playerPrefsSetNumberByUserId(arg_29_1, arg_29_2)
end

function var_0_0._getInteger(arg_30_0, arg_30_1, arg_30_2)
	return GameUtil.playerPrefsGetNumberByUserId(arg_30_1, arg_30_2)
end

local var_0_5 = "D|"

function var_0_0._getPrefsKeyDifficulty(arg_31_0, arg_31_1)
	assert(type(arg_31_1) == "number")

	return arg_31_0:_getPrefsKeyPrefix() .. var_0_5 .. tostring(arg_31_1)
end

function var_0_0._saveUnlockDifficulty(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:_getPrefsKeyDifficulty(arg_32_1)

	arg_32_0:_saveInteger(var_32_0, arg_32_2)
end

function var_0_0._getUnlockDifficulty(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:_getPrefsKeyDifficulty(arg_33_1)

	return arg_33_0:_getInteger(var_33_0, arg_33_2)
end

function var_0_0._getPrefsKeyLastMarkDifficulty(arg_34_0)
	return arg_34_0:_getPrefsKeyPrefix() .. var_0_4 .. var_0_5
end

function var_0_0.setLastMarkSelectedDifficulty(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0:_getPrefsKeyLastMarkDifficulty()

	arg_35_0:_saveInteger(var_35_0, arg_35_1)
end

function var_0_0.getLastMarkSelectedDifficulty(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0:_getPrefsKeyLastMarkDifficulty()

	return arg_36_0:_getInteger(var_36_0, arg_36_1)
end

local var_0_6 = "S|"

function var_0_0._getPrefsKeyStyle(arg_37_0, arg_37_1)
	assert(type(arg_37_1) == "number")

	return arg_37_0:_getPrefsKeyPrefix() .. var_0_6 .. tostring(arg_37_1)
end

function var_0_0._saveUnlockStyle(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0:_getPrefsKeyStyle(arg_38_1)

	arg_38_0:_saveInteger(var_38_0, arg_38_2)
end

function var_0_0._getUnlockStyle(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:_getPrefsKeyStyle(arg_39_1)

	return arg_39_0:_getInteger(var_39_0, arg_39_2)
end

function var_0_0.passedLayerId(arg_40_0, arg_40_1)
	if not arg_40_0._rougeGameRecord then
		return false
	end

	return arg_40_0._rougeGameRecord:passedLayerId(arg_40_1)
end

function var_0_0.collectionIsPass(arg_41_0, arg_41_1)
	if not arg_41_0._rougeGameRecord then
		return false
	end

	return arg_41_0._rougeGameRecord:collectionIsPass(arg_41_1)
end

function var_0_0.storyIsPass(arg_42_0, arg_42_1)
	if not arg_42_0._rougeGameRecord then
		return false
	end

	return arg_42_0._rougeGameRecord:storyIsPass(arg_42_1)
end

function var_0_0.passedAnyEventId(arg_43_0, arg_43_1)
	for iter_43_0, iter_43_1 in ipairs(arg_43_1) do
		if arg_43_0:passedEventId(iter_43_1) then
			return true
		end
	end

	return false
end

function var_0_0.passedEventId(arg_44_0, arg_44_1)
	if not arg_44_0._rougeGameRecord then
		return false
	end

	return arg_44_0._rougeGameRecord:passedEventId(arg_44_1)
end

function var_0_0.passAnyOneEnd(arg_45_0)
	return arg_45_0._rougeGameRecord and arg_45_0._rougeGameRecord:passAnyOneEnd()
end

function var_0_0.passEndId(arg_46_0, arg_46_1)
	return arg_46_0._rougeGameRecord and arg_46_0._rougeGameRecord:passEndId(arg_46_1)
end

function var_0_0.passEntrustId(arg_47_0, arg_47_1)
	return arg_47_0._rougeGameRecord and arg_47_0._rougeGameRecord:passEntrustId(arg_47_1)
end

function var_0_0.getGeniusBranchStartViewInfo(arg_48_0, arg_48_1)
	if not RougeTalentModel.instance:isTalentUnlock(arg_48_1) then
		return 0
	end

	return arg_48_0._config:getGeniusBranchStartViewInfo(arg_48_1)
end

function var_0_0.getGeniusBranchStartViewDeltaValue(arg_49_0, arg_49_1, arg_49_2)
	return arg_49_0:getGeniusBranchStartViewInfo(arg_49_1)[arg_49_2] or 0
end

function var_0_0.getGeniusBranchStartViewAllInfo(arg_50_0)
	local var_50_0 = {}
	local var_50_1 = arg_50_0._config:getGeniusBranchIdListWithStartView()

	for iter_50_0, iter_50_1 in ipairs(var_50_1) do
		var_50_0[iter_50_1] = false
	end

	RougeTalentModel.instance:calcTalentUnlockIds(var_50_0)

	local var_50_2 = {}

	for iter_50_2, iter_50_3 in pairs(var_50_0) do
		if iter_50_3 then
			local var_50_3 = arg_50_0._config:getGeniusBranchStartViewInfo(iter_50_2)

			for iter_50_4, iter_50_5 in pairs(var_50_3) do
				var_50_2[iter_50_4] = (var_50_2[iter_50_4] or 0) + iter_50_5
			end
		end
	end

	return var_50_2
end

function var_0_0.getStartViewAllInfo(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0._config:getDifficultyCOStartViewInfo(arg_51_1)
	local var_51_1 = arg_51_0:getGeniusBranchStartViewAllInfo()
	local var_51_2 = {}

	for iter_51_0, iter_51_1 in pairs(var_51_0) do
		var_51_2[iter_51_0] = (var_51_2[iter_51_0] or 0) + iter_51_1
	end

	for iter_51_2, iter_51_3 in pairs(var_51_1) do
		var_51_2[iter_51_2] = (var_51_2[iter_51_2] or 0) + iter_51_3
	end

	return var_51_2
end

function var_0_0.getCurExtraPoint(arg_52_0)
	return arg_52_0._rougeInfo and arg_52_0._rougeInfo.curExtraPoint or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
