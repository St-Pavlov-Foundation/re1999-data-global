module("modules.logic.activity.view.chessmap.Activity109ChessEntry", package.seeall)

local var_0_0 = class("Activity109ChessEntry", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg2")
	arg_1_0._btntask = gohelper.findChildButton(arg_1_0.viewGO, "#btn_task")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "#btn_task/#go_reddot")
	arg_1_0._btnswitch = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "switchmap/#btn_switch", AudioEnum.UI.play_ui_activity_dog_page)
	arg_1_0._goepisodeitem = gohelper.findChild(arg_1_0.viewGO, "info/#scroll_list/Viewport/maplist/#go_episodeitem")
	arg_1_0._txtremaintime = gohelper.findChildTextMesh(arg_1_0.viewGO, "remaintimebg/#txt_remaintime")
	arg_1_0._golock = gohelper.findChild(arg_1_0.viewGO, "switchmap/#go_lock")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "switchmap/#go_unlock")
	arg_1_0._scrolllist = gohelper.findChildScrollRect(arg_1_0.viewGO, "info/#scroll_list")
	arg_1_0._gobottommask = gohelper.findChild(arg_1_0.viewGO, "info/#go_bottommask")
	arg_1_0._gotopmask = gohelper.findChild(arg_1_0.viewGO, "info/#go_topmask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntask:AddClickListener(arg_2_0._btntaskOnClick, arg_2_0)
	arg_2_0._btnswitch:AddClickListener(arg_2_0._btnswitchOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity109ChessController.instance, ActivityEvent.Refresh109ActivityData, arg_2_0._onRefresh109ActivityData, arg_2_0)
	arg_2_0:addEventCb(Activity109ChessController.instance, ActivityEvent.Play109EntryViewOpenAni, arg_2_0._onPlay109EntryViewOpenAni, arg_2_0)
	arg_2_0:addEventCb(Activity109ChessController.instance, ActivityChessEvent.TaskJump, arg_2_0._handleTaskJump, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0._onRefreshActivityState, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.dailyRefresh, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	arg_2_0._scrolllist:AddOnValueChanged(arg_2_0._onScrollValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntask:RemoveClickListener()
	arg_3_0._btnswitch:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.dailyRefresh, arg_3_0)
	arg_3_0._scrolllist:RemoveOnValueChanged()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._ani = gohelper.onceAddComponent(arg_4_0.viewGO, typeof(UnityEngine.Animator))
	arg_4_0._scrolllist_rect = gohelper.findChildScrollRect(arg_4_0.viewGO, "info/#scroll_list")
	arg_4_0._scrolllist_ani = gohelper.findChildComponent(arg_4_0.viewGO, "info/#scroll_list", typeof(UnityEngine.Animator))

	arg_4_0._simagebg2:LoadImage(ResUrl.getVersionactivitychessIcon("full/img_shangceng"))

	arg_4_0._image_bg1 = gohelper.findChildSingleImage(arg_4_0.viewGO, "image_bg1")
	arg_4_0._image_bg2 = gohelper.findChildSingleImage(arg_4_0.viewGO, "image_bg2")

	arg_4_0._image_bg1:LoadImage(ResUrl.getVersionactivitychessIcon("bg_01"))
	arg_4_0._image_bg2:LoadImage(ResUrl.getVersionactivitychessIcon("bg_02"))

	arg_4_0._episodeGoList = arg_4_0:getUserDataTb_()
	arg_4_0._goswitchicon1 = gohelper.findChild(arg_4_0.viewGO, "switchmap/page1/switchicon1")
	arg_4_0._goswitchicon = gohelper.findChild(arg_4_0.viewGO, "switchmap/page1/switchicon")
end

function var_0_0._onRefreshActivityState(arg_5_0, arg_5_1)
	if string.nilorempty(arg_5_1) or arg_5_1 == 0 then
		return
	end

	if arg_5_1 ~= Activity109Model.instance:getCurActivityID() then
		return
	end

	if ActivityHelper.getActivityStatus(arg_5_1) ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, var_0_0.yesCallback)
	end
end

function var_0_0.yesCallback()
	ViewMgr.instance:closeView(ViewName.Activity109ChessEntry)
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg1:UnLoadImage()
	arg_7_0._simagebg2:UnLoadImage()
	arg_7_0._image_bg1:UnLoadImage()
	arg_7_0._image_bg2:UnLoadImage()

	for iter_7_0, iter_7_1 in pairs(arg_7_0._episodeGoList) do
		gohelper.findChildButton(iter_7_1, "btn_click"):RemoveClickListener()
		gohelper.findChildButton(iter_7_1, "btn_story"):RemoveClickListener()
	end
end

function var_0_0._btnswitchOnClick(arg_8_0)
	local var_8_0 = arg_8_0._cur_select_stage

	arg_8_0._cur_select_stage = arg_8_0._cur_select_stage + 1
	arg_8_0._cur_select_stage = arg_8_0._cur_select_stage > 2 and 1 or arg_8_0._cur_select_stage

	local var_8_1, var_8_2 = arg_8_0:_stageIsOpen(arg_8_0._cur_select_stage)

	if not var_8_1 then
		arg_8_0._cur_select_stage = var_8_0

		arg_8_0:_showNoOpenToast(var_8_2)

		return
	end

	arg_8_0:_refreshEpisodeData()
	arg_8_0:_playAni(arg_8_0._cur_select_stage == 1 and "switch_youlun" or "switch_wudu")
	arg_8_0._scrolllist_ani:Play(UIAnimationName.Click, 0, 0)

	arg_8_0._scrolllist.verticalNormalizedPosition = 1
end

function var_0_0._showNoOpenToast(arg_9_0, arg_9_1)
	arg_9_1 = math.floor(arg_9_1)

	local var_9_0 = math.floor(arg_9_1 / 86400)
	local var_9_1 = math.floor(arg_9_1 % 86400 / 3600)

	if var_9_0 > 0 then
		GameFacade.showToast(ToastEnum.Chess2, var_9_0)
	elseif var_9_1 > 0 then
		GameFacade.showToast(ToastEnum.Chess3, var_9_1)
	else
		GameFacade.showToast(ToastEnum.Chess4)
	end
end

function var_0_0._playAni(arg_10_0, arg_10_1)
	arg_10_0._ani.enabled = true

	arg_10_0._ani:Play(arg_10_1, 0, 0)
end

function var_0_0._onPlay109EntryViewOpenAni(arg_11_0)
	local var_11_0 = arg_11_0._cur_select_stage == 1 and "back2" or "back1"

	arg_11_0:_playAni(var_11_0, 0, 0)
	arg_11_0:_dimBgm(false)
end

function var_0_0._onRefresh109ActivityData(arg_12_0)
	arg_12_0:_refreshEpisodeData()
end

function var_0_0.dailyRefresh(arg_13_0)
	Activity109Rpc.instance:sendGetAct109InfoRequest(Activity109Model.instance:getCurActivityID())
end

function var_0_0._dimBgm(arg_14_0, arg_14_1)
	if arg_14_1 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_open)
	else
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_close)
	end
