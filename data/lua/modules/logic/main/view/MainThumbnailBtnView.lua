module("modules.logic.main.view.MainThumbnailBtnView", package.seeall)

local var_0_0 = class("MainThumbnailBtnView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnhandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_handbook")
	arg_1_0._goreddotHandbook = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_handbook/#go_reddot")
	arg_1_0._btnsocial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_social")
	arg_1_0._gosocialreddot = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_social/#go_socialreddot")
	arg_1_0._btnbell = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_bell")
	arg_1_0._btnplayercard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_playercard")
	arg_1_0._goreddotplayercard = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_playercard/#go_reddot")
	arg_1_0._btnfeedback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_feedback")
	arg_1_0._gobelllreddot = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_bell/#go_belllreddot")
	arg_1_0._btncalendar = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_calendar")
	arg_1_0._gocalendarreddot = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_calendar/#go_calendarreddot")
	arg_1_0._btnsetting = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_setting")
	arg_1_0._btnzhoubian = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_zhoubian")
	arg_1_0._btnachievement = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_achievement")
	arg_1_0._goachievementreddot = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_achievement/#go_achievementreddot")
	arg_1_0._btnrecordvideo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_recordvideo")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/#btn_right")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content")
	arg_1_0._gobtncontent1 = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content/#go_btncontent1")
	arg_1_0._gobtncontent2 = gohelper.findChild(arg_1_0.viewGO, "btns/btn_content/#go_content/#go_btncontent2")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "btns/#go_scroll")
	arg_1_0._playercardreddot = RedDotController.instance:addNotEventRedDot(arg_1_0._goreddotplayercard, arg_1_0._isShowPlayerCardRedDot, arg_1_0)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnhandbook:AddClickListener(arg_2_0._btnhandbookOnClick, arg_2_0)
	arg_2_0._btnsocial:AddClickListener(arg_2_0._btnsocialOnClick, arg_2_0)
	arg_2_0._btnplayercard:AddClickListener(arg_2_0._btnplayercardOnClick, arg_2_0)
	arg_2_0._btnbell:AddClickListener(arg_2_0._btnbellOnClick, arg_2_0)
	arg_2_0._btncalendar:AddClickListener(arg_2_0._btncalendarOnClick, arg_2_0)
	arg_2_0._btnsetting:AddClickListener(arg_2_0._btnsettingOnClick, arg_2_0)
	arg_2_0._btnzhoubian:AddClickListener(arg_2_0._btnzhoubianOnClick, arg_2_0)
	arg_2_0._btnfeedback:AddClickListener(arg_2_0._btnfeedbackOnClick, arg_2_0)
	arg_2_0._btnachievement:AddClickListener(arg_2_0._btnachievementOnClick, arg_2_0)
	arg_2_0._btnrecordvideo:AddClickListener(arg_2_0._btnrecordvideoOnClick, arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterBook, arg_2_0._btnhandbookOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterAchievement, arg_2_0._btnachievementOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterFriend, arg_2_0._btnsocialOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterTravelCollection, arg_2_0._btnplayercardOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterNotice, arg_2_0._btnbellOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSetting, arg_2_0._btnsettingOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterFeedback, arg_2_0._btnfeedbackOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSign, arg_2_0._btncalendarOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterStore, arg_2_0._btnzhoubianOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnhandbook:RemoveClickListener()
	arg_3_0._btnsocial:RemoveClickListener()
	arg_3_0._btnplayercard:RemoveClickListener()
	arg_3_0._btnbell:RemoveClickListener()
	arg_3_0._btncalendar:RemoveClickListener()
	arg_3_0._btnsetting:RemoveClickListener()
	arg_3_0._btnzhoubian:RemoveClickListener()
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
	arg_3_0._btnfeedback:RemoveClickListener()
	arg_3_0._btnachievement:RemoveClickListener()
	arg_3_0._btnrecordvideo:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterBook, arg_3_0._btnhandbookOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterAchievement, arg_3_0._btnachievementOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterFriend, arg_3_0._btnsocialOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterTravelCollection, arg_3_0._btnplayercardOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterNotice, arg_3_0._btnbellOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSetting, arg_3_0._btnsettingOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterFeedback, arg_3_0._btnfeedbackOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSign, arg_3_0._btncalendarOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterStore, arg_3_0._btnzhoubianOnClick, arg_3_0)
end

