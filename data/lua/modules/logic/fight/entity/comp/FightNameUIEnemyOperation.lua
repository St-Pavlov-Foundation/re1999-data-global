module("modules.logic.fight.entity.comp.FightNameUIEnemyOperation", package.seeall)

local var_0_0 = class("FightNameUIEnemyOperation", FightBaseView)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._opContainerCanvasGroup = gohelper.onceAddComponent(arg_1_2, typeof(UnityEngine.CanvasGroup))
	arg_1_0._opItemGO = arg_1_3

	gohelper.setActive(arg_1_0._opItemGO, false)

	arg_1_0._itemList = arg_1_0:com_registViewItemList(arg_1_0._opItemGO, FightNameUIOperationItem, arg_1_2)

	arg_1_0._itemList:setFuncNames("refreshItemData")

	arg_1_0.entity = arg_1_1
	arg_1_0._entityMO = arg_1_0.entity:getMO()
	arg_1_0.playCardInfoList = {}

	arg_1_0:setPlayCardInfo()
	arg_1_0:com_registMsg(FightMsgId.Act174MonsterAiCard, arg_1_0._onAct174MonsterAiCard)
	arg_1_0:com_registFightEvent(FightEvent.OnInvokeSkill, arg_1_0._onInvokeSkill)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart)
	arg_1_0:com_registFightEvent(FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate)
	arg_1_0:com_registFightEvent(FightEvent.GMHideFightView, arg_1_0._checkGMHideUI)
	arg_1_0:com_registFightEvent(FightEvent.InvalidEnemyUsedCard, arg_1_0._onInvalidEnemyUsedCard)
end

function var_0_0._onAct174MonsterAiCard(arg_2_0)
	arg_2_0:setPlayCardInfo()
end

function var_0_0.setPlayCardInfo(arg_3_0)
	FightDataUtil.coverData(FightDataHelper.playCardMgr.enemyAct174PlayCard, arg_3_0.playCardInfoList)

	for iter_3_0 = #arg_3_0.playCardInfoList, 1, -1 do
		if arg_3_0.playCardInfoList[iter_3_0].uid ~= arg_3_0._entityMO.uid then
			table.remove(arg_3_0.playCardInfoList, iter_3_0)
		end
	end

	arg_3_0._itemList:setDataList(arg_3_0.playCardInfoList)
end

function var_0_0._checkGMHideUI(arg_4_0)
	gohelper.setActive(arg_4_0._opContainerCanvasGroup.gameObject, GMFightShowState.enemyOp)
end

function var_0_0._onSkillPlayStart(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_1.id ~= arg_5_0.entity.id then
		return
	end

	arg_5_0:_checkPlaySkill(arg_5_3)
end

function var_0_0._checkPlaySkill(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._itemList) do
		if iter_6_1._cardData.index == arg_6_1.cardIndex then
			iter_6_1.animator:Play("fightname_op_play", nil, nil)
			arg_6_0._itemList:removeIndexDelayRecycle(iter_6_0, 0.67)

			break
		end
	end
end

function var_0_0._onInvokeSkill(arg_7_0, arg_7_1)
	if arg_7_1.fromId ~= arg_7_0.entity.id then
		return
	end

	arg_7_0:_checkPlaySkill(arg_7_1)
end

function var_0_0._onBuffUpdate(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_1 ~= arg_8_0.entity.id then
		return
	end

	if arg_8_2 == FightEnum.EffectType.BUFFADD or arg_8_2 == FightEnum.EffectType.BUFFDEL then
		arg_8_0:_checkPlayForbid()
	end
end

function var_0_0._checkPlayForbid(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._itemList) do
		iter_9_1:_refreshAni()
	end
end

function var_0_0._onInvalidEnemyUsedCard(arg_10_0, arg_10_1)
	if arg_10_0._itemList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._itemList) do
			if iter_10_1._cardData.index == arg_10_1 then
				iter_10_1.animator:Play("fightname_forbid_imprison", nil, nil)
				arg_10_0._itemList:removeIndexDelayRecycle(iter_10_0, 0.4)

				break
			end
		end
	end
end

function var_0_0.getOpItemList(arg_11_0)
	return arg_11_0._itemList or {}
end

return var_0_0
