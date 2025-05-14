module("modules.logic.fight.system.work.FightWorkRestartBefore", package.seeall)

local var_0_0 = class("FightWorkRestartBefore", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, arg_2_0._onDestroyViewFinish, arg_2_0)
	GameSceneMgr.instance:getCurScene().view:onSceneClose()
	GameSceneMgr.instance:getCurScene().level:setFrontVisible(true)
end

function var_0_0._onDestroyViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.FightView then
		ViewMgr.instance:unregisterCallback(ViewEvent.DestroyViewFinish, arg_3_0._onDestroyViewFinish, arg_3_0)

		FightDataHelper.tempMgr.simplePolarizationLevel = nil

		StoryController.instance:closeStoryView()
		FightFloatMgr.instance:clearFloatItem()
		FightPreloadController.instance:releaseRoleCardAsset()
		FightController.instance:dispatchEvent(FightEvent.OnEndFightForGuide)
		FightController.instance:dispatchEvent(FightEvent.OnRestartStageBefore)

		local var_3_0 = GameSceneMgr.instance:getCurScene()

		var_3_0.entityMgr:removeAllUnits()
		var_3_0.director:registRespBeginFight()
		var_3_0.bgm:resumeBgm()
		FightSkillMgr.instance:dispose()
		FightSystem.instance:dispose()
		FightNameMgr.instance:onRestartStage()
		FightAudioMgr.instance:dispose()

		FightRoundSequence.roundTempData = {}

		var_3_0.camera:enablePostProcessSmooth(false)
		var_3_0.camera:resetParam()
		var_3_0.camera:setSceneCameraOffset()

		FightModel.instance._curRoundId = 1

		FightModel.instance:onRestart()
		FightController.instance:dispatchEvent(FightEvent.OnRestartFightDisposeDone)
		gohelper.setActiveCanvasGroup(ViewMgr.instance:getUILayer(UILayerName.Hud), false)

		if arg_3_0.context and arg_3_0.context.noReloadScene then
			arg_3_0:_correctRootState()
			arg_3_0:onDone(true)

			return
		end

		if GameSceneMgr.instance:getCurLevelId() ~= FightModel.instance:getFightParam():getSceneLevel(1) then
			GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingBlackView)
			GameSceneMgr.instance:showLoading(SceneType.Fight)
			TaskDispatcher.runDelay(arg_3_0._delayDone, arg_3_0, 5)
			TaskDispatcher.runDelay(arg_3_0._startLoadLevel, arg_3_0, 0.25)

			arg_3_0._loadTime = Time.time
		else
			arg_3_0:_correctRootState()
			arg_3_0:onDone(true)
		end
	end
end

function var_0_0._correctRootState(arg_4_0)
	if GameSceneMgr.instance:getCurSceneId() == FightTLEventMarkSceneDefaultRoot.sceneId and GameSceneMgr.instance:getCurLevelId() == FightTLEventMarkSceneDefaultRoot.levelId then
		local var_4_0 = GameSceneMgr.instance:getCurScene()

		if var_4_0 then
			local var_4_1 = var_4_0.level:getSceneGo()

			if var_4_1 then
				local var_4_2 = var_4_1.transform.childCount

				for iter_4_0 = 0, var_4_2 - 1 do
					local var_4_3 = var_4_1.transform:GetChild(iter_4_0)

					gohelper.setActive(var_4_3.gameObject, var_4_3.name == FightTLEventMarkSceneDefaultRoot.rootName)
				end
			end
		end
	end
end

function var_0_0._startLoadLevel(arg_5_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_5_0._onLevelLoaded, arg_5_0)

	local var_5_0 = GameSceneMgr.instance:getScene(SceneType.Fight)
	local var_5_1 = FightModel.instance:getFightParam():getSceneLevel(1)

	var_5_0.level:onSceneStart(var_5_0.level._sceneId, var_5_1)
end

function var_0_0._onLevelLoaded(arg_6_0)
	local var_6_0 = 0.5 - (Time.time - arg_6_0._loadTime)

	if var_6_0 <= 0 then
		arg_6_0:onDone(true)
	else
		TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
		TaskDispatcher.runDelay(arg_6_0._delayDone, arg_6_0, var_6_0)
	end

	GameSceneMgr.instance:getCurScene().camera:setSceneCameraOffset()
end

function var_0_0._delayDone(arg_7_0)
	local var_7_0 = GameSceneMgr.instance:getCurScene()

	arg_7_0:onDone(true)
end

function var_0_0.clearWork(arg_8_0)
	GameSceneMgr.instance:hideLoading()
	TaskDispatcher.cancelTask(arg_8_0._delayDone, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._startLoadLevel, arg_8_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.OnLevelLoaded, arg_8_0._onLevelLoaded, arg_8_0)
end

return var_0_0
