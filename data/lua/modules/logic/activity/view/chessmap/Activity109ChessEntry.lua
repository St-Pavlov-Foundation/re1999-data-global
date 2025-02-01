module("modules.logic.activity.view.chessmap.Activity109ChessEntry", package.seeall)

slot0 = class("Activity109ChessEntry", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._btntask = gohelper.findChildButton(slot0.viewGO, "#btn_task")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "#btn_task/#go_reddot")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.viewGO, "switchmap/#btn_switch", AudioEnum.UI.play_ui_activity_dog_page)
	slot0._goepisodeitem = gohelper.findChild(slot0.viewGO, "info/#scroll_list/Viewport/maplist/#go_episodeitem")
	slot0._txtremaintime = gohelper.findChildTextMesh(slot0.viewGO, "remaintimebg/#txt_remaintime")
	slot0._golock = gohelper.findChild(slot0.viewGO, "switchmap/#go_lock")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "switchmap/#go_unlock")
	slot0._scrolllist = gohelper.findChildScrollRect(slot0.viewGO, "info/#scroll_list")
	slot0._gobottommask = gohelper.findChild(slot0.viewGO, "info/#go_bottommask")
	slot0._gotopmask = gohelper.findChild(slot0.viewGO, "info/#go_topmask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntask:AddClickListener(slot0._btntaskOnClick, slot0)
	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)
	slot0:addEventCb(Activity109ChessController.instance, ActivityEvent.Refresh109ActivityData, slot0._onRefresh109ActivityData, slot0)
	slot0:addEventCb(Activity109ChessController.instance, ActivityEvent.Play109EntryViewOpenAni, slot0._onPlay109EntryViewOpenAni, slot0)
	slot0:addEventCb(Activity109ChessController.instance, ActivityChessEvent.TaskJump, slot0._handleTaskJump, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._onRefreshActivityState, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0._scrolllist:AddOnValueChanged(slot0._onScrollValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntask:RemoveClickListener()
	slot0._btnswitch:RemoveClickListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0._scrolllist:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0._ani = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
	slot0._scrolllist_rect = gohelper.findChildScrollRect(slot0.viewGO, "info/#scroll_list")
	slot0._scrolllist_ani = gohelper.findChildComponent(slot0.viewGO, "info/#scroll_list", typeof(UnityEngine.Animator))

	slot0._simagebg2:LoadImage(ResUrl.getVersionactivitychessIcon("full/img_shangceng"))

	slot0._image_bg1 = gohelper.findChildSingleImage(slot0.viewGO, "image_bg1")
	slot0._image_bg2 = gohelper.findChildSingleImage(slot0.viewGO, "image_bg2")

	slot0._image_bg1:LoadImage(ResUrl.getVersionactivitychessIcon("bg_01"))
	slot0._image_bg2:LoadImage(ResUrl.getVersionactivitychessIcon("bg_02"))

	slot0._episodeGoList = slot0:getUserDataTb_()
	slot0._goswitchicon1 = gohelper.findChild(slot0.viewGO, "switchmap/page1/switchicon1")
	slot0._goswitchicon = gohelper.findChild(slot0.viewGO, "switchmap/page1/switchicon")
end

function slot0._onRefreshActivityState(slot0, slot1)
	if string.nilorempty(slot1) or slot1 == 0 then
		return
	end

	if slot1 ~= Activity109Model.instance:getCurActivityID() then
		return
	end

	if ActivityHelper.getActivityStatus(slot1) ~= ActivityEnum.ActivityStatus.Normal then
		GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, uv0.yesCallback)
	end
end

function slot0.yesCallback()
	ViewMgr.instance:closeView(ViewName.Activity109ChessEntry)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._image_bg1:UnLoadImage()
	slot0._image_bg2:UnLoadImage()

	for slot4, slot5 in pairs(slot0._episodeGoList) do
		gohelper.findChildButton(slot5, "btn_click"):RemoveClickListener()
		gohelper.findChildButton(slot5, "btn_story"):RemoveClickListener()
	end
end

function slot0._btnswitchOnClick(slot0)
	slot0._cur_select_stage = slot0._cur_select_stage + 1
	slot0._cur_select_stage = slot0._cur_select_stage > 2 and 1 or slot0._cur_select_stage
	slot2, slot3 = slot0:_stageIsOpen(slot0._cur_select_stage)

	if not slot2 then
		slot0._cur_select_stage = slot0._cur_select_stage

		slot0:_showNoOpenToast(slot3)

		return
	end

	slot0:_refreshEpisodeData()
	slot0:_playAni(slot0._cur_select_stage == 1 and "switch_youlun" or "switch_wudu")
	slot0._scrolllist_ani:Play(UIAnimationName.Click, 0, 0)

	slot0._scrolllist.verticalNormalizedPosition = 1
end

function slot0._showNoOpenToast(slot0, slot1)
	slot1 = math.floor(slot1)
	slot3 = math.floor(slot1 % 86400 / 3600)

	if math.floor(slot1 / 86400) > 0 then
		GameFacade.showToast(ToastEnum.Chess2, slot2)
	elseif slot3 > 0 then
		GameFacade.showToast(ToastEnum.Chess3, slot3)
	else
		GameFacade.showToast(ToastEnum.Chess4)
	end
end

function slot0._playAni(slot0, slot1)
	slot0._ani.enabled = true

	slot0._ani:Play(slot1, 0, 0)
end

function slot0._onPlay109EntryViewOpenAni(slot0)
	slot0:_playAni(slot0._cur_select_stage == 1 and "back2" or "back1", 0, 0)
	slot0:_dimBgm(false)
end

function slot0._onRefresh109ActivityData(slot0)
	slot0:_refreshEpisodeData()
end

function slot0.dailyRefresh(slot0)
	Activity109Rpc.instance:sendGetAct109InfoRequest(Activity109Model.instance:getCurActivityID())
end

function slot0._dimBgm(slot0, slot1)
	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_open)
	else
		AudioMgr.instance:trigger(AudioEnum.ChessGame.muisc_obscure_close)
	end
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_activity_dog_open)

	slot0._cur_select_episode_id = slot0.viewParam
	slot1 = Activity109Model.instance:getCurActivityID()
	slot0._activity_data = ActivityModel.instance:getActivityInfo()[slot1]
	slot0._cur_select_stage = 1
	slot0._episode_list = {}
	slot5 = slot1

	for slot5, slot6 in ipairs(Activity109Config.instance:getEpisodeList(slot5)) do
		if not slot0._episode_list[slot6.chapterId] then
			slot0._episode_list[slot6.chapterId] = {}
		end

		table.insert(slot0._episode_list[slot6.chapterId], slot6)
	end

	if slot0._cur_select_episode_id then
		for slot5 = 1, #slot0._episode_list do
			for slot9, slot10 in ipairs(slot0._episode_list[slot5]) do
				if slot10.id == slot0._cur_select_episode_id then
					slot0._cur_select_stage = slot5

					break
				end
			end
		end
	elseif not Activity109Model.instance:isAllClear() and GuideModel.instance:isGuideFinish(ActivityChessEnum.GuideIDForSwitchButton) then
		slot0._cur_select_stage = slot0:_getMaxOpenChapter()
	end

	slot0:_refreshEpisodeData()
	slot0:_showLeftTime()
	TaskDispatcher.runRepeat(slot0._showLeftTime, slot0, 60)
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.VersionActivityPiKeLeSiTask)
end

