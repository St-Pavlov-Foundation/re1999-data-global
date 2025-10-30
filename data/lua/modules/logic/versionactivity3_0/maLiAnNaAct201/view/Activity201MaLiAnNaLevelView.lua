module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.Activity201MaLiAnNaLevelView", package.seeall)

local var_0_0 = class("Activity201MaLiAnNaLevelView", BaseView)

var_0_0.HardId = 1301111
var_0_0.TaskId = 610011

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gopath = gohelper.findChild(arg_1_0.viewGO, "#go_path")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent")
	arg_1_0._golineroot = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/path")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/#go_stages")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "#go_title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_title/#simage_title")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "#go_title/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_task")
	arg_1_0._btnEndless = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Endless")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddotreward")
	arg_1_0._gotaskani = gohelper.findChild(arg_1_0.viewGO, "#btn_task/ani")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._animEndless = arg_1_0._btnEndless.gameObject:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._animTask = arg_1_0._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnEndless:AddClickListener(arg_2_0._btnEndlessOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity201MaLiAnNaController.instance, Activity201MaLiAnNaEvent.EpisodeFinished, arg_2_0._onEpisodeFinished, arg_2_0)
	arg_2_0:addEventCb(Activity201MaLiAnNaController.instance, Activity201MaLiAnNaEvent.OnBackToLevel, arg_2_0._onBackToLevel, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnEndless:RemoveClickListener()
	arg_3_0:removeEventCb(Activity201MaLiAnNaController.instance, Activity201MaLiAnNaEvent.EpisodeFinished, arg_3_0._onEpisodeFinished, arg_3_0)
	arg_3_0:removeEventCb(Activity201MaLiAnNaController.instance, Activity201MaLiAnNaEvent.OnBackToLevel, arg_3_0._onBackToLevel, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_3_0._onOpenView, arg_3_0)
end

function var_0_0._btntaskOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.Activity201MaLiAnNaTaskView)
end

function var_0_0._btnEndlessOnClick(arg_5_0)
	if arg_5_0.lastCo and arg_5_0.lastCo.gameId == 0 then
		if arg_5_0.lastCo.storyBefore > 0 then
			local var_5_0 = {}

			var_5_0.mark = true

			StoryController.instance:playStory(arg_5_0.lastCo.storyBefore, var_5_0, arg_5_0._onGameFinished, arg_5_0)
		end
	elseif arg_5_0.lastCo.storyBefore > 0 then
		local var_5_1 = {}

		var_5_1.mark = true

		StoryController.instance:playStory(arg_5_0.lastCo.storyBefore, var_5_1, arg_5_0._enterGame, arg_5_0)
	else
		arg_5_0:_enterGame()
	end
end

function var_0_0._enterGame(arg_6_0)
	Activity201MaLiAnNaGameController.instance:enterGame(arg_6_0.lastCo.gameId, arg_6_0.lastCo.episodeId)

	if arg_6_0.lastCo.episodeId == var_0_0.HardId then
		TaskRpc.instance:sendFinishReadTaskRequest(var_0_0.TaskId)
	end
end

function var_0_0._onGameFinished(arg_7_0)
	Activity201MaLiAnNaController.instance:_onGameFinished(arg_7_0.actId, arg_7_0.lastCo.episodeId)
end

function var_0_0._refreshTask(arg_8_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a0MaLiAnNaTask, 0) then
		arg_8_0._animTask:Play("loop")
	else
		arg_8_0._animTask:Play("idle")
	end
end

function var_0_0._onCloseTask(arg_9_0)
	arg_9_0:_refreshTask()
end

function var_0_0._removeEvents(arg_10_0)
	return
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0.actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa
	arg_11_0._viewAnimator = arg_11_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	RedDotController.instance:addRedDot(arg_11_0._goreddotreward, RedDotEnum.DotNode.V3a0MaLiAnNaTask)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_initLevelItems()
	arg_12_0:_refreshLeftTime()
	arg_12_0:_refreshTask()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function var_0_0._refreshLeftTime(arg_13_0)
	arg_13_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_13_0.actId)
end

