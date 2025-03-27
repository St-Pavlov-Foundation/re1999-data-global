module("modules.logic.fight.entity.comp.FightNameUIEnemyOperation", package.seeall)

slot0 = class("FightNameUIEnemyOperation", FightBaseView)

function slot0.init(slot0, slot1, slot2, slot3)
	slot0._opContainerCanvasGroup = gohelper.onceAddComponent(slot2, typeof(UnityEngine.CanvasGroup))
	slot0._opItemGO = slot3

	gohelper.setActive(slot0._opItemGO, false)

	slot0._itemList = slot0:com_registViewItemList(slot0._opItemGO, FightNameUIOperationItem, slot2)

	slot0._itemList:setFuncNames("refreshItemData")

	slot0.entity = slot1
	slot0._entityMO = slot0.entity:getMO()
	slot0.playCardInfoList = {}

	slot0:setPlayCardInfo()
	slot0:com_registMsg(FightMsgId.Act174MonsterAiCard, slot0._onAct174MonsterAiCard)
	slot0:com_registFightEvent(FightEvent.OnInvokeSkill, slot0._onInvokeSkill)
	slot0:com_registFightEvent(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart)
	slot0:com_registFightEvent(FightEvent.OnBuffUpdate, slot0._onBuffUpdate)
	slot0:com_registFightEvent(FightEvent.GMHideFightView, slot0._checkGMHideUI)
	slot0:com_registFightEvent(FightEvent.InvalidEnemyUsedCard, slot0._onInvalidEnemyUsedCard)
end

function slot0._onAct174MonsterAiCard(slot0)
	slot0:setPlayCardInfo()
end

function slot0.setPlayCardInfo(slot0)
	FightDataHelper.coverData(FightDataHelper.playCardMgr.enemyAct174PlayCard, slot0.playCardInfoList)

	for slot4 = #slot0.playCardInfoList, 1, -1 do
		if slot0.playCardInfoList[slot4].uid ~= slot0._entityMO.uid then
			table.remove(slot0.playCardInfoList, slot4)
		end
	end

	slot0._itemList:setDataList(slot0.playCardInfoList)
end

function slot0._checkGMHideUI(slot0)
	gohelper.setActive(slot0._opContainerCanvasGroup.gameObject, GMFightShowState.enemyOp)
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	if slot1.id ~= slot0.entity.id then
		return
	end

	slot0:_checkPlaySkill(slot3)
end

function slot0._checkPlaySkill(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._itemList) do
		if slot6._cardData.index == slot1.cardIndex then
			slot6.animator:Play("fightname_op_play", nil, )
			slot0._itemList:removeIndexDelayRecycle(slot5, 0.67)

			break
		end
	end
end

function slot0._onInvokeSkill(slot0, slot1)
	if slot1.fromId ~= slot0.entity.id then
		return
	end

	slot0:_checkPlaySkill(slot1)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.entity.id then
		return
	end

	if slot2 == FightEnum.EffectType.BUFFADD or slot2 == FightEnum.EffectType.BUFFDEL then
		slot0:_checkPlayForbid()
	end
end

function slot0._checkPlayForbid(slot0)
	for slot4, slot5 in ipairs(slot0._itemList) do
		slot5:_refreshAni()
	end
end

function slot0._onInvalidEnemyUsedCard(slot0, slot1)
	if slot0._itemList then
		for slot5, slot6 in ipairs(slot0._itemList) do
			if slot6._cardData.index == slot1 then
				slot6.animator:Play("fightname_forbid_imprison", nil, )
				slot0._itemList:removeIndexDelayRecycle(slot5, 0.4)

				break
			end
		end
	end
end

function slot0.getOpItemList(slot0)
	return slot0._itemList or {}
end

return slot0
