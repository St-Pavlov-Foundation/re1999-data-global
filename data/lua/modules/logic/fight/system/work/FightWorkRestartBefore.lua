module("modules.logic.fight.system.work.FightWorkRestartBefore", package.seeall)

slot0 = class("FightWorkRestartBefore", BaseWork)

function slot0.ctor(slot0)
end

function slot0.onStart(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, slot0._onDestroyViewFinish, slot0)
	GameSceneMgr.instance:getCurScene().view:onSceneClose()
	GameSceneMgr.instance:getCurScene().level:setFrontVisible(true)
end

function slot0._onDestroyViewFinish(slot0, slot1)
	if slot1 == ViewName.FightView then
		ViewMgr.instance:unregisterCallback(ViewEvent.DestroyViewFinish, slot0._onDestroyViewFinish, slot0)

		FightDataHelper.tempMgr.simplePolarizationLevel = nil

		StoryController.instance:closeStoryView()
		FightFloatMgr.instance:clearFloatItem()
		FightPreloadController.instance:releaseRoleCardAsset()
		FightController.instance:dispatchEvent(FightEvent.OnEndFightForGuide)
		FightController.instance:dispatchEvent(FightEvent.OnRestartStageBefore)

		slot2 = GameSceneMgr.instance:getCurScene()

		slot2.entityMgr:removeAllUnits()
		slot2.director:registRespBeginFight()
		slot2.bgm:resumeBgm()
		FightSkillMgr.instance:dispose()
		FightSystem.instance:dispose()
		FightNameMgr.instance:onRestartStage()
		FightAudioMgr.instance:dispose()

		FightRoundSequence.roundTempData = {}

		slot2.camera:enablePostProcessSmooth(false)
		slot2.camera:resetParam()
		slot2.camera:setSceneCameraOffset()

		FightModel.instance._curRoundId = 1

		FightModel.instance:onRestart()
		FightController.instance:dispatchEvent(FightEvent.OnRestartFightDisposeDone)
		gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), false)

		if slot0.context and slot0.context.noReloadScene then
			slot0:_correctRootState()
			slot0:onDone(true)

			return
		end

		if GameSceneMgr.instance:getCurLevelId() ~= FightModel.instance:getFightParam():getSceneLevel(1) then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView)
			GameSceneMgr.instance:showLoading(SceneType.Fight)
			TaskDispatcher.runDelay(slot0._delayDone, slot0, 5)
			TaskDispatcher.runDelay(slot0._startLoadLevel, slot0, 0.25)

			slot0._loadTime = Time.time
		else
			slot0:_correctRootState()
			slot0:onDone(true)
		end
	end
end

function slot0._correctRootState(slot0)
	if GameSceneMgr.instance:getCurSceneId() == FightTLEventMarkSceneDefaultRoot.sceneId and GameSceneMgr.instance:getCurLevelId() == FightTLEventMarkSceneDefaultRoot.levelId and GameSceneMgr.instance:getCurScene() and slot1.level:getSceneGo() then
		for slot7 = 0, slot2.transform.childCount - 1 do
			slot8 = slot2.transform:GetChild(slot7)

			gohelper.setActive(slot8.gameObject, slot8.name == FightTLEventMarkSceneDefaultRoot.rootName)
		end
	end
end

function slot0._startLoadLevel(slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)

	slot1 = GameSceneMgr.instance:getScene(SceneType.Fight)

	slot1.level:onSceneStart(slot1.level._sceneId, FightModel.instance:getFightParam():getSceneLevel(1))
end

function slot0._onLevelLoaded(slot0)
	if 0.5 - (Time.time - slot0._loadTime) <= 0 then
		slot0:onDone(true)
	else
		TaskDispatcher.cancelTask(slot0._delayDone, slot0)
		TaskDispatcher.runDelay(slot0._delayDone, slot0, slot2)
	end

	GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
end

function slot0._delayDone(slot0)
	slot1 = GameSceneMgr.instance:getCurScene()

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	GameSceneMgr.instance:hideLoading()
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	TaskDispatcher.cancelTask(slot0._startLoadLevel, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, slot0._onLevelLoaded, slot0)
end

return slot0
