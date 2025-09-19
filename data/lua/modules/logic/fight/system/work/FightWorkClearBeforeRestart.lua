module("modules.logic.fight.system.work.FightWorkClearBeforeRestart", package.seeall)

local var_0_0 = class("FightWorkClearBeforeRestart", FightWorkItem)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.SAFETIME = 30
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:com_registEvent(ViewMgr.instance, ViewEvent.DestroyViewFinish, arg_2_0._onDestroyViewFinish)
	GameSceneMgr.instance:getCurScene().view:onSceneClose()
	GameSceneMgr.instance:getCurScene().level:setFrontVisible(true)
end

function var_0_0._onDestroyViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.FightView then
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
		arg_3_0:onDone(true)
	end
end

return var_0_0
