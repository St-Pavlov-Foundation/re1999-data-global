module("modules.logic.versionactivity1_2.yaxian.view.game.YaXianGameContainer", package.seeall)

local var_0_0 = class("YaXianGameContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, YaXianGameSceneView.New())
	table.insert(var_1_0, YaXianGameTipAreaView.New())
	table.insert(var_1_0, YaXianGamePathView.New())
	table.insert(var_1_0, YaXianGameView.New())
	table.insert(var_1_0, YaXianGameSkillView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.YaxianChessHelp)

		var_2_0:setOverrideClose(arg_2_0.overrideOnCloseClick, arg_2_0)

		return {
			var_2_0
		}
	end
end

function var_0_0.onContainerInit(arg_3_0)
	arg_3_0:refreshViewGo()
end

function var_0_0.refreshViewGo(arg_4_0)
	gohelper.setActive(arg_4_0.viewGO, not YaXianModel.instance:checkIsPlayingClickAnimation())
end

function var_0_0.onContainerOpen(arg_5_0)
	local var_5_0 = YaXianGameModel.instance:getEpisodeCo()
	local var_5_1 = YaXianConfig.instance:getChapterConfig(var_5_0.chapterId)

	AudioMgr.instance:trigger(var_5_1.ambientAudio)
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_decrease)
end

function var_0_0.onContainerClose(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_redecrease)
	ViewMgr.instance:closeView(ViewName.YaXianGameResultView)
end

function var_0_0.onContainerCloseFinish(arg_7_0)
	YaXianGameController.instance:release()
	YaXianGameModel.instance:release()
end

function var_0_0.setRootSceneGo(arg_8_0, arg_8_1)
	arg_8_0.sceneGo = arg_8_1
end

function var_0_0.getRootSceneGo(arg_9_0)
	return arg_9_0.sceneGo
end

function var_0_0.getScenePosOffsetY(arg_10_0)
	if arg_10_0.sceneOffsetY then
		return arg_10_0.sceneOffsetY
	end

	local var_10_0, var_10_1, var_10_2 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	arg_10_0.sceneOffsetY = var_10_1

	return arg_10_0.sceneOffsetY
end

function var_0_0.playOpenTransition(arg_11_0)
	arg_11_0:_cancelBlock()
	arg_11_0:_stopOpenCloseAnim()
	arg_11_0:onPlayOpenTransitionFinish()
end

function var_0_0.playCloseTransition(arg_12_0)
	arg_12_0:_cancelBlock()
	arg_12_0:_stopOpenCloseAnim()
	arg_12_0:__getAnimatorPlayer():Play("close", arg_12_0.onPlayCloseTransitionFinish, arg_12_0)
	TaskDispatcher.runDelay(arg_12_0.onPlayCloseTransitionFinish, arg_12_0, 2)
end

function var_0_0.overrideOnCloseClick(arg_13_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitPushBoxEpisode, MsgBoxEnum.BoxType.Yes_No, arg_13_0.yesCallback, nil, nil, arg_13_0)
end

function var_0_0.yesCallback(arg_14_0)
	Stat1_2Controller.instance:yaXianStatEnd(StatEnum.Result.Abort)
	arg_14_0:closeThis()
end

return var_0_0
