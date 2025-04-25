module("modules.logic.fight.view.preview.SkillEditorMulSkillView", package.seeall)

slot0 = class("SkillEditorMulSkillView", BaseView)

function slot0.onInitView(slot0)
	slot0._infos = {}
	slot0._btnMulSkill = gohelper.findChildButton(slot0.viewGO, "scene/Grid/btnMulSkill")
	slot0._btnClose = gohelper.findChildButton(slot0.viewGO, "mulSkill/btnGroup/btnClose")
	slot0._btnStart = gohelper.findChildButton(slot0.viewGO, "mulSkill/btnGroup/btnStart")
	slot0._toggleParallel = gohelper.findChildToggle(slot0.viewGO, "mulSkill/btnGroup/toggleParallel")
	slot0._toggleNoSpeedUp = gohelper.findChildToggle(slot0.viewGO, "mulSkill/btnGroup/toggleNoSpeedUp")
	slot0._toggleHideAllUI = gohelper.findChildToggle(slot0.viewGO, "mulSkill/btnGroup/toggleHideAllUI")
	slot0._toggleDelay = gohelper.findChildToggle(slot0.viewGO, "mulSkill/btnGroup/toggleDelay")
	slot0._inputDelay = gohelper.findChildTextMeshInputField(slot0.viewGO, "mulSkill/btnGroup/toggleDelay/#input_delay")
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

	slot1 = FightRoundMO.New()
	FightModel.instance._curRoundMO = slot1
	slot1.fightStepMOs = {}

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

	slot2 = tonumber(slot0._inputDelay:GetText()) or 0
	slot0._playSkillsFlow = FlowSequence.New()

	if slot0._toggleDelay.isOn and slot2 > 0 then
		slot0._playSkillsFlow:addWork(WorkWaitSeconds.New(slot2))
	end

	slot3, slot4 = FightStepBuilder.buildStepWorkList(slot1.fightStepMOs)

	for slot8, slot9 in ipairs(slot3) do
		slot0._playSkillsFlow:addWork(slot9)
	end

	if slot0._toggleDelay.isOn and slot2 > 0 then
		slot0._playSkillsFlow:addWork(WorkWaitSeconds.New(slot2))
	end

	slot0._playSkillsFlow:registerDoneListener(slot0._onPlaySkillsEnd, slot0)
	slot0._playSkillsFlow:start()
	gohelper.setActive(slot0.viewGO, false)

	if slot0._toggleHideAllUI.isOn then
		slot0:hideAllUI()
	end
end

function slot0.hideAllUI(slot0)
	slot0:setNameUIActive(false)
	slot0:setViewActive(false)
	slot0:setFrameActive(false)
end

function slot0.showAllUI(slot0)
	slot0:setNameUIActive(true)
	slot0:setViewActive(true)
	slot0:setFrameActive(true)
end

function slot0.setNameUIActive(slot0, slot1)
	for slot7, slot8 in pairs(GameSceneMgr.instance:getCurScene().entityMgr._tagUnitDict) do
		for slot12, slot13 in pairs(slot8) do
			if slot13.nameUI then
				gohelper.setActive(slot14:getGO(), slot1)
			end
		end
	end
end

function slot0.setViewActive(slot0, slot1)
	if ViewMgr.instance:getContainer(ViewName.SkillEffectStatView) then
		gohelper.setActive(slot2.viewGO, slot1)
	end
end

function slot0.setFrameActive(slot0, slot1)
	gohelper.setActive(gohelper.findChild(ViewMgr.instance:getUIRoot(), "Text"), slot1)
end

function slot0._onPlaySkillsEnd(slot0)
	slot0._playSkillsFlow:unregisterDoneListener(slot0._onPlaySkillsEnd, slot0)
	gohelper.setActive(slot0.viewGO, true)
	FightReplayModel.instance:setReplay(false)
	FightModel.instance:setUserSpeed(FightModel.instance:getUserSpeed())
	FightController.instance:dispatchEvent(FightEvent.OnUpdateSpeed)
	slot0:showAllUI()
end

return slot0
