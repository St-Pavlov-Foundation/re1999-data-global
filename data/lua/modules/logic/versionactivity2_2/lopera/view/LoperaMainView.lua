module("modules.logic.versionactivity2_2.lopera.view.LoperaMainView", package.seeall)

local var_0_0 = class("LoperaMainView", BaseView)
local var_0_1 = VersionActivity2_2Enum.ActivityId.Lopera
local var_0_2 = {
	0.86,
	0.6,
	0.48,
	0.35,
	0.25,
	0.13,
	0
}
local var_0_3 = 1
local var_0_4 = 0
local var_0_5 = -480
local var_0_6 = 5
local var_0_7 = 8

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "window/righttop/reward/clickArea", AudioEnum.UI.play_ui_mission_open)
	arg_1_0._btnEndless = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Endless")
	arg_1_0._btnReplay = gohelper.findChildButton(arg_1_0.viewGO, "window/title/#btn_Play")
	arg_1_0._goscrollcontent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/Content")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/Content/#go_stages")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "window/title/#txt_time")

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "#go_path/#go_scrollcontent/Content/path")

	arg_1_0._viewAnimator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._animPath = var_1_0:GetComponent(gohelper.Type_Animator)
	arg_1_0._taskAnimator = gohelper.findChild(arg_1_0.viewGO, "window/righttop/reward/ani"):GetComponent(gohelper.Type_Animator)
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "window/righttop/reward/reddot")
	arg_1_0._goEndlessRedDot = gohelper.findChild(arg_1_0.viewGO, "#btn_Endless/#go_reddot")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnEndless:AddClickListener(arg_2_0._btnEndlessOnClick, arg_2_0)
	arg_2_0._btnReplay:AddClickListener(arg_2_0._btnReplayOnClick, arg_2_0)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.BeforeEnterEpisode, arg_2_0._beforeEneterEpisode, arg_2_0)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeUpdate, arg_2_0._onEpisodeUpdate, arg_2_0)
	arg_2_0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeFinish, arg_2_0._onEpisodeFinish, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0._refreshTask, arg_2_0)
	RedDotController.instance:addRedDot(arg_2_0._gored, RedDotEnum.DotNode.LoperaTaksReword)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnEndless:RemoveClickListener()
	arg_3_0._btnReplay:RemoveClickListener()
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0._refreshTask, arg_3_0)
end

function var_0_0._btntaskOnClick(arg_4_0)
	LoperaController.instance:openTaskView()
end

function var_0_0._btnEndlessOnClick(arg_5_0)
	LoperaController.instance:enterEpisode(LoperaEnum.EndlessEpisodeId)
	GameUtil.playerPrefsSetNumberByUserId(PlayerPrefsKey.Version2_2LoperaEndlessNewFlag .. var_0_1, 1)
end

function var_0_0._btnReplayOnClick(arg_6_0)
	local var_6_0 = ActivityModel.instance:getActMO(var_0_1)
	local var_6_1 = var_6_0 and var_6_0.config and var_6_0.config.storyId

	if not var_6_1 or var_6_1 == 0 then
		logError(string.format("act id %s dot config story id", arg_6_0.curActId))

		return
	end

	StoryController.instance:playStory(var_6_1)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._viewAnimator = arg_7_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._pathAnimator = gohelper.findChild(arg_7_0.viewGO, "#go_path/#go_scrollcontent/path/path_2"):GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._excessAnimator = arg_7_0._goexcessive:GetComponent(typeof(UnityEngine.Animator))
	arg_7_0._blackAnimator = arg_7_0._goblack:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:_initStages()
	arg_8_0:_refreshBtnState()
	arg_8_0:refreshTime()
	arg_8_0:_refreshTask()
	arg_8_0:_refreshPathState()
	TaskDispatcher.runRepeat(arg_8_0.refreshTime, arg_8_0, 60)
	arg_8_0._viewAnimator:Play(UIAnimationName.Open, 0, 0)
end

