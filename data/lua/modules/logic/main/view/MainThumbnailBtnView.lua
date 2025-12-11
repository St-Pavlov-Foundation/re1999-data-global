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
	arg_1_0._btnteam = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btns/btn_content/#go_content/#btn_team")
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
	arg_2_0._btnteam:AddClickListener(arg_2_0._btnteamOnClick, arg_2_0)
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
	arg_3_0._btnteam:RemoveClickListener()
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

function var_0_0._btnteamOnClick(arg_13_0)
	HeroGroupPresetController.instance:openHeroGroupPresetTeamView()
end

function var_0_0._btnplayercardOnClick(arg_14_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.PlayerCard) then
		local var_14_0 = PlayerModel.instance:getPlayinfo()

		PlayerCardController.instance:openPlayerCardView({
			userId = var_14_0.userId
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.PlayerCard))
	end
end

function var_0_0._btnleftOnClick(arg_15_0)
	arg_15_0:setTargetPageIndex(arg_15_0:getTargetPageIndex() - 1)
	arg_15_0:_updatePage()
end

function var_0_0._btnrightOnClick(arg_16_0)
	arg_16_0:setTargetPageIndex(arg_16_0:getTargetPageIndex() + 1)
	arg_16_0:_updatePage()
end

function var_0_0.setTargetPageIndex(arg_17_0, arg_17_1)
	arg_17_0._targetPageIndex = arg_17_1
end

function var_0_0.getTargetPageIndex(arg_18_0)
	return arg_18_0._targetPageIndex
end

function var_0_0._updatePage(arg_19_0)
	arg_19_0:_updatePageBtns()

	local var_19_0 = (1 - arg_19_0:getTargetPageIndex()) * arg_19_0._space

	ZProj.TweenHelper.DOAnchorPosX(arg_19_0._gocontent.transform, var_19_0, 0.25)
end

function var_0_0._updatePageBtns(arg_20_0)
	gohelper.setActive(arg_20_0._btnleft.gameObject, arg_20_0:getTargetPageIndex() > 1)
	gohelper.setActive(arg_20_0._btnright.gameObject, arg_20_0:getTargetPageIndex() < arg_20_0._pageNum and arg_20_0._pageNum > 1)
end

function var_0_0.onOpen(arg_21_0)
	arg_21_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_21_0._checkOpen, arg_21_0)
	arg_21_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_21_0._checkOpen, arg_21_0)
	arg_21_0:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, arg_21_0._onRefreshNoticeRedDot, arg_21_0)
	arg_21_0:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, arg_21_0._onRefreshNoticeRedDot, arg_21_0)
	arg_21_0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_21_0._onRefreshNoticeRedDot, arg_21_0)
	arg_21_0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, arg_21_0._isShowPlayerCardRedDot, arg_21_0)
	arg_21_0:addEventCb(HandbookController.instance, HandbookEvent.EnterHandbookSkin, arg_21_0._onRefreshHandbookRedDot, arg_21_0)
	arg_21_0:addEventCb(HandbookController.instance, HandbookEvent.MarkHandbookSkinSuitRedDot, arg_21_0._onRefreshHandbookRedDot, arg_21_0)
end

function var_0_0._checkOpen(arg_22_0)
	arg_22_0:_checkZhouBianOpen()
end

function var_0_0._checkZhouBianOpen(arg_23_0)
	if arg_23_0._isGamePad then
		return
	end

	if GameChannelConfig.isEfun() then
		return
	end

	if SettingsModel.instance:isTwRegion() then
		return
	end

	local var_23_0 = arg_23_0._btnzhoubian.gameObject

	if var_23_0.activeSelf then
		return
	end

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.ZhouBian) then
		return
	end

	if not ActivityModel.instance:isActOnLine(10004) then
		return
	end

	arg_23_0._btnNum = arg_23_0._btnNum + 1
	arg_23_0._pageNum = math.ceil(arg_23_0._btnNum / 8)

	gohelper.addChild(arg_23_0._gobtncontent2, var_23_0)
	gohelper.setActive(var_23_0, true)
	arg_23_0:_initDrag(var_23_0)
	arg_23_0:_updatePageBtns()
end