function var_0_0._initLevelItems(arg_14_0)
	local var_14_0 = arg_14_0.viewContainer:getSetting().otherRes[1]

	arg_14_0._episodeItems = {}

	local var_14_1 = Activity201MaLiAnNaConfig.instance:getEpisodeCoList(arg_14_0.actId)

	arg_14_0._lastIndex = #var_14_1
	arg_14_0._beforeLastEpisodeId = var_14_1[#var_14_1 - 1].episodeId
	arg_14_0.lastCo = var_14_1[#var_14_1]

	arg_14_0:chekcShowHardNode()

	local var_14_2 = Activity201MaLiAnNaModel.instance:getMaxUnlockEpisodeId()

	arg_14_0._curEpisodeIndex = Activity201MaLiAnNaModel.instance:getEpisodeIndex(var_14_2)

	Activity201MaLiAnNaModel.instance:setCurEpisode(arg_14_0._curEpisodeIndex, var_14_2)

	for iter_14_0 = 1, #var_14_1 - 1 do
		local var_14_3 = gohelper.findChild(arg_14_0._gostages, "stage" .. iter_14_0)
		local var_14_4 = arg_14_0:getResInst(var_14_0, var_14_3)
		local var_14_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_4, Activity201MaLiAnNaLevelItem, arg_14_0)

		arg_14_0._episodeItems[iter_14_0] = var_14_5

		arg_14_0._episodeItems[iter_14_0]:setParam(var_14_1[iter_14_0], iter_14_0, arg_14_0.actId)
	end
end

function var_0_0._onBackToLevel(arg_15_0)
	local var_15_0 = Activity201MaLiAnNaModel.instance:getNewFinishEpisode()

	if var_15_0 and var_15_0 ~= 0 then
		local var_15_1 = Activity201MaLiAnNaModel.instance:getMaxUnlockEpisodeId()

		arg_15_0._curEpisodeIndex = Activity201MaLiAnNaModel.instance:getEpisodeIndex(var_15_1)

		Activity201MaLiAnNaModel.instance:setCurEpisode(arg_15_0._curEpisodeIndex, var_15_1)
	end

	arg_15_0:_refreshTask()
	Activity201MaLiAnNaController.instance:startBurnAudio()
end

function var_0_0._onEpisodeFinished(arg_16_0)
	if Activity201MaLiAnNaModel.instance:getNewFinishEpisode() then
		TaskDispatcher.runDelay(arg_16_0._playStoryFinishAnim, arg_16_0, 1)
	end
end

function var_0_0._playStoryFinishAnim(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._playStoryFinishAnim, arg_17_0)

	local var_17_0 = Activity201MaLiAnNaModel.instance:getNewFinishEpisode()

	if var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._episodeItems) do
			if iter_17_1.id == var_17_0 then
				arg_17_0._finishEpisodeIndex = iter_17_0

				iter_17_1:playFinish()
				iter_17_1:playStarAnim()
				TaskDispatcher.runDelay(arg_17_0._finishStoryEnd, arg_17_0, 1.5)

				break
			end
		end

		Activity201MaLiAnNaModel.instance:clearFinishEpisode()
	end
end

function var_0_0._finishStoryEnd(arg_18_0)
	if arg_18_0._finishEpisodeIndex == #arg_18_0._episodeItems then
		arg_18_0._curEpisodeIndex = arg_18_0._finishEpisodeIndex
		arg_18_0._finishEpisodeIndex = nil

		arg_18_0:chekcShowHardNode()
	else
		arg_18_0._curEpisodeIndex = arg_18_0._finishEpisodeIndex + 1

		arg_18_0:_unlockStory()
	end
end

function var_0_0._unlockStory(arg_19_0)
	arg_19_0._episodeItems[arg_19_0._finishEpisodeIndex + 1]:refreshUI()
	arg_19_0._episodeItems[arg_19_0._finishEpisodeIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(arg_19_0._unlockLvEnd, arg_19_0, 1.5)
end

function var_0_0._unlockLvEnd(arg_20_0)
	arg_20_0._finishEpisodeIndex = nil
end

function var_0_0.chekcShowHardNode(arg_21_0)
	local var_21_0 = Activity201MaLiAnNaModel.instance:isEpisodePass(arg_21_0._beforeLastEpisodeId)

	gohelper.setActive(arg_21_0._btnEndless.gameObject, var_21_0)

	if var_21_0 and GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Activity201MaLiAnNaLevelViewHardAnim, 0) == 0 then
		GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Activity201MaLiAnNaLevelViewHardAnim, 1)
		arg_21_0._animEndless:Play("open")
		AudioMgr.instance:trigger(AudioEnum3_0.MaLiAnNa.play_ui_lushang_level_appear)
	else
		arg_21_0._animEndless:Play("idle")
	end
end

function var_0_0.onClose(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._refreshLeftTime, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._playStoryFinishAnim, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._finishStoryEnd, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._unlockLvEnd, arg_22_0)
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0:_removeEvents()

	arg_23_0._episodeItems = nil

	TaskDispatcher.cancelTask(arg_23_0._refreshLeftTime, arg_23_0)
end

function var_0_0._onCloseView(arg_24_0, arg_24_1)
	if arg_24_1 == ViewName.Activity201MaLiAnNaGameView then
		gohelper.setActive(arg_24_0.viewGO, true)
	elseif arg_24_1 == ViewName.Activity201MaLiAnNaTaskView then
		arg_24_0:_onCloseTask()
	end
end

function var_0_0._onOpenView(arg_25_0, arg_25_1)
	if arg_25_1 == ViewName.MaLiAnNaNoticeView then
		gohelper.setActive(arg_25_0.viewGO, false)
	end
end

return var_0_0
