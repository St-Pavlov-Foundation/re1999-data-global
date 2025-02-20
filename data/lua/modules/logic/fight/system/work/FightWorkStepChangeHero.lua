module("modules.logic.fight.system.work.FightWorkStepChangeHero", package.seeall)

slot0 = class("FightWorkStepChangeHero", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightStepMO = slot1
end

function slot0.isMySide(slot0)
	if FightDataHelper.entityMgr:getById(slot0._fightStepMO.fromId) then
		return slot1.side == FightEnum.EntitySide.MySide
	end

	return tonumber(slot0._fightStepMO.fromId) > 0
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 5)

	slot0.from_id = slot0._fightStepMO.fromId
	slot0.to_id = slot0._fightStepMO.toId

	FightDataHelper.calMgr:playChangeHero(slot0._fightStepMO)

	slot0._changedEntityMO = FightDataHelper.entityMgr:getById(slot0.from_id)
	slot0.entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	FightController.instance:dispatchEvent(FightEvent.BeforeChangeSubHero, slot0.to_id)

	if FightHelper.getEntity(slot0.from_id) and slot1.spine:getSpineGO() ~= nil then
		slot0:_startChangeHero()
	else
		slot2 = FightDataHelper.entityMgr:getById(slot0.from_id)
		slot3 = FightHelper.getSubEntity(slot2.side)

		if slot2 and slot3 then
			slot0.entityMgr:removeUnit(slot3:getTag(), slot3.id)
			FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSubSpineLoaded, slot0)

			slot0._toBuildSubId = slot2.id

			if slot0.entityMgr:buildSubSpine(slot2) and lua_stance.configDict[FightHelper.getEntityStanceId(slot0._changedEntityMO)] then
				transformhelper.setLocalPos(slot4.go.transform, slot5.subPos1[1] or 0, slot6[2] or 0, slot6[3] or 0)
			end
		else
			slot0:_startChangeHero()
		end
	end
end

function slot0._startChangeHero(slot0)
	FightController.instance:dispatchEvent(FightEvent.OnStartChangeEntity, slot0._fromEntityMO)

	slot0.from_entity = slot0.entityMgr:getEntity(slot0.from_id)
	slot0.from_entity_mo = FightDataHelper.entityMgr:getById(slot0.from_id)
	slot0.to_entity = slot0.entityMgr:getEntity(slot0.to_id)
	slot0.to_entity_mo = FightDataHelper.entityMgr:getById(slot0.to_id)

	if slot0.to_entity then
		slot1 = FightModel.instance:getSpeed()

		if slot0.to_entity.spineRenderer then
			slot0.to_entity.spineRenderer:setAlpha(0, 0.4 / slot1)

			slot2 = slot0.to_entity.effect:addHangEffect("always/ui_renwuxiaoshi")

			slot2:setLocalPos(0, 0, 0)
			FightRenderOrderMgr.instance:onAddEffectWrap(slot0.to_entity.id, slot2)
		end

		TaskDispatcher.runDelay(slot0._targetEntityQuitFinish, slot0, 0.4 / slot1)
	else
		slot0:_targetEntityQuitFinish()
	end
end

function slot0._targetEntityQuitFinish(slot0)
	slot0._jump_end_pos = {}
	slot0._jump_end_pos.x, slot0._jump_end_pos.y, slot0._jump_end_pos.z = FightHelper.getEntityStandPos(slot0._changedEntityMO)

	if slot0.to_entity then
		slot0.entityMgr:removeUnit(slot0.to_entity:getTag(), slot0.to_entity.id)

		slot0.to_entity = nil
	end

	if slot0.from_entity_mo.side == FightEnum.EntitySide.MySide then
		slot0:_playJumpTimeline()
	else
		slot0:_entityEnter()
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