function slot0._onFinishTask(slot0)
end

function slot0._refreshTaskRed(slot0)
	gohelper.setActive(slot0._goreddot, uv0.getTaskRedState())
end

function slot0.getTaskRedState()
	slot1 = false

	for slot5, slot6 in ipairs(Activity109Config.instance:getTaskList()) do
		if Activity109Model.instance:getTaskData(slot6.id) and slot7.finishCount == 0 and slot7.hasFinished then
			slot1 = true

			break
		end
	end

	return slot1
end

function slot0._getMaxOpenChapter(slot0)
	slot1 = 1

	for slot6, slot7 in ipairs(Activity109Model.instance:getChapterList()) do
		if not slot0:_stageIsOpen(slot7) then
			break
		end

		slot1 = slot7

		if not Activity109Model.instance:isChapterClear(slot7) then
			break
		end
	end

	return slot1
end

function slot0._showLeftTime(slot0)
	slot0._txtremaintime.text = string.format(luaLang("activity_warmup_remain_time"), slot0._activity_data:getRemainTimeStr())
end

function slot0._refreshSwitchBtnData(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getVersionactivitychessIcon(slot0._cur_select_stage == 1 and "bg_01" or "bg_02"))
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "switchmap/page1"), slot0._cur_select_stage == 1)
	gohelper.setActive(gohelper.findChild(slot0.viewGO, "switchmap/page2"), slot0._cur_select_stage == 2)

	slot2 = slot0:_stageIsOpen(2)

	gohelper.setActive(slot0._golock, not slot2)
	gohelper.setActive(slot0._gounlock, slot2)
	gohelper.setActive(slot0._goswitchicon, slot2)
	gohelper.setActive(slot0._goswitchicon1, slot2)
