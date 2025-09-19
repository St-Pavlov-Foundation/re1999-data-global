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
		"ui/viewres/fight/fightskin/0001/fight_skin_up_0001.prefab"
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
		local var_3_0 = arg_3_2:GetResource()

		table.insert(arg_3_0.effectList, gohelper.clone(var_3_0, arg_3_3))
	end
end

function var_0_0.onAllLoaded(arg_4_0)
	local var_4_0 = arg_4_0:com_registWorkDoneFlowSequence()
	local var_4_1 = FightDataHelper.handCardMgr.handCard

	tabletool.addValues(var_4_1, arg_4_0.distributeCards)
	FightCardDataHelper.combineCardListForPerformance(var_4_1)
	arg_4_0.fightViewHandCard:_updateHandCards()

	local var_4_2 = arg_4_0.fightViewHandCard._handCardItemList

	gohelper.setActive(arg_4_0.effectList[1], false)
	gohelper.setActive(arg_4_0.effectList[2], false)

	local var_4_3 = FightModel.instance:getUISpeed()

	var_4_0:registWork(FightWorkDelayTimer, 0.5 / var_4_3)
	var_4_0:registWork(FightWorkFunction, arg_4_0.showEffect, arg_4_0)

	for iter_4_0 = 1, #var_4_1 do
		local var_4_4 = var_4_2[iter_4_0]

		gohelper.setActive(var_4_4.go, false)
		var_4_0:registWork(FightWorkDelayTimer, 0.06 / var_4_3)
		var_4_0:registWork(FightWorkFunction, arg_4_0.showOnceCard, arg_4_0, var_4_4)
	end

	var_4_0:registWork(FightWorkDelayTimer, 1.3)
	var_4_0:registWork(FightWorkFunction, arg_4_0.stopCardAni, arg_4_0)
	var_4_0:registWork(FightWorkDelayTimer, 0.2)
	var_4_0:registWork(FightWorkFunction, arg_4_0.correctAppearance, arg_4_0)
	var_4_0:start()
end

function var_0_0.showEffect(arg_5_0)
	gohelper.setActive(arg_5_0.effectList[1], true)
	gohelper.setActive(arg_5_0.effectList[2], true)
end

function var_0_0.showOnceCard(arg_6_0, arg_6_1)
	arg_6_1:playCardAni("ui/animations/dynamic/fightcarditem_skin_0001.controller", "fightcarditem_skin_0001")
end

function var_0_0.stopCardAni(arg_7_0)
	local var_7_0 = FightDataHelper.handCardMgr.handCard
	local var_7_1 = arg_7_0.fightViewHandCard._handCardItemList

	for iter_7_0 = 1, #var_7_0 do
		local var_7_2 = var_7_1[iter_7_0]

		SLFramework.AnimatorPlayer.Get(var_7_2._innerGO):Stop()

		var_7_2._cardAni.runtimeAnimatorController = nil
		var_7_2._cardAni.enabled = false
	end
end

function var_0_0.correctAppearance(arg_8_0)
	local var_8_0 = FightDataHelper.handCardMgr.handCard
	local var_8_1 = arg_8_0.fightViewHandCard._handCardItemList

	for iter_8_0 = 1, #var_8_0 do
		local var_8_2 = var_8_1[iter_8_0]._innerGO.transform

		transformhelper.setLocalRotation(var_8_2, 0, 0, 0)
		transformhelper.setLocalScale(var_8_2, 1, 1, 1)
	end

	for iter_8_1, iter_8_2 in ipairs(arg_8_0.effectList) do
		gohelper.destroy(iter_8_2)
	end
end

return var_0_0