function var_0_0._onGetEpisodeInfo(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 == 0 then
		ViewMgr.instance:openView(ViewName.LoperaLevelView)
	end
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0._initStages(arg_11_0)
	if arg_11_0._stageItemList then
		return
	end

	local var_11_0 = arg_11_0.viewContainer:getSetting().otherRes[1]

	arg_11_0._stageItemList = {}
	arg_11_0._curOpenEpisodeCount = Activity168Model.instance:getFinishedCount() + 1

	local var_11_1 = VersionActivity2_2Enum.ActivityId.Lopera
	local var_11_2 = Activity168Config.instance:getEpisodeCfgList(var_11_1)
	local var_11_3 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaSelect .. var_11_1, "1")
	local var_11_4

	var_11_4 = tonumber(var_11_3) or 1

	local var_11_5 = Mathf.Clamp(var_11_4, 1, #var_11_2)
	local var_11_6 = (var_11_2[var_11_5] and var_11_2[var_11_5] or var_11_2[1]).id

	Activity168Model.instance:setCurEpisodeId(var_11_6)

	for iter_11_0 = 1, #var_11_2 do
		local var_11_7 = var_11_2[iter_11_0]

		if var_11_7.episodeType == LoperaEnum.EpisodeType.ExploreEndless then
			break
		end

		local var_11_8 = gohelper.findChild(arg_11_0._gostages, "stage" .. iter_11_0)
		local var_11_9 = arg_11_0:getResInst(var_11_0, var_11_8)
		local var_11_10 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_9, LoperaMainViewStageItem, arg_11_0)

		var_11_10:refreshItem(var_11_7, iter_11_0)
		table.insert(arg_11_0._stageItemList, var_11_10)
	end

	arg_11_0:_setContentOffset(var_11_5)
end

function var_0_0._setContentOffset(arg_12_0, arg_12_1)
	recthelper.setAnchor(arg_12_0._goContent.transform, arg_12_1 < var_0_6 and var_0_4 or var_0_5, 0)
end

function var_0_0._refreshBtnState(arg_13_0)
	local var_13_0 = Activity168Model.instance:getFinishedCount()

	gohelper.setActive(arg_13_0._goEndlessRedDot, arg_13_0._checkEnterEndlessMode())
	gohelper.setActive(arg_13_0._btnEndless.gameObject, var_13_0 >= var_0_7)

	if var_13_0 >= var_0_7 then
		LoperaController.instance:dispatchEvent(LoperaEvent.EndlessUnlock)
	end
end

function var_0_0._refreshPathState(arg_14_0)
	local var_14_0 = Activity168Model.instance:getFinishedCount()

	arg_14_0._pathEffectValue = var_14_0 > 0 and var_0_2[var_14_0] or 1

	arg_14_0:_setPathMatEffectValue(arg_14_0._pathEffectValue)
end

function var_0_0._setPathMatEffectValue(arg_15_0, arg_15_1)
	if not arg_15_0._pathMat then
		arg_15_0._pathMat = gohelper.findChild(arg_15_0.viewGO, "#go_path/#go_scrollcontent/Content/path/luxian_light"):GetComponent(typeof(UIMesh)).material
	end

	local var_15_0 = Vector4.New(arg_15_1, 0.05, 0, 0)

	arg_15_0._pathMat:SetVector("_DissolveControl", var_15_0)
end

function var_0_0._onEpisodeFinish(arg_16_0, arg_16_1)
	arg_16_0:_refreshTask()
end

