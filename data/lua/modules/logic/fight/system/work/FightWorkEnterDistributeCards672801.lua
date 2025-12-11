module("modules.logic.fight.system.work.FightWorkEnterDistributeCards672801", package.seeall)

local var_0_0 = class("FightWorkEnterDistributeCards672801", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.fightViewHandCard = arg_1_1
	arg_1_0.distributeCards = arg_1_2
	arg_1_0.effectList = {}
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = {
		"ui/viewres/fight/fightskin/0001/fight_skin_down_0001.prefab",
		"ui/viewres/fight/fightskin/0001/fight_skin_up_0001.prefab",
		"ui/animations/dynamic/fightcarditem_skin_0001.controller"
	}
	local var_2_1 = {
		arg_2_0.fightViewHandCard.skinDownEffectRoot,
		arg_2_0.fightViewHandCard.skinUpEffectRoot
	}

	arg_2_0:cancelFightWorkSafeTimer()
	arg_2_0:com_loadListAsset(var_2_0, arg_2_0.onLoaded, arg_2_0.onAllLoaded, var_2_1)
end

function var_0_0.onLoaded(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 then
		if arg_3_3 then
			local var_3_0 = arg_3_2:GetResource()

			table.insert(arg_3_0.effectList, gohelper.clone(var_3_0, arg_3_3))
		else
			arg_3_0.runtimeAnimatorController = arg_3_2:GetResource()
		end
	end
end

function var_0_0.onAllLoaded(arg_4_0)
	local var_4_0 = FightDataHelper.handCardMgr.handCard

	tabletool.addValues(var_4_0, arg_4_0.distributeCards)
	FightCardDataHelper.combineCardListForPerformance(var_4_0)
	arg_4_0.fightViewHandCard:_updateHandCards()

	local var_4_1 = arg_4_0.fightViewHandCard._handCardItemList

	gohelper.setActive(arg_4_0.effectList[1], false)
	gohelper.setActive(arg_4_0.effectList[2], false)

	local var_4_2 = FightModel.instance:getUISpeed()
	local var_4_3 = arg_4_0:com_registWorkDoneFlowSequence()

	var_4_3:registWork(FightWorkDelayTimer, 0.5 / var_4_2)
	var_4_3:registWork(FightWorkFunction, arg_4_0.showEffect, arg_4_0)

	local var_4_4 = var_4_3:registWork(FightWorkFlowParallel)

	for iter_4_0 = 1, #var_4_0 do
		local var_4_5 = var_4_1[iter_4_0]

		gohelper.setActive(var_4_5.go, false)

		local var_4_6 = var_4_4:registWork(FightWorkFlowSequence)
		local var_4_7 = var_4_5._innerGO

		var_4_6:registWork(FightWorkDelayTimer, 0.06 / var_4_2 * iter_4_0)
		var_4_6:registWork(FightWorkFunction, arg_4_0.showCard, arg_4_0, var_4_5)
		var_4_6:registWork(FightWorkPlayAnimator, var_4_7, "fightcarditem_skin_0001", var_4_2, var_4_5._onCardAniFinish, var_4_5)
	end

	var_4_3:start()
end

function var_0_0.showCard(arg_5_0, arg_5_1)
	gohelper.setActive(arg_5_1.go, true)

	arg_5_1._cardAni.runtimeAnimatorController = arg_5_0.runtimeAnimatorController
end

function var_0_0.showEffect(arg_6_0)
	gohelper.setActive(arg_6_0.effectList[1], true)
	gohelper.setActive(arg_6_0.effectList[2], true)
	arg_6_0:com_registTimer(function()
		AudioMgr.instance:trigger(20300021)
	end, 0.5 / FightModel.instance:getSpeed())
end

function var_0_0.onDestructor(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.effectList) do
		gohelper.destroy(iter_8_1)
	end
end

return var_0_0
