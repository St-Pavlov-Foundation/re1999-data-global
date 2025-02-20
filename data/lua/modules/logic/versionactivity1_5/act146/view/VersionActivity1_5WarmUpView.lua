module("modules.logic.versionactivity1_5.act146.view.VersionActivity1_5WarmUpView", package.seeall)

slot0 = class("VersionActivity1_5WarmUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simageTitle = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_Title")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "Right/LimitTime/#txt_LimitTime")
	slot0._scrollTaskTabList = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList")
	slot0._goradiotaskitem = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content/#go_radiotaskitem")
	slot0._scrollTaskDesc = gohelper.findChildScrollRect(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc")
	slot0._txtTaskContent = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#scroll_TaskDesc/Viewport/#txt_TaskContent")
	slot0._scrollReward = gohelper.findChildScrollRect(slot0.viewGO, "Right/RawardPanel/#scroll_Reward")
	slot0._goWrongChannel = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#go_WrongChannel")
	slot0._gorewarditem = gohelper.findChild(slot0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content/#go_rewarditem")
	slot0._godragarea = gohelper.findChild(slot0.viewGO, "Middle/#go_dragarea")
	slot0._goTitle = gohelper.findChild(slot0.viewGO, "Right/TaskPanel/#go_Title")
	slot0._txtTaskTitle = gohelper.findChildText(slot0.viewGO, "Right/TaskPanel/#go_Title/#txt_TaskTitle")
	slot0._btngetreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/RawardPanel/#btn_getreward")
	slot0._imagePhoto2 = gohelper.findChildImage(slot0.viewGO, "Middle/#go_mail2/#image_Photo2")
	slot0._goguide1 = gohelper.findChild(slot0.viewGO, "Middle/#go_guide1")
	slot0._goguide2 = gohelper.findChild(slot0.viewGO, "Middle/#go_guide2")
	slot0._gomail1 = gohelper.findChild(slot0.viewGO, "Middle/#go_mail1")
	slot0._imageTipsBG1 = gohelper.findChild(slot0.viewGO, "Middle/#go_mail1/#image_TipsBG1")
	slot0._gomail2 = gohelper.findChild(slot0.viewGO, "Middle/#go_mail2")
	slot0._imageTipsBG2 = gohelper.findChild(slot0.viewGO, "Middle/#go_mail2/#image_TipsBG2")
	slot0._imagePhoto = gohelper.findChildImage(slot0.viewGO, "Middle/#go_mail1/image_Envelop/#image_Photo")
	slot0._imagePhotoMask1 = gohelper.findChildImage(slot0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask1")
	slot0._imagePhotoMask2 = gohelper.findChildImage(slot0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask2")
	slot0._imagePhotoMask3 = gohelper.findChildImage(slot0.viewGO, "Middle/#go_mail2/image_PhotoMask/#image_PhotoMask3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Activity146Controller.instance, Activity146Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity146Controller.instance, Activity146Event.OnEpisodeFinished, slot0._onEpisodeFinished, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0._btngetreward:AddClickListener(slot0._btngetrewardOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(Activity146Controller.instance, Activity146Event.DataUpdate, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity146Controller.instance, Activity146Event.OnEpisodeFinished, slot0._onEpisodeFinished, slot0)
	slot0:removeEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._onDailyRefresh, slot0)
	slot0._btngetreward:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._episodeItemTab = slot0:getUserDataTb_()
	slot0._rewardItemTab = slot0:getUserDataTb_()
	slot0._goRewardContent = gohelper.findChild(slot0.viewGO, "Right/RawardPanel/#scroll_Reward/Viewport/Content")
	slot0._goTaskContent = gohelper.findChild(slot0.viewGO, "Right/TaskTab/#scroll_TaskTabList/Viewport/Content")
	slot0._dragAreaCanvasGroup = gohelper.onceAddComponent(slot0._godragarea, typeof(UnityEngine.CanvasGroup))
	slot0._viewGOCanvasGroup = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
	slot0._middleAnim = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "Middle"), typeof(UnityEngine.Animator))
	slot0._tipsBG1Anim = gohelper.onceAddComponent(slot0._imageTipsBG1, typeof(UnityEngine.Animator))
	slot0._tipsBG2Anim = gohelper.onceAddComponent(slot0._imageTipsBG2, typeof(UnityEngine.Animator))
	slot0._viewGOAnim = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._gomail1, false)
	gohelper.setActive(slot0._gomail2, false)

	slot0._txtWrongChannel = gohelper.findChildText(slot0._goWrongChannel, "txt_WrongChannel")
	slot0._episodeCanGetInfoDict = {}
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0._actId = slot0.viewParam.actId

	Activity146Controller.instance:getAct146InfoFromServer(slot0._actId)
end

function slot0.refreshUI(slot0)
	slot0:_showDeadline()
	slot0:_initEpisodeList()
	slot0:_realRefreshEpisodeUI()
	slot0:_refreshGuide()
	slot0:_initRewards()
	Activity146Controller.instance:markHasEnterEpisode()
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 60)
end

