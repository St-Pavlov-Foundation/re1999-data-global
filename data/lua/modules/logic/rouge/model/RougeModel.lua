module("modules.logic.rouge.model.RougeModel", package.seeall)

local var_0_0 = class("RougeModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._rougeInfo = nil
end

function var_0_0.updateRougeInfo(arg_3_0, arg_3_1)
	arg_3_0._rougeInfo = arg_3_0._rougeInfo or RougeInfoMO.New()

	arg_3_0._rougeInfo:init(arg_3_1)

	if arg_3_1:HasField("mapInfo") then
		arg_3_0._mapModel = RougeMapModel.instance

		arg_3_0._mapModel:updateMapInfo(arg_3_1.mapInfo)
	end

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfo)
end

function var_0_0.updateResultInfo(arg_4_0, arg_4_1)
	arg_4_0._rougeResult = arg_4_0._rougeResult or RougeResultMO.New()

	arg_4_0._rougeResult:init(arg_4_1)
end

function var_0_0.getRougeInfo(arg_5_0)
	return arg_5_0._rougeInfo
end

function var_0_0.getRougeResult(arg_6_0)
	return arg_6_0._rougeResult
end

function var_0_0.getMapModel(arg_7_0)
	return arg_7_0._mapModel
end

function var_0_0.getSeason(arg_8_0)
	return arg_8_0._rougeInfo and arg_8_0._rougeInfo.season
end

function var_0_0.getVersion(arg_9_0)
	if not arg_9_0:inRouge() then
		local var_9_0 = RougeOutsideModel.instance:getRougeGameRecord()

		return var_9_0 and var_9_0:getVersionIds() or {}
	end

	return arg_9_0._rougeInfo and arg_9_0._rougeInfo.version or nil or {}
end

function var_0_0.getDifficulty(arg_10_0)
	return arg_10_0._rougeInfo and arg_10_0._rougeInfo.difficulty or nil
end

function var_0_0.getStyle(arg_11_0)
	return arg_11_0._rougeInfo and arg_11_0._rougeInfo.style or nil
end

function var_0_0.getTeamCapacity(arg_12_0)
	return arg_12_0._rougeInfo and arg_12_0._rougeInfo.teamSize
end

function var_0_0.getTeamInfo(arg_13_0)
	return arg_13_0._rougeInfo and arg_13_0._rougeInfo.teamInfo
end

function var_0_0.updatePower(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_0._rougeInfo then
		return
	end

	arg_14_0._rougeInfo.power = arg_14_1
	arg_14_0._rougeInfo.powerLimit = arg_14_2

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfoPower)
end

function var_0_0.updateTeamInfo(arg_15_0, arg_15_1)
	arg_15_0._rougeInfo:updateTeamInfo(arg_15_1)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTeamInfo)
end

function var_0_0.updateTeamLife(arg_16_0, arg_16_1)
	arg_16_0._rougeInfo:updateTeamLife(arg_16_1)
end

function var_0_0.updateExtraHeroInfo(arg_17_0, arg_17_1)
	arg_17_0._rougeInfo:updateExtraHeroInfo(arg_17_1)
end

function var_0_0.updateTeamLifeAndDispatchEvent(arg_18_0, arg_18_1)
	arg_18_0._rougeInfo:updateTeamLifeAndDispatchEvent(arg_18_1)
end

function var_0_0.updateTalentInfo(arg_19_0, arg_19_1)
	arg_19_0._rougeInfo:updateTalentInfo(arg_19_1)
	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeTalentInfo)
end

function var_0_0.isContinueLast(arg_20_0)
	if not arg_20_0._rougeInfo then
		return false
	end

	return arg_20_0._rougeInfo:isContinueLast()
end

function var_0_0.clear(arg_21_0)
	arg_21_0._mapModel = nil
	arg_21_0._rougeInfo = nil
	arg_21_0._isAbort = nil
	arg_21_0._rougeResult = nil
	arg_21_0._initHeroDict = nil

	RougeController.instance:dispatchEvent(RougeEvent.OnUpdateRougeInfo)
end

function var_0_0.isCanSelectRewards(arg_22_0)
	if not arg_22_0._rougeInfo then
		return false
	end

	return arg_22_0._rougeInfo:isCanSelectRewards()
