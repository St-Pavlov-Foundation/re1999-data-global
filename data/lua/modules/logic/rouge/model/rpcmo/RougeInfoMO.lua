module("modules.logic.rouge.model.rpcmo.RougeInfoMO", package.seeall)

local var_0_0 = pureTable("RougeInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	if arg_1_1:HasField("season") then
		arg_1_0.season = arg_1_1.season
	else
		arg_1_0.season = nil
	end

	arg_1_0.version = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.version) do
		table.insert(arg_1_0.version, iter_1_1)
	end

	arg_1_0.state = arg_1_1.state
	arg_1_0.difficulty = arg_1_1.difficulty
	arg_1_0.lastReward = arg_1_1.lastReward
	arg_1_0.selectRewardNum = arg_1_1.selectRewardNum
	arg_1_0.selectRewardId = arg_1_1.selectRewardId
	arg_1_0.style = arg_1_1.style
	arg_1_0.teamLevel = arg_1_1.teamLevel
	arg_1_0.teamExp = arg_1_1.teamExp
	arg_1_0.teamSize = arg_1_1.teamSize
	arg_1_0.coin = arg_1_1.coin
	arg_1_0.talentPoint = arg_1_1.talentPoint
	arg_1_0.power = arg_1_1.power
	arg_1_0.powerLimit = arg_1_1.powerLimit
	arg_1_0.endId = arg_1_1.endId
	arg_1_0.endId = arg_1_1.endId
	arg_1_0.retryNum = arg_1_1.retryNum
	arg_1_0.gameNum = arg_1_1.gameNum

	arg_1_0:updateTeamInfo(arg_1_1.teamInfo)

	if arg_1_1.talentTree then
		arg_1_0:updateTalentInfo(arg_1_1.talentTree.rougeTalent)
	end

	RougeCollectionModel.instance:init()
	RougeCollectionModel.instance:onReceiveNewInfo2Slot(arg_1_1.bag.layouts)
	RougeCollectionModel.instance:onReceiveNewInfo2Bag(arg_1_1.warehouse.items)
	arg_1_0:updateEffect(arg_1_1.effectInfo)
	arg_1_0:updateGameLimiterInfo(arg_1_1)
end

function var_0_0.updateTeamInfo(arg_2_0, arg_2_1)
	arg_2_0.teamInfo = RougeTeamInfoMO.New()

	arg_2_0.teamInfo:init(arg_2_1)
end

function var_0_0.updateTeamLife(arg_3_0, arg_3_1)
	if not arg_3_0.teamInfo then
		return
	end

	arg_3_0.teamInfo:updateTeamLife(arg_3_1)
end

function var_0_0.updateTeamLifeAndDispatchEvent(arg_4_0, arg_4_1)
	if not arg_4_0.teamInfo then
		return
	end

	arg_4_0.teamInfo:updateTeamLifeAndDispatchEvent(arg_4_1)
end

function var_0_0.updateExtraHeroInfo(arg_5_0, arg_5_1)
	if not arg_5_0.teamInfo then
		return
	end

	arg_5_0.teamInfo:updateExtraHeroInfo(arg_5_1)
end

function var_0_0.updateTalentInfo(arg_6_0, arg_6_1)
	arg_6_0.talentInfo = GameUtil.rpcInfosToList(arg_6_1, RougeTalentMO)
end

function var_0_0.isContinueLast(arg_7_0)
	return arg_7_0.state ~= RougeEnum.State.Empty and arg_7_0.state ~= RougeEnum.State.isEnd
end

function var_0_0.isCanSelectRewards(arg_8_0)
	return #arg_8_0.lastReward > 0
end

function var_0_0.updateEffect(arg_9_0, arg_9_1)
	arg_9_0.effectDict = arg_9_0.effectDict or {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_0 = iter_9_1.effectId

		for iter_9_2, iter_9_3 in ipairs(var_9_0) do
			if not arg_9_0.effectDict[iter_9_3] then
				arg_9_0.effectDict[iter_9_3] = RougeMapConfig.instance:getRougeEffect(iter_9_3)
			end
		end
	end
end

function var_0_0.getEffectDict(arg_10_0)
	return arg_10_0.effectDict
end

function var_0_0.getDeadHeroNum(arg_11_0)
	return arg_11_0.teamInfo and arg_11_0.teamInfo:getDeadHeroNum() or 0
end

function var_0_0.updateGameLimiterInfo(arg_12_0, arg_12_1)
	arg_12_0._gameLimiterMo = nil

	if arg_12_1:HasField("limiterInfo") then
		arg_12_0._gameLimiterMo = RougeGameLimiterMO.New()

		arg_12_0._gameLimiterMo:init(arg_12_1.limiterInfo)
	end
end

function var_0_0.getGameLimiterMo(arg_13_0)
	return arg_13_0._gameLimiterMo
end

function var_0_0.checkMountDlc(arg_14_0)
	return arg_14_0.version and #arg_14_0.version > 0
end

return var_0_0