function slot0._onRefreshDeadline(slot0)
	slot1, slot2, slot3 = ActivityModel.instance:getRemainTime(slot0._actId)
	slot0._txtLimitTime.text = string.format(luaLang("verionactivity1_3radioview_remaintime"), slot1, slot2)

	if slot1 <= 0 and slot2 <= 0 and slot3 <= 0 then
		TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	end
end

slot0.DelaySwitchPhotoTime = 0.3

function slot0._fakeRefreshEpisodeUI(slot0, slot1, slot2)
	gohelper.setActive(slot0._goWrongChannel, not slot2)
	gohelper.setActive(slot0._godragarea, not slot2)
	gohelper.setActive(slot0._goTitle, slot2)
	gohelper.setActive(slot0._scrollTaskDesc.gameObject, slot2)

	slot0._dragAreaCanvasGroup.alpha = slot2 and 0 or 1
	slot0._txtTaskContent.text = tostring(Activity146Config.instance:getEpisodeDesc(slot0._actId, slot1))
	slot0._fakeEpisodeId = slot1
	slot0._fakeEpisodeState = slot2

	TaskDispatcher.cancelTask(slot0._delaySwitchPhoto, slot0)
	TaskDispatcher.runDelay(slot0._delaySwitchPhoto, slot0, slot0._isNeedDelaySwitchPhoto and uv0.DelaySwitchPhotoTime or 0)

	slot0._isNeedDelaySwitchPhoto = false
	slot0._txtWrongChannel.text = luaLang(slot1 > 1 and "p_v1a5_warmup_txt_WrongChannel" or "p_v1a5_warmup_txt_tip2")
end

function slot0._delaySwitchPhoto(slot0)
	slot1 = slot0._fakeEpisodeId
	slot2 = slot0._fakeEpisodeState

	UISpriteSetMgr.instance:setV1a5WarmUpSprite(slot0._imagePhoto2, "v1a5_warmup_photo" .. slot1)
	UISpriteSetMgr.instance:setV1a5WarmUpSprite(slot0._imagePhoto, "v1a5_warmup_photo" .. slot1)
	gohelper.setActive(slot0._imagePhotoMask1.gameObject, not slot2)
	gohelper.setActive(slot0._imagePhotoMask2.gameObject, not slot2)
	gohelper.setActive(slot0._imagePhotoMask3.gameObject, not slot2)
	gohelper.setActive(slot0._gomail1, slot1 == 1)
	gohelper.setActive(slot0._gomail2, slot1 ~= 1)

	if not (slot0._middleAnim:GetCurrentAnimatorStateInfo(0):IsName("open") and (slot1 == 1 and slot2)) then
		if slot3 then
			slot0._middleAnim:Play("open", 0, slot1 == 1 and Activity146Model.instance:isEpisodeFinished(slot1) and 1 or 0)
		else
			slot0._middleAnim:Play("idle", 0, 0)
		end
	end

	slot7 = slot2 and "close" or "open"

	slot0._tipsBG1Anim:Play(slot7, 0, 0)
	slot0._tipsBG2Anim:Play(slot7, 0, 0)
