module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelView", package.seeall)

local var_0_0 = class("CooperGarlandLevelView", BaseView)
local var_0_1 = -300
local var_0_2 = 0.15

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._gostoryPath = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath")
	arg_1_0._gostoryScroll = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll")
	arg_1_0._gostoryStages = gohelper.findChild(arg_1_0.viewGO, "#go_storyPath/#go_storyScroll/#go_storyStages")
	arg_1_0._goTitle = gohelper.findChild(arg_1_0.viewGO, "#go_Title")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Title/#simage_title")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_Title/#go_time")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "#go_Title/#go_time/#txt_limittime")
	arg_1_0._btnTask = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Task")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_Task/#go_reddot")
	arg_1_0._btnExtraEpisode = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_ChallengeBtn")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTask:AddClickListener(arg_2_0._btnTaskOnClick, arg_2_0)
	arg_2_0._btnExtraEpisode:AddClickListener(arg_2_0._btnExtraEpisodeOnClick, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._touch:AddClickDownListener(arg_2_0._onClickDown, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, arg_2_0._onInfoUpdate, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnClickEpisode, arg_2_0._onClickEpisode, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.FirstFinishEpisode, arg_2_0._onFirstFinishEpisode, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnTask:RemoveClickListener()
	arg_3_0._btnExtraEpisode:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._touch:RemoveClickDownListener()
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, arg_3_0._onInfoUpdate, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnClickEpisode, arg_3_0._onClickEpisode, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.FirstFinishEpisode, arg_3_0._onFirstFinishEpisode, arg_3_0)
end

function var_0_0._btnTaskOnClick(arg_4_0)
	CooperGarlandController.instance:openTaskView()
end

function var_0_0._btnExtraEpisodeOnClick(arg_5_0)
	local var_5_0 = CooperGarlandConfig.instance:getExtraEpisode(arg_5_0.actId, true)

	if CooperGarlandModel.instance:isUnlockEpisode(arg_5_0.actId, var_5_0) then
		CooperGarlandController.instance:clickEpisode(arg_5_0.actId, var_5_0)
	end
end

function var_0_0._onDragBegin(arg_6_0)
	arg_6_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEnd(arg_7_0)
	arg_7_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDown(arg_8_0)
	arg_8_0._audioScroll:onClickDown()
end

function var_0_0._onInfoUpdate(arg_9_0)
	arg_9_0:refreshExtraEpisode()
end

function var_0_0._onClickEpisode(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.actId ~= arg_10_1 then
		return
	end

	arg_10_0:onFocusEnd(arg_10_2)
end

function var_0_0._onFirstFinishEpisode(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.actId ~= arg_11_1 then
		return
	end

	arg_11_0:focusNewestLevelItem()

	arg_11_0._waitFinishAnimEpisode = arg_11_2

	arg_11_0:playEpisodeFinishAnim()
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.actId = CooperGarlandModel.instance:getAct192Id()
	arg_12_0._taskAnimator = gohelper.findChild(arg_12_0.viewGO, "#btn_Task/ani"):GetComponentInChildren(typeof(UnityEngine.Animator))
	arg_12_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_12_0._gostoryPath)
	arg_12_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_12_0._gostoryPath)
	arg_12_0._scrollStory = arg_12_0._gostoryPath:GetComponent(gohelper.Type_ScrollRect)
	arg_12_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_12_0._gostoryPath, DungeonMapEpisodeAudio, arg_12_0._scrollStory)
	arg_12_0._transstoryScroll = arg_12_0._gostoryScroll.transform
	arg_12_0._pathAnimator = gohelper.findChildAnim(arg_12_0.viewGO, "#go_storyPath/#go_storyScroll/path/path_2")
	arg_12_0.openAnimComplete = nil
	arg_12_0._waitFinishAnimEpisode = nil
	arg_12_0._finishEpisodeIndex = nil

	local var_12_0 = recthelper.getWidth(ViewMgr.instance:getUIRoot().transform)

	arg_12_0._offsetX = (var_12_0 - var_0_1) / 2
	arg_12_0.minContentAnchorX = -recthelper.getWidth(arg_12_0._transstoryScroll) + var_12_0

	arg_12_0:_initLevelItem()
	RedDotController.instance:addRedDot(arg_12_0._goreddot, RedDotEnum.DotNode.V2a7CooperGarlandTask, nil, arg_12_0._refreshRedDot, arg_12_0)
end

function var_0_0._initLevelItem(arg_13_0)
	if arg_13_0._levelItemList then
		return
	end

	arg_13_0._levelItemList = {}

	local var_13_0 = arg_13_0.viewContainer:getSetting().otherRes[1]
	local var_13_1 = CooperGarlandConfig.instance:getEpisodeIdList(arg_13_0.actId, true)
	local var_13_2 = #var_13_1
	local var_13_3 = arg_13_0._gostoryStages.transform
	local var_13_4 = var_13_3.childCount

	if var_13_4 < var_13_2 then
		logError(string.format("CooperGarlandLevelView:_initLevelItem error, level node not enough, has:%s, need:%s", var_13_4, var_13_2))
	end

	local var_13_5 = 1

	for iter_13_0 = 1, var_13_4 do
		local var_13_6 = var_13_1[iter_13_0]

		if var_13_6 then
			local var_13_7 = var_13_3:GetChild(iter_13_0 - 1)
			local var_13_8 = string.format("levelItem_%s", iter_13_0)
			local var_13_9 = arg_13_0:getResInst(var_13_0, var_13_7.gameObject, var_13_8)
			local var_13_10 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_9, CooperGarlandLevelItem)

			if CooperGarlandConfig.instance:isGameEpisode(arg_13_0.actId, var_13_6) then
				var_13_10:setData(arg_13_0.actId, var_13_6, iter_13_0, var_13_5)

				var_13_5 = var_13_5 + 1
			else
				var_13_10:setData(arg_13_0.actId, var_13_6, iter_13_0)
			end

			table.insert(arg_13_0._levelItemList, var_13_10)
		end
	end
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:refreshUI()
	TaskDispatcher.runRepeat(arg_15_0.refreshTime, arg_15_0, TimeUtil.OneMinuteSecond)
	arg_15_0:focusNewestLevelItem()

	local var_15_0 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._levelItemList) do
		if CooperGarlandModel.instance:isFinishedEpisode(arg_15_0.actId, iter_15_1.episodeId) then
			var_15_0 = iter_15_1.index
		end
	end

	arg_15_0:_playPathAnim(var_15_0, false)
