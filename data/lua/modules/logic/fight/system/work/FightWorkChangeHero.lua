module("modules.logic.fight.system.work.FightWorkChangeHero", package.seeall)

slot0 = class("FightWorkChangeHero", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getVersion() < 4 then
		slot0:onDone(true)

		return
	end

	if not slot0._actEffectMO.entityMO then
		slot0:onDone(true)

		return
	end

	slot0:com_registTimer(slot0._delayDone, 5)

	slot0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr
	slot0._targetId = slot0._actEffectMO.targetId
	slot0._targetEntity = FightHelper.getEntity(slot0._targetId)

	if FightEntityDataHelper.isPlayerUid(slot0._targetId) then
		slot0._targetEntity = nil
	end

	slot0._changedId = slot0._actEffectMO.entityMO.id
	slot0._changedSubEntity = FightHelper.getEntity(slot0._changedId)
	slot0._changedEntityMO = FightDataHelper.entityMgr:getById(slot0._changedId)

	FightController.instance:dispatchEvent(FightEvent.BeforeChangeSubHero, slot0._targetId, slot0._changedId)

	slot0._seasonUseChangeHero = FightModel.instance:isSeason2() and slot0._actEffectMO.configEffect == 1

	if slot0._changedEntityMO.side == FightEnum.EntitySide.MySide then
		if slot0._seasonUseChangeHero then
			slot0:_startChangeHero()
		elseif slot0._changedSubEntity and slot0._changedSubEntity.spine:getSpineGO() ~= nil then
			slot0:_startChangeHero()
		else
			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSubSpineLoaded, slot0)

			slot0._toBuildSubId = slot0._changedEntityMO.id

			if not slot0._changedSubEntity and slot0._entityMgr:buildSubSpine(slot0._changedEntityMO) and lua_stance.configDict[FightHelper.getEntityStanceId(slot0._changedEntityMO)] then
				transformhelper.setLocalPos(slot2.go.transform, slot3.subPos1[1] or 0, slot4[2] or 0, slot4[3] or 0)
			end
		end
	else
		slot0:_startChangeHero()
	end
end

function slot0._startChangeHero(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnStartChangeEntity, slot0._changedEntityMO)

	if slot0._targetEntity then
		if slot0._targetEntity.spineRenderer then
			slot0._targetEntity.spineRenderer:setAlpha(0, 0.4 / FightModel.instance:getSpeed())

			slot2 = "always/ui_renwuxiaoshi"
			slot3 = nil

			if slot0._actEffectMO.configEffect == 1 then
				slot2 = "buff/buff_huanren"
				slot3 = ModuleEnum.SpineHangPoint.mountmiddle
			end

			if not slot0._seasonUseChangeHero then
				slot4 = slot0._targetEntity.effect:addHangEffect(slot2, slot3)

				slot4:setLocalPos(0, 0, 0)
				FightRenderOrderMgr.instance:onAddEffectWrap(slot0._targetEntity.id, slot4)
			end
		end

		if FightModel.instance:isSeason2() then
			slot0:_targetEntityQuitFinish()
			AudioMgr.instance:trigger(410000103)
		else
			TaskDispatcher.runDelay(slot0._targetEntityQuitFinish, slot0, 0.4 / slot1)
		end
	else
		slot0:_targetEntityQuitFinish()
	end
end

function slot0._targetEntityQuitFinish(slot0)
	if slot0._targetEntity then
		slot0._entityMgr:removeUnit(slot0._targetEntity:getTag(), slot0._targetEntity.id)
	end

	if slot0._changedEntityMO.side == FightEnum.EntitySide.MySide and not slot0._seasonUseChangeHero then
		slot0:_playJumpTimeline()
	else
		slot0:_entityEnter()
	end
end

function slot0._playJumpTimeline(slot0)
	slot1, slot2, slot3 = FightHelper.getEntityStandPos(slot0._changedEntityMO)
	slot4 = {
		actId = 0,
		customType = "change_hero",
		actEffectMOs = {
			{
				targetId = slot0._targetId
			}
		},
		actEffect = {},
		fromId = slot0._changedId,
		toId = slot0._targetId,
		actType = FightEnum.ActType.SKILL,
		forcePosX = slot1,
		forcePosY = slot2,
		forcePosZ = slot3
	}
	slot5 = nil

	if SkinConfig.instance:getSkinCo(slot0._changedEntityMO.skin) and not string.nilorempty(slot6.alternateSpineJump) then
		slot5 = slot6.alternateSpineJump
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot0._subEntity = GameSceneMgr.instance:getCurScene().entityMgr:buildTempSceneEntity("tibushangzhen" .. slot0._changedEntityMO.id)
	uv0.playingChangeHero = true

	slot0._subEntity.skill:playTimeline(slot5 or "change_hero_common", slot4)