function var_0_0.tryShowFinishUnlockView(arg_17_0)
	local var_17_0 = Activity168Model.instance:getFinishedCount()

	if var_17_0 < arg_17_0._curOpenEpisodeCount then
		return
	end

	local var_17_1 = Activity168Model.instance:getCurEpisodeId()

	if var_17_1 and var_17_1 == LoperaEnum.EndlessEpisodeId then
		return
	end

	arg_17_0._curOpenEpisodeCount = var_17_0 + 1
	arg_17_0._playingUnlockNextLevel = true

	arg_17_0:_destroyFlow()

	arg_17_0.unlockAniflow = FlowSequence.New()

	arg_17_0.unlockAniflow:addWork(DelayFuncWork.New(arg_17_0._playFinishAni, arg_17_0, 1))
	arg_17_0.unlockAniflow:addWork(DelayFuncWork.New(arg_17_0._playNewPathAni, arg_17_0, 1))
	arg_17_0.unlockAniflow:addWork(DelayFuncWork.New(arg_17_0._playUnlockAni, arg_17_0, 1))
	arg_17_0.unlockAniflow:addWork(DelayFuncWork.New(arg_17_0._playChessMoveAni, arg_17_0, 1))
	arg_17_0.unlockAniflow:start()
end

function var_0_0._playFinishAni(arg_18_0)
	local var_18_0 = Activity168Model.instance:getFinishedCount()

	if arg_18_0._stageItemList[var_18_0] then
		arg_18_0._stageItemList[var_18_0]:playFinishAni()
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_jlbn_level_pass)
end

function var_0_0._playNewPathAni(arg_19_0)
	local var_19_0 = Activity168Model.instance:getFinishedCount()
	local var_19_1 = var_19_0 > 0 and var_0_2[var_19_0] or 1

	if arg_19_0._pathEffectValue == var_19_1 then
		return
	end

	local var_19_2 = arg_19_0._pathEffectValue
	local var_19_3 = 1

	arg_19_0._pathEffectValue = var_19_1

	local var_19_4 = var_0_3

	arg_19_0._pathAnimTweenId = ZProj.TweenHelper.DOTweenFloat(var_19_3, var_19_1, var_19_4, arg_19_0._onPathFrame, nil, arg_19_0, nil, EaseType.Linear)
end

function var_0_0._onPathFrame(arg_20_0, arg_20_1)
	arg_20_0:_setPathMatEffectValue(arg_20_1)
end

function var_0_0._playUnlockAni(arg_21_0)
	local var_21_0 = Activity168Model.instance:getFinishedCount()

	if arg_21_0._stageItemList[var_21_0 + 1] then
		arg_21_0._stageItemList[var_21_0 + 1]:playUnlockAni()
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_jlbn_level_unlock)
	end
end

function var_0_0._playChessMoveAni(arg_22_0)
	return
end

function var_0_0._beforeEneterEpisode(arg_23_0)
	arg_23_0._viewAnimator:Play(UIAnimationName.Click, 0, 0)
end

function var_0_0._onEpisodeUpdate(arg_24_0)
	arg_24_0:_refreshBtnState()
end

function var_0_0.refreshTime(arg_25_0)
	arg_25_0._txtlimittime.text = arg_25_0.getLimitTimeStr()
end

function var_0_0.getLimitTimeStr()
	local var_26_0 = ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.Lopera)

	if not var_26_0 then
		return ""
	end

	local var_26_1 = var_26_0:getRealEndTimeStamp() - ServerTime.now()

	if var_26_1 > 0 then
		return TimeUtil.SecondToActivityTimeFormat(var_26_1)
	end

	return ""
end

function var_0_0._checkEnterEndlessMode(arg_27_0)
	return GameUtil.playerPrefsGetNumberByUserId(PlayerPrefsKey.Version2_2LoperaEndlessNewFlag .. var_0_1, 0) == 0
end

function var_0_0._refreshTask(arg_28_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.LoperaTaksReword, 0) then
		arg_28_0._taskAnimator:Play(UIAnimationName.Loop, 0, 0)
	else
		arg_28_0._taskAnimator:Play(UIAnimationName.Idle, 0, 0)
	end
end

function var_0_0._destroyFlow(arg_29_0)
	if arg_29_0.unlockAniflow then
		arg_29_0.unlockAniflow:destroy()

		arg_29_0.unlockAniflow = nil
	end
end

function var_0_0.onDestroyView(arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0.refreshTime, arg_30_0)
	arg_30_0:_destroyFlow()
end

return var_0_0