end

function var_0_0.getNewestLevelItem(arg_16_0)
	local var_16_0 = arg_16_0._levelItemList[1]
	local var_16_1 = CooperGarlandModel.instance:getNewestEpisodeId(arg_16_0.actId)

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._levelItemList) do
		if iter_16_1.episodeId == var_16_1 then
			var_16_0 = iter_16_1

			break
		end
	end

	return var_16_0
end

function var_0_0.refreshUI(arg_17_0)
	arg_17_0:refreshTime()
	arg_17_0:refreshExtraEpisode()
end

function var_0_0.refreshTime(arg_18_0)
	local var_18_0, var_18_1 = CooperGarlandModel.instance:getAct192RemainTimeStr(arg_18_0.actId)

	arg_18_0._txtlimittime.text = var_18_0

	if var_18_1 then
		TaskDispatcher.cancelTask(arg_18_0.refreshTime, arg_18_0)
	end
end

function var_0_0.refreshExtraEpisode(arg_19_0)
	local var_19_0 = CooperGarlandConfig.instance:getExtraEpisode(arg_19_0.actId, true)
	local var_19_1 = CooperGarlandModel.instance:isUnlockEpisode(arg_19_0.actId, var_19_0)

	gohelper.setActive(arg_19_0._btnExtraEpisode, var_19_1)
end

function var_0_0._refreshRedDot(arg_20_0, arg_20_1)
	arg_20_1:defaultRefreshDot()

	local var_20_0 = arg_20_1.show

	arg_20_0._taskAnimator:Play(var_20_0 and "loop" or "idle")
end

function var_0_0.focusNewestLevelItem(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getNewestLevelItem()

	if not var_21_0 then
		return
	end

	local var_21_1 = recthelper.getAnchorX(var_21_0._go.transform.parent)
	local var_21_2 = arg_21_0._offsetX - var_21_1

	if var_21_2 > 0 then
		var_21_2 = 0
	elseif var_21_2 < arg_21_0.minContentAnchorX then
		var_21_2 = arg_21_0.minContentAnchorX
	end

	ZProj.TweenHelper.DOAnchorPosX(arg_21_0._transstoryScroll, var_21_2, arg_21_1 or 0, arg_21_0.onFocusEnd, arg_21_0)
end

function var_0_0.onFocusEnd(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return
	end

	CooperGarlandController.instance:afterClickEpisode(arg_22_0.actId, arg_22_1)
end

function var_0_0.playEpisodeFinishAnim(arg_23_0)
	if not arg_23_0.openAnimComplete or not arg_23_0._waitFinishAnimEpisode then
		return
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._levelItemList) do
		if iter_23_1.episodeId == arg_23_0._waitFinishAnimEpisode then
			arg_23_0._finishEpisodeIndex = iter_23_0

			iter_23_1:refreshUI("finish")
			AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_lit)
			arg_23_0:_playPathAnim(arg_23_0._finishEpisodeIndex, true)
			TaskDispatcher.runDelay(arg_23_0._playEpisodeUnlockAnim, arg_23_0, var_0_2)
		end
	end

	arg_23_0.openAnimComplete = nil
	arg_23_0._waitFinishAnimEpisode = nil
end

function var_0_0._playPathAnim(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_1 > 0 then
		arg_24_0._pathAnimator.speed = 1

		local var_24_0 = string.format("go%s", Mathf.Clamp(arg_24_1, 1, #arg_24_0._levelItemList))

		arg_24_0._pathAnimator:Play(var_24_0, 0, arg_24_2 and 0 or 1)
	else
		arg_24_0._pathAnimator.speed = 0

		arg_24_0._pathAnimator:Play("go1", -1, 0)
	end
end

function var_0_0._playEpisodeUnlockAnim(arg_25_0)
	if not arg_25_0._finishEpisodeIndex then
		return
	end

	local var_25_0 = arg_25_0._levelItemList[arg_25_0._finishEpisodeIndex + 1]

	if var_25_0 then
		var_25_0:refreshUI("unlock")
		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_unlock)
	end

	arg_25_0._finishEpisodeIndex = nil
end

function var_0_0.onClose(arg_26_0)
	arg_26_0.openAnimComplete = nil
	arg_26_0._waitFinishAnimEpisode = nil
	arg_26_0._finishEpisodeIndex = nil

	TaskDispatcher.cancelTask(arg_26_0.refreshTime, arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._playEpisodeUnlockAnim, arg_26_0)
end

function var_0_0.onDestroyView(arg_27_0)
	return
end

return var_0_0
