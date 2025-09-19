module("modules.logic.versionactivity2_5.autochess.model.AutoChessMO", package.seeall)

local var_0_0 = pureTable("AutoChessMO")

function var_0_0.updateSvrScene(arg_1_0, arg_1_1)
	arg_1_0:updateSvrBaseInfo(arg_1_1.baseInfo)
	arg_1_0:updateSvrFight(arg_1_1.fight)
	arg_1_0:updateSvrMall(arg_1_1.mall)
end

function var_0_0.updateSvrBaseInfo(arg_2_0, arg_2_1)
	arg_2_0.sceneRound = arg_2_1.sceneRound
	arg_2_0.preview = arg_2_1.preview
	arg_2_0.previewCoin = arg_2_1.previewCoin
	arg_2_0.buyInfos = arg_2_1.buyInfos
end

function var_0_0.updateSvrMall(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.svrMall then
		local var_3_0 = AutoChessHelper.getMallRegionByType(arg_3_0.svrMall.regions, AutoChessEnum.MallType.Normal)
		local var_3_1 = AutoChessHelper.getMallRegionByType(arg_3_1.regions, AutoChessEnum.MallType.Normal)

		if var_3_0.mallId ~= var_3_1.mallId then
			arg_3_0.mallUpgrade = true
		end

		arg_3_0.lastRewardProgress = arg_3_0.svrMall.rewardProgress
	end

	arg_3_0.svrMall = arg_3_1
	arg_3_0.svrMall.coin = tonumber(arg_3_1.coin)

	if arg_3_2 then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMallData)
	end
end

function var_0_0.updateSvrMallCoin(arg_4_0, arg_4_1)
	arg_4_1 = tonumber(arg_4_1)
	arg_4_0.svrMall.coin = arg_4_1

	AutoChessController.instance:dispatchEvent(AutoChessEvent.MallCoinChange)
end

function var_0_0.updateSvrMallRegion(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0 = 1, #arg_5_0.svrMall.regions do
		if arg_5_0.svrMall.regions[iter_5_0].mallId == arg_5_1.mallId then
			arg_5_0.svrMall.regions[iter_5_0] = arg_5_1

			break
		end
	end

	if arg_5_2 then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMallRegion)
	end
end

function var_0_0.updateSvrTurn(arg_6_0, arg_6_1)
	arg_6_0:updateSvrStep(arg_6_1.step)
	arg_6_0:analyzeStepList(arg_6_0.svrStepList)
end

function var_0_0.analyzeStepList(arg_7_0, arg_7_1)
	arg_7_0.fightEffectList = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		if iter_7_1.actionType == AutoChessEnum.ActionType.RoundStart then
			arg_7_0.fightEffectList = iter_7_1.effect
		elseif iter_7_1.actionType == AutoChessEnum.ActionType.StartBuy then
			arg_7_0.startBuyEffectList = iter_7_1.effect
		elseif iter_7_1.actionType == AutoChessEnum.ActionType.EndBuy then
			arg_7_0.endBuyEffectList = iter_7_1.effect
		elseif iter_7_1.actionType == AutoChessEnum.ActionType.Immediately then
			AutoChessController.instance:dispatchEvent(AutoChessEvent.PlayStepList, iter_7_1.effect)
		elseif iter_7_1.actionType == AutoChessEnum.ActionType.FightData then
			local var_7_0 = iter_7_1.effect[1]

			if var_7_0 and var_7_0.effectType == AutoChessEnum.EffectType.FightUpdate then
				arg_7_0:updateSvrFight(var_7_0.fight)
			end
		end
	end
end

function var_0_0.cacheSvrFight(arg_8_0)
	arg_8_0.lastSvrFight = arg_8_0.svrFight
end

function var_0_0.updateSvrFight(arg_9_0, arg_9_1)
	arg_9_0.svrFight = AutoChessFightMO.New()

	arg_9_0.svrFight:init(arg_9_1)
end

function var_0_0.updateSvrStep(arg_10_0, arg_10_1)
	arg_10_0.svrStepList = arg_10_1
end

function var_0_0.freezeReply(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2 == AutoChessEnum.FreeZeType.Freeze

	for iter_11_0, iter_11_1 in ipairs(arg_11_0.svrMall.regions) do
		if iter_11_1.mallId == arg_11_1 then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.items) do
				iter_11_3.freeze = var_11_0
			end

			break
		end
	end
end

function var_0_0.clearData(arg_12_0)
	arg_12_0.sceneRound = nil
	arg_12_0.svrMall = nil
	arg_12_0.svrFight = nil
	arg_12_0.svrStepList = nil
end

function var_0_0.getChessPosition(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_3 = arg_13_3 or arg_13_0.svrFight

	if arg_13_1 == AutoChessEnum.WarZone.Four then
		for iter_13_0, iter_13_1 in ipairs(arg_13_3.unwarZone.positions) do
			if iter_13_1.index == arg_13_2 - 1 then
				return iter_13_1
			end
		end
	else
		for iter_13_2, iter_13_3 in ipairs(arg_13_3.warZones) do
			if iter_13_3.id == arg_13_1 then
				for iter_13_4, iter_13_5 in ipairs(iter_13_3.positions) do
					if iter_13_5.index == arg_13_2 - 1 then
						return iter_13_5
					end
				end
			end
		end
	end

	logError(string.format("异常:不存在战区%s站位%s的ChessPos数据", arg_13_1, arg_13_2))
end

function var_0_0.getChessPosition1(arg_14_0, arg_14_1, arg_14_2)
	arg_14_2 = arg_14_2 or arg_14_0.svrFight

	for iter_14_0, iter_14_1 in ipairs(arg_14_2.warZones) do
		for iter_14_2, iter_14_3 in ipairs(iter_14_1.positions) do
			if iter_14_3.chess.uid == arg_14_1 then
				return iter_14_3, iter_14_1.id
			end
		end
	end

	logError(string.format("异常:不存在包含棋子%s的ChessPos数据", arg_14_1))
end

function var_0_0.getEmptyPos(arg_15_0, arg_15_1)
	if arg_15_1 == AutoChessStrEnum.ChessType.Incubate then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.svrFight.unwarZone.positions) do
			if iter_15_1.teamType == AutoChessEnum.TeamType.Player and tonumber(iter_15_1.chess.uid) == 0 then
				return arg_15_0.svrFight.unwarZone.id, iter_15_1.index + 1
			end
		end
	else
		for iter_15_2, iter_15_3 in ipairs(arg_15_0.svrFight.warZones) do
			if arg_15_1 == AutoChessEnum.WarZoneType[iter_15_3.type] then
				for iter_15_4, iter_15_5 in ipairs(iter_15_3.positions) do
					if iter_15_5.teamType == AutoChessEnum.TeamType.Player and tonumber(iter_15_5.chess.uid) == 0 then
						return iter_15_3.id, iter_15_5.index + 1
					end
				end
			end
		end
	end
end

function var_0_0.checkCostEnough(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_1 == AutoChessStrEnum.CostType.Coin then
		if arg_16_2 <= tonumber(arg_16_0.svrMall.coin) then
			return true
		else
			return false, ToastEnum.AutoChessCoinNotEnough
		end
	elseif arg_16_1 == AutoChessStrEnum.CostType.Hp then
		if arg_16_2 < tonumber(arg_16_0.svrFight.mySideMaster.hp) then
			return true
		else
			return false, ToastEnum.AutoChessHpNotEnough
		end
	end

	return false, ToastEnum.AutoChessCoinNotEnough
end

return var_0_0
