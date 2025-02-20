module("modules.logic.fight.view.preview.SkillEditorSideView", package.seeall)

slot0 = class("SkillEditorSideView", BaseView)
slot0.isCrit = false

function slot0.ctor(slot0, slot1)
	slot0._side = slot1
	slot0._oppositeSide = slot1 == FightEnum.EntitySide.MySide and FightEnum.EntitySide.EnemySide or FightEnum.EntitySide.MySide
	slot0._attackerTag = slot0._side == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	slot0._oppositeTag = slot0._side == FightEnum.EntitySide.MySide and SceneTag.UnitMonster or SceneTag.UnitPlayer
	slot0._isPlayingSkill = false
end

function slot0.onInitView(slot0)
	slot2 = gohelper.findChild(slot0.viewGO, slot0._side == FightEnum.EntitySide.MySide and "right" or "left")
	slot0._toggleCrit = gohelper.findChildToggle(slot0.viewGO, "scene/goToggleRoot/toggleCrit")
	slot0._txtToggleCrit = gohelper.findChildText(slot0.viewGO, "scene/goToggleRoot/toggleCrit/Text")
	slot0._btnSelectSkill = SLFramework.UGUI.ButtonWrap.GetWithPath(slot2, "btnSelectSkill")
	slot0._btnFight = SLFramework.UGUI.ButtonWrap.GetWithPath(slot2, "btnFight")
	slot0._txtHero = gohelper.findChildText(slot2, "btnSelectHero/Text")
	slot0._skillSelectView = SkillEditorSkillSelectView.New()

	slot0._skillSelectView:init(slot2)
	slot0._skillSelectView:hide()

	slot0._scene = GameSceneMgr.instance:getCurScene()

	if slot0._scene.entityMgr:getEntityByPosId(slot0._attackerTag, 1) then
		slot0._skillSelectView:setAttacker(slot3.id)
	end

	slot0:_updateBtnName()
end

function slot0.onDestroyView(slot0)
	slot0._skillSelectView:dispose()
end

function slot0.addEvents(slot0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.OnSelectEntity, slot0._onSelectEntity, slot0)
	SkillEditorMgr.instance:registerCallback(SkillEditorMgr.OnSubHeroEnter, slot0._onSubheroEnter, slot0)
	slot0._toggleCrit:AddOnValueChanged(slot0._onToggleChanged, slot0)
	slot0._btnSelectSkill:AddClickListener(slot0._onClickSelectSkill, slot0)
	slot0._btnFight:AddClickListener(slot0._onClickFight, slot0)
end

function slot0.removeEvents(slot0)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.OnSelectEntity, slot0._onSelectEntity, slot0)
	SkillEditorMgr.instance:unregisterCallback(SkillEditorMgr.OnSubHeroEnter, slot0._onSubheroEnter, slot0)
	slot0._toggleCrit:RemoveOnValueChanged()
	slot0._btnSelectSkill:RemoveClickListener()
	slot0._btnFight:RemoveClickListener()
end

function slot0._onToggleChanged(slot0, slot1, slot2)
	uv0.isCrit = slot2
	slot0._txtToggleCrit.text = slot2 and "暴击" or "普攻"
end

function slot0._onSelectEntity(slot0, slot1, slot2)
	if slot1 == slot0._side then
		slot0:_onPlayFinish()

		slot3 = FightDataHelper.entityMgr:getNormalList(slot0._side)

		if slot2 or slot3 and slot3[1] then
			slot0._skillSelectView:setAttacker(slot2 or slot3[1].id)
		end
	end

	slot0:_updateBtnName()
end

function slot0._onSubheroEnter(slot0, slot1)
	slot0:_onSelectEntity(FightEnum.EntitySide.MySide, slot1)
end