function var_0_0._btnhandbookOnClick(arg_4_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Handbook) then
		HandbookController.instance:openView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Handbook))
	end
end

function var_0_0._btnsocialOnClick(arg_5_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Friend) then
		SocialController.instance:openSocialView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Friend))
	end
end

function var_0_0._btnbellOnClick(arg_6_0)
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

function var_0_0._btncalendarOnClick(arg_7_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.SignIn) then
		local var_7_0 = {}

		var_7_0.isBirthday = false

		SignInController.instance:openSignInDetailView(var_7_0)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.SignIn))
	end
end

function var_0_0._btnsettingOnClick(arg_8_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Setting) then
		SettingsController.instance:openView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Setting))
	end
end

function var_0_0._btnzhoubianOnClick(arg_9_0)
	local var_9_0 = CommonConfig.instance:getConstStr(ConstEnum.MallWebUrl)
	local var_9_1 = CommonConfig.instance:getConstStr(ConstEnum.MallDeepLink)

	StatController.instance:track(StatEnum.EventName.Click_Collectibles_Button, {})

	local var_9_2 = SettingsModel.instance:extractByRegion(var_9_0)
	local var_9_3 = SettingsModel.instance:extractByRegion(var_9_1)

	if GameUtil.openDeepLink(var_9_2, var_9_3) then
		return
	end

	GameUtil.openURL(var_9_2)
end

function var_0_0._btnfeedbackOnClick(arg_10_0)
	if GameFacade.isExternalTest() then
		return
	end

	if SDKNativeUtil.openCostumerService(LangSettings.instance:getCostumerServiceName()) then
		return
	end

	ViewMgr.instance:openView(ViewName.FeedBackView)
end

function var_0_0._btnachievementOnClick(arg_11_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Achievement) then
		ViewMgr.instance:openView(ViewName.AchievementEntryView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Achievement))
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_achieve_open)
end

function var_0_0._btnrecordvideoOnClick(arg_12_0)
	if SettingsShowHelper.canShowRecordVideo() then
		SDKMgr.instance:openVideosPage()
	end
end

function var_0_0._btnplayercardOnClick(arg_13_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		local var_13_0 = PlayerModel.instance:getPlayinfo()

		PlayerCardController.instance:openPlayerCardView({
			userId = var_13_0.userId
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.PlayerCard))
	end
end

function var_0_0._btnleftOnClick(arg_14_0)
	arg_14_0:setTargetPageIndex(arg_14_0:getTargetPageIndex() - 1)
	arg_14_0:_updatePage()
end

function var_0_0._btnrightOnClick(arg_15_0)
	arg_15_0:setTargetPageIndex(arg_15_0:getTargetPageIndex() + 1)
	arg_15_0:_updatePage()
end

function var_0_0.setTargetPageIndex(arg_16_0, arg_16_1)
	arg_16_0._targetPageIndex = arg_16_1
end

function var_0_0.getTargetPageIndex(arg_17_0)
	return arg_17_0._targetPageIndex
end

function var_0_0._updatePage(arg_18_0)
	arg_18_0:_updatePageBtns()

	local var_18_0 = (1 - arg_18_0:getTargetPageIndex()) * arg_18_0._space

	ZProj.TweenHelper.DOAnchorPosX(arg_18_0._gocontent.transform, var_18_0, 0.25)
end

function var_0_0._updatePageBtns(arg_19_0)
	gohelper.setActive(arg_19_0._btnleft.gameObject, arg_19_0:getTargetPageIndex() > 1)
	gohelper.setActive(arg_19_0._btnright.gameObject, arg_19_0:getTargetPageIndex() < arg_19_0._pageNum and arg_19_0._pageNum > 1)
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_20_0._checkOpen, arg_20_0)
	arg_20_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_20_0._checkOpen, arg_20_0)
	arg_20_0:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, arg_20_0._onRefreshNoticeRedDot, arg_20_0)
	arg_20_0:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, arg_20_0._onRefreshNoticeRedDot, arg_20_0)
	arg_20_0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_20_0._onRefreshNoticeRedDot, arg_20_0)
	arg_20_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, arg_20_0._isShowPlayerCardRedDot, arg_20_0)
	arg_20_0:addEventCb(HandbookController.instance, HandbookEvent.EnterHandbookSkin, arg_20_0._onRefreshHandbookRedDot, arg_20_0)
	arg_20_0:addEventCb(HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, arg_20_0._onRefreshHandbookRedDot, arg_20_0)
end

