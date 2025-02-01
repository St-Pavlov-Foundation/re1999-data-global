module("modules.logic.fight.view.FightViewBossHpMgr", package.seeall)

slot0 = class("FightViewBossHpMgr", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._bossHpRoot = gohelper.findChild(slot0.viewGO, "root/bossHpRoot").transform

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRestartStageBefore, slot0._onRestartStage, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._hpItem = gohelper.findChild(slot0.viewGO, "root/bossHpRoot/bossHp")

	SLFramework.AnimatorPlayer.Get(slot0._hpItem):Play("idle", nil, )
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "root/bossHpRoot/bossHp/Alpha/bossHp"), false)
end

function slot0._onRestartStage(slot0)
	slot0:killAllChildView()
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if not GMFightShowState.bossHp then
		return
	end

	if BossRushController.instance:isInBossRushInfiniteFight(true) then
		slot0:openSubView(BossRushFightViewBossHp, slot0._hpItem)

		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CardDeck) then
		slot1 = 3 + 1
	end

	if FightView.canShowSpecialBtn() then
		slot1 = slot1 + 1
	end

	if DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId) and slot2.type == DungeonEnum.EpisodeType.Rouge then
		slot1 = slot1 + 1
	end

	if slot1 >= 6 then
		recthelper.setAnchorX(slot0._bossHpRoot, -150)
	end

	for slot11, slot12 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide)) do
		if slot12:getMO() and FightHelper.isBossId(FightHelper.getCurBossId(), slot13.modelId) then
			slot5 = 0 + 1

			table.insert({}, slot12.id)
		end
	end

	if slot5 == 2 then
		for slot11, slot12 in ipairs(slot7) do
			gohelper.setActive(gohelper.cloneInPlace(slot0._hpItem, "bossHp" .. slot11), true)
			recthelper.setWidth(slot13.transform, slot1 >= 5 and 400 or 450)

			if (slot1 >= 5 and 240 or 295) == 295 and slot11 == 1 then
				slot15 = 255
			end

			recthelper.setAnchorX(slot13.transform, slot11 == 1 and -slot15 or slot15)
			slot0:openSubView(FightViewMultiBossHp, slot13, nil, slot12)
		end

		gohelper.setActive(slot0._hpItem, false)
	else
		slot0:openSubView(FightViewBossHp, slot0._hpItem)
	end
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