end

function slot0._realRefreshEpisodeUI(slot0)
	slot1 = Activity146Model.instance:getCurSelectedEpisode()
	slot2 = Activity146Model.instance:isEpisodeFinished(slot1)

	slot0:_fakeRefreshEpisodeUI(slot1, slot2)

	slot0._txtTaskTitle.text = tostring(Activity146Config.instance:getEpisodeTitle(slot0._actId, slot1))

	gohelper.setActive(slot0._imageTipsBG1, not slot2)
	gohelper.setActive(slot0._imageTipsBG2, not slot2)
end

function slot0._refreshGuide(slot0)
	slot1 = Activity146Model.instance:getCurSelectedEpisode()
	slot2 = Activity146Model.instance:isEpisodeFinished(slot1)
	slot3 = Activity146Model.instance:isEpisodeFirstEnter(slot1)

	gohelper.setActive(slot0._goguide1, slot1 == 1 and not slot2 and slot3)
	gohelper.setActive(slot0._goguide2, slot1 == 2 and not slot2 and slot3)
end

slot1 = 6

function slot0._onEpisodeFinished(slot0)
	slot1 = Activity146Model.instance:getCurSelectedEpisode()

	slot0:_fakeRefreshEpisodeUI(slot1, true)

	slot0._viewGOCanvasGroup.blocksRaycasts = false

	slot0:_overrideViewCloseCheckFunc()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, false)
	slot0:_playEpisodeDesc("", tostring(Activity146Config.instance:getEpisodeDesc(slot0._actId, slot1)), uv0, slot0._onPlayEpisodeDescFinished, slot0)

	if slot1 == 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_opening)
	end
end

function slot0._playEpisodeDesc(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._onPlayEpisodeDescUpdate, slot0)

	slot0._txtTaskContent.text = slot1
	slot0._tweenId = ZProj.TweenHelper.DOText(slot0._txtTaskContent, slot2, slot3 * (1 - (GameUtil.utf8len(slot2) > 0 and GameUtil.utf8len(slot1) / slot6 or 0)), slot4, slot5)

	TaskDispatcher.runRepeat(slot0._onPlayEpisodeDescUpdate, slot0, 0)

	slot0._isPlayingEpisodeDesc = true

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_loop)
end

function slot0._onPlayEpisodeDescUpdate(slot0)
	slot0._scrollTaskDesc.verticalNormalizedPosition = 0
end

function slot0._onPlayEpisodeDescFinished(slot0)
	slot0._viewGOCanvasGroup.blocksRaycasts = true

	gohelper.setActive(slot0._btngetreward.gameObject, true)

	slot0._isPlayingEpisodeDesc = false

	slot0:_revertViewCloseCheckFunc()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, true)
	Activity146Controller.instance:onFinishActEpisode(slot0._actId)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)

	slot0._scrollTaskDesc.verticalNormalizedPosition = 0

	TaskDispatcher.cancelTask(slot0._onPlayEpisodeDescUpdate, slot0)
end