end

function slot0._refreshEpisodeData(slot0)
	slot0:_refreshSwitchBtnData()

	for slot5 = 1, #slot0:_getCurEpisodeList() do
		slot6 = slot1[slot5]

		if not slot0._episodeGoList[slot5] then
			table.insert(slot0._episodeGoList, slot5, gohelper.cloneInPlace(slot0._goepisodeitem, "episodeitem" .. slot5))
		end

		gohelper.setActive(slot7, true)

		slot9 = gohelper.findChildTextMesh(slot7, "txt_mapname")
		slot11 = gohelper.onceAddComponent(gohelper.findChild(slot7, "stars"), typeof(UnityEngine.CanvasGroup))

		gohelper.setActive(gohelper.findChild(slot7, "go_lock"), not slot12)
		gohelper.setActive(gohelper.findChildButtonWithAudio(slot7, "btn_story").gameObject, Activity109Model.instance:getEpisodeData(slot6.id) and slot12.star > 0 and not (slot6.storyBefore == 0))
		slot17:AddClickListener(slot0._onStoryBtnClick, slot0, slot6.storyBefore)
		gohelper.findChildButtonWithAudio(slot7, "btn_click"):AddClickListener(slot0._onEpisodeBtnClick, slot0, slot5)

		if slot6.storyBefore ~= 0 then
			UISpriteSetMgr.instance:setActivityChessMapSprite(gohelper.findChildImage(slot7, "bg"), "img_yeqian1")
		else
			UISpriteSetMgr.instance:setActivityChessMapSprite(slot8, slot12 and "img_yeqian2" or "img_yeqian2suo")
		end

		slot11.alpha = slot14 and 1 or 0.4
		slot9.text = string.format("<%s>%s</color>", slot15 and "#633118" or "#2E2924", slot6.name)

		ZProj.UGUIHelper.SetColorAlpha(slot9, slot12 and 1 or 0.55)

		for slot21 = 1, 2 do
			gohelper.setActive(gohelper.findChild(slot7, "stars/go_star" .. slot21 .. "/full"), slot12 and slot21 <= slot12.star)
		end

		UISpriteSetMgr.instance:setActivityChessMapSprite(gohelper.findChildImage(slot7, "index"), slot12 and slot6.orderId or slot6.orderId .. "_lock", true)
		gohelper.setActive(gohelper.findChildImage(slot7, "spdecorate"), false)

		if slot15 then
			gohelper.setActive(slot20, true)
			UISpriteSetMgr.instance:setActivityChessMapSprite(slot20, slot12 and "bg_bodian1" or "bg_bodian2", true)
		end
	end

	slot0:_initScrollMask()
end

function slot0._getCurEpisodeList(slot0)
	slot0._cur_list = slot0._episode_list[slot0._cur_select_stage]

	return slot0._cur_list
end

function slot0._stageIsOpen(slot0, slot1)
	slot2 = slot0._episode_list[slot1][1]
	slot3 = slot0._activity_data:getRealStartTimeStamp() + (slot2.openDay - 1) * 24 * 60 * 60

	if not Activity109Model.instance:getEpisodeData(slot2.id) and ServerTime.now() < slot3 then
		return false, slot3 - ServerTime.now()
	end

	return true
