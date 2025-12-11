module("modules.logic.fight.view.FightEnemyEntityAiUseCardView", package.seeall)

local var_0_0 = class("FightEnemyEntityAiUseCardView", FightBaseView)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.entityData = arg_1_1
	arg_1_0.entityId = arg_1_1.id
	arg_1_0.aiUseCardList = FightDataHelper.entityExMgr:getById(arg_1_0.entityId).aiUseCardList
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.itemObj = gohelper.findChild(arg_2_0.viewGO, "item")
	arg_2_0._opContainerCanvasGroup = gohelper.onceAddComponent(arg_2_0.viewGO, typeof(UnityEngine.CanvasGroup))

	gohelper.setActive(arg_2_0._opItemGO, false)

	arg_2_0.itemList = arg_2_0:com_registViewItemList(arg_2_0.itemObj, FightEnemyEntityAiUseCardItemView, arg_2_0.viewGO)
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0:com_registMsg(FightMsgId.RefreshEnemyAiUseCard, arg_3_0.onRefreshEnemyAiUseCard)
	arg_3_0:com_registMsg(FightMsgId.GetEnemyAiUseCardItemList, arg_3_0.onGetEnemyAiUseCardItemList)
	arg_3_0:com_registFightEvent(FightEvent.OnExPointChange, arg_3_0.onExPointChange)
	arg_3_0:com_registFightEvent(FightEvent.BeforePlayTimeline, arg_3_0.beforePlaySkill)
	arg_3_0:com_registFightEvent(FightEvent.OnMySideRoundEnd, arg_3_0.onMySideRoundEnd)
	arg_3_0:com_registFightEvent(FightEvent.GMHideFightView, arg_3_0.checkGMHideUI)
	arg_3_0:com_registFightEvent(FightEvent.OnStartSequenceFinish, arg_3_0.onStartSequenceFinish)
	arg_3_0:com_registFightEvent(FightEvent.OnRoundSequenceFinish, arg_3_0.onRoundSequenceFinish)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.itemList:setDataList(arg_4_0.aiUseCardList)
end

function var_0_0.onRefreshEnemyAiUseCard(arg_5_0)
	arg_5_0.itemList:setDataList(arg_5_0.aiUseCardList)
end

function var_0_0.onGetEnemyAiUseCardItemList(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0.entityId then
		return
	end

	return arg_6_0.itemList
end

function var_0_0.showOpContainer(arg_7_0, arg_7_1)
	arg_7_0:checkGMHideUI()

	if not gohelper.isNil(arg_7_0._opContainerCanvasGroup) then
		arg_7_0._opContainerCanvasGroup.alpha = 1
	end

	if arg_7_1 and arg_7_1 > 0 then
		arg_7_0:com_registSingleTimer(arg_7_0.hideOpContainer, arg_7_1)
	end
end

function var_0_0.hideOpContainer(arg_8_0)
	if not gohelper.isNil(arg_8_0._opContainerCanvasGroup) then
		arg_8_0._opContainerCanvasGroup.alpha = 0
	end
end

function var_0_0.onExPointChange(arg_9_0)
	gohelper.setActive(arg_9_0._opContainerCanvasGroup.gameObject, GMFightShowState.enemyOp)
end

function var_0_0.checkGMHideUI(arg_10_0)
	gohelper.setActive(arg_10_0._opContainerCanvasGroup.gameObject, GMFightShowState.enemyOp)
end

function var_0_0.beforePlaySkill(arg_11_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.ClothSkill) then
		return
	end

	arg_11_0:hideOpContainer()
end

function var_0_0.onMySideRoundEnd(arg_12_0)
	arg_12_0:showOpContainer()
end

function var_0_0.onStartSequenceFinish(arg_13_0)
	arg_13_0:showOpContainer()
end

function var_0_0.onRoundSequenceFinish(arg_14_0)
	arg_14_0:showOpContainer()
end

return var_0_0