function slot0._initEpisodeList(slot0)
	slot2 = Activity146Model.instance:getCurSelectedEpisode()
	slot3 = {}

	if Activity146Config.instance:getAllEpisodeConfigs(slot0._actId) then
		for slot7, slot8 in ipairs(slot1) do
			gohelper.setActive(slot0:_getOrCreateEpisodeItem(slot8.id).episodeItemGo, slot8 ~= nil)

			if slot8 then
				slot9.txtDateUnSelected.text = string.format("Day.%s", slot7)
				slot9.txtDateSelected.text = string.format("Day.%s", slot7)
				slot10 = Activity146Model.instance:isEpisodeUnLock(slot8.id)
				slot11 = slot8.id == slot2
				slot9.txtDateUnSelected.color = GameUtil.parseColor(slot10 and "#acacac" or "#8C8783")

				gohelper.setActive(slot9.goDateSelected, slot11)
				gohelper.setActive(slot9.txtDateUnSelected.gameObject, not slot11)
				gohelper.setActive(slot9.goLocked, not slot10)
			end

			slot3[slot9] = true
		end
	end

	slot0:_recycleUnUsefulEpisodeItem(slot3)
	ZProj.UGUIHelper.RebuildLayout(slot0._goTaskContent.transform)

	slot0._scrollTaskTabList.horizontalNormalizedPosition = Mathf.Lerp(0, 1, (slot2 - 1) / (#slot1 - 1))
end

function slot0._getOrCreateEpisodeItem(slot0, slot1)
	slot0._episodeItemTab = slot0._episodeItemTab or {}

	if not slot0._episodeItemTab[slot1] then
		slot3 = gohelper.cloneInPlace(slot0._goradiotaskitem, "taskItem" .. slot1)
		slot10 = gohelper.findChildButtonWithAudio(slot3, "btn_click")

		slot10:AddClickListener(slot0._taskItemOnClick, slot0, slot1)

		slot0._episodeItemTab[slot1] = {
			episodeItemGo = slot3,
			goDateSelected = gohelper.findChild(slot3, "image_Selected"),
			txtDateSelected = gohelper.findChildText(slot3, "image_Selected/txt_DateSelected"),
			imagewave = gohelper.findChildImage(slot3, "image_Selected/image_wave"),
			finishEffectGo = gohelper.findChild(slot3, "image_Selected/Wave_effect2"),
			goLocked = gohelper.findChild(slot3, "image_Locked"),
			txtDateUnSelected = gohelper.findChildText(slot3, "txt_DateUnSelected"),
			click = slot10
		}
	end

	return slot2
end

function slot0._taskItemOnClick(slot0, slot1)
	if Activity146Model.instance:getCurSelectedEpisode() ~= slot1 and Activity146Model.instance:isEpisodeUnLock(slot1) then
		slot0._viewGOAnim:Play("switch", 0, 0)

		slot0._isNeedDelaySwitchPhoto = true
	end

	Activity146Controller.instance:setCurSelectedEpisode(slot1)

	slot5 = Activity146Model.instance:isEpisodeFinished(Activity146Model.instance:getCurSelectedEpisode())

	gohelper.setActive(slot0._imageTipsBG1.gameObject, not slot5)
	gohelper.setActive(slot0._imageTipsBG2.gameObject, not slot5)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_day_tap)
end

function slot0._recycleUnUsefulEpisodeItem(slot0, slot1)
	if slot1 then
		for slot5, slot6 in pairs(slot0._episodeItemTab) do
			if not slot1[slot6] then
				gohelper.setActive(slot6.episodeItemGo, false)
			end
		end
	end
end

function slot0._initRewards(slot0)
	slot1 = Activity146Model.instance:getCurSelectedEpisode()
	slot3 = Activity146Model.instance:isEpisodeFinishedButUnReceive(slot1)
	slot4 = Activity146Model.instance:isEpisodeHasReceivedReward(slot1)
	slot5 = {}

	if Activity146Config.instance:getEpisodeRewardConfig(slot0._actId, slot1) then
		for slot9, slot10 in ipairs(slot2) do
			if not slot0._rewardItemTab[slot9] then
				slot11 = {
					go = gohelper.cloneInPlace(slot0._gorewarditem, "rewarditem" .. slot9)
				}
				slot11.icon = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot11.go, "go_icon"))
				slot11.goreceive = gohelper.findChild(slot11.go, "go_receive")
				slot11.gocanget = gohelper.findChild(slot11.go, "go_canget")
				slot11.hasgetAnim = gohelper.findChild(slot11.go, "go_receive/go_hasget"):GetComponent(typeof(UnityEngine.Animator))
				slot0._rewardItemTab[slot9] = slot11
			end

			gohelper.setActive(slot11.go, true)
			gohelper.setActive(slot11.goreceive, slot4)
			gohelper.setActive(slot11.gocanget, slot3)

			slot12 = string.splitToNumber(slot10, "#")

			slot11.icon:setMOValue(slot12[1], slot12[2], slot12[3])
			slot11.icon:setCountFontSize(42)
			slot11.icon:setScale(0.5)

			slot5[slot11] = true
		end
	end

	slot0._episodeCanGetInfoDict[slot1] = slot3

	if slot0._episodeCanGetInfoDict[slot1] == false and slot3 == true then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_read_over)
	end

	slot10 = slot3

	gohelper.setActive(slot0._btngetreward.gameObject, slot10)

	for slot10, slot11 in pairs(slot0._rewardItemTab) do
		if not slot5[slot11] then
			gohelper.setActive(slot11.go, false)
		end
	end
