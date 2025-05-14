module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiLevelView", package.seeall)

local var_0_0 = class("WuErLiXiLevelView", BaseView)
local var_0_1 = 464
local var_0_2 = 0
local var_0_3 = 4
local var_0_4 = 0.3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._animEvent = arg_1_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_Title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._taskAnim = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	arg_1_0._goTaskReddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._animTask = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/ani"):GetComponent(gohelper.Type_Animator)
	arg_1_0._goepisodescroll = gohelper.findChild(arg_1_0.viewGO, "#scroll_StateList")
	arg_1_0._goepisodecontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_StateList/Viewport/Content")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTask:RemoveClickListener()
end

function var_0_0._btnTaskOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.WuErLiXiTaskView)
end

function var_0_0._onEpisodeFinished(arg_5_0)
	if WuErLiXiModel.instance:getNewFinishEpisode() then
		arg_5_0:_playStoryFinishAnim()
	end
end

function var_0_0._playStoryFinishAnim(arg_6_0)
	local var_6_0 = WuErLiXiModel.instance:getNewFinishEpisode()

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._episodeItems) do
			if iter_6_1.id == var_6_0 then
				arg_6_0._finishEpisodeIndex = iter_6_0

				iter_6_1:playFinish()
				iter_6_1:playStarAnim()
				TaskDispatcher.runDelay(arg_6_0._finishStoryEnd, arg_6_0, 1.5)

				break
			end
		end

		WuErLiXiModel.instance:clearFinishEpisode()
	end
end

function var_0_0._onBackToLevel(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_signal)
	arg_7_0._anim:Play("back", 0, 0)
	arg_7_0:_refreshTask()
end

function var_0_0._refreshTask(arg_8_0)
	if RedDotModel.instance:isDotShow(RedDotEnum.DotNode.V2a4WuErLiXiTask, 0) then
		arg_8_0._taskAnim:Play("loop", 0, 0)
	else
		arg_8_0._taskAnim:Play("idle", 0, 0)
	end
end

function var_0_0._onCloseTask(arg_9_0)
	arg_9_0:_refreshTask()
end

function var_0_0._addEvents(arg_10_0)
	arg_10_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.EpisodeFinished, arg_10_0._onEpisodeFinished, arg_10_0)
	arg_10_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.OnBackToLevel, arg_10_0._onBackToLevel, arg_10_0)
	arg_10_0:addEventCb(WuErLiXiController.instance, WuErLiXiEvent.OnCloseTask, arg_10_0._onCloseTask, arg_10_0)
end

function var_0_0._removeEvents(arg_11_0)
	arg_11_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.EpisodeFinished, arg_11_0._onEpisodeFinished, arg_11_0)
	arg_11_0:removeEventCb(WuErLiXiController.instance, WuErLiXiEvent.OnCloseTask, arg_11_0._onCloseTask, arg_11_0)
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.actId = VersionActivity2_4Enum.ActivityId.WuErLiXi
	arg_12_0.actConfig = ActivityConfig.instance:getActivityCo(arg_12_0.actId)

	arg_12_0:_initLevelItems()
	arg_12_0:_addEvents()
end

function var_0_0.onOpen(arg_13_0)
	RedDotController.instance:addRedDot(arg_13_0._goTaskReddot, RedDotEnum.DotNode.V2a4WuErLiXiTask)
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_jinru)
	arg_13_0:_refreshLeftTime()
	arg_13_0:_refreshTask()
	TaskDispatcher.runRepeat(arg_13_0._refreshLeftTime, arg_13_0, 1)
end

function var_0_0._refreshLeftTime(arg_14_0)
	arg_14_0._txtlimittime.text = ActivityHelper.getActivityRemainTimeStr(arg_14_0.actId)
end

function var_0_0._initLevelItems(arg_15_0)
	local var_15_0 = arg_15_0.viewContainer:getSetting().otherRes[1]

	arg_15_0._episodeItems = {}

	local var_15_1 = WuErLiXiConfig.instance:getEpisodeCoList(arg_15_0.actId)

	for iter_15_0 = 1, #var_15_1 do
		local var_15_2 = arg_15_0:getResInst(var_15_0, arg_15_0._goepisodecontent)
		local var_15_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_15_2, WuErLiXiLevelItem, arg_15_0)

		arg_15_0._episodeItems[iter_15_0] = var_15_3

		arg_15_0._episodeItems[iter_15_0]:setParam(var_15_1[iter_15_0], iter_15_0, arg_15_0.actId)

		if arg_15_0._episodeItems[iter_15_0]:isUnlock() then
			arg_15_0._curEpisodeIndex = iter_15_0
		end
	end

	local var_15_4 = WuErLiXiModel.instance:getCurEpisodeIndex()

	arg_15_0._curEpisodeIndex = var_15_4 > 0 and var_15_4 or arg_15_0._curEpisodeIndex

	arg_15_0:_focusLvItem(arg_15_0._curEpisodeIndex)
end

function var_0_0._finishStoryEnd(arg_16_0)
	if arg_16_0._finishEpisodeIndex == #arg_16_0._episodeItems then
		arg_16_0._curEpisodeIndex = arg_16_0._finishEpisodeIndex
		arg_16_0._finishEpisodeIndex = nil
	else
		arg_16_0._curEpisodeIndex = arg_16_0._finishEpisodeIndex + 1

		arg_16_0:_unlockStory()
	end
end

function var_0_0._unlockStory(arg_17_0)
	arg_17_0._episodeItems[arg_17_0._finishEpisodeIndex + 1]:playUnlock()
	TaskDispatcher.runDelay(arg_17_0._unlockLvEnd, arg_17_0, 1.5)
end

function var_0_0._unlockLvEnd(arg_18_0)
	arg_18_0._episodeItems[arg_18_0._finishEpisodeIndex + 1]:refreshUI()

	arg_18_0._finishEpisodeIndex = nil
end

function var_0_0._focusLvItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = WuErLiXiConfig.instance:getEpisodeCoList(VersionActivity2_4Enum.ActivityId.WuErLiXi)
	local var_19_1 = arg_19_1 < var_0_3 and var_0_2 or var_0_2 + (arg_19_1 - var_0_3) * (var_0_1 - var_0_2) / (#var_19_0 - var_0_3)

	if arg_19_2 then
		ZProj.TweenHelper.DOLocalMoveY(arg_19_0._goepisodecontent.transform, var_19_1, var_0_4, arg_19_0._onFocusEnd, arg_19_0, arg_19_1)
	else
		ZProj.TweenHelper.DOLocalMoveY(arg_19_0._goepisodecontent.transform, var_19_1, var_0_4)
	end

	WuErLiXiModel.instance:setCurEpisodeIndex(arg_19_1)
end

function var_0_0._onFocusEnd(arg_20_0, arg_20_1)
	return
end

function var_0_0.onClose(arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._refreshLeftTime, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._unlockLvEnd, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._finishStoryEnd, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._unlockStory, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0._playStoryFinishAnim, arg_21_0)
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0:_removeEvents()

	arg_22_0._episodeItems = nil
end

return var_0_0