end

function var_0_0.onOpen(arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dog_open)

	arg_15_0._cur_select_episode_id = arg_15_0.viewParam

	local var_15_0 = Activity109Model.instance:getCurActivityID()

	arg_15_0._activity_data = ActivityModel.instance:getActivityInfo()[var_15_0]
	arg_15_0._cur_select_stage = 1
	arg_15_0._episode_list = {}

	for iter_15_0, iter_15_1 in ipairs(Activity109Config.instance:getEpisodeList(var_15_0)) do
		if not arg_15_0._episode_list[iter_15_1.chapterId] then
			arg_15_0._episode_list[iter_15_1.chapterId] = {}
		end

		table.insert(arg_15_0._episode_list[iter_15_1.chapterId], iter_15_1)
	end

	if arg_15_0._cur_select_episode_id then
		for iter_15_2 = 1, #arg_15_0._episode_list do
			for iter_15_3, iter_15_4 in ipairs(arg_15_0._episode_list[iter_15_2]) do
				if iter_15_4.id == arg_15_0._cur_select_episode_id then
					arg_15_0._cur_select_stage = iter_15_2

					break
				end
			end
		end
	elseif not Activity109Model.instance:isAllClear() and GuideModel.instance:isGuideFinish(ActivityChessEnum.GuideIDForSwitchButton) then
		arg_15_0._cur_select_stage = arg_15_0:_getMaxOpenChapter()
	end

	arg_15_0:_refreshEpisodeData()
	arg_15_0:_showLeftTime()
	TaskDispatcher.runRepeat(arg_15_0._showLeftTime, arg_15_0, 60)
	RedDotController.instance:addRedDot(arg_15_0._goreddot, RedDotEnum.DotNode.VersionActivityPiKeLeSiTask)