end

function slot0._btngetrewardOnClick(slot0)
	Activity146Controller.instance:tryReceiveEpisodeRewards(slot0._actId)
end

function slot0._onDailyRefresh(slot0)
	if slot0._actId then
		Activity146Controller.instance:getAct146InfoFromServer(slot0._actId)
	end
end

function slot0._overrideViewCloseCheckFunc(slot0)
	if ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView) and slot1.navigationView then
		slot0._originCloseCheckFunc = slot2._closeCheckFunc
		slot0._originCloseCheckObj = slot2._closeCheckObj
		slot0._originHomeCheckFunc = slot2._homeCheckFunc
		slot0._originHomeCheckObj = slot2._homeCheckObj

		slot2:setCloseCheck(slot0._onCloseCheckFunc, slot0)
		slot2:setHomeCheck(slot0._onCloseCheckFunc, slot0)
	end
end

function slot0._revertViewCloseCheckFunc(slot0)
	if ViewMgr.instance:getContainer(ViewName.ActivityBeginnerView) and slot1.navigationView then
		slot2:setCloseCheck(slot0._originCloseCheckFunc, slot0._originCloseCheckObj)
		slot2:setHomeCheck(slot0._originHomeCheckFunc, slot0._originHomeCheckObj)
	end

	slot0._originCloseCheckFunc = nil
	slot0._originCloseCheckObj = nil
	slot0._originHomeCheckFunc = nil
	slot0._originHomeCheckObj = nil
end

function slot0._onCloseCheckFunc(slot0)
	if slot0._isPlayingEpisodeDesc then
		GameFacade.showMessageBox(MessageBoxIdDefine.V1a5_WarmUpPlayingQuitCheck, MsgBoxEnum.BoxType.Yes_No, slot0._messageBoxYesFunc, slot0._messageBoxNoFunc, nil, slot0, slot0)

		if slot0._tweenId then
			ZProj.TweenHelper.KillById(slot0._tweenId)

			slot0._tweenId = nil
		end
	end

	TaskDispatcher.cancelTask(slot0._onPlayEpisodeDescUpdate, slot0)

	return not slot0._isPlayingEpisodeDesc
end

function slot0._messageBoxYesFunc(slot0)
	ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
end

function slot0._messageBoxNoFunc(slot0)
	slot0:_playEpisodeDesc(slot0._txtTaskContent.text, tostring(Activity146Config.instance:getEpisodeDesc(slot0._actId, Activity146Model.instance:getCurSelectedEpisode())), uv0, slot0._onPlayEpisodeDescFinished, slot0)
end

function slot0.onClose(slot0)
	slot0:_revertViewCloseCheckFunc()
	Activity146Controller.instance:onCloseView()
	ActivityController.instance:dispatchEvent(ActivityEvent.SetBannerViewCategoryListInteract, true)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._delaySwitchPhoto, slot0)

	if slot0._episodeItemTab then
		for slot4, slot5 in pairs(slot0._episodeItemTab) do
			slot5.click:RemoveClickListener()
		end
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._onPlayEpisodeDescUpdate, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_wulu_atticletter_write_stop)
end

return slot0
