module("modules.logic.rouge.model.rpcmo.RougeInfoMO", package.seeall)

slot0 = pureTable("RougeInfoMO")

function slot0.init(slot0, slot1)
	if slot1:HasField("season") then
		slot0.season = slot1.season
	else
		slot0.season = nil
	end

	slot0.version = {}

	for slot5, slot6 in ipairs(slot1.version) do
		table.insert(slot0.version, slot6)
	end

	slot0.state = slot1.state
	slot0.difficulty = slot1.difficulty
	slot0.lastReward = slot1.lastReward
	slot0.selectRewardNum = slot1.selectRewardNum
	slot0.selectRewardId = slot1.selectRewardId
	slot0.style = slot1.style
	slot0.teamLevel = slot1.teamLevel
	slot0.teamExp = slot1.teamExp
	slot0.teamSize = slot1.teamSize
	slot0.coin = slot1.coin
	slot0.talentPoint = slot1.talentPoint
	slot0.power = slot1.power
	slot0.powerLimit = slot1.powerLimit
	slot0.endId = slot1.endId
	slot0.endId = slot1.endId
	slot0.retryNum = slot1.retryNum
	slot0.gameNum = slot1.gameNum

	slot0:updateTeamInfo(slot1.teamInfo)

	if slot1.talentTree then
		slot0:updateTalentInfo(slot1.talentTree.rougeTalent)
	end

	RougeCollectionModel.instance:init()
	RougeCollectionModel.instance:onReceiveNewInfo2Slot(slot1.bag.layouts)
	RougeCollectionModel.instance:onReceiveNewInfo2Bag(slot1.warehouse.items)
	slot0:updateEffect(slot1.effectInfo)
	slot0:updateGameLimiterInfo(slot1)
end

function slot0.updateTeamInfo(slot0, slot1)
	slot0.teamInfo = RougeTeamInfoMO.New()

	slot0.teamInfo:init(slot1)
end

function slot0.updateTeamLife(slot0, slot1)
	if not slot0.teamInfo then
		return
	end

	slot0.teamInfo:updateTeamLife(slot1)
end

function slot0.updateTeamLifeAndDispatchEvent(slot0, slot1)
	if not slot0.teamInfo then
		return
	end

	slot0.teamInfo:updateTeamLifeAndDispatchEvent(slot1)
end

function slot0.updateExtraHeroInfo(slot0, slot1)
	if not slot0.teamInfo then
		return
	end

	slot0.teamInfo:updateExtraHeroInfo(slot1)
end

function slot0.updateTalentInfo(slot0, slot1)
	slot0.talentInfo = GameUtil.rpcInfosToList(slot1, RougeTalentMO)
end

function slot0.isContinueLast(slot0)
	return slot0.state ~= RougeEnum.State.Empty and slot0.state ~= RougeEnum.State.isEnd
end

function slot0.isCanSelectRewards(slot0)
	return #slot0.lastReward > 0
end

function slot0.updateEffect(slot0, slot1)
	slot0.effectDict = slot0.effectDict or {}

	for slot5, slot6 in ipairs(slot1) do
		for slot11, slot12 in ipairs(slot6.effectId) do
			if not slot0.effectDict[slot12] then
				slot0.effectDict[slot12] = RougeMapConfig.instance:getRougeEffect(slot12)
			end
		end
	end
end

function slot0.getEffectDict(slot0)
	return slot0.effectDict
end

function slot0.getDeadHeroNum(slot0)
	return slot0.teamInfo and slot0.teamInfo:getDeadHeroNum() or 0
end

function slot0.updateGameLimiterInfo(slot0, slot1)
	slot0._gameLimiterMo = nil

	if slot1:HasField("limiterInfo") then
		slot0._gameLimiterMo = RougeGameLimiterMO.New()

		slot0._gameLimiterMo:init(slot1.limiterInfo)
	end
end

function slot0.getGameLimiterMo(slot0)
	return slot0._gameLimiterMo
end

function slot0.checkMountDlc(slot0)
	return slot0.version and #slot0.version > 0
end

return slot0