end

function var_0_0._onFinishTask(arg_16_0)
	return
end

function var_0_0._refreshTaskRed(arg_17_0)
	gohelper.setActive(arg_17_0._goreddot, var_0_0.getTaskRedState())
end

function var_0_0.getTaskRedState()
	local var_18_0 = Activity109Config.instance:getTaskList()
	local var_18_1 = false

	for iter_18_0, iter_18_1 in ipairs(var_18_0) do
		local var_18_2 = Activity109Model.instance:getTaskData(iter_18_1.id)

		if var_18_2 and var_18_2.finishCount == 0 and var_18_2.hasFinished then
			var_18_1 = true

			break
		end
	end

	return var_18_1
end

function var_0_0._getMaxOpenChapter(arg_19_0)
	local var_19_0 = 1
	local var_19_1 = Activity109Model.instance:getChapterList()

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		if not arg_19_0:_stageIsOpen(iter_19_1) then
			break
		end

		var_19_0 = iter_19_1

		if not Activity109Model.instance:isChapterClear(iter_19_1) then
			break
		end
	end

	return var_19_0
end

function var_0_0._showLeftTime(arg_20_0)
	arg_20_0._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), arg_20_0._activity_data:getRemainTimeStr())
end

function var_0_0._refreshSwitchBtnData(arg_21_0)
	local var_21_0 = arg_21_0._cur_select_stage == 1 and "bg_01" or "bg_02"

	arg_21_0._simagebg1:LoadImage(ResUrl.getVersionactivitychessIcon(var_21_0))
	gohelper.setActive(gohelper.findChild(arg_21_0.viewGO, "switchmap/page1"), arg_21_0._cur_select_stage == 1)
	gohelper.setActive(gohelper.findChild(arg_21_0.viewGO, "switchmap/page2"), arg_21_0._cur_select_stage == 2)

	local var_21_1 = arg_21_0:_stageIsOpen(2)

	gohelper.setActive(arg_21_0._golock, not var_21_1)
	gohelper.setActive(arg_21_0._gounlock, var_21_1)
	gohelper.setActive(arg_21_0._goswitchicon, var_21_1)
	gohelper.setActive(arg_21_0._goswitchicon1, var_21_1)
end