end

function var_0_0.isFinishedDifficulty(arg_23_0)
	return arg_23_0._rougeInfo and arg_23_0._rougeInfo.state == RougeEnum.State.Difficulty
end

function var_0_0.isFinishedLastReward(arg_24_0)
	return arg_24_0._rougeInfo and arg_24_0._rougeInfo.state == RougeEnum.State.LastReward
end

function var_0_0.isFinishedStyle(arg_25_0)
	return arg_25_0._rougeInfo and arg_25_0._rougeInfo.state == RougeEnum.State.Style
end

function var_0_0.isStarted(arg_26_0)
	return arg_26_0._rougeInfo and arg_26_0._rougeInfo.state == RougeEnum.State.Start
end

function var_0_0.isFinish(arg_27_0)
	return arg_27_0._rougeInfo and arg_27_0._rougeInfo.state == RougeEnum.State.isEnd
end

function var_0_0.getState(arg_28_0)
	return arg_28_0._rougeInfo and arg_28_0._rougeInfo.state or RougeEnum.State.Empty
end

function var_0_0.inRouge(arg_29_0)
	local var_29_0 = arg_29_0:getState()

	return var_29_0 ~= RougeEnum.State.Empty and var_29_0 ~= RougeEnum.State.isEnd
end

function var_0_0.getEndId(arg_30_0)
	return arg_30_0._rougeInfo and arg_30_0._rougeInfo.endId
end

function var_0_0.updateFightResultMo(arg_31_0, arg_31_1)
	if not arg_31_0.fightResultMo then
		arg_31_0.fightResultMo = RougeFightResultMO.New()
	end

	arg_31_0.fightResultMo:init(arg_31_1)
end

function var_0_0.getFightResultInfo(arg_32_0)
	return arg_32_0.fightResultMo
end

function var_0_0.getLastRewardList(arg_33_0)
	return arg_33_0._rougeInfo and arg_33_0._rougeInfo.lastReward or {}
end

function var_0_0.getSelectRewardNum(arg_34_0)
	return arg_34_0._rougeInfo and arg_34_0._rougeInfo.selectRewardNum or 0
end

function var_0_0.getRougeRetryNum(arg_35_0)
	return arg_35_0._rougeInfo and arg_35_0._rougeInfo.retryNum or 0
end

function var_0_0.updateRetryNum(arg_36_0, arg_36_1)
	if arg_36_0._rougeInfo then
		arg_36_0._rougeInfo.retryNum = arg_36_1
	end
end

function var_0_0.isRetryFight(arg_37_0)
	local var_37_0 = arg_37_0:getRougeRetryNum()

	if not var_37_0 then
		return false
	end

	return var_37_0 > 0
end

function var_0_0.getEffectDict(arg_38_0)
	return arg_38_0._rougeInfo and arg_38_0._rougeInfo:getEffectDict()
end

function var_0_0.isAbortRouge(arg_39_0)
	return arg_39_0._isAbort
end

function var_0_0.onAbortRouge(arg_40_0)
	arg_40_0._isAbort = true
end

function var_0_0.getDeadHeroNum(arg_41_0)
	return arg_41_0._rougeInfo and arg_41_0._rougeInfo:getDeadHeroNum() or 0
end

function var_0_0.setTeamInitHeros(arg_42_0, arg_42_1)
	arg_42_0._initHeroDict = {}

	if arg_42_1 then
		for iter_42_0, iter_42_1 in ipairs(arg_42_1) do
			arg_42_0._initHeroDict[iter_42_1] = true
		end
	end
end

function var_0_0.isInitHero(arg_43_0, arg_43_1)
	local var_43_0 = false

	if arg_43_1 then
		var_43_0 = arg_43_0._initHeroDict and arg_43_0._initHeroDict[arg_43_1]
	end

	return var_43_0
end

function var_0_0.getInitHeroIds(arg_44_0)
	local var_44_0 = {}

	if arg_44_0._initHeroDict then
		for iter_44_0, iter_44_1 in pairs(arg_44_0._initHeroDict) do
			var_44_0[#var_44_0 + 1] = iter_44_0
		end
	end

	return var_44_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
