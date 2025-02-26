module("modules.logic.fight.view.preview.SkillEditorMulSkillView", package.seeall)

slot0 = class("SkillEditorMulSkillView", BaseView)

function slot0.onInitView(slot0)
	slot0._infos = {}
	slot0._btnMulSkill = gohelper.findChildButton(slot0.viewGO, "scene/Grid/btnMulSkill")
	slot0._btnClose = gohelper.findChildButton(slot0.viewGO, "mulSkill/btnGroup/btnClose")
	slot0._btnStart = gohelper.findChildButton(slot0.viewGO, "mulSkill/btnGroup/btnStart")
	slot0._toggleParallel = gohelper.findChildToggle(slot0.viewGO, "mulSkill/btnGroup/toggleParallel")
	slot0._toggleNoSpeedUp = gohelper.findChildToggle(slot0.viewGO, "mulSkill/btnGroup/toggleNoSpeedUp")
	slot0._mulSkillViewGO = gohelper.findChild(slot0.viewGO, "mulSkill")
	slot0._items = {
		gohelper.findChild(slot0.viewGO, "mulSkill/content/item")
	}

	gohelper.setActive(slot0._mulSkillViewGO, false)
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0._btnMulSkill, slot0._showThis, slot0)
	slot0:addClickCb(slot0._btnClose, slot0._hideThis, slot0)
	slot0:addClickCb(slot0._btnStart, slot0._onClickStart, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0._btnMulSkill, slot0._showThis, slot0)
	slot0:removeClickCb(slot0._btnClose, slot0._hideThis, slot0)

	slot4 = slot0._onClickStart
	slot5 = slot0

	slot0:removeClickCb(slot0._btnStart, slot4, slot5)

	for slot4, slot5 in ipairs(slot0._items) do
		gohelper.findChildButtonWithAudio(slot5, "imgRemove"):RemoveClickListener()
	end
end

function slot0._showThis(slot0)
	gohelper.setActive(slot0._mulSkillViewGO, true)
	slot0:_updateItems()
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.OnSelectSkill, slot0._onSelectSkill, slot0)
end

function slot0._hideThis(slot0)
	gohelper.setActive(slot0._mulSkillViewGO, false)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.OnSelectSkill, slot0._onSelectSkill, slot0)
end

function slot0._onSelectSkill(slot0, slot1, slot2)
	table.insert(slot0._infos, {
		side = slot4,
		stancePos = SkillEditorView.selectPosId[slot4],
		modelId = slot1.modelId,
		skillId = slot2,
		targetId = GameSceneMgr.instance:getCurScene().entityMgr:getEntityByPosId(slot4 == FightEnum.EntitySide.MySide and SceneTag.UnitMonster or SceneTag.UnitPlayer, SkillEditorView.selectPosId[slot1.side == FightEnum.EntitySide.EnemySide and FightEnum.EntitySide.MySide or FightEnum.EntitySide.EnemySide]).id
	})
	slot0:_updateItems()
end

function slot0._updateItems(slot0)
	for slot4, slot5 in ipairs(slot0._infos) do
		if not slot0._items[slot4] then
			table.insert(slot0._items, gohelper.cloneInPlace(slot0._items[1], "item" .. slot4))
		end

		gohelper.setActive(slot6, true)

		if FightDataHelper.entityMgr:getByPosId(slot5.side, slot5.stancePos) then
			slot11 = string.split(FightConfig.instance:getSkinSkillTimeline(slot7.skin, slot5.skillId), "_")
			gohelper.findChildText(slot6, "Text").text = string.format("%s-%s", slot7:getEntityName(), slot11[#slot11])
		end

		gohelper.findChildButtonWithAudio(slot6, "imgRemove"):AddClickListener(slot0._onClickRemoveInfo, slot0, slot4)
	end

	for slot4 = #slot0._infos + 1, #slot0._items do
		gohelper.setActive(slot0._items[slot4], false)
	end
end

function slot0._onClickRemoveInfo(slot0, slot1)
	table.remove(slot0._infos, slot1)
	slot0:_updateItems()
end

function slot0._onClickStart(slot0)
	if not slot0._infos or #slot0._infos == 0 then
		GameFacade.showToast(ToastEnum.IconId, "未添加技能")

		return
	end

	FightModel.instance:setAuto(slot0._toggleParallel.isOn)

	if not slot0._toggleNoSpeedUp.isOn then
		FightReplayModel.instance:setReplay(true)
		FightModel.instance:setUserSpeed(FightModel.instance:getUserSpeed())
		FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	end

	FightRoundMO.New().fightStepMOs = {}

	for slot5, slot6 in ipairs(slot0._infos) do
		slot7 = slot6.skillId

		if FightDataHelper.entityMgr:getByPosId(slot6.side, slot6.stancePos) then
			slot9 = slot8.id
			slot12 = slot6.side == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide

			if FightHelper.getTargetLimits(slot11, slot7) and #slot13 > 0 and not tabletool.indexOf(slot13, slot6.targetId) then
				slot10 = slot13[1]
			end

			tabletool.addValues(slot1.fightStepMOs, SkillEditorStepBuilder.buildStepMOs(slot7, slot9, slot10))
		end
	end

	slot2, slot3 = FightStepBuilder.buildStepWorkList(slot1.fightStepMOs)
	slot0._playSkillsFlow = FlowSequence.New()

	for slot7, slot8 in ipairs(slot2) do
		slot0._playSkillsFlow:addWork(slot8)
	end

	slot0._playSkillsFlow:registerDoneListener(slot0._onPlaySkillsEnd, slot0)
	slot0._playSkillsFlow:start()
	gohelper.setActive(slot0.viewGO, false)
end

function slot0._onPlaySkillsEnd(slot0)
	slot0._playSkillsFlow:unregisterDoneListener(slot0._onPlaySkillsEnd, slot0)
	gohelper.setActive(slot0.viewGO, true)
	FightReplayModel.instance:setReplay(false)
	FightModel.instance:setUserSpeed(FightModel.instance:getUserSpeed())
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
end

return slot0