function var_0_0._editableInitView(arg_24_0)
	arg_24_0._scrollList = arg_24_0:getUserDataTb_()
	arg_24_0._btnGoList = arg_24_0:getUserDataTb_()

	table.insert(arg_24_0._btnGoList, arg_24_0._btnhandbook.gameObject)
	table.insert(arg_24_0._btnGoList, arg_24_0._btnachievement.gameObject)
	table.insert(arg_24_0._btnGoList, arg_24_0._btnsocial.gameObject)
	table.insert(arg_24_0._btnGoList, arg_24_0._btnplayercard.gameObject)
	table.insert(arg_24_0._btnGoList, arg_24_0._btnbell.gameObject)
	table.insert(arg_24_0._btnGoList, arg_24_0._btncalendar.gameObject)
	table.insert(arg_24_0._btnGoList, arg_24_0._btnsetting.gameObject)

	if not VersionValidator.instance:isInReviewing() then
		table.insert(arg_24_0._btnGoList, arg_24_0._btnteam.gameObject)
	end

	table.insert(arg_24_0._btnGoList, arg_24_0._btnfeedback.gameObject)
	table.insert(arg_24_0._btnGoList, arg_24_0._btnrecordvideo.gameObject)
	table.insert(arg_24_0._btnGoList, arg_24_0._btnzhoubian.gameObject)

	arg_24_0._isGamePad = SDKNativeUtil.isGamePad()

	arg_24_0:_refreshBtns()
	arg_24_0:_refreshRedDot()
	arg_24_0:initBtnAudio()
	arg_24_0:_initDrag(arg_24_0._goscroll)
	gohelper.addUIClickAudio(arg_24_0._btnzhoubian.gameObject, AudioEnum.UI.play_ui_admission_open)
end

function var_0_0._initDrag(arg_25_0, arg_25_1)
	local var_25_0 = SLFramework.UGUI.UIDragListener.Get(arg_25_1)

	var_25_0:AddDragBeginListener(arg_25_0._onScrollDragBegin, arg_25_0)
	var_25_0:AddDragEndListener(arg_25_0._onScrollDragEnd, arg_25_0)

	arg_25_0._scrollList[arg_25_1] = var_25_0
end