function slot0._playJumpTimeline(slot0)
	slot1 = {
		actId = 0,
		customType = "change_hero",
		actEffectMOs = {
			{
				targetId = slot0.to_id
			}
		},
		actEffect = {},
		fromId = slot0.from_id,
		toId = slot0.to_id,
		actType = FightEnum.ActType.SKILL,
		forcePosX = slot0._jump_end_pos.x,
		forcePosY = slot0._jump_end_pos.y,
		forcePosZ = slot0._jump_end_pos.z
	}
	slot2 = nil

	if SkinConfig.instance:getSkinCo(slot0.from_entity_mo.skin) and not string.nilorempty(slot3.alternateSpineJump) then
		slot2 = slot3.alternateSpineJump
	end

	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)

	slot0._subEntity = GameSceneMgr.instance:getCurScene().entityMgr:buildTempSceneEntity(slot0.from_id)
	uv0.playingChangeHero = true

	slot0._subEntity.skill:playTimeline(slot2 or "change_hero_common", slot1)
end

function slot0._removeSubEntity(slot0)
	if slot0.from_entity and slot0.from_entity.go then
		slot0.entityMgr:destroyUnit(slot0.from_entity)

		slot0.from_entity = nil
	end
end

function slot0._entityEnter(slot0)
	if slot0.from_entity then
		if slot0._timeline_duration then
			slot0.from_entity:setAlpha(0, slot0._timeline_duration * 0.2 / FightModel.instance:getSpeed())

			slot0._need_invoke_remove_sub_entity = true

			slot0.entityMgr:removeUnitData(slot0.from_entity:getTag(), slot0.from_entity.id)
		else
			slot0.entityMgr:removeUnit(slot0.from_entity:getTag(), slot0.from_entity.id)
		end
	end

	slot0.from_entity_mo:onChangeHero()
	FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onEnterEntitySpineLoadFinish, slot0)

	slot0._newEntity = slot0.entityMgr:buildSpine(slot0.from_entity_mo)
end

function slot0._onEnterEntitySpineLoadFinish(slot0, slot1)
	if slot1.unitSpawn.id == slot0.from_entity_mo.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onEnterEntitySpineLoadFinish, slot0)

		slot2 = slot0.entityMgr:getEntity(slot0.from_entity_mo.id)
		slot0._work = FightWorkStartBornNormal.New(slot2, false)

		slot0._work:registerDoneListener(slot0._onEntityBornDone, slot0)
		slot0._work:onStart()

		if slot2:isMySide() then
			FightAudioMgr.instance:playHeroVoiceRandom(slot0.from_entity_mo.modelId, CharacterEnum.VoiceType.EnterFight)
		end
	end
end

function slot0._onEntityBornDone(slot0)
	slot0._work:unregisterDoneListener(slot0._onEntityBornDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeEntity, slot0._newEntity)

	if slot0.from_entity_mo and slot0.from_entity_mo.side == FightEnum.EntitySide.MySide and FightDataHelper.entityMgr:getMySubList()[1] then
		slot0.nextSubEntityMO = slot2

		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onNextSubSpineLoaded, slot0)

		slot0._nextSubEntity = slot0.entityMgr:buildSubSpine(slot2)
	end

	if FightDataHelper.entityMgr:getById(slot0.to_id) then
		slot1:onChangeHero()
	end

	slot0:onDone(true)
end

function slot0._onNextSubSpineLoaded(slot0, slot1)
	if slot1.unitSpawn.id == slot0.nextSubEntityMO.id then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onNextSubSpineLoaded, slot0)

		slot0._nextSubBornFlow = FlowSequence.New()

		slot0._nextSubBornFlow:addWork(FightWorkStartBornNormal.New(GameSceneMgr.instance:getCurScene().entityMgr:getEntity(slot0.nextSubEntityMO.id), true))
		slot0._nextSubBornFlow:start()
	end
end

function slot0._onSubSpineLoaded(slot0, slot1)
	if slot1.unitSpawn.id == slot0._toBuildSubId then
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSubSpineLoaded, slot0)
		slot0:_startChangeHero()
	end
end

function slot0._delayDone(slot0)
	logError("change entity step timeout, targetId = " .. slot0._fightStepMO.fromId .. " -> " .. slot0._fightStepMO.toId)
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

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
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

function slot0.onResume(slot0)
	logError("change entity step can't resume")
end

function slot0.onDestroy(slot0)
	if slot0._nextSubBornFlow then
		slot0._nextSubBornFlow:stop()

		slot0._nextSubBornFlow = nil
	end

	uv0.super.onDestroy(slot0)
end

return slot0