function var_0_0._refreshEpisodeData(arg_22_0)
	arg_22_0:_refreshSwitchBtnData()

	local var_22_0 = arg_22_0:_getCurEpisodeList()

	for iter_22_0 = 1, #var_22_0 do
		local var_22_1 = var_22_0[iter_22_0]
		local var_22_2 = arg_22_0._episodeGoList[iter_22_0]

		if not var_22_2 then
			var_22_2 = gohelper.cloneInPlace(arg_22_0._goepisodeitem, "episodeitem" .. iter_22_0)

			table.insert(arg_22_0._episodeGoList, iter_22_0, var_22_2)
		end

		gohelper.setActive(var_22_2, true)

		local var_22_3 = gohelper.findChildImage(var_22_2, "bg")
		local var_22_4 = gohelper.findChildTextMesh(var_22_2, "txt_mapname")
		local var_22_5 = gohelper.findChild(var_22_2, "stars")
		local var_22_6 = gohelper.onceAddComponent(var_22_5, typeof(UnityEngine.CanvasGroup))
		local var_22_7 = Activity109Model.instance:getEpisodeData(var_22_1.id)
		local var_22_8 = gohelper.findChildButtonWithAudio(var_22_2, "btn_click")
		local var_22_9 = var_22_7 and var_22_7.star > 0
		local var_22_10 = var_22_1.storyBefore == 0
		local var_22_11 = gohelper.findChild(var_22_2, "go_lock")
		local var_22_12 = gohelper.findChildButtonWithAudio(var_22_2, "btn_story")

		gohelper.setActive(var_22_11, not var_22_7)
		gohelper.setActive(var_22_12.gameObject, var_22_9 and not var_22_10)
		var_22_12:AddClickListener(arg_22_0._onStoryBtnClick, arg_22_0, var_22_1.storyBefore)
		var_22_8:AddClickListener(arg_22_0._onEpisodeBtnClick, arg_22_0, iter_22_0)

		if var_22_1.storyBefore ~= 0 then
			UISpriteSetMgr.instance:setActivityChessMapSprite(var_22_3, "img_yeqian1")
		else
			UISpriteSetMgr.instance:setActivityChessMapSprite(var_22_3, var_22_7 and "img_yeqian2" or "img_yeqian2suo")
		end

		var_22_6.alpha = var_22_9 and 1 or 0.4
		var_22_4.text = string.format("<%s>%s</color>", var_22_10 and "#633118" or "#2E2924", var_22_1.name)

		ZProj.UGUIHelper.SetColorAlpha(var_22_4, var_22_7 and 1 or 0.55)

		for iter_22_1 = 1, 2 do
			gohelper.setActive(gohelper.findChild(var_22_2, "stars/go_star" .. iter_22_1 .. "/full"), var_22_7 and iter_22_1 <= var_22_7.star)
		end

		local var_22_13 = gohelper.findChildImage(var_22_2, "index")
		local var_22_14 = var_22_7 and var_22_1.orderId or var_22_1.orderId .. "_lock"

		UISpriteSetMgr.instance:setActivityChessMapSprite(var_22_13, var_22_14, true)

		local var_22_15 = gohelper.findChildImage(var_22_2, "spdecorate")

		gohelper.setActive(var_22_15, false)

		if var_22_10 then
			gohelper.setActive(var_22_15, true)
			UISpriteSetMgr.instance:setActivityChessMapSprite(var_22_15, var_22_7 and "bg_bodian1" or "bg_bodian2", true)
		end
	end

	arg_22_0:_initScrollMask()
end

function var_0_0._getCurEpisodeList(arg_23_0)
	arg_23_0._cur_list = arg_23_0._episode_list[arg_23_0._cur_select_stage]

	return arg_23_0._cur_list
end

