module("modules.logic.fight.system.work.FightWorkAddHandCard", package.seeall)

local var_0_0 = class("FightWorkAddHandCard", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	if not FightCardDataHelper.cardChangeIsMySide(arg_1_0._actEffectMO) then
		arg_1_0:onDone(true)

		return
	end

	arg_1_0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	local var_1_0 = FightCardInfoMO.New()

	var_1_0:init(arg_1_0._actEffectMO.cardInfo)

	if arg_1_0._actEffectMO.cardInfo.skillId == 0 then
		local var_1_1 = ""
		local var_1_2 = FightLocalDataMgr.instance:getEntityById(arg_1_0._actEffectMO.cardInfo.uid)

		if var_1_2 then
			var_1_1 = var_1_2:getEntityName() or ""
		end

		local var_1_3 = "服务器下发了一张技能id为0的卡牌,卡牌归属者uid:%s,归属者名称:%s,所属步骤类型:%s, actId:%s"

		logError(string.format(var_1_3, arg_1_0._actEffectMO.cardInfo.uid, var_1_1, arg_1_0._fightStepMO.actType, arg_1_0._fightStepMO.actId))
	end

	local var_1_4 = FightCardModel.instance:getHandCards()

	table.insert(var_1_4, var_1_0)
	FightCardModel.instance:coverCard(var_1_4)

	if FightModel.instance:getVersion() >= 4 then
		local var_1_5 = 0.5

		arg_1_0:com_registTimer(arg_1_0._delayAfterPerformance, var_1_5)
		FightController.instance:dispatchEvent(FightEvent.AddHandCard, var_1_0)
	else
		FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(var_1_4))
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		arg_1_0:onDone(true)
	end
end

function var_0_0.clearWork(arg_2_0)
	if arg_2_0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return var_0_0