function var_0_0._onScrollDragBegin(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0._scrollStartPos = arg_26_2.position
end

function var_0_0._onScrollDragEnd(arg_27_0, arg_27_1, arg_27_2)
	if not arg_27_0._scrollStartPos then
		return
	end

	local var_27_0 = arg_27_2.position
	local var_27_1 = var_27_0.x - arg_27_0._scrollStartPos.x
	local var_27_2 = var_27_0.y - arg_27_0._scrollStartPos.y

	arg_27_0._scrollStartPos = nil

	if math.abs(var_27_1) < math.abs(var_27_2) then
		return
	end

	local var_27_3 = arg_27_0:getTargetPageIndex()
	local var_27_4 = var_27_3 < arg_27_0._pageNum
	local var_27_5 = var_27_3 > 1

	if var_27_1 > 100 and var_27_5 then
		arg_27_0:setTargetPageIndex(var_27_3 - 1)
		arg_27_0:_updatePage()
	elseif var_27_1 < -100 and var_27_4 then
		arg_27_0:setTargetPageIndex(var_27_3 + 1)
		arg_27_0:_updatePage()
	end
end

function var_0_0.initBtnAudio(arg_28_0)
	local var_28_0 = AudioEnum.UI

	gohelper.addUIClickAudio(arg_28_0._btnhandbook.gameObject, var_28_0.play_ui_screenplay_open)
	gohelper.addUIClickAudio(arg_28_0._btncalendar.gameObject, var_28_0.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(arg_28_0._btnbell.gameObject, var_28_0.play_ui_notice_open)
	gohelper.addUIClickAudio(arg_28_0._btnfeedback.gameObject, var_28_0.play_ui_feedback_open)
end

function var_0_0._refreshRedDot(arg_29_0)
	RedDotController.instance:addRedDot(arg_29_0._gosocialreddot, RedDotEnum.DotNode.FriendBtn)
	RedDotController.instance:addRedDot(arg_29_0._gocalendarreddot, RedDotEnum.DotNode.SignInBtn, nil, arg_29_0._checkSignInRed, arg_29_0)
	RedDotController.instance:addRedDot(arg_29_0._goachievementreddot, RedDotEnum.DotNode.AchievementEntry)

	arg_29_0.noticeRedDot = RedDotController.instance:addNotEventRedDot(arg_29_0._gobelllreddot, NoticeModel.hasNotRedNotice, NoticeModel.instance)
	arg_29_0.handbookskinRedDot = RedDotController.instance:addNotEventRedDot(arg_29_0._goreddotHandbook, HandbookController.hasAnyHandBookSkinGroupRedDot, HandbookController.instance)
end

function var_0_0._checkSignInRed(arg_30_0, arg_30_1)
	arg_30_1:defaultRefreshDot()

	if not arg_30_1.show then
		arg_30_1.show = LifeCircleController.instance:isShowRed()

		arg_30_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0._onRefreshNoticeRedDot(arg_31_0)
	arg_31_0.noticeRedDot:refreshRedDot()
end

function var_0_0._onRefreshHandbookRedDot(arg_32_0)
	arg_32_0.handbookskinRedDot:refreshRedDot()
end

function var_0_0._isShowPlayerCardRedDot(arg_33_0)
	gohelper.setActive(arg_33_0._goreddotplayercard, PlayerCardModel.instance:getShowRed())

	return PlayerCardModel.instance:getShowRed()
end

local var_0_1 = 8

function var_0_0._refreshBtns(arg_34_0)
	for iter_34_0, iter_34_1 in ipairs(arg_34_0._btnGoList) do
		gohelper.setActive(iter_34_1, true)
	end

	local var_34_0 = not VersionValidator.instance:isInReviewing()
	local var_34_1 = not GameFacade.isExternalTest()
	local var_34_2 = not SDKMgr.getShowNotice or SDKMgr.instance:getShowNotice()
	local var_34_3 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Notice)

	gohelper.setActive(arg_34_0._btnbell.gameObject, var_34_0 and var_34_1 and var_34_2 and var_34_3)
	gohelper.setActive(arg_34_0._btnsetting.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Setting))
	gohelper.setActive(arg_34_0._btncalendar.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.SignIn))
	gohelper.setActive(arg_34_0._btnsocial.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Friend) and arg_34_0._isGamePad == false)
	gohelper.setActive(arg_34_0._btnhandbook.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Handbook))
	gohelper.setActive(arg_34_0._btnplayercard.gameObject, var_34_0 and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.PlayerCard))
	gohelper.setActive(arg_34_0._btnachievement.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Achievement))
	gohelper.setActive(arg_34_0._btnfeedback.gameObject, arg_34_0._isGamePad == false and var_34_1)

	if VersionValidator.instance:isInReviewing() then
		gohelper.setActive(arg_34_0._btnfeedback.gameObject, false)
	end

	if GameChannelConfig.isEfun() then
		gohelper.setActive(arg_34_0._btnfeedback.gameObject, false)
	end

	gohelper.setActive(arg_34_0._btnrecordvideo, SettingsShowHelper.canShowRecordVideo())
	gohelper.setActive(arg_34_0._btnzhoubian.gameObject, not arg_34_0._isGamePad and OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.ZhouBian) and ActivityModel.instance:isActOnLine(10004))

	local var_34_4 = 0

	for iter_34_2, iter_34_3 in ipairs(arg_34_0._btnGoList) do
		if iter_34_3.activeSelf then
			var_34_4 = var_34_4 + 1

			if var_34_4 <= var_0_1 then
				gohelper.addChild(arg_34_0._gobtncontent1, iter_34_3)
			else
				gohelper.addChild(arg_34_0._gobtncontent2, iter_34_3)
			end

			arg_34_0:_initDrag(iter_34_3)
		end
	end

	arg_34_0._btnNum = var_34_4
	arg_34_0._pageNum = math.ceil(arg_34_0._btnNum / var_0_1)
	arg_34_0._space = recthelper.getWidth(arg_34_0._gobtncontent1.transform)

	arg_34_0:setTargetPageIndex(1)
	arg_34_0:_updatePageBtns()
	arg_34_0:_checkZhouBianOpen()
end

function var_0_0.onDestroyView(arg_35_0)
	for iter_35_0, iter_35_1 in pairs(arg_35_0._scrollList) do
		iter_35_1:RemoveDragBeginListener()
		iter_35_1:RemoveDragEndListener()
	end
end

return var_0_0
