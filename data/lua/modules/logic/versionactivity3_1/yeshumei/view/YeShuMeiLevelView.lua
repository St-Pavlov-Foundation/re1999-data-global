module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiLevelView", package.seeall)

local var_0_0 = class("YeShuMeiLevelView", BaseView)
local var_0_1 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._trsBg = gohelper.findChild(arg_1_0.viewGO, "#simage_FullBG").transform
	arg_1_0._gostoryScroll = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._scrollstory = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_storyPath")
	arg_1_0._gostages = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/image_LimitTimeBG/#txt_limittime")
	arg_1_0._btntask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._goreddotreward = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._gotaskani = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/ani")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._animTask = arg_1_0._gotaskani:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0:addEventCb(YeShuMeiController.instance, YeShuMeiEvent.EpisodeFinished, arg_2_0._onEpisodeFinished, arg_2_0)
	arg_2_0:addEventCb(YeShuMeiController.instance, YeShuMeiEvent.OnBackToLevel, arg_2_0._onBackToLevel, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0._onScreenSizeChange, arg_2_0)
	arg_2_0._scrollstory:AddOnValueChanged(arg_2_0.onValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0:removeEventCb(YeShuMeiController.instance, YeShuMeiEvent.EpisodeFinished, arg_3_0._onEpisodeFinished, arg_3_0)
	arg_3_0:removeEventCb(YeShuMeiController.instance, YeShuMeiEvent.OnBackToLevel, arg_3_0._onBackToLevel, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.ReOpenWhileOpen, arg_3_0._onOpenView, arg_3_0)
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenSizeChange, arg_3_0)
	arg_3_0._scrollstory:RemoveOnValueChanged()
end

function var_0_0.onValueChanged(arg_4_0)
	local var_4_0 = arg_4_0._scrollstory.horizontalNormalizedPosition

	if var_4_0 > 1 then
		var_4_0 = 1
	end

	local var_4_1 = arg_4_0._canMoveBgWidth * var_4_0

	recthelper.setAnchorX(arg_4_0._trsBg, -var_4_1)
end

function var_0_0._btntaskOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.YeShuMeiTaskView)
end

function var_0_0._refreshTask(arg_6_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V3a1YeShuMeiTask, 0) then
		arg_6_0._animTask:Play("loop")
	else
		arg_6_0._animTask:Play("idle")
	end
end

function var_0_0._onCloseTask(arg_7_0)
	arg_7_0:_refreshTask()
end

function var_0_0._removeEvents(arg_8_0)
	return
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0.actId = VersionActivity3_1Enum.ActivityId.YeShuMei
	arg_9_0._viewAnimator = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	local var_9_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_9_0._halfbg = recthelper.getWidth(arg_9_0._trsBg) / 2
	arg_9_0._offsetX = var_9_0 / 2
	arg_9_0._canMoveBgWidth = arg_9_0._halfbg - arg_9_0._offsetX
	arg_9_0.minContentAnchorX = -4000 + var_9_0

	RedDotController.instance:addRedDot(arg_9_0._goreddotreward, RedDotEnum.DotNode.V3a1YeShuMeiTask)
end

function var_0_0._onOpenView(arg_10_0)
	arg_10_0._focusId = arg_10_0.viewParam and arg_10_0.viewParam.episodeId

	local var_10_0 = YeShuMeiModel.instance:getEpisodeIndex(arg_10_0._focusId)

	arg_10_0:_focusStoryItem(var_10_0, true)

	arg_10_0._focusId = nil
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._focusId = arg_11_0.viewParam and arg_11_0.viewParam.episodeId

	arg_11_0:_initLines()
	arg_11_0:_initLevelItems()
	arg_11_0:_refreshLines()
	arg_11_0:_refreshLeftTime()
	TaskDispatcher.runRepeat(arg_11_0._refreshLeftTime, arg_11_0, 1)
	arg_11_0:_refreshTask()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
end

function var_0_0._initLines(arg_12_0)
	arg_12_0._linesList = {}

	for iter_12_0 = 1, 7 do
		local var_12_0 = arg_12_0:getUserDataTb_()

		var_12_0.go = gohelper.findChild(arg_12_0.viewGO, "#go_storyPath/#go_storyScroll/path/path2/Line" .. iter_12_0)
		var_12_0.animator = var_12_0.go:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(var_12_0.go, false)
		table.insert(arg_12_0._linesList, var_12_0)
	end
end

function var_0_0._refreshLines(arg_13_0)
	for iter_13_0 = 1, arg_13_0._curEpisodeIndex - 1 do
		local var_13_0 = arg_13_0._linesList[iter_13_0]

		if var_13_0 then
			gohelper.setActive(var_13_0.go, true)
		end
	end
end

function var_0_0._refreshLeftTime(arg_14_0)
	arg_14_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(arg_14_0.actId)
end

function var_0_0._initLevelItems(arg_15_0)
	local var_15_0 = arg_15_0.viewContainer:getSetting().otherRes[1]

	arg_15_0._episodeItems = {}

	local var_15_1 = YeShuMeiConfig.instance:getEpisodeCoList(arg_15_0.actId)
	local var_15_2 = YeShuMeiModel.instance:getMaxUnlockEpisodeId()

	arg_15_0._curEpisodeIndex = YeShuMeiModel.instance:getEpisodeIndex(var_15_2)

	YeShuMeiModel.instance:setCurEpisode(arg_15_0._curEpisodeIndex, var_15_2)

	for iter_15_0 = 1, #var_15_1 do
		local var_15_3 = gohelper.findChild(arg_15_0._gostages, "stage" .. iter_15_0)
		local var_15_4 = arg_15_0:getResInst(var_15_0, var_15_3)
		local var_15_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_4, YeShuMeiStoryItem, arg_15_0)

		arg_15_0._episodeItems[iter_15_0] = var_15_5

		arg_15_0._episodeItems[iter_15_0]:setParam(var_15_1[iter_15_0], iter_15_0, arg_15_0.actId)
	end

	if not arg_15_0._focusId then
		arg_15_0:_focusStoryItem(arg_15_0._curEpisodeIndex)
	else
		local var_15_6 = YeShuMeiModel.instance:getEpisodeIndex(arg_15_0._focusId)

		arg_15_0:_focusStoryItem(var_15_6)

		arg_15_0._focusId = nil
	end
