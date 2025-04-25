module("modules.logic.main.view.MainThumbnailBtnView", package.seeall)

slot0 = class("MainThumbnailBtnView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnhandbook = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_handbook")
	slot0._btnsocial = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_social")
	slot0._gosocialreddot = gohelper.findChild(slot0.viewGO, "btns/btn_content/#go_content/#btn_social/#go_socialreddot")
	slot0._btnbell = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_bell")
	slot0._btnplayercard = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_playercard")
	slot0._btnfeedback = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_feedback")
	slot0._gobelllreddot = gohelper.findChild(slot0.viewGO, "btns/btn_content/#go_content/#btn_bell/#go_belllreddot")
	slot0._btncalendar = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_calendar")
	slot0._gocalendarreddot = gohelper.findChild(slot0.viewGO, "btns/btn_content/#go_content/#btn_calendar/#go_calendarreddot")
	slot0._btnsetting = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_setting")
	slot0._btnzhoubian = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_zhoubian")
	slot0._btnachievement = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_achievement")
	slot0._goachievementreddot = gohelper.findChild(slot0.viewGO, "btns/btn_content/#go_content/#btn_achievement/#go_achievementreddot")
	slot0._btnrecordvideo = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/btn_content/#go_content/#btn_recordvideo")
	slot0._btnleft = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/#btn_left")
	slot0._btnright = gohelper.findChildButtonWithAudio(slot0.viewGO, "btns/#btn_right")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "btns/btn_content/#go_content")
	slot0._gobtncontent1 = gohelper.findChild(slot0.viewGO, "btns/btn_content/#go_content/#go_btncontent1")
	slot0._gobtncontent2 = gohelper.findChild(slot0.viewGO, "btns/btn_content/#go_content/#go_btncontent2")
	slot0._goscroll = gohelper.findChild(slot0.viewGO, "btns/#go_scroll")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnhandbook:AddClickListener(slot0._btnhandbookOnClick, slot0)
	slot0._btnsocial:AddClickListener(slot0._btnsocialOnClick, slot0)
	slot0._btnplayercard:AddClickListener(slot0._btnplayercardOnClick, slot0)
	slot0._btnbell:AddClickListener(slot0._btnbellOnClick, slot0)
	slot0._btncalendar:AddClickListener(slot0._btncalendarOnClick, slot0)
	slot0._btnsetting:AddClickListener(slot0._btnsettingOnClick, slot0)
	slot0._btnzhoubian:AddClickListener(slot0._btnzhoubianOnClick, slot0)
	slot0._btnfeedback:AddClickListener(slot0._btnfeedbackOnClick, slot0)
	slot0._btnachievement:AddClickListener(slot0._btnachievementOnClick, slot0)
	slot0._btnrecordvideo:AddClickListener(slot0._btnrecordvideoOnClick, slot0)
	slot0._btnleft:AddClickListener(slot0._btnleftOnClick, slot0)
	slot0._btnright:AddClickListener(slot0._btnrightOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterBook, slot0._btnhandbookOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterAchievement, slot0._btnachievementOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterFriend, slot0._btnsocialOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterTravelCollection, slot0._btnplayercardOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterNotice, slot0._btnbellOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSetting, slot0._btnsettingOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterFeedback, slot0._btnfeedbackOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSign, slot0._btncalendarOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterStore, slot0._btnzhoubianOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnhandbook:RemoveClickListener()
	slot0._btnsocial:RemoveClickListener()
	slot0._btnplayercard:RemoveClickListener()
	slot0._btnbell:RemoveClickListener()
	slot0._btncalendar:RemoveClickListener()
	slot0._btnsetting:RemoveClickListener()
	slot0._btnzhoubian:RemoveClickListener()
	slot0._btnleft:RemoveClickListener()
	slot0._btnright:RemoveClickListener()
	slot0._btnfeedback:RemoveClickListener()
	slot0._btnachievement:RemoveClickListener()
	slot0._btnrecordvideo:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterBook, slot0._btnhandbookOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterAchievement, slot0._btnachievementOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterFriend, slot0._btnsocialOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterTravelCollection, slot0._btnplayercardOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterNotice, slot0._btnbellOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSetting, slot0._btnsettingOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterFeedback, slot0._btnfeedbackOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSign, slot0._btncalendarOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterStore, slot0._btnzhoubianOnClick, slot0)
end

function slot0._btnhandbookOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Handbook) then
		HandbookController.instance:openView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Handbook))
	end
end

function slot0._btnsocialOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		SocialController.instance:openSocialView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Friend))
	end
end

function slot0._btnbellOnClick(slot0)
	if VersionValidator.instance:isInReviewing() then
		logWarn("in reviewing ...")

		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Notice) then
		NoticeController.instance:openNoticeView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Notice))
	end
end

function slot0._btncalendarOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		SignInController.instance:openSignInDetailView({
			isBirthday = false
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.SignIn))
	end
end

