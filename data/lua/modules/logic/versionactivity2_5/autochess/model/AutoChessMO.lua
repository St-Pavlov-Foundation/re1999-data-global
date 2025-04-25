module("modules.logic.versionactivity2_5.autochess.model.AutoChessMO", package.seeall)

slot0 = pureTable("AutoChessMO")

function slot0.updateSvrScene(slot0, slot1)
	slot0:updateSvrBaseInfo(slot1.baseInfo)
	slot0:updateSvrFight(slot1.fight)
	slot0:updateSvrMall(slot1.mall)
end

function slot0.updateSvrBaseInfo(slot0, slot1)
	slot0.sceneRound = slot1.sceneRound
	slot0.preview = slot1.preview
	slot0.previewCoin = slot1.previewCoin
	slot0.buyInfos = slot1.buyInfos
end

function slot0.updateSvrMall(slot0, slot1, slot2)
	if slot0.svrMall then
		if AutoChessHelper.getMallRegionByType(slot0.svrMall.regions, AutoChessEnum.MallType.Normal).mallId ~= AutoChessHelper.getMallRegionByType(slot1.regions, AutoChessEnum.MallType.Normal).mallId then
			slot0.mallUpgrade = true
		end

		slot0.lastRewardProgress = slot0.svrMall.rewardProgress
	end

	slot0.svrMall = slot1
	slot0.svrMall.coin = tonumber(slot1.coin)

	if slot2 then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMallData)
	end
end

function slot0.updateSvrMallCoin(slot0, slot1)
	slot0.svrMall.coin = tonumber(slot1)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.MallCoinChange)
end

function slot0.updateSvrMallRegion(slot0, slot1, slot2)
	for slot6 = 1, #slot0.svrMall.regions do
		if slot0.svrMall.regions[slot6].mallId == slot1.mallId then
			slot0.svrMall.regions[slot6] = slot1

			break
		end
	end

	if slot2 then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMallRegion)
	end
end

function slot0.updateSvrTurn(slot0, slot1)
	slot0:updateSvrStep(slot1.step)
	slot0:analyzeStepList(slot0.svrStepList)
end

function slot0.analyzeStepList(slot0, slot1)
	slot0.fightEffectList = {}

	for slot5, slot6 in ipairs(slot1) do
		if slot6.actionType == AutoChessEnum.ActionType.RoundStart then
			slot0.fightEffectList = slot6.effect
		elseif slot6.actionType == AutoChessEnum.ActionType.StartBuy then
			slot0.startBuyEffectList = slot6.effect
		elseif slot6.actionType == AutoChessEnum.ActionType.EndBuy then
			slot0.endBuyEffectList = slot6.effect
		elseif slot6.actionType == AutoChessEnum.ActionType.Immediately then
			AutoChessController.instance:dispatchEvent(AutoChessEvent.PlayStepList, slot6.effect)
		elseif slot6.actionType == AutoChessEnum.ActionType.FightData and slot6.effect[1] and slot7.effectType == AutoChessEnum.EffectType.FightUpdate then
			slot0:updateSvrFight(slot7.fight)
		end
	end
end

function slot0.cacheSvrFight(slot0)
	slot0.lastSvrFight = slot0.svrFight
end

function slot0.updateSvrFight(slot0, slot1)
	slot0.svrFight = AutoChessFightMO.New()

	slot0.svrFight:init(slot1)
end

function slot0.updateSvrStep(slot0, slot1)
	slot0.svrStepList = slot1
end

function slot0.freezeReply(slot0, slot1, slot2)
	slot3 = slot2 == AutoChessEnum.FreeZeType.Freeze

	for slot7, slot8 in ipairs(slot0.svrMall.regions) do
		if slot8.mallId == slot1 then
			for slot12, slot13 in ipairs(slot8.items) do
				slot13.freeze = slot3
			end

			break
		end
	end
end

function slot0.clearData(slot0)
	slot0.sceneRound = nil
	slot0.svrMall = nil
	slot0.svrFight = nil
	slot0.svrStepList = nil
end

function slot0.getChessPosition(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs((slot3 or slot0.svrFight).warZones) do
		if slot8.id == slot1 then
			for slot12, slot13 in ipairs(slot8.positions) do
				if slot13.index == slot2 - 1 then
					return slot13
				end
			end
		end
	end

	logError(string.format("异常:不存在战区%s站位%s的ChessPos数据"), slot1, slot2)
end

function slot0.getChessPosition1(slot0, slot1, slot2)
	for slot6, slot7 in ipairs((slot2 or slot0.svrFight).warZones) do
		for slot11, slot12 in ipairs(slot7.positions) do
			if slot12.chess.uid == slot1 then
				return slot12
			end
		end
	end

	logError(string.format("异常:不存在包含棋子%s的ChessPos数据", slot1))
end

function slot0.getEmptyPos(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.svrFight.warZones) do
		if slot1 == AutoChessEnum.WarZoneType[slot6.type] then
			for slot10, slot11 in ipairs(slot6.positions) do
				if slot11.teamType == AutoChessEnum.TeamType.Player and tonumber(slot11.chess.uid) == 0 then
					return slot6.id, slot11.index + 1
				end
			end
		end
	end
end

function slot0.checkCostEnough(slot0, slot1, slot2)
	if slot1 == AutoChessStrEnum.CostType.Coin then
		if slot2 <= tonumber(slot0.svrMall.coin) then
			return true
		end
	elseif slot1 == AutoChessStrEnum.CostType.Hp and slot2 <= tonumber(slot0.svrFight.mySideMaster.hp) then
		return true
	end

	return false
end

return slot0
