module("modules.logic.scene.fight.comp.FightSceneTriggerSceneAnimatorComp", package.seeall)

slot0 = class("FightSceneTriggerSceneAnimatorComp", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._activeState = true

	FightController.instance:registerCallback(FightEvent.TriggerSceneAnimator, slot0._onTriggerSceneAnimator, slot0)
	FightController.instance:registerCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)

	slot0._cacheAni = {}
end

function slot0._onLevelLoaded(slot0)
	slot0._fightScene = GameSceneMgr.instance:getCurScene()
	slot0.listenClass = gohelper.onceAddComponent(slot0._fightScene.level:getSceneGo(), typeof(ZProj.FightSceneActiveState))

	if BootNativeUtil.isWindows() and GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High then
		RenderPipelineSetting.AddRCASSceneCompoment(slot1)
	end

	slot0.listenClass:releaseCallback()
	slot0.listenClass:setCallback(slot0._onSceneStateChange, slot0)
end

function slot0._onTriggerSceneAnimator(slot0, slot1)
	slot0._fightScene = slot0._fightScene or GameSceneMgr.instance:getCurScene()

	if slot0._fightScene and gohelper.findChildComponent(slot0._fightScene.level:getSceneGo(), slot1.param1, typeof(UnityEngine.Animator)) then
		slot3.speed = FightModel.instance:getSpeed()

		slot3:Play(slot1.param2, 0, 0)

		slot0._cacheAni[slot1.param1] = slot1.param2
	end
end

function slot0._onSceneStateChange(slot0, slot1)
	FightController.instance:dispatchEvent(FightEvent.ChangeSceneVisible, slot1)

	if slot0._fightScene and not gohelper.isNil(slot0._fightScene.level:getSceneGo()) and slot0._activeState ~= slot1 then
		slot0._activeState = slot1

		if slot0._activeState then
			for slot6, slot7 in pairs(slot0._cacheAni) do
				if gohelper.findChildComponent(slot2, slot6, typeof(UnityEngine.Animator)) then
					slot8.speed = FightModel.instance:getSpeed()

					slot8:Play(slot7 .. "_idle", 0, 0)
				end
			end
		end
	end
end

function slot0._onRestartStageBefore(slot0)
	slot0._activeState = true
	slot0._cacheAni = {}
end

function slot0.onSceneClose(slot0, slot1, slot2)
	if slot0.listenClass then
		slot0.listenClass:releaseCallback()

		slot0.listenClass = nil
	end

	slot0._cacheAni = nil

	FightController.instance:unregisterCallback(FightEvent.TriggerSceneAnimator, slot0._onTriggerSceneAnimator, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRestartStageBefore, slot0._onRestartStageBefore, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

return slot0