function slot0._updateBtnName(slot0)
	slot1, slot2 = SkillEditorMgr.instance:getTypeInfo(slot0._side)

	if slot1 == SkillEditorMgr.SelectType.Hero then
		slot3 = slot2 and slot2.ids and lua_character.configDict[slot2.ids[1]]
		slot0._txtHero.text = slot3 and slot3.name
	elseif slot1 == SkillEditorMgr.SelectType.Monster then
		slot3 = slot2 and slot2.ids and lua_monster.configDict[slot2.ids[1]]
		slot0._txtHero.text = FightConfig.instance:getSkinCO(slot2.skinIds[1]).name and slot4.name or nil
	elseif slot1 == SkillEditorMgr.SelectType.Group then
		slot0._txtHero.text = "怪物组-" .. slot2.groupId
	end
end

function slot0._onClickSelectSkill(slot0)
	slot0._skillSelectView:show()
end

function slot0._onClickFight(slot0)
	FightController.instance:setCurStage(FightEnum.Stage.Card)

	if not lua_skill.configDict[slot0._skillSelectView:getSelectSkillId()] then
		logError("技能配置不存在，id = " .. slot1)

		return
	end

	if slot0._isPlayingSkill then
		return
	end

	if FightSystem.instance:getStartSequence():isRunning() then
		slot3:stop()
	end

	slot0._isPlayingSkill = true

	TaskDispatcher.runDelay(slot0._onPlayFinish, slot0, 60)

	slot4 = slot0._scene.entityMgr:getEntityByPosId(slot0._attackerTag, SkillEditorView.selectPosId[slot0._side]).id

	if FightHelper.getTargetLimits(slot0._side, slot1) and #slot6 > 0 and not tabletool.indexOf(slot6, slot0._scene.entityMgr:getEntityByPosId(slot0._oppositeTag, SkillEditorView.selectPosId[slot0._oppositeSide]).id) then
		slot5 = slot0._scene.entityMgr:getEntityByPosId(slot0._attackerTag, SkillEditorView.prevSelectPosId[slot0._side]).id
	end

	if FightHelper.getEntity(slot4).skill then
		gohelper.setActive(slot0.viewGO, false)

		slot8 = FightRoundMO.New()
		FightModel.instance._curRoundMO = slot8
		slot8.fightStepMOs = {}

		tabletool.addValues(slot8.fightStepMOs, SkillEditorStepBuilder.buildStepMOs(slot1, slot4, slot5))

		slot10, slot11 = FightStepBuilder.buildStepWorkList(slot8.fightStepMOs)
		slot0._playSkillsFlow = FlowSequence.New()

		for slot15, slot16 in ipairs(slot10) do
			slot0._playSkillsFlow:addWork(slot16)
		end

		slot0._playSkillsFlow:registerDoneListener(slot0._onPlayFinish, slot0)
		slot0._playSkillsFlow:start()
		gohelper.setActive(slot0.viewGO, false)
	else
		slot0._isPlayingSkill = false

		logError("所选对象没有技能")
	end
end

function slot0._onPlayFinish(slot0)
	slot0._isPlayingSkill = false

	if slot0._playSkillsFlow then
		slot0._playSkillsFlow:unregisterDoneListener(slot0._onPlayFinish, slot0)
		slot0._playSkillsFlow:stop()

		slot0._playSkillsFlow = nil
	end

	TaskDispatcher.cancelTask(slot0._onPlayFinish, slot0)

	if GMController.instance:getIsShowEditorFightUI() then
		gohelper.setActive(slot0.viewGO, true)
	else
		gohelper.setActive(slot0.viewGO, false)
	end

	slot0:_checkResetEntityHp()
end

function slot0._checkResetEntityHp()
	for slot4, slot5 in ipairs(FightHelper.getAllEntitys()) do
		slot6 = slot5:getMO()

		if slot5.nameUI and slot6 and slot6.currentHp <= 0 then
			slot5.nameUI:addHp(slot6.attrMO.hp)
			slot5.nameUI:setActive(true)
		end
	end
end

return slot0