function var_0_0._checkOpen(arg_21_0)
	arg_21_0:_checkZhouBianOpen()
end

function var_0_0._checkZhouBianOpen(arg_22_0)
	if arg_22_0._isGamePad then
		return
	end

	if GameChannelConfig.isEfun() then
		return
	end

	if SettingsModel.instance:isTwRegion() then
		return
	end

	local var_22_0 = arg_22_0._btnzhoubian.gameObject

	if var_22_0.activeSelf then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ZhouBian) then
		return
	end

	if not ActivityModel.instance:isActOnLine(10004) then
		return
	end

	arg_22_0._btnNum = arg_22_0._btnNum + 1
	arg_22_0._pageNum = math.ceil(arg_22_0._btnNum / 8)

	gohelper.addChild(arg_22_0._gobtncontent2, var_22_0)
	gohelper.setActive(var_22_0, true)
	arg_22_0:_initDrag(var_22_0)
	arg_22_0:_updatePageBtns()
end

function var_0_0._editableInitView(arg_23_0)
	arg_23_0._scrollList = arg_23_0:getUserDataTb_()
	arg_23_0._btnGoList = arg_23_0:getUserDataTb_()

	table.insert(arg_23_0._btnGoList, arg_23_0._btnhandbook.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btnachievement.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btnsocial.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btnplayercard.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btnbell.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btncalendar.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btnsetting.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btnfeedback.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btnrecordvideo.gameObject)
	table.insert(arg_23_0._btnGoList, arg_23_0._btnzhoubian.gameObject)

	arg_23_0._isGamePad = SDKNativeUtil.isGamePad()

	arg_23_0:_refreshBtns()
	arg_23_0:_refreshRedDot()
	arg_23_0:initBtnAudio()
	arg_23_0:_initDrag(arg_23_0._goscroll)
	gohelper.addUIClickAudio(arg_23_0._btnzhoubian.gameObject, AudioEnum.UI.play_ui_admission_open)
end

function var_0_0._initDrag(arg_24_0, arg_24_1)
	local var_24_0 = SLFramework.UGUI.UIDragListener.Get(arg_24_1)

	var_24_0:AddDragBeginListener(arg_24_0._onScrollDragBegin, arg_24_0)
	var_24_0:AddDragEndListener(arg_24_0._onScrollDragEnd, arg_24_0)

	arg_24_0._scrollList[arg_24_1] = var_24_0
end