end

function slot0._removeSubEntity(slot0)
	if slot0._changedSubEntity and slot0._changedSubEntity.go then
		slot0._entityMgr:destroyUnit(slot0._changedSubEntity)

		slot0._changedSubEntity = nil
	end
end

function slot0._onSkillPlayFinish(slot0, slot1)
	if slot1 == slot0._subEntity then
		slot0:_removeSubEntity()
	end
end

function slot0._onSkillPlayStart(slot0, slot1)
	if slot1 == slot0._subEntity then
		slot0._timeline_duration = slot1.skill and slot1.skill:getCurTimelineDuration()

		TaskDispatcher.runDelay(slot0._entityEnter, slot0, slot0._timeline_duration * 0.8)
	end
end

function slot0._entityEnter(slot0)
	if slot0._changedSubEntity then
		if slot0._timeline_duration then
			slot0._changedSubEntity:setAlpha(0, slot0._timeline_duration * 0.2 / FightModel.instance:getSpeed())

			slot0._need_invoke_remove_sub_entity = true

			slot0._entityMgr:removeUnitData(slot0._changedSubEntity:getTag(), slot0._changedSubEntity.id)
		else
			slot0._entityMgr:removeUnit(slot0._changedSubEntity:getTag(), slot0._changedSubEntity.id)
		end
	end

	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onEnterEntitySpineLoadFinish, slot0)

	slot0._newEntity = slot0._entityMgr:buildSpine(slot0._changedEntityMO)
end

function slot0._onEnterEntitySpineLoadFinish(slot0, slot1)
	if slot1.unitSpawn.id == slot0._changedEntityMO.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onEnterEntitySpineLoadFinish, slot0)

		slot2 = slot0._entityMgr:getEntity(slot0._changedEntityMO.id)

		if slot0._seasonUseChangeHero then
			if slot2 then
				slot2:resetEntity()
			end

			slot0:_onEntityBornDone()

			slot3 = "always/ui_renwuxiaoshi"
			slot4 = nil

			if slot0._actEffectMO.configEffect == 1 then
				slot3 = "buff/buff_huanren"
				slot4 = ModuleEnum.SpineHangPoint.mountmiddle
			end

			slot5 = slot2.effect:addHangEffect(slot3, slot4, nil, 2)

			slot5:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(slot2.id, slot5)

			if slot2 and slot2.buff then
				xpcall(slot6.dealStartBuff, __G__TRACKBACK__, slot6)
			end

			return
		end

		slot0._work = FightWorkStartBornNormal.New(slot2, false)

		slot0._work:registerDoneListener(slot0._onEntityBornDone, slot0)
		slot0._work:onStart()

		if slot2:isMySide() then
			FightAudioMgr.instance:playHeroVoiceRandom(slot0._changedEntityMO.modelId, CharacterEnum.VoiceType.EnterFight)
		end
	end
end

function slot0.sortSubList()
end

function slot0._onEntityBornDone(slot0)
	if slot0._work then
		slot0._work:unregisterDoneListener(slot0._onEntityBornDone, slot0)
	end

	FightController.instance:dispatchEvent(FightEvent.OnChangeEntity, slot0._newEntity)
	GameSceneMgr.instance:getCurScene().entityMgr:showSubEntity()
	slot0:onDone(true)
end

function slot0._onSubSpineLoaded(slot0, slot1)
	if slot1.unitSpawn.id == slot0._toBuildSubId then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSubSpineLoaded, slot0)

		slot0._changedSubEntity = FightHelper.getEntity(slot0._changedId)

		slot0:_startChangeHero()
	end
end

function slot0._delayDone(slot0)
	logError("换人超时")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	uv0.playingChangeHero = false

	if slot0._subEntity then
		if GameSceneMgr.instance:getCurScene().entityMgr then
			slot1:removeUnit(slot0._subEntity:getTag(), slot0._subEntity.id)
		end

		slot0._subEntity = nil
	end

	if slot0._need_invoke_remove_sub_entity then
		slot0:_removeSubEntity()
	end

	TaskDispatcher.cancelTask(slot0._targetEntityQuitFinish, slot0)
	TaskDispatcher.cancelTask(slot0._entityEnter, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSubSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onNextSubSpineLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onEnterEntitySpineLoadFinish, slot0)

	slot0._fightStepMO = nil

	if slot0._work then
		slot0._work:unregisterDoneListener(slot0._onEntityBornDone, slot0)
		slot0._work:onStop()

		slot0._work = nil
	end

	slot0._timeline_duration = nil
end

function slot0.onDestroy(slot0)
	if slot0._nextSubBornFlow then
		slot0._nextSubBornFlow:stop()

		slot0._nextSubBornFlow = nil
	end

	uv0.super.onDestroy(slot0)
end

return slot0
