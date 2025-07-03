module("modules.logic.fight.model.FightPlayCardModel", package.seeall)

local var_0_0 = class("FightPlayCardModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._clientSkillOpAll = {}
	arg_1_0._clientSkillOpList = {}
	arg_1_0._serverSkillOpList = {}
	arg_1_0._usedCards = {}
	arg_1_0._curIndex = 0
end

function var_0_0.getCurIndex(arg_2_0)
	return arg_2_0._curIndex
end

function var_0_0.playCard(arg_3_0, arg_3_1)
	arg_3_0._curIndex = arg_3_1
end

function var_0_0.clearUsedCards(arg_4_0)
	arg_4_0._usedCards = {}
	arg_4_0._curIndex = 0
end

function var_0_0.setUsedCard(arg_5_0, arg_5_1)
	arg_5_0:clearUsedCards()

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = FightCardInfoData.New(iter_5_1)

		table.insert(arg_5_0._usedCards, var_5_0)
	end
end

function var_0_0.addUseCard(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_0._usedCards then
		local var_6_0 = FightCardInfoData.New(arg_6_2)

		var_6_0.clientData.custom_fromSkillId = arg_6_3 or 0

		table.insert(arg_6_0._usedCards, arg_6_1, var_6_0)
	end
end

function var_0_0.getUsedCards(arg_7_0)
	return arg_7_0._usedCards
end

function var_0_0.updateClientOps(arg_8_0)
	arg_8_0._clientSkillOpAll = {}
	arg_8_0._clientSkillOpList = {}

	local var_8_0 = FightDataHelper.operationDataMgr:getOpList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if iter_8_1:isPlayCard() then
			arg_8_0:buildDisplayMOByOp(iter_8_1)

			if iter_8_1:needCopyCard() then
				arg_8_0:buildDisplayMOByOp(iter_8_1).isCopyCard = true
			end
		end
	end
end

function var_0_0.buildDisplayMOByOp(arg_9_0, arg_9_1)
	local var_9_0 = FightSkillDisplayMO.New()

	var_9_0.entityId = arg_9_1.belongToEntityId
	var_9_0.skillId = arg_9_1.skillId
	var_9_0.targetId = arg_9_1.toId

	table.insert(arg_9_0._clientSkillOpAll, 1, var_9_0)
	table.insert(arg_9_0._clientSkillOpList, 1, var_9_0)

	return var_9_0
end

function var_0_0.updateFightRound(arg_10_0, arg_10_1)
	arg_10_0._serverSkillOpList = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1.fightStep) do
		local var_10_0 = FightDataHelper.entityMgr:getById(iter_10_1.fromId)
		local var_10_1 = var_10_0 and var_10_0.side == FightEnum.EntitySide.MySide
		local var_10_2 = iter_10_1.actType == FightEnum.ActType.SKILL
		local var_10_3 = var_10_2 and FightCardDataHelper.isActiveSkill(iter_10_1.fromId, iter_10_1.actId) or false

		if var_10_1 and var_10_2 and var_10_3 then
			local var_10_4 = FightSkillDisplayMO.New()

			var_10_4.entityId = iter_10_1.fromId
			var_10_4.skillId = iter_10_1.actId
			var_10_4.targetId = iter_10_1.toId

			table.insert(arg_10_0._serverSkillOpList, 1, var_10_4)
		end
	end
end

function var_0_0.onEndRound(arg_11_0)
	arg_11_0._clientSkillOpAll = {}
	arg_11_0._clientSkillOpList = {}
	arg_11_0._serverSkillOpList = {}
end

function var_0_0.checkClientSkillMatch(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._clientSkillOpList[#arg_12_0._clientSkillOpList]

	if var_12_0 and var_12_0.entityId == arg_12_1 and var_12_0.skillId == arg_12_2 then
		return true
	end

	return false
end

function var_0_0.removeClientSkillOnce(arg_13_0)
	return table.remove(arg_13_0._clientSkillOpList, #arg_13_0._clientSkillOpList)
end

function var_0_0.onPlayOneSkillId(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0:checkClientSkillMatch(arg_14_1, arg_14_2) then
		table.remove(arg_14_0._clientSkillOpList, #arg_14_0._clientSkillOpList)
	else
		local var_14_0 = arg_14_0._clientSkillOpList[#arg_14_0._clientSkillOpList]

		logError("Play skill card not match: " .. arg_14_2 .. " " .. (var_14_0 and var_14_0.skillId or "nil"))
	end

	table.remove(arg_14_0._serverSkillOpList, #arg_14_0._serverSkillOpList)
end

function var_0_0.getClientSkillOpAll(arg_15_0)
	return arg_15_0._clientSkillOpAll
end

function var_0_0.getClientLeftSkillOpList(arg_16_0)
	return arg_16_0._clientSkillOpList
end

function var_0_0.clearClientLeftSkillOpList(arg_17_0)
	arg_17_0._clientSkillOpList = {}
end

function var_0_0.getServerLeftSkillOpList(arg_18_0)
	return arg_18_0._serverSkillOpList
end

function var_0_0.isPlayerHasSkillToPlay(arg_19_0, arg_19_1)
	if FightModel.instance:getVersion() >= 1 then
		for iter_19_0 = arg_19_0._curIndex + 1, #arg_19_0._usedCards do
			if arg_19_0._usedCards[iter_19_0].uid == arg_19_1 then
				return true
			end
		end

		return
	end

	for iter_19_1, iter_19_2 in ipairs(arg_19_0._serverSkillOpList) do
		if iter_19_2.entityId == arg_19_1 then
			return true
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
