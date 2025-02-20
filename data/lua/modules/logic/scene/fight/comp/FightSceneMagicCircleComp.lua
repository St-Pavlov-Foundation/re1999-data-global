module("modules.logic.scene.fight.comp.FightSceneMagicCircleComp", package.seeall)

slot0 = class("FightSceneMagicCircleComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._effectDic = {}
end

function slot0.onScenePrepared(slot0, slot1, slot2)
	slot0._entity = FightHelper.getEntity(FightEntityScene.MySideId)

	FightController.instance:registerCallback(FightEvent.AddMagicCircile, slot0._onAddMagicCircile, slot0)
	FightController.instance:registerCallback(FightEvent.DeleteMagicCircile, slot0._onDeleteMagicCircile, slot0)
	FightController.instance:registerCallback(FightEvent.UpdateMagicCircile, slot0._onUpdateMagicCircile, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:registerCallback(FightEvent.ChangeSceneVisible, slot0._onChangeSceneVisible, slot0)
	FightController.instance:registerCallback(FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.StartFightEnd, slot0._onStartFightEnd, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
end

function slot0._onLevelLoaded(slot0)
	slot0._fightScene = GameSceneMgr.instance:getCurScene()
	slot0._sceneObj = slot0._fightScene.level:getSceneGo()
end

function slot0.createEffect(slot0, slot1, slot2)
	if not string.nilorempty(slot1) then
		slot2 = slot2 and slot2 / 1000
		slot4 = slot0._config.posArr
		slot5 = {
			x = slot4[1],
			y = slot4[2],
			z = slot4[3]
		}
		slot6 = FightHelper.getMagicSide(FightModel.instance:getMagicCircleInfo().createUid)

		slot0._entity.effect:addGlobalEffect(slot1, slot6, slot2):setLocalPos(slot6 == FightEnum.EntitySide.MySide and slot5.x or -slot5.x, slot5.y, slot5.z)

		if not slot2 then
			slot0._effectDic[slot7.uniqueId] = slot7
		end

		return slot7
	end
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if FightModel.instance:getMagicCircleInfo().magicCircleId then
		slot0:_onAddMagicCircile(slot1.magicCircleId)
	end
end

function slot0._getConfig(slot0, slot1)
	return lua_fight_skin_replace_magic_effect.configDict[slot1] and lua_fight_skin_replace_magic_effect.configDict[slot1][FightDataHelper.entityMgr:getById(FightModel.instance:getMagicCircleInfo().createUid) and slot3.skin] or lua_magic_circle.configDict[slot1]
end

function slot0._onAddMagicCircile(slot0, slot1)
	slot0:clearLastLoopEffect()

	slot0._config = slot0:_getConfig(slot1)

	slot0:createEffect(slot0._config.enterEffect, slot0._config.enterTime)

	slot0._loopEffect = slot0:createEffect(slot0._config.loopEffect, nil)

	slot0:_playAudio(slot0._config.enterAudio)
end

function slot0.clearLastLoopEffect(slot0)
	if slot0._loopEffect then
		slot0:_releaseEffect(slot0._loopEffect)

		slot0._loopEffect = nil
	end

	if slot0._removeEffectWrap then
		slot0:_releaseEffect(slot0._removeEffectWrap)

		slot0._removeEffectWrap = nil
	end

	TaskDispatcher.cancelTask(slot0._releaseLoopAfterCloseAni, slot0)
	FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, slot0._onRemoveEffectLoaded, slot0)
end

function slot0._playAudio(slot0, slot1)
	if slot1 ~= 0 then
		AudioMgr.instance:trigger(slot1)
	end
end

function slot0._onDeleteMagicCircile(slot0, slot1)
	slot0._config = slot0:_getConfig(slot1)

	if not string.nilorempty(slot0._config.closeAniName) then
		if slot0._loopEffect and slot0._loopEffect.effectGO then
			if gohelper.onceAddComponent(slot0._loopEffect.effectGO, typeof(UnityEngine.Animator)) then
				slot2:Play(slot0._config.closeAniName)
			end

			TaskDispatcher.runDelay(slot0._releaseLoopAfterCloseAni, slot0, slot0._config.closeTime / 1000)
		else
			slot0:_releaseLoopEffect()
		end
	else
		slot0._removeEffectWrap = slot0:createEffect(slot0._config.closeEffect, slot0._config.closeTime)

		if slot0._removeEffectWrap then
			if slot0._removeEffectWrap.effectGO then
				slot0:_releaseLoopEffect()
			else
				FightController.instance:registerCallback(FightEvent.EntityEffectLoaded, slot0._onRemoveEffectLoaded, slot0)
			end
		else
			slot0:_releaseLoopEffect()
		end
	end

	slot0:_playAudio(slot0._config.closeAudio)
end

function slot0._releaseLoopAfterCloseAni(slot0)
	slot0:_releaseLoopEffect()
end

function slot0._releaseLoopEffect(slot0)
	if slot0._loopEffect then
		slot0:_releaseEffect(slot0._loopEffect)

		slot0._loopEffect = nil
	end
end

function slot0._onRemoveEffectLoaded(slot0, slot1, slot2)
	if slot0._removeEffectWrap == slot2 then
		FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, slot0._onRemoveEffectLoaded, slot0)
		slot0:_releaseLoopEffect()
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.FightFocusView and slot0._loopEffect then
		slot0._loopEffect:setActive(false, "FightSceneMagicCircleComp_FightFocusView")
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.FightFocusView and slot0._loopEffect then
		slot0._loopEffect:setActive(true, "FightSceneMagicCircleComp_FightFocusView")
	end
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	if slot1:getMO() and slot4:isUniqueSkill(slot2) and slot0._loopEffect then
		slot0._loopEffect:setActive(false, "FightSceneMagicCircleComp_onSkillPlayStart" .. slot3.stepUid)
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if slot1:getMO() and slot4:isUniqueSkill(slot2) and slot0._loopEffect then
		slot0._loopEffect:setActive(true, "FightSceneMagicCircleComp_onSkillPlayStart" .. slot3.stepUid)
	end
end

function slot0._onChangeSceneVisible(slot0, slot1)
end

function slot0._onUpdateMagicCircile(slot0, slot1)
end

function slot0._onRestartStageBefore(slot0)
	slot0:releaseAllEffect()
end

function slot0._releaseEffect(slot0, slot1)
	slot0._effectDic[slot1.uniqueId] = nil

	if slot0._entity then
		slot0._entity.effect:removeEffect(slot1)
	end
end

function slot0.releaseAllEffect(slot0)
	for slot4, slot5 in pairs(slot0._effectDic) do
		slot0:_releaseEffect(slot5)
	end

	slot0._effectDic = {}
	slot0._loopEffect = nil
end

function slot0._onStartFightEnd(slot0)
	slot0:releaseAllEffect()
end

function slot0.onSceneClose(slot0, slot1, slot2)
	TaskDispatcher.cancelTask(slot0._releaseLoopAfterCloseAni, slot0)
	FightController.instance:unregisterCallback(FightEvent.EntityEffectLoaded, slot0._onRemoveEffectLoaded, slot0)
	FightController.instance:unregisterCallback(FightEvent.AddMagicCircile, slot0._onAddMagicCircile, slot0)
	FightController.instance:unregisterCallback(FightEvent.DeleteMagicCircile, slot0._onDeleteMagicCircile, slot0)
	FightController.instance:unregisterCallback(FightEvent.UpdateMagicCircile, slot0._onUpdateMagicCircile, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	FightController.instance:unregisterCallback(FightEvent.ChangeSceneVisible, slot0._onChangeSceneVisible, slot0)
	FightController.instance:unregisterCallback(FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.StartFightEnd, slot0._onStartFightEnd, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:releaseAllEffect()

	slot0._entity = nil
end

return slot0
