module("modules.logic.sp01.act205.controller.Act205CardController", package.seeall)

local var_0_0 = class("Act205CardController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.openCardEnterView(arg_3_0)
	local var_3_0 = Act205CardModel.instance:getGameStageId()

	if not Act205Model.instance:isGameStageOpen(var_3_0, true) then
		return
	end

	local var_3_1 = Act205Model.instance:getAct205Id()

	Activity205Rpc.instance:sendAct205GetInfoRequest(var_3_1, arg_3_0._realOpenCardEnterView, arg_3_0)
end

function var_0_0._realOpenCardEnterView(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_2 ~= 0 then
		return
	end

	local var_4_0 = {}
	local var_4_1 = Act205Model.instance:getAct205Id()

	var_4_0.activityId = var_4_1
	var_4_0.gameStageId = Act205CardModel.instance:getGameStageId()

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(var_4_1)
	ViewMgr.instance:openView(ViewName.Act205GameStartView, var_4_0)
end

function var_0_0.enterCardGame(arg_5_0)
	Act205CardModel.instance:clearSelectedCard()

	local var_5_0 = Act205CardModel.instance:getGameStageId()

	if not Act205Model.instance:isGameStageOpen(var_5_0, true) then
		return
	end

	if Act205CardModel.instance:getGameCount() <= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.Act205CardSelectView)
end

function var_0_0.openCardShowView(arg_6_0)
	ViewMgr.instance:openView(ViewName.Act205CardShowView)
	ViewMgr.instance:closeView(ViewName.Act205CardSelectView)
end

function var_0_0.openCardResultView(arg_7_0, arg_7_1, arg_7_2)
	ViewMgr.instance:openView(ViewName.Act205CardResultView, {
		point = arg_7_1,
		rewardId = arg_7_2
	})
end

function var_0_0.beginNewCardGame(arg_8_0)
	local var_8_0 = Act205CardModel.instance:getGameStageId()

	if not Act205Model.instance:isGameStageOpen(var_8_0, true) then
		return
	end

	local var_8_1 = Act205Model.instance:getAct205Id()

	Activity205Rpc.instance:sendAct205GetInfoRequest(var_8_1, arg_8_0._onBeginNewCardGame, arg_8_0)
end

function var_0_0._onBeginNewCardGame(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 ~= 0 then
		return
	end

	local var_9_0 = Act205Model.instance:getAct205Id()

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(var_9_0)
	arg_9_0:enterCardGame()
	ViewMgr.instance:closeView(ViewName.Act205CardShowView)
	ViewMgr.instance:closeView(ViewName.Act205CardResultView)
end

function var_0_0.getEnemyCardIdList(arg_10_0)
	return Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.EnemyCard) or arg_10_0:_generateCardIdList(false)
end

function var_0_0.getPlayerCardIdList(arg_11_0)
	return Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.PlayerCard) or arg_11_0:_generateCardIdList(true)
end

local function var_0_1(arg_12_0, arg_12_1)
	local var_12_0 = Act205Config.instance:getCardType(arg_12_0)
	local var_12_1 = Act205Config.instance:getCardType(arg_12_1)

	if var_12_0 ~= var_12_1 then
		return var_12_1 < var_12_0
	end

	return arg_12_0 < arg_12_1
end