function slot0._btnsettingOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Setting) then
		SettingsController.instance:openView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Setting))
	end
end

function slot0._btnzhoubianOnClick(slot0)
	if GameUtil.openDeepLink(SettingsModel.instance:extractByRegion(CommonConfig.instance:getConstStr(ConstEnum.MallWebUrl)), SettingsModel.instance:extractByRegion(CommonConfig.instance:getConstStr(ConstEnum.MallDeepLink))) then
		return
	end

	GameUtil.openURL(slot1)
end

function slot0._btnfeedbackOnClick(slot0)
	if GameFacade.isExternalTest() then
		return
	end

	if SDKNativeUtil.openCostumerService(LangSettings.instance:getCostumerServiceName()) then
		return
	end

	ViewMgr.instance:openView(ViewName.FeedBackView)
end

function slot0._btnachievementOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementEntryView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_open)
end

function slot0._btnrecordvideoOnClick(slot0)
	if SettingsShowHelper.canShowRecordVideo() then
		SDKMgr.instance:openVideosPage()
	end
end

function slot0._btnplayercardOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		PlayerCardController.instance:openPlayerCardView({
			userId = PlayerModel.instance:getPlayinfo().userId
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.PlayerCard))
	end
end

function slot0._btnleftOnClick(slot0)
	slot0:setTargetPageIndex(slot0:getTargetPageIndex() - 1)
	slot0:_updatePage()
end

function slot0._btnrightOnClick(slot0)
	slot0:setTargetPageIndex(slot0:getTargetPageIndex() + 1)
	slot0:_updatePage()
end

function slot0.setTargetPageIndex(slot0, slot1)
	slot0._targetPageIndex = slot1
end

function slot0.getTargetPageIndex(slot0)
	return slot0._targetPageIndex
end

function slot0._updatePage(slot0)
	slot0:_updatePageBtns()
	ZProj.TweenHelper.DOAnchorPosX(slot0._gocontent.transform, (1 - slot0:getTargetPageIndex()) * slot0._space, 0.25)
end

function slot0._updatePageBtns(slot0)
	gohelper.setActive(slot0._btnleft.gameObject, slot0:getTargetPageIndex() > 1)
	gohelper.setActive(slot0._btnright.gameObject, slot0:getTargetPageIndex() < slot0._pageNum and slot0._pageNum > 1)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0._checkOpen, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._checkOpen, slot0)
	slot0:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, slot0._onRefreshNoticeRedDot, slot0)
	slot0:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, slot0._onRefreshNoticeRedDot, slot0)
	slot0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, slot0._onRefreshNoticeRedDot, slot0)
end

function slot0._checkOpen(slot0)
	slot0:_checkZhouBianOpen()
end

function slot0._checkZhouBianOpen(slot0)
	if slot0._isGamePad then
		return
	end

	if GameChannelConfig.isEfun() then
		return
	end

	if SettingsModel.instance:isTwRegion() then
		return
	end

	if slot0._btnzhoubian.gameObject.activeSelf then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ZhouBian) then
		return
	end

	if not ActivityModel.instance:isActOnLine(10004) then
		return
	end

	slot0._btnNum = slot0._btnNum + 1
	slot0._pageNum = math.ceil(slot0._btnNum / 8)

	gohelper.addChild(slot0._gobtncontent2, slot1)
	gohelper.setActive(slot1, true)
	slot0:_initDrag(slot1)
	slot0:_updatePageBtns()
end

function slot0._editableInitView(slot0)
	slot0._scrollList = slot0:getUserDataTb_()
	slot0._btnGoList = slot0:getUserDataTb_()

	table.insert(slot0._btnGoList, slot0._btnhandbook.gameObject)
	table.insert(slot0._btnGoList, slot0._btnachievement.gameObject)
	table.insert(slot0._btnGoList, slot0._btnsocial.gameObject)
	table.insert(slot0._btnGoList, slot0._btnplayercard.gameObject)
	table.insert(slot0._btnGoList, slot0._btnbell.gameObject)
	table.insert(slot0._btnGoList, slot0._btncalendar.gameObject)
	table.insert(slot0._btnGoList, slot0._btnsetting.gameObject)
	table.insert(slot0._btnGoList, slot0._btnfeedback.gameObject)
	table.insert(slot0._btnGoList, slot0._btnrecordvideo.gameObject)
	table.insert(slot0._btnGoList, slot0._btnzhoubian.gameObject)

	slot0._isGamePad = SDKNativeUtil.isGamePad()

	slot0:_refreshBtns()
	slot0:_refreshRedDot()
	slot0:initBtnAudio()
	slot0:_initDrag(slot0._goscroll)
	gohelper.addUIClickAudio(slot0._btnzhoubian.gameObject, AudioEnum.UI.play_ui_admission_open)
end

