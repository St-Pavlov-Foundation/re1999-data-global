module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameContainer", package.seeall)

slot0 = class("YaXianGameContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, YaXianGameSceneView.New())
	table.insert(slot1, YaXianGameTipAreaView.New())
	table.insert(slot1, YaXianGamePathView.New())
	table.insert(slot1, YaXianGameView.New())
	table.insert(slot1, YaXianGameSkillView.New())
	table.insert(slot1, TabViewGroup.New(1, "#go_btns"))

	return slot1
end

function slot0.buildTabViews(slot0, slot1)
	if slot1 == 1 then
		slot2 = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.YaxianChessHelp)

		slot2:setOverrideClose(slot0.overrideOnCloseClick, slot0)

		return {
			slot2
		}
	end
end

function slot0.onContainerInit(slot0)
	slot0:refreshViewGo()
end

function slot0.refreshViewGo(slot0)
	gohelper.setActive(slot0.viewGO, not YaXianModel.instance:checkIsPlayingClickAnimation())
end

function slot0.onContainerOpen(slot0)
	AudioMgr.instance:trigger(YaXianConfig.instance:getChapterConfig(YaXianGameModel.instance:getEpisodeCo().chapterId).ambientAudio)
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_decrease)
end

function slot0.onContainerClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_redecrease)
	ViewMgr.instance:closeView(ViewName.YaXianGameResultView)
end

function slot0.onContainerCloseFinish(slot0)
	YaXianGameController.instance:release()
	YaXianGameModel.instance:release()
end

function slot0.setRootSceneGo(slot0, slot1)
	slot0.sceneGo = slot1
end

function slot0.getRootSceneGo(slot0)
	return slot0.sceneGo
end

function slot0.getScenePosOffsetY(slot0)
	if slot0.sceneOffsetY then
		return slot0.sceneOffsetY
	end

	slot1, slot0.sceneOffsetY, slot3 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	return slot0.sceneOffsetY
end

function slot0.playOpenTransition(slot0)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
	slot0:onPlayOpenTransitionFinish()
end

function slot0.playCloseTransition(slot0)
	slot0:_cancelBlock()
	slot0:_stopOpenCloseAnim()
	slot0:__getAnimatorPlayer():Play("close", slot0.onPlayCloseTransitionFinish, slot0)
	TaskDispatcher.runDelay(slot0.onPlayCloseTransitionFinish, slot0, 2)
end

function slot0.overrideOnCloseClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, slot0.yesCallback, nil, , slot0)
end

function slot0.yesCallback(slot0)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Abort)
	slot0:closeThis()
end

return slot0