function var_0_0._stageIsOpen(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0._episode_list[arg_24_1][1]
	local var_24_1 = arg_24_0._activity_data:getRealStartTimeStamp() + (var_24_0.openDay - 1) * 24 * 60 * 60

	if not Activity109Model.instance:getEpisodeData(var_24_0.id) and var_24_1 > ServerTime.now() then
		return false, var_24_1 - ServerTime.now()
	end

	return true
end

function var_0_0._focusOnEpisode(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = 1
	local var_25_1 = arg_25_0._episode_list[arg_25_1]

	if not var_25_1 then
		return
	end

	local var_25_2 = #var_25_1

	if var_25_2 == 0 then
		return
	end

	for iter_25_0 = 1, var_25_2 do
		if var_25_1[iter_25_0].id == arg_25_2 then
			var_25_0 = iter_25_0

			break
		end
	end

	local var_25_3 = 1 - (var_25_0 - 1) / (var_25_2 - 1)

	arg_25_0._scrolllist_rect.verticalNormalizedPosition = var_25_3
end

var_0_0.UI_CLICK_BLOCK_KEY = "Activity109ChessEntryClick"

function var_0_0._onEpisodeBtnClick(arg_26_0, arg_26_1)
	if Activity109ChessController.instance:checkCanStartEpisode(arg_26_0._cur_list[arg_26_1].id) then
		arg_26_0:_playAni(UIAnimationName.Click)

		arg_26_0._delayEpisodeId = arg_26_0._cur_list[arg_26_1].id

		UIBlockMgr.instance:startBlock(var_0_0.UI_CLICK_BLOCK_KEY)
		TaskDispatcher.runDelay(arg_26_0._delayAfterEnterAnim, arg_26_0, 0.2)
	end
end

function var_0_0._onStoryBtnClick(arg_27_0, arg_27_1)
	if arg_27_1 then
		StoryController.instance:playStories({
			arg_27_1
		}, nil, nil)
	end
end

function var_0_0._handleTaskJump(arg_28_0, arg_28_1)
	if arg_28_1.listenerType ~= ActivityChessEnum.TaskTypeClearEpisode then
		return
	end

	local var_28_0 = tonumber(arg_28_1.listenerParam)
	local var_28_1 = Activity109Config.instance:getEpisodeCo(Activity109Model.instance:getCurActivityID(), var_28_0)

	if not var_28_1 then
		return
	end

	local var_28_2 = var_28_1.chapterId
	local var_28_3, var_28_4 = arg_28_0:_stageIsOpen(var_28_2)

	if not var_28_3 then
		arg_28_0:_showNoOpenToast(var_28_4)

		return
	end

	if arg_28_0._cur_select_stage ~= var_28_2 then
		arg_28_0:_btnswitchOnClick()
	end

	arg_28_0:_focusOnEpisode(var_28_2, var_28_0)
end

function var_0_0._delayAfterEnterAnim(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._delayAfterEnterAnim, arg_29_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)

	if arg_29_0._delayEpisodeId then
		Activity109ChessController.instance:startNewEpisode(arg_29_0._delayEpisodeId)

		arg_29_0._delayEpisodeId = nil
	end

	arg_29_0:_dimBgm(true)
end

function var_0_0.onClose(arg_30_0)
	UIBlockMgr.instance:endBlock(var_0_0.UI_CLICK_BLOCK_KEY)
	TaskDispatcher.cancelTask(arg_30_0._showLeftTime, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._delayAfterEnterAnim, arg_30_0)
	arg_30_0:_dimBgm(false)
end

function var_0_0._btntaskOnClick(arg_31_0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity109
	}, arg_31_0._taskCallback, arg_31_0)
end

function var_0_0._taskCallback(arg_32_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_open)
	ViewMgr.instance:openView(ViewName.Activity109ChessTask)
end

function var_0_0._onScrollValueChanged(arg_33_0, arg_33_1)
	local var_33_0 = gohelper.getRemindFourNumberFloat(arg_33_0._scrolllist.verticalNormalizedPosition)

	gohelper.setActive(arg_33_0._gobottommask, arg_33_0.couldScroll and var_33_0 > 0)
	gohelper.setActive(arg_33_0._gotopmask, arg_33_0.couldScroll and var_33_0 < 1)
end

function var_0_0._initScrollMask(arg_34_0)
	local var_34_0 = gohelper.findChild(arg_34_0._scrolllist.gameObject, "Viewport/maplist")

	ZProj.UGUIHelper.RebuildLayout(var_34_0.transform)

	arg_34_0.couldScroll = recthelper.getHeight(var_34_0.transform) > recthelper.getHeight(arg_34_0._scrolllist.transform) and true or false

	local var_34_1 = gohelper.getRemindFourNumberFloat(arg_34_0._scrolllist.verticalNormalizedPosition)

	gohelper.setActive(arg_34_0._gobottommask, arg_34_0.couldScroll and var_34_1 > 0)
	gohelper.setActive(arg_34_0._gotopmask, arg_34_0.couldScroll and var_34_1 < 1)
end

return var_0_0