function var_0_0._generateCardIdList(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}
	local var_13_1 = arg_13_1 and Act205Enum.ConstId.CardGamePlayerCardCount or Act205Enum.ConstId.CardGameEnemyCardCount
	local var_13_2 = Act205Config.instance:getAct205Const(var_13_1, true)

	if not var_13_2 or var_13_2 < 0 then
		return var_13_0
	end

	local var_13_3 = {}

	if arg_13_2 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_2) do
			var_13_3[iter_13_1] = true
		end
	end

	local var_13_4 = {}

	if arg_13_1 then
		local var_13_5 = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.EnemyCard)

		if var_13_5 then
			for iter_13_2, iter_13_3 in ipairs(var_13_5) do
				var_13_4[Act205Config.instance:getCardType(iter_13_3)] = iter_13_3
			end
		end
	end

	local var_13_6 = Act205Config.instance:getAct205Const(Act205Enum.ConstId.MinimumGuaranteeCard)
	local var_13_7 = string.splitToNumber(var_13_6, "#")
	local var_13_8 = var_13_7[1]
	local var_13_9 = var_13_7[2]

	if var_13_8 > Act205CardModel.instance:getContinueFailCount() then
		var_13_9 = nil
	end

	local var_13_10 = Act205Config.instance:getCardTypeDict()

	for iter_13_4, iter_13_5 in pairs(var_13_10) do
		local var_13_11
		local var_13_12 = var_13_4[iter_13_4]

		if var_13_12 then
			var_13_11 = Act205Config.instance:getBeRestrainedCard(var_13_12)
		end

		local var_13_13 = {}
		local var_13_14 = 0
		local var_13_15 = var_13_2

		for iter_13_6, iter_13_7 in ipairs(iter_13_5) do
			if not Act205Config.instance:isSpCard(iter_13_7) or arg_13_1 then
				if iter_13_7 == var_13_11 or iter_13_7 == var_13_9 then
					table.insert(var_13_0, iter_13_7)

					var_13_15 = var_13_15 - 1
				else
					var_13_14 = var_13_14 + Act205Config.instance:getCardWeight(iter_13_7, var_13_3[iter_13_7])
					var_13_13[#var_13_13 + 1] = iter_13_6
				end
			end
		end

		for iter_13_8 = 1, var_13_15 do
			local var_13_16 = #var_13_13

			if var_13_16 == 0 or var_13_14 <= 0 then
				logError("Act205CardController:_generateCardIdList error, card not enough, cardType:%s, hasCount:%s, needCount:%s", iter_13_4, #iter_13_5, var_13_15)

				break
			end

			local var_13_17 = math.random(var_13_14)
			local var_13_18 = 0

			for iter_13_9 = 1, var_13_16 do
				local var_13_19 = iter_13_5[var_13_13[iter_13_9]]
				local var_13_20 = Act205Config.instance:getCardWeight(var_13_19, var_13_3[var_13_19])

				var_13_18 = var_13_18 + var_13_20

				if var_13_17 <= var_13_18 then
					table.insert(var_13_0, var_13_19)

					var_13_14 = var_13_14 - var_13_20

					table.remove(var_13_13, iter_13_9)

					break
				end
			end
		end
	end

	table.sort(var_13_0, var_0_1)

	local var_13_21 = arg_13_1 and Act205Enum.CardGameCacheKey.PlayerCard or Act205Enum.CardGameCacheKey.EnemyCard

	Act205CardModel.instance:setCacheKeyData(var_13_21, var_13_0)

	return var_13_0
end

function var_0_0.playerClickCard(arg_14_0, arg_14_1)
	local var_14_0 = Act205CardModel.instance:isCardSelected(arg_14_1)

	Act205CardModel.instance:setSelectedCard(arg_14_1, not var_14_0)
	arg_14_0:dispatchEvent(Act205Event.PlayerSelectCard, arg_14_1)
end

function var_0_0.checkPkPoint(arg_15_0)
	local var_15_0 = Act205CardModel.instance:getGameStageId()

	if not Act205Model.instance:isGameStageOpen(var_15_0, true) then
		return
	end

	local var_15_1 = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.EnemyCard)

	if not var_15_1 then
		logError("Act205CardController.checkPkPoint error, no enemyCardList")

		return
	end

	if not Act205CardModel.instance:getIsCanBeginPK() then
		return
	end

	local var_15_2 = Act205Config.instance:getAct205Const(Act205Enum.ConstId.CardGameBasePoint, true)

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		local var_15_3 = Act205Config.instance:getCardType(iter_15_1)
		local var_15_4 = Act205CardModel.instance:getSelectedCard(var_15_3)

		if not var_15_4 then
			return
		end

		local var_15_5 = arg_15_0:getCardPKResult(var_15_4, iter_15_1)

		Act205CardModel.instance:setPkResult(var_15_3, var_15_5)

		var_15_2 = var_15_2 + var_15_5
	end

	Act205CardModel.instance:setResultPoint(var_15_2)

	return var_15_2
end

function var_0_0.getCardPKResult(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = Act205Enum.CardPKResult
	local var_16_1 = var_16_0.Draw

	if Act205Config.instance:isSpCard(arg_16_1) then
		local var_16_2 = Act205Config.instance:getSpEff(arg_16_1)

		if var_16_2 == Act205Enum.SpEffType.All then
			var_16_1 = var_16_0.Restrain
		elseif var_16_2 == Act205Enum.SpEffType.Half then
			var_16_1 = math.random() < 0.5 and var_16_0.Restrain or var_16_0.BeRestrained
		else
			logError(string.format("Act205CardController:getCardPKResult error, spEff not support, spEff:%s", var_16_2))
		end
	else
		local var_16_3 = Act205Config.instance:getIsCardRestrain(arg_16_1, arg_16_2)
		local var_16_4 = Act205Config.instance:getIsCardBeRestrained(arg_16_1, arg_16_2)

		if var_16_3 then
			var_16_1 = var_16_0.Restrain
		elseif var_16_4 then
			var_16_1 = var_16_0.BeRestrained
		end
	end

	return var_16_1
end

function var_0_0.cardGameFinishGetReward(arg_17_0)
	local var_17_0 = Act205CardModel.instance:getGameStageId()

	if not Act205Model.instance:isGameStageOpen(var_17_0, true) then
		return
	end

	local var_17_1 = Act205CardModel.instance:getResultPoint() or arg_17_0:checkPkPoint()

	if not var_17_1 then
		var_17_1 = Act205Config.instance:getMaxPoint()

		Act205CardModel.instance:setResultPoint(var_17_1)
	end

	local var_17_2 = var_17_1 > Act205Enum.CardGameFailPoint
	local var_17_3 = 0

	if not var_17_2 then
		var_17_3 = Act205CardModel.instance:getContinueFailCount() + 1
	end

	local var_17_4 = Act205Config.instance:getRewardId(var_17_1)
	local var_17_5 = {
		activityId = Act205Model.instance:getAct205Id(),
		gameType = var_17_0,
		gameInfo = tostring(var_17_3),
		rewardId = var_17_4
	}

	Activity205Rpc.instance:sendAct205FinishGameRequest(var_17_5, arg_17_0._onGetCardGameReward, arg_17_0)
end

function var_0_0._onGetCardGameReward(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2 ~= 0 then
		return
	end

	local var_18_0 = Act205CardModel.instance:getResultPoint()

	arg_18_0:openCardResultView(var_18_0, arg_18_3.rewardId)
	Act205CardModel.instance:setResultPoint()

	local var_18_1 = Act205Model.instance:getAct205Id()

	Activity205Rpc.instance:sendAct205GetGameInfoRequest(var_18_1, arg_18_0._generateCard, arg_18_0)
end

function var_0_0._generateCard(arg_19_0)
	local var_19_0 = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.EnemyCard)

	arg_19_0:_generateCardIdList(false, var_19_0)

	local var_19_1 = Act205CardModel.instance:getCacheKeyData(Act205Enum.CardGameCacheKey.PlayerCard)

	arg_19_0:_generateCardIdList(true, var_19_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