end

function var_0_0._focusStoryItem(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = recthelper.getAnchorX(arg_16_0._episodeItems[arg_16_1].transform.parent)
	local var_16_1 = arg_16_0._offsetX - var_16_0

	if var_16_1 > 0 then
		var_16_1 = 0
	elseif var_16_1 < arg_16_0.minContentAnchorX then
		var_16_1 = arg_16_0.minContentAnchorX
	end

	if arg_16_2 then
		ZProj.TweenHelper.DOAnchorPosX(arg_16_0._gostoryScroll.transform, var_16_1, var_0_1)
	else
		recthelper.setAnchorX(arg_16_0._gostoryScroll.transform, var_16_1)
	end
end

function var_0_0.onStoryItemClick(arg_17_0, arg_17_1)
	arg_17_0:_focusStoryItem(arg_17_1, true)
end

function var_0_0._onBackToLevel(arg_18_0)
	local var_18_0 = YeShuMeiModel.instance:getNewFinishEpisode()

	if var_18_0 and var_18_0 ~= 0 then
		local var_18_1 = YeShuMeiModel.instance:getMaxUnlockEpisodeId()

		arg_18_0._curEpisodeIndex = YeShuMeiModel.instance:getEpisodeIndex(var_18_1)

		YeShuMeiModel.instance:setCurEpisode(arg_18_0._curEpisodeIndex, var_18_1)
	end

	arg_18_0:_refreshTask()
end

function var_0_0._onEpisodeFinished(arg_19_0)
	if YeShuMeiModel.instance:getNewFinishEpisode() then
		TaskDispatcher.runDelay(arg_19_0._playStoryFinishAnim, arg_19_0, 1)
	end
end

function var_0_0._playStoryFinishAnim(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._playStoryFinishAnim, arg_20_0)

	local var_20_0 = YeShuMeiModel.instance:getNewFinishEpisode()

	if var_20_0 then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._episodeItems) do
			if iter_20_1.id == var_20_0 then
				arg_20_0._finishEpisodeIndex = iter_20_0

				iter_20_1:playFinish()
				iter_20_1:playStarAnim()
				TaskDispatcher.runDelay(arg_20_0._finishStoryEnd, arg_20_0, 1.5)

				break
			end
		end

		YeShuMeiModel.instance:clearFinishEpisode()
	end
end

function var_0_0._finishStoryEnd(arg_21_0)
	if arg_21_0._finishEpisodeIndex == #arg_21_0._episodeItems then
		arg_21_0._curEpisodeIndex = arg_21_0._finishEpisodeIndex
		arg_21_0._finishEpisodeIndex = nil
	else
		arg_21_0._curEpisodeIndex = arg_21_0._finishEpisodeIndex + 1

		arg_21_0:_unlockStory()
	end
end

function var_0_0._unlockStory(arg_22_0)
	arg_22_0._episodeItems[arg_22_0._finishEpisodeIndex + 1]:refreshUI()
	arg_22_0._episodeItems[arg_22_0._finishEpisodeIndex + 1]:playUnlock()

	local var_22_0 = arg_22_0._linesList[arg_22_0._finishEpisodeIndex]

	if var_22_0 then
		gohelper.setActive(var_22_0.go, true)
		var_22_0.animator:Play("open", 0, 0)
	end

	arg_22_0:_focusStoryItem(arg_22_0._finishEpisodeIndex + 1, true)
	TaskDispatcher.runDelay(arg_22_0._unlockLvEnd, arg_22_0, 1.5)
end

function var_0_0._unlockLvEnd(arg_23_0)
	arg_23_0._finishEpisodeIndex = nil
end

function var_0_0._onScreenSizeChange(arg_24_0)
	local var_24_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_24_0._halfbg = recthelper.getWidth(arg_24_0._trsBg) / 2
	arg_24_0._offsetX = var_24_0 / 2
	arg_24_0._canMoveBgWidth = arg_24_0._halfbg - arg_24_0._offsetX
	arg_24_0.minContentAnchorX = -4000 + var_24_0

	local var_24_1 = arg_24_0._scrollstory.horizontalNormalizedPosition

	if var_24_1 > 1 then
		var_24_1 = 1
	end

	local var_24_2 = arg_24_0._canMoveBgWidth * var_24_1

	recthelper.setAnchorX(arg_24_0._trsBg, -var_24_2)
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._refreshLeftTime, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._playStoryFinishAnim, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._finishStoryEnd, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._unlockLvEnd, arg_25_0)
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0:_removeEvents()

	arg_26_0._episodeItems = nil

	TaskDispatcher.cancelTask(arg_26_0._refreshLeftTime, arg_26_0)
end

function var_0_0._onCloseView(arg_27_0, arg_27_1)
	if arg_27_1 == ViewName.YeShuMeiGameView then
		gohelper.setActive(arg_27_0.viewGO, true)
	elseif arg_27_1 == ViewName.YeShuMeiTaskView then
		arg_27_0:_onCloseTask()
	end
end

return var_0_0