function var_0_0._onScrollDragBegin(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0._scrollStartPos = arg_25_2.position
end

function var_0_0._onScrollDragEnd(arg_26_0, arg_26_1, arg_26_2)
	if not arg_26_0._scrollStartPos then
		return
	end

	local var_26_0 = arg_26_2.position
	local var_26_1 = var_26_0.x - arg_26_0._scrollStartPos.x
	local var_26_2 = var_26_0.y - arg_26_0._scrollStartPos.y

	arg_26_0._scrollStartPos = nil

	if math.abs(var_26_1) < math.abs(var_26_2) then
		return
	end

	local var_26_3 = arg_26_0:getTargetPageIndex()
	local var_26_4 = var_26_3 < arg_26_0._pageNum
	local var_26_5 = var_26_3 > 1

	if var_26_1 > 100 and var_26_5 then
		arg_26_0:setTargetPageIndex(var_26_3 - 1)
		arg_26_0:_updatePage()
	elseif var_26_1 < -100 and var_26_4 then
		arg_26_0:setTargetPageIndex(var_26_3 + 1)
		arg_26_0:_updatePage()
	end
end

function var_0_0.initBtnAudio(arg_27_0)
	local var_27_0 = AudioEnum.UI

	gohelper.addUIClickAudio(arg_27_0._btnhandbook.gameObject, var_27_0.play_ui_screenplay_open)
	gohelper.addUIClickAudio(arg_27_0._btncalendar.gameObject, var_27_0.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(arg_27_0._btnbell.gameObject, var_27_0.play_ui_notice_open)
	gohelper.addUIClickAudio(arg_27_0._btnfeedback.gameObject, var_27_0.play_ui_feedback_open)
end

function var_0_0._refreshRedDot(arg_28_0)
	RedDotController.instance:addRedDot(arg_28_0._gosocialreddot, RedDotEnum.DotNode.FriendBtn)
	RedDotController.instance:addRedDot(arg_28_0._gocalendarreddot, RedDotEnum.DotNode.SignInBtn, nil, arg_28_0._checkSignInRed, arg_28_0)
	RedDotController.instance:addRedDot(arg_28_0._goachievementreddot, RedDotEnum.DotNode.AchievementEntry)

	arg_28_0.noticeRedDot = RedDotController.instance:addNotEventRedDot(arg_28_0._gobelllreddot, NoticeModel.hasNotRedNotice, NoticeModel.instance)
	arg_28_0.handbookskinRedDot = RedDotController.instance:addNotEventRedDot(arg_28_0._goreddotHandbook, HandbookController.hasAnyHandBookSkinGroupRedDot, HandbookController.instance)
end

function var_0_0._checkSignInRed(arg_29_0, arg_29_1)
	arg_29_1:defaultRefreshDot()

	if not arg_29_1.show then
		arg_29_1.show = LifeCircleController.instance:isShowRed()

		arg_29_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0._onRefreshNoticeRedDot(arg_30_0)
	arg_30_0.noticeRedDot:refreshRedDot()
end

function var_0_0._onRefreshHandbookRedDot(arg_31_0)
	arg_31_0.handbookskinRedDot:refreshRedDot()
end

function var_0_0._isShowPlayerCardRedDot(arg_32_0)
	gohelper.setActive(arg_32_0._goreddotplayercard, PlayerCardModel.instance:getShowRed())

	return PlayerCardModel.instance:getShowRed()
end

local var_0_1 = 8

function var_0_0._refreshBtns(arg_33_0)
	for iter_33_0, iter_33_1 in ipairs(arg_33_0._btnGoList) do
		gohelper.setActive(iter_33_1, true)
	end

	local var_33_0 = not VersionValidator.instance:isInReviewing()
	local var_33_1 = not GameFacade.isExternalTest()
	local var_33_2 = not SDKMgr.getShowNotice or SDKMgr.instance:getShowNotice()
	local var_33_3 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Notice)

	gohelper.setActive(arg_33_0._btnbell.gameObject, var_33_0 and var_33_1 and var_33_2 and var_33_3)
	gohelper.setActive(arg_33_0._btnsetting.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Setting))
	gohelper.setActive(arg_33_0._btncalendar.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SignIn))
	gohelper.setActive(arg_33_0._btnsocial.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Friend) and arg_33_0._isGamePad == false)
	gohelper.setActive(arg_33_0._btnhandbook.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Handbook))
	gohelper.setActive(arg_33_0._btnplayercard.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.PlayerCard))
	gohelper.setActive(arg_33_0._btnachievement.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Achievement))
	gohelper.setActive(arg_33_0._btnfeedback.gameObject, arg_33_0._isGamePad == false and var_33_1)

	if VersionValidator.instance:isInReviewing() then
		gohelper.setActive(arg_33_0._btnfeedback.gameObject, false)
	end

	if GameChannelConfig.isEfun() then
		gohelper.setActive(arg_33_0._btnfeedback.gameObject, false)
	end

	gohelper.setActive(arg_33_0._btnrecordvideo, SettingsShowHelper.canShowRecordVideo())
	gohelper.setActive(arg_33_0._btnzhoubian.gameObject, not arg_33_0._isGamePad and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ZhouBian) and ActivityModel.instance:isActOnLine(10004))

	local var_33_4 = 0

	for iter_33_2, iter_33_3 in ipairs(arg_33_0._btnGoList) do
		if iter_33_3.activeSelf then
			var_33_4 = var_33_4 + 1

			if var_33_4 <= var_0_1 then
				gohelper.addChild(arg_33_0._gobtncontent1, iter_33_3)
			else
				gohelper.addChild(arg_33_0._gobtncontent2, iter_33_3)
			end

			arg_33_0:_initDrag(iter_33_3)
		end
	end

	arg_33_0._btnNum = var_33_4
	arg_33_0._pageNum = math.ceil(arg_33_0._btnNum / var_0_1)
	arg_33_0._space = recthelper.getWidth(arg_33_0._gobtncontent1.transform)

	arg_33_0:setTargetPageIndex(1)
	arg_33_0:_updatePageBtns()
	arg_33_0:_checkZhouBianOpen()
end

function var_0_0.onDestroyView(arg_34_0)
	for iter_34_0, iter_34_1 in pairs(arg_34_0._scrollList) do
		iter_34_1:RemoveDragBeginListener()
		iter_34_1:RemoveDragEndListener()
	end
end

return var_0_0
