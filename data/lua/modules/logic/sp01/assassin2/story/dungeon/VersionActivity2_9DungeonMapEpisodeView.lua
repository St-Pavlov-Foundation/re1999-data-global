module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9DungeonMapEpisodeView", package.seeall)

local var_0_0 = class("VersionActivity2_9DungeonMapEpisodeView", VersionActivityFixedDungeonMapEpisodeView)
local var_0_1 = "VersionActivity2_9DungeonMapEpisodeView_FocusEpisode"

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0.mapView = arg_1_0.viewContainer.mapView
	arg_1_0.mapSceneElements = arg_1_0.viewContainer.mapSceneElements
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_content")
end

function var_0_0.addEvents(arg_2_0)
	var_0_0.super.addEvents(arg_2_0)
	arg_2_0._touch:AddClickUpListener(arg_2_0._onClickUpHandler, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDragHandler, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_2_0._onBeginShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_2_0._onEndShowRewardView, arg_2_0)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnNewElementsFocusDone)
end

function var_0_0.removeEvents(arg_3_0)
	var_0_0.super.removeEvents(arg_3_0)
	arg_3_0._touch:RemoveClickUpListener()
	arg_3_0._drag:RemoveDragListener()
end

function var_0_0.refreshModeLockText(arg_4_0)
	gohelper.setActive(arg_4_0._hardModeLockTip, false)
	gohelper.setActive(arg_4_0._gohardmodelock, false)
end

function var_0_0.onLoadLayoutFinish(arg_5_0)
	var_0_0.super.onLoadLayoutFinish(arg_5_0)

	arg_5_0._contentTran = arg_5_0.scrollRect.content
	arg_5_0._originLocalPosX, arg_5_0._originLocalPosY = transformhelper.getPos(arg_5_0._contentTran)
	arg_5_0._originScreenPosX, arg_5_0._originScreenPosY = recthelper.uiPosToScreenPos2(arg_5_0._contentTran)

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnOneWorkLoadDone, VersionActivity2_9DungeonEnum.LoadWorkType.Layout)
	arg_5_0:tryFindNextEpisodeId()
	arg_5_0:tryFocusNextEpisode()
end

function var_0_0._onClickUpHandler(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._isDragging then
		return
	end

	if arg_6_0.mapSceneElements:isMouseDownElement() then
		arg_6_0.mapView:_btncloseviewOnClick()
		arg_6_0.mapSceneElements:onClickDown()
		arg_6_0.mapSceneElements:onClickUp()
	elseif arg_6_0.chapterLayout:tryClickDNA(arg_6_2) then
		-- block empty
	else
		arg_6_0.mapView:_btncloseviewOnClick()
	end
end

function var_0_0._onClickDownHandler(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_0.setLayoutVisible(arg_8_0, arg_8_1)
	var_0_0.super.setLayoutVisible(arg_8_0, arg_8_1)

	if not arg_8_0.chapterLayout then
		return
	end

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnEpisodeListVisible, arg_8_1)
end

function var_0_0._onDragBeginHandler(arg_9_0)
	arg_9_0._isDragging = true
end

function var_0_0._onDragEndHandler(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._isDragging = false

	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnScrollEpisodeList, arg_10_2.delta.x, true)
end

function var_0_0._onDragHandler(arg_11_0, arg_11_1, arg_11_2)
	VersionActivity2_9DungeonController.instance:dispatchEvent(VersionActivity2_9Event.OnScrollEpisodeList, arg_11_2.delta.x, false)
end

function var_0_0._onUpdateDungeonInfo(arg_12_0)
	arg_12_0:tryFindNextEpisodeId()
	arg_12_0:tryFocusNextEpisode()
	var_0_0.super._onUpdateDungeonInfo(arg_12_0)
end

function var_0_0.tryFindNextEpisodeId(arg_13_0)
	local var_13_0 = DungeonModel.instance.lastSendEpisodeId

	arg_13_0._nextFocusEpisodeId = nil

	if arg_13_0.activityDungeonMo.episodeId ~= var_13_0 then
		return
	end

	local var_13_1 = DungeonConfig.instance:getChapterEpisodeCOList(arg_13_0.activityDungeonMo.chapterId)

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		local var_13_2 = iter_13_1 and DungeonModel.instance:getEpisodeInfo(iter_13_1.id) or nil

		if not var_13_2 then
			break
		end

		if var_13_2.isNew and iter_13_1.preEpisode == var_13_0 then
			var_13_2.isNew = false
			arg_13_0._nextFocusEpisodeId = iter_13_1.id

			break
		end
	end
end

function var_0_0.tryFocusNextEpisode(arg_14_0)
	if not arg_14_0._nextFocusEpisodeId or not arg_14_0.chapterLayout then
		return
	end

	arg_14_0:destroyFocusFlow()

	arg_14_0._focusFlow = FlowSequence.New()

	arg_14_0._focusFlow:addWork(WaitEventWork.New("VersionActivity2_9DungeonController;VersionActivity2_9Event;OnNewElementsFocusDone"))
	arg_14_0._focusFlow:addWork(FunctionWork.New(arg_14_0._lockScreen, true))
	arg_14_0._focusFlow:addWork(DelayDoFuncWork.New(arg_14_0._delay2ChangeEpisode, arg_14_0, VersionActivity2_9DungeonEnum.Time_FocuysNewEpisode))
	arg_14_0._focusFlow:addWork(FunctionWork.New(arg_14_0._lockScreen, false))
	arg_14_0._focusFlow:start()
end

function var_0_0._lockScreen(arg_15_0, arg_15_1)
	AssassinHelper.lockScreen(var_0_1, arg_15_1)
end

function var_0_0.destroyFocusFlow(arg_16_0)
	if arg_16_0._focusFlow then
		arg_16_0._focusFlow:destroy()

		arg_16_0._focusFlow = nil
	end
end

function var_0_0._delay2ChangeEpisode(arg_17_0)
	if not arg_17_0.activityDungeonMo or not arg_17_0._nextFocusEpisodeId then
		return
	end

	if arg_17_0.chapterLayout then
		arg_17_0.chapterLayout:setFocusEpisodeId(arg_17_0._nextFocusEpisodeId, true)
		AudioMgr.instance:trigger(AudioEnum2_9.Dungeon.play_ui_unlockNewEpisode)
	end

	arg_17_0._nextFocusEpisodeId = nil
end

function var_0_0._onBeginShowRewardView(arg_18_0)
	arg_18_0:hideUI()
end

function var_0_0._onEndShowRewardView(arg_19_0)
	arg_19_0:showUI()
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0:_lockScreen(false)
	arg_20_0:destroyFocusFlow()
	var_0_0.super.onDestroyView(arg_20_0)
end

return var_0_0