end

function slot0._focusOnEpisode(slot0, slot1, slot2)
	slot3 = 1

	if not slot0._episode_list[slot1] then
		return
	end

	if #slot4 == 0 then
		return
	end

	for slot9 = 1, slot5 do
		if slot4[slot9].id == slot2 then
			slot3 = slot9

			break
		end
	end

	slot0._scrolllist_rect.verticalNormalizedPosition = 1 - (slot3 - 1) / (slot5 - 1)
end

slot0.UI_CLICK_BLOCK_KEY = "Activity109ChessEntryClick"

function slot0._onEpisodeBtnClick(slot0, slot1)
	if Activity109ChessController.instance:checkCanStartEpisode(slot0._cur_list[slot1].id) then
		slot0:_playAni(UIAnimationName.Click)

		slot0._delayEpisodeId = slot0._cur_list[slot1].id

		UIBlockMgr.instance:startBlock(uv0.UI_CLICK_BLOCK_KEY)
		TaskDispatcher.runDelay(slot0._delayAfterEnterAnim, slot0, 0.2)
	end
end

function slot0._onStoryBtnClick(slot0, slot1)
	if slot1 then
		StoryController.instance:playStories({
			slot1
		}, nil, )
	end
end

function slot0._handleTaskJump(slot0, slot1)
	if slot1.listenerType ~= ActivityChessEnum.TaskTypeClearEpisode then
		return
	end

	if not Activity109Config.instance:getEpisodeCo(Activity109Model.instance:getCurActivityID(), tonumber(slot1.listenerParam)) then
		return
	end

	slot5, slot6 = slot0:_stageIsOpen(slot3.chapterId)

	if not slot5 then
		slot0:_showNoOpenToast(slot6)

		return
	end

	if slot0._cur_select_stage ~= slot4 then
		slot0:_btnswitchOnClick()
	end

	slot0:_focusOnEpisode(slot4, slot2)
end

function slot0._delayAfterEnterAnim(slot0)
	TaskDispatcher.cancelTask(slot0._delayAfterEnterAnim, slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)

	if slot0._delayEpisodeId then
		Activity109ChessController.instance:startNewEpisode(slot0._delayEpisodeId)

		slot0._delayEpisodeId = nil
	end

	slot0:_dimBgm(true)
end

function slot0.onClose(slot0)
	UIBlockMgr.instance:endBlock(uv0.UI_CLICK_BLOCK_KEY)
	TaskDispatcher.cancelTask(slot0._showLeftTime, slot0)
	TaskDispatcher.cancelTask(slot0._delayAfterEnterAnim, slot0)
	slot0:_dimBgm(false)
end

function slot0._btntaskOnClick(slot0)
	TaskRpc.instance:sendGetTaskInfoRequest({
		TaskEnum.TaskType.Activity109
	}, slot0._taskCallback, slot0)
end

function slot0._taskCallback(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mission_open)
	ViewMgr.instance:openView(ViewName.Activity109ChessTask)
end

function slot0._onScrollValueChanged(slot0, slot1)
	slot2 = gohelper.getRemindFourNumberFloat(slot0._scrolllist.verticalNormalizedPosition)

	gohelper.setActive(slot0._gobottommask, slot0.couldScroll and slot2 > 0)
	gohelper.setActive(slot0._gotopmask, slot0.couldScroll and slot2 < 1)
end

function slot0._initScrollMask(slot0)
	slot1 = gohelper.findChild(slot0._scrolllist.gameObject, "Viewport/maplist")

	ZProj.UGUIHelper.RebuildLayout(slot1.transform)

	slot0.couldScroll = recthelper.getHeight(slot0._scrolllist.transform) < recthelper.getHeight(slot1.transform) and true or false
	slot4 = gohelper.getRemindFourNumberFloat(slot0._scrolllist.verticalNormalizedPosition)

	gohelper.setActive(slot0._gobottommask, slot0.couldScroll and slot4 > 0)
	gohelper.setActive(slot0._gotopmask, slot0.couldScroll and slot4 < 1)
end

return slot0