function slot0._initDrag(slot0, slot1)
	slot2 = SLFramework.UGUI.UIDragListener.Get(slot1)

	slot2:AddDragBeginListener(slot0._onScrollDragBegin, slot0)
	slot2:AddDragEndListener(slot0._onScrollDragEnd, slot0)

	slot0._scrollList[slot1] = slot2
end

function slot0._onScrollDragBegin(slot0, slot1, slot2)
	slot0._scrollStartPos = slot2.position
end

function slot0._onScrollDragEnd(slot0, slot1, slot2)
	if not slot0._scrollStartPos then
		return
	end

	slot3 = slot2.position
	slot0._scrollStartPos = nil

	if math.abs(slot3.x - slot0._scrollStartPos.x) < math.abs(slot3.y - slot0._scrollStartPos.y) then
		return
	end

	slot7 = slot0:getTargetPageIndex() < slot0._pageNum

	if slot4 > 100 and slot6 > 1 then
		slot0:setTargetPageIndex(slot6 - 1)
		slot0:_updatePage()
	elseif slot4 < -100 and slot7 then
		slot0:setTargetPageIndex(slot6 + 1)
		slot0:_updatePage()
	end
end

function slot0.initBtnAudio(slot0)
	slot1 = AudioEnum.UI

	gohelper.addUIClickAudio(slot0._btnhandbook.gameObject, slot1.play_ui_screenplay_open)
	gohelper.addUIClickAudio(slot0._btncalendar.gameObject, slot1.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(slot0._btnbell.gameObject, slot1.play_ui_notice_open)
	gohelper.addUIClickAudio(slot0._btnfeedback.gameObject, slot1.play_ui_feedback_open)
end

function slot0._refreshRedDot(slot0)
	RedDotController.instance:addRedDot(slot0._gosocialreddot, RedDotEnum.DotNode.FriendBtn)
	RedDotController.instance:addRedDot(slot0._gocalendarreddot, RedDotEnum.DotNode.SignInBtn, nil, slot0._checkSignInRed, slot0)
	RedDotController.instance:addRedDot(slot0._goachievementreddot, RedDotEnum.DotNode.AchievementEntry)

	slot0.noticeRedDot = RedDotController.instance:addNotEventRedDot(slot0._gobelllreddot, NoticeModel.hasNotRedNotice, NoticeModel.instance)
end

function slot0._checkSignInRed(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		slot1.show = LifeCircleController.instance:isShowRed()

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0._onRefreshNoticeRedDot(slot0)
	slot0.noticeRedDot:refreshRedDot()
end

function slot0._isShowPlayerCardRedDot(slot0)
	gohelper.setActive(slot0._goreddotplayercard, PlayerCardModel.instance:getShowRed())

	return PlayerCardModel.instance:getShowRed()
end

slot1 = 8

function slot0._refreshBtns(slot0)
	for slot4, slot5 in ipairs(slot0._btnGoList) do
		gohelper.setActive(slot5, true)
	end

	slot2 = not GameFacade.isExternalTest()

	gohelper.setActive(slot0._btnbell.gameObject, not VersionValidator.instance:isInReviewing() and slot2 and (not SDKMgr.getShowNotice or SDKMgr.instance:getShowNotice()) and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Notice))
	gohelper.setActive(slot0._btnsetting.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Setting))
	gohelper.setActive(slot0._btncalendar.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SignIn))
	gohelper.setActive(slot0._btnsocial.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Friend) and slot0._isGamePad == false)
	gohelper.setActive(slot0._btnhandbook.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Handbook))
	gohelper.setActive(slot0._btnplayercard.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.PlayerCard))
	gohelper.setActive(slot0._btnfeedback.gameObject, slot0._isGamePad == false and slot2)

	if VersionValidator.instance:isInReviewing() then
		gohelper.setActive(slot0._btnfeedback.gameObject, false)
	end

	if GameChannelConfig.isEfun() then
		gohelper.setActive(slot0._btnfeedback.gameObject, false)
	end

	gohelper.setActive(slot0._btnrecordvideo, SettingsShowHelper.canShowRecordVideo())
	gohelper.setActive(slot0._btnzhoubian.gameObject, not slot0._isGamePad and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ZhouBian) and ActivityModel.instance:isActOnLine(10004))

	slot5 = 0

	for slot9, slot10 in ipairs(slot0._btnGoList) do
		if slot10.activeSelf then
			if slot5 + 1 <= uv0 then
				gohelper.addChild(slot0._gobtncontent1, slot10)
			else
				gohelper.addChild(slot0._gobtncontent2, slot10)
			end

			slot0:_initDrag(slot10)
		end
	end

	slot0._btnNum = slot5
	slot0._pageNum = math.ceil(slot0._btnNum / uv0)
	slot0._space = recthelper.getWidth(slot0._gobtncontent1.transform)

	slot0:setTargetPageIndex(1)
	slot0:_updatePageBtns()
	slot0:_checkZhouBianOpen()
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0._scrollList) do
		slot5:RemoveDragBeginListener()
		slot5:RemoveDragEndListener()
	end
end

return slot0
