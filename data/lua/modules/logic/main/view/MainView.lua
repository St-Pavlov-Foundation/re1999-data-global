module("modules.logic.main.view.MainView", package.seeall)

slot0 = class("MainView", BaseView)

function slot0.onInitView(slot0)
	slot0._golightspinecontrol = gohelper.findChild(slot0.viewGO, "#go_lightspinecontrol")
	slot0._btnquest = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_quest")
	slot0._gotaskreddot = gohelper.findChild(slot0.viewGO, "left/#btn_quest/#go_taskreddot")
	slot0._btnstorage = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_storage")
	slot0._godeadline = gohelper.findChild(slot0.viewGO, "left/#btn_storage/#go_deadline")
	slot0._godeadlineEffect = gohelper.findChild(slot0.viewGO, "left/#btn_storage/#go_deadline/#effect")
	slot0._imagetimebg = gohelper.findChildImage(slot0.viewGO, "left/#btn_storage/#go_deadline/timebg")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "left/#btn_storage/#go_deadline/#txt_time")
	slot0._imagetimeicon = gohelper.findChildImage(slot0.viewGO, "left/#btn_storage/#go_deadline/#txt_time/timeicon")
	slot0._txtformat = gohelper.findChildText(slot0.viewGO, "left/#btn_storage/#go_deadline/#txt_time/#txt_format")
	slot0._gostoragereddot = gohelper.findChild(slot0.viewGO, "left/#btn_storage/#go_storagereddot")
	slot0._btnbank = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_bank")
	slot0._gobankreddot = gohelper.findChild(slot0.viewGO, "left/#btn_bank/#go_bankreddot")
	slot0._godeadlinebank = gohelper.findChild(slot0.viewGO, "left/#btn_bank/#go_deadlinebank")
	slot0._goright = gohelper.findChild(slot0.viewGO, "right")
	slot0._btnroom = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_room")
	slot0._goroomlock = gohelper.findChild(slot0.viewGO, "right/#btn_room/#go_roomlock")
	slot0._goroomreddot = gohelper.findChild(slot0.viewGO, "right/#btn_room/#go_roomreddot")
	slot0._gogreendot = gohelper.findChild(slot0.viewGO, "right/#btn_room/#go_roomreddot/#go_greendot")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "right/#btn_room/#go_roomreddot/#go_reddot")
	slot0._goroomgiftreddot = gohelper.findChild(slot0.viewGO, "right/#btn_room/#go_v1a9actroom")
	slot0._gobanners = gohelper.findChild(slot0.viewGO, "left/#go_banners")
	slot0._goactivity = gohelper.findChild(slot0.viewGO, "left/#go_activity")
	slot0._btnswitchrole = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_switchrole")
	slot0._gothumbnialreddot = gohelper.findChild(slot0.viewGO, "left/#btn_switchrole/#go_thumbnailreddot")
	slot0._btnplayerinfo = gohelper.findChildButtonWithAudio(slot0.viewGO, "left_top/playerinfos/info/#btn_playerinfo")
	slot0._imageslider = gohelper.findChildImage(slot0.viewGO, "left_top/playerinfos/info/#image_slider")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "left_top/playerinfos/txtContainer/#txt_name")
	slot0._txtid = gohelper.findChildText(slot0.viewGO, "left_top/playerinfos/txtContainer/#txt_id")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "left_top/playerinfos/txtContainer/layout/#txt_level")
	slot0._goplayerreddot = gohelper.findChild(slot0.viewGO, "left_top/#go_reddot")
	slot0._btnmail = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_mail")
	slot0._gomailreddot = gohelper.findChild(slot0.viewGO, "left/#btn_mail/#go_mailreddot")

	if GMController.instance:getGMNode("mainview", gohelper.findChild(slot0.viewGO, "left_top/btns")) then
		slot0._btngm = gohelper.findChildButtonWithAudio(slot1, "#btn_gm")
	end

	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
	slot0._btnpower = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_power")
	slot0._btnrole = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_role")
	slot0._btnsummon = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_summon")
	slot0._imagesummonnew = gohelper.findChildImage(slot0.viewGO, "right/#btn_summon/#image_summonnew")
	slot0._imagesummonfree = gohelper.findChildImage(slot0.viewGO, "right/#btn_summon/#image_free")
	slot0._imagesummonreddot = gohelper.findChildImage(slot0.viewGO, "right/#btn_summon/#image_summonreddot")
	slot0._txtpower = gohelper.findChildText(slot0.viewGO, "right/txtContainer/#txt_power")
	slot0._gospinescale = gohelper.findChild(slot0.viewGO, "#go_spine_scale")
	slot0._golightspine = gohelper.findChild(slot0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	slot0._gocontentbg = gohelper.findChild(slot0.viewGO, "bottom/#go_contentbg")
	slot0._txtanacn = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_cn")
	slot0._txtanaen = gohelper.findChildText(slot0.viewGO, "bottom/#txt_ana_en")
	slot0._btnhide = gohelper.findChildButtonWithAudio(slot0.viewGO, "left/#btn_hide")
	slot0._btnbgm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_bgm")
	slot0._gobgmnone = gohelper.findChild(slot0.viewGO, "#btn_bgm/none")
	slot0._gobgmplay = gohelper.findChild(slot0.viewGO, "#btn_bgm/playing")
	slot0._btnlimitedshow = gohelper.findChildButtonWithAudio(slot0.viewGO, "limitedshow/#btn_limitedshow")
	slot0._golimitedshow = gohelper.findChild(slot0.viewGO, "limitedshow")
	slot0._pcBtnHide = gohelper.findChild(slot0._btnhide.gameObject, "#go_pcbtn")
	slot0._pcBtnRoom = gohelper.findChild(slot0._btnroom.gameObject, "#go_pcbtn")
	slot0._pcBtnCharactor = gohelper.findChild(slot0._btnrole.gameObject, "#go_pcbtn")
	slot0._pcBtnSummon = gohelper.findChild(slot0._btnsummon.gameObject, "#go_pcbtn")

	gohelper.setActive(slot0._btnlimitedshow.gameObject, true)
	gohelper.setActive(slot0._golimitedshow, false)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnquest:AddClickListener(slot0._btnquestOnClick, slot0)
	slot0._btnstorage:AddClickListener(slot0._btnstorageOnClick, slot0)
	slot0._btnbank:AddClickListener(slot0._btnbankOnClick, slot0)
	slot0._btnroom:AddClickListener(slot0._btnroomOnClick, slot0)
	slot0._btnswitchrole:AddClickListener(slot0._btnswitchroleOnClick, slot0)
	slot0._btnplayerinfo:AddClickListener(slot0._btnplayerinfoOnClick, slot0)
	slot0._btnmail:AddClickListener(slot0._btnmailOnClick, slot0)

	if slot0._btngm then
		slot0._btngm:AddClickListener(slot0._btngmOnClick, slot0)
	end

	slot0._btnpower:AddClickListener(slot0._btnpowerOnClick, slot0)
	slot0._btnrole:AddClickListener(slot0._btnroleOnClick, slot0)
	slot0._btnsummon:AddClickListener(slot0._btnsummonOnClick, slot0)
	slot0._btnhide:AddClickListener(slot0._btnhideOnClick, slot0)
	slot0._btnbgm:AddClickListener(slot0._btnbgmOnClick, slot0)
	slot0._btnlimitedshow:AddClickListener(slot0._btnlimitedshowOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifySetMainViewVisible, slot0.OnNotifySetMainViewVisible, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRoom, slot0.OnNotifyEnterRoom, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRole, slot0.OnNotifyEnterRole, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSummon, slot0.OnNotifyEnterSummon, slot0)
	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, slot0.showKeyTips, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnquest:RemoveClickListener()
	slot0._btnstorage:RemoveClickListener()
	slot0._btnbank:RemoveClickListener()
	slot0._btnroom:RemoveClickListener()
	slot0._btnswitchrole:RemoveClickListener()
	slot0._btnplayerinfo:RemoveClickListener()
	slot0._btnmail:RemoveClickListener()

	if slot0._btngm then
		slot0._btngm:RemoveClickListener()
	end

	slot0._btnpower:RemoveClickListener()
	slot0._btnrole:RemoveClickListener()
	slot0._btnsummon:RemoveClickListener()
	slot0._btnhide:RemoveClickListener()
	slot0._btnbgm:RemoveClickListener()
	slot0._btnlimitedshow:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifySetMainViewVisible, slot0.OnNotifySetMainViewVisible, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRoom, slot0.OnNotifyEnterRoom, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRole, slot0.OnNotifyEnterRole, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSummon, slot0.OnNotifyEnterSummon, slot0)
	slot0:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, slot0.showKeyTips, slot0)
end

function slot0._btnhideOnClick(slot0)
	MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, false)
	gohelper.setActive(slot0._golimitedshow, LimitedRoleController.instance:getNeedPlayLimitedCO() ~= nil)

	slot0.viewContainer._canvasGroup.interactable = slot1 ~= nil
end

function slot0.OnNotifySetMainViewVisible(slot0)
	if slot0.viewContainer._canvasGroup.interactable then
		slot0:_btnhideOnClick()
	else
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
	end
end

function slot0.showKeyTips(slot0)
	if PlayerPrefsHelper.getNumber("keyTips", 0) == 1 then
		PCInputController.instance:showkeyTips(slot0._pcBtnHide, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.hide)
		PCInputController.instance:showkeyTips(slot0._pcBtnRoom, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Room)
		PCInputController.instance:showkeyTips(slot0._pcBtnCharactor, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Role)
		PCInputController.instance:showkeyTips(slot0._pcBtnSummon, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Summon)
	end
end

function slot0._btnbgmOnClick(slot0)
	slot0._animator:Play("mainview_bgm", 0, 0)
	BGMSwitchController.instance:openBGMSwitchView()
end

function slot0._btnlimitedshowOnClick(slot0)
	if LimitedRoleController.instance:getNeedPlayLimitedCO() then
		LimitedRoleController.instance:play(LimitedRoleEnum.Stage.MainVisibleClick, slot1)
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
		gohelper.setActive(slot0._golimitedshow, false)
	end
end

function slot0._setViewVisible(slot0, slot1)
	if LuaUtil.isString(slot1) then
		slot1 = slot1 == "true"
	end

	gohelper.setActive(slot0._pcBtnHide, slot1)
	slot0._animator:Play(slot1 and "mainview_in" or "mainview_out", 0, 0)

	slot0.viewContainer._canvasGroup.interactable = slot1

	if slot1 then
		gohelper.setActive(slot0._golimitedshow, false)
	end
end

function slot0._setViewRootVisible(slot0, slot1)
	TaskDispatcher.cancelTask(slot0._hideViewRoot, slot0)

	if slot1 then
		slot0.viewContainer:_setVisible(true)
		gohelper.setActive(slot0.viewGO, slot1)
	else
		slot0.viewContainer:_setVisible(false)
		TaskDispatcher.runDelay(slot0._hideViewRoot, slot0, 1)
	end
end

function slot0._hideViewRoot(slot0)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0._btnsummonOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Summon) then
		SummonController.instance:enterSummonScene()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Summon))
	end
end

function slot0.OnNotifyEnterSummon(slot0)
	slot0:_btnsummonOnClick()
end

function slot0._btnswitchroleOnClick(slot0)
	if Time.realtimeSinceStartup - slot0._openMainThumbnailTime <= 0.2 then
		return
	end

	MainController.instance:openMainThumbnailView()
end

function slot0._btnbankOnClick(slot0)
	StoreController.instance:checkAndOpenStoreView()
end

function slot0._btnpowerOnClick(slot0)
	CurrencyController.instance:openPowerView()
end

function slot0.onOpen(slot0)
	UnityEngine.Shader.DisableKeyword("_TRANSVERSEALPHA_ON")
	slot0:_refreshGMBtn()
	slot0:_refreshBtns()
	WeatherController.instance:playAnim("s01_character_switch_in")
	MainController.instance:dispatchEvent(MainEvent.ShowMainView)
	slot0:_updateRedDot()
end

function slot0._updateRedDot(slot0)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.RoomBtn
	})
end

function slot0._refreshGMBtn(slot0)
	if slot0._btngm then
		gohelper.setActive(slot0._btngm.gameObject, GMController.instance:isOpenGM())
	end
end

function slot0._refreshBtns(slot0)
	gohelper.setActive(slot0._btnquest.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Task))
	gohelper.setActive(slot0._btnstorage.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Storage))
	gohelper.setActive(slot0._btnbank.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Bank))
	gohelper.setActive(slot0._btnroom.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Room))

	slot0._roomCanvasGroup.alpha = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) and 1 or 0.65

	gohelper.setActive(slot0._goroomlock, not slot5)
	gohelper.setActive(slot0._btnmail.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Mail))
	gohelper.setActive(slot0._btnsummon.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon))
	gohelper.setActive(slot0._btnrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Role))
	gohelper.setActive(slot0._btnswitchrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.MainThumbnail))
end

function slot0._setBtnPos(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		transformhelper.setLocalPosXY(slot6.transform, 60 + 85 * math.fmod(slot5 - 1, 2), 195 - 85 * slot5)
	end
end

function slot0._btnplayerinfoOnClick(slot0)
	PlayerController.instance:openPlayerView(PlayerModel.instance:getPlayinfo(), true)
end

function slot0._btngmOnClick(slot0)
	ViewMgr.instance:openView(ViewName.GMToolView)
end

function slot0._btnmailOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MailController.instance:open()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Setting))
	end
end

function slot0._btnquestOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Task) then
		TaskController.instance:enterTaskView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Task))
	end
end

function slot0._btnstorageOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Storage) then
		BackpackController.instance:enterItemBackpack()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Storage))
	end
end

function slot0._btnroomOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Room))
	end
end

function slot0.OnNotifyEnterRoom(slot0)
	slot0:_btnroomOnClick()
end

function slot0._btnroleOnClick(slot0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Role) then
		CharacterController.instance:enterCharacterBackpack()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Role))
	end
end

function slot0.OnNotifyEnterRole(slot0)
	slot0:_btnroleOnClick()
end

function slot0._btnvisitOnClick(slot0)
end

function slot0._btncostOnClick(slot0)
end

function slot0._OnDailyRefresh(slot0)
	slot1, slot2 = StoreHelper.getRecommendStoreSecondTabConfig()

	if slot2 and #slot2 > 0 then
		StoreRpc.instance:sendGetStoreInfosRequest(slot2)
	end

	ActivityRpc.instance:sendGetActivityInfosRequest()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.VersionActivityEnterRedDot
	})
	PlayerController.instance:updateAssistRewardCount()
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerinfo, slot0._setPlayerInfo, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshBackpack, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onNewPoolChanged, slot0._refreshSummonNewFlag, slot0)
	slot0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, slot0._refreshSummonNewFlag, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, slot0._refreshBtns, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnChangeGMBtnStatus, slot0._refreshGMBtn, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.SetMainViewVisible, slot0._setViewVisible, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.SetMainViewRootVisible, slot0._setViewRootVisible, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, slot0._OnDailyRefresh, slot0)
	slot0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, slot0._refreshBgm, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, slot0._onStartSwitchScene, slot0)
	slot0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinish, slot0._onSwitchSceneFinish, slot0)
	slot0:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, slot0._onRefreshNoticeRedDot, slot0)
	slot0:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, slot0._onRefreshNoticeRedDot, slot0)
	slot0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, slot0._onUpdateAssistRewardCount, slot0)
	slot0:_refreshRedDot()
	slot0:_refreshPower()
	slot0:_refreshBgm()
	slot0:_refreshBackpack()
	slot0:_refreshSummonNewFlag()
	slot0:_setPlayerInfo(PlayerModel.instance:getPlayinfo())
	slot0:_updateMainSceneClothes()
	slot0:showKeyTips()

	slot1 = AudioEnum.UI

	gohelper.addUIClickAudio(slot0._btnstorage.gameObject, slot1.Play_UI_Warehouse)
	gohelper.addUIClickAudio(slot0._btnroom.gameObject, slot1.play_ui_moor_open)
	gohelper.addUIClickAudio(slot0._btnhide.gameObject, slot1.play_ui_main_shield)
	gohelper.addUIClickAudio(slot0._btnswitchrole.gameObject, slot1.play_ui_thumbnail_click)
	gohelper.addUIClickAudio(slot0._btnsummon.gameObject, slot1.play_ui_callfor_open)
	gohelper.addUIClickAudio(slot0._btnquest.gameObject, slot1.UI_Mission_open)
	gohelper.addUIClickAudio(slot0._btnbank.gameObject, slot1.play_ui_bank_open)
	gohelper.addUIClickAudio(slot0._btnrole.gameObject, slot1.play_ui_role_open)
	gohelper.addUIClickAudio(slot0._btnplayerinfo.gameObject, slot1.Play_UI_Magazines)
	gohelper.addUIClickAudio(slot0._btnpower.gameObject, slot1.Play_UI_Enterhuoxing)
	gohelper.addUIClickAudio(slot0._btnmail.gameObject, slot1.UI_Mail_open)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	slot0._cameraAnimator.speed = 1
	slot0._animatorRight = gohelper.findChildComponent(slot0.viewGO, "right", typeof(UnityEngine.Animator))
	slot0._openOtherView = false
	slot0._goroomImage = gohelper.findChild(slot0.viewGO, "right/#btn_room/image2")
	slot0._roomCanvasGroup = gohelper.onceAddComponent(slot0._goroomImage, typeof(UnityEngine.CanvasGroup))
	slot0._openMainThumbnailTime = Time.realtimeSinceStartup
end

function slot0._refreshRedDot(slot0)
	RedDotController.instance:addRedDot(slot0._gotaskreddot, RedDotEnum.DotNode.TaskBtn)
	RedDotController.instance:addRedDot(slot0._gomailreddot, RedDotEnum.DotNode.MailBtn)
	RedDotController.instance:addRedDot(slot0._gobankreddot, RedDotEnum.DotNode.StoreBtn, nil, slot0.storeRedDotRefreshFunc, slot0)
	RedDotController.instance:addRedDotTag(slot0._goreddot, RedDotEnum.DotNode.MainRoomProductionFull)
	RedDotController.instance:addRedDotTag(slot0._gogreendot, RedDotEnum.DotNode.MainRoomCharacterFaithGetFull)
	RedDotController.instance:addRedDotTag(slot0._goroomgiftreddot, RedDotEnum.DotNode.RoomGift)

	slot0.playerRedDot = RedDotController.instance:addMultiRedDot(slot0._goplayerreddot, {
		{
			id = RedDotEnum.DotNode.PlayerChangeBgNew
		}
	}, slot0.playerRedDotRefreshFunc, slot0)
	slot0.thumbnailRedDot = RedDotController.instance:addMultiRedDot(slot0._gothumbnialreddot, {
		{
			id = RedDotEnum.DotNode.FriendBtn
		},
		{
			id = RedDotEnum.DotNode.SignInBtn
		},
		{
			id = RedDotEnum.DotNode.AchievementEntry
		},
		{
			id = RedDotEnum.DotNode.MainSceneSwitch
		}
	}, slot0.thumbnailRedDotRefreshFunc, slot0)
end

function slot0._onUpdateAssistRewardCount(slot0)
	slot0:playerRedDotRefreshFunc(slot0.playerRedDot)
	slot0:thumbnailRedDotRefreshFunc(slot0.thumbnailRedDot)
end

function slot0.playerRedDotRefreshFunc(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		slot1.show = PlayerModel.instance:isHasAssistReward()

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0._onRefreshNoticeRedDot(slot0)
	slot0:thumbnailRedDotRefreshFunc(slot0.thumbnailRedDot)
end

function slot0.thumbnailRedDotRefreshFunc(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show and (NoticeModel.instance:hasNotRedNotice() or PlayerModel.instance:isHasAssistReward() or BGMSwitchController.instance:hasBgmRedDot()) then
		slot1.show = true

		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.storeRedDotRefreshFunc(slot0, slot1)
	slot1:defaultRefreshDot()

	if not slot1.show then
		for slot6, slot7 in ipairs(StoreHelper.getRecommendStoreSecondTabConfig()) do
			if StoreController.instance:isNeedShowRedDotNewTag(slot7) and not StoreController.instance:isEnteredRecommendStore(slot7.id) then
				slot1.show = true

				slot1:showRedDot(RedDotEnum.Style.NewTag)
				slot1:SetRedDotTrsWithType(RedDotEnum.Style.NewTag, 9.7, 4.2)
				slot0:showStoreDeadline(false)
				slot0:registStoreDeadlineCall(false)

				return
			end
		end

		if not slot1.show and StoreModel.instance:isRedTabReadOnceClient(StoreEnum.StoreId.EventPackage) then
			slot1.show = true

			slot1:showRedDot(RedDotEnum.Style.Normal)
		end
	else
		slot2 = false

		if StoreModel.instance:getAllRedDotInfo() then
			for slot7, slot8 in pairs(slot3) do
				if StoreModel.instance:getGoodsMO(slot8.uid) then
					slot2 = slot9.refreshTime == StoreEnum.ChargeRefreshTime.Week or slot9.refreshTime == StoreEnum.ChargeRefreshTime.Month
				end

				if slot2 then
					break
				end
			end

			if slot2 then
				slot1.show = true

				slot1:showRedDot(RedDotEnum.Style.NewTag)
				slot1:SetRedDotTrsWithType(RedDotEnum.Style.NewTag, 9.7, 4.2)
			end
		end

		slot0:showStoreDeadline(false)
		slot0:registStoreDeadlineCall(false)

		return
	end

	slot0:registStoreDeadlineCall(true)
	slot0:showStoreDeadline(true)
end

function slot0.registStoreDeadlineCall(slot0, slot1)
	if not slot0._isStoreDeadlineRunning and slot1 then
		TaskDispatcher.runRepeat(slot0.showStoreDeadline, slot0, 1)

		slot0._isStoreDeadlineRunning = true
	elseif slot0._isStoreDeadlineRunning and not slot1 then
		TaskDispatcher.cancelTask(slot0.showStoreDeadline, slot0)

		slot0._isStoreDeadlineRunning = false
	end
end

function slot0.showStoreDeadline(slot0, slot1)
	if not slot0.viewGO then
		return
	end

	slot2 = slot0:getOrCreateStoreDeadline()
	slot2.needShow = slot1 or slot2.needShow

	if StoreConfig.instance:getTabConfig(StoreEnum.StoreId.Summon) and slot2.needShow then
		slot4 = false

		if StoreHelper.getRemainExpireTime(slot3) and slot5 > 0 and slot5 <= TimeUtil.OneDaySecond * 7 then
			gohelper.setActive(slot2.godeadline, true)
			gohelper.setActive(slot2.txttime.gameObject, true)

			slot2.txttime.text, slot2.txtformat.text, slot10 = TimeUtil.secondToRoughTime(math.floor(slot5), true)

			UISpriteSetMgr.instance:setCommonSprite(slot2.imagetimebg, slot10 and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(slot2.imagetimeicon, slot4 and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(slot2.txttime, slot4 and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(slot2.txtformat, slot4 and "#98D687" or "#E99B56")
			gohelper.setActive(slot2.godeadlineEffect, not slot4)

			return
		end
	end

	gohelper.setActive(slot2.godeadline, false)
	gohelper.setActive(slot2.txttime.gameObject, false)
end

function slot0.getOrCreateStoreDeadline(slot0)
	if not slot0._deadlineStore then
		slot0._deadlineStore = slot0:getUserDataTb_()
		slot0._deadlineStore.godeadline = slot0._godeadlinebank
		slot0._deadlineStore.godeadlineEffect = gohelper.findChild(slot0._deadlineStore.godeadline, "#effect")
		slot0._deadlineStore.txttime = gohelper.findChildText(slot0._deadlineStore.godeadline, "#txt_time")
		slot0._deadlineStore.txtformat = gohelper.findChildText(slot0._deadlineStore.godeadline, "#txt_time/#txt_format")
		slot0._deadlineStore.imagetimebg = gohelper.findChildImage(slot0._deadlineStore.godeadline, "timebg")
		slot0._deadlineStore.imagetimeicon = gohelper.findChildImage(slot0._deadlineStore.godeadline, "#txt_time/timeicon")
	end

	return slot0._deadlineStore
end

function slot0._setPlayerInfo(slot0, slot1)
	slot0._txtlevel.text = slot1.level
	slot0._txtname.text = slot1.name
	slot0._txtid.text = "ID:" .. slot1.userId
	slot3 = slot1.exp
	slot4 = 0

	if slot1.level < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		slot4 = PlayerConfig.instance:getPlayerLevelCO(slot2 + 1).exp
	else
		slot3 = PlayerConfig.instance:getPlayerLevelCO(slot2).exp
	end

	slot0._imageslider.fillAmount = slot3 / slot4

	if slot0._lastUpdateLevel ~= slot1.level then
		slot0._lastUpdateLevel = slot1.level
	end

	slot0:_refreshPower()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.MainThumbnailView then
		slot0._startCheckTime = Time.realtimeSinceStartup

		TaskDispatcher.cancelTask(slot0._checkCamera, slot0)
		TaskDispatcher.runRepeat(slot0._checkCamera, slot0, 0)
		LateUpdateBeat:Add(slot0._forceUpdateCameraPos, slot0)
	end

	slot0:_tryDoMainViewGuide()
end

function slot0._forceUpdateCameraPos(slot0)
	slot0._openMainThumbnailTime = Time.realtimeSinceStartup
	slot1 = CameraMgr.instance:getCameraTrace()
	slot1.EnableTrace = true
	slot1.EnableTrace = false
	slot1.enabled = false
end

function slot0._checkCamera(slot0)
	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	if not slot0._cameraAnimator.enabled or Time.realtimeSinceStartup - slot0._startCheckTime >= 2 then
		TaskDispatcher.cancelTask(slot0._checkCamera, slot0)
		transformhelper.setLocalPos(CameraMgr.instance:getCameraRootGO().transform, 0, 0, 0)
		slot0:_forceUpdateCameraPos()
		LateUpdateBeat:Remove(slot0._forceUpdateCameraPos, slot0)
	end
end

function slot0._onCloseView(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if GameSceneMgr.instance:isClosing() then
		return
	end

	if not slot0._openOtherView then
		return
	end

	if not slot0:_hasOpenedOtherView() then
		slot0:_tryDoMainViewGuide()
		slot0:_updateRedDot()
		PlayerController.instance:updateAssistRewardCount()
	end
end

function slot0._onOpenView(slot0)
	if slot0:_hasOpenedOtherView() then
		slot0._openOtherView = true
	end
end

function slot0._hasOpenedOtherView(slot0)
	for slot5 = #NavigateMgr.sortOpenViewNameList(ViewMgr.instance:getOpenViewNameList()), 1, -1 do
		slot6 = slot1[slot5]
		slot7 = ViewMgr.instance:getSetting(slot6)
		slot8 = ViewMgr.instance:getContainer(slot6)

		if slot6 == ViewName.MainView then
			return false
		elseif slot7.layer == "POPUP_TOP" or slot7.layer == "POPUP" or slot7.layer == "HUD" then
			return true
		end
	end

	return true
end

function slot0._onCloseFullView(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		slot0.viewContainer:_setVisible(false)

		return
	end

	if slot1 == ViewName.DungeonView or slot1 == ViewName.DungeonMapView then
		slot0:_updateMainSceneClothes()
	end

	if slot1 == ViewName.BackpackView or slot1 == ViewName.StoreView then
		return
	end

	if slot0.viewGO.gameObject.activeInHierarchy then
		if slot0._animator then
			slot0._animator:Play("mainview_in", 0, (ViewMgr.instance:isOpen(ViewName.MailView) or ViewMgr.instance:isOpen(ViewName.TaskView)) and 1 or 0)
		end

		if slot0._animatorRight then
			slot0._animatorRight:Play("mainview_right", 0, slot2 and 1 or 0)
		end

		if gohelper.findChildComponent(slot0.viewGO, "#go_righttop/currencyview(Clone)", typeof(UnityEngine.Animator)) then
			slot3:Play("currencyview_in", 0, slot2 and 1 or 0)
		end
	end

	WeatherController.instance:playAnim("s01_character_switch_in")

	if slot0.viewContainer._isVisible then
		MainController.instance:dispatchEvent(MainEvent.ShowMainView)
	end
end

function slot0._onOpenFullView(slot0, slot1)
	if slot1 == ViewName.BackpackView or slot1 == ViewName.StoreView then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		return
	end

	if slot0.viewGO.gameObject.activeInHierarchy then
		if slot0._animator then
			if slot1 == ViewName.CharacterBackpackView then
				slot0._animator:Play("mainview_in_hero", 0, 0)
			else
				slot0._animator:Play("mainview_out", 0, 0)
			end
		end

		if gohelper.findChildComponent(slot0.viewGO, "#go_righttop/currencyview(Clone)", typeof(UnityEngine.Animator)) then
			slot2:Play("currencyview_out", 0, 0)
		end
	end
end

function slot0._onStartSwitchScene(slot0)
end

function slot0._onSwitchSceneFinish(slot0)
	slot0._showMainSceneClothes = nil
	slot0._clothesGo = nil

	slot0:_updateMainSceneClothes()
	slot0:_refreshBgm()
end

function slot0._updateMainSceneClothes(slot0)
	if slot0._showMainSceneClothes then
		return
	end

	if slot0._showMainSceneClothes ~= DungeonModel.instance:hasPassLevelAndStory(CommonConfig.instance:getConstNum(ConstEnum.MainSceneClothesEpisodeId)) then
		slot0._showMainSceneClothes = slot2

		if not slot0._clothesGo then
			slot0._clothesGo = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/yifu")

			if not slot0._clothesGo then
				logError("_updateMainSceneClothes no clothesGo")
			end
		end

		gohelper.setActive(slot0._clothesGo, slot2)
	end
end

function slot0._refreshBackpack(slot0)
	slot0._itemDeadline = BackpackModel.instance:getItemDeadline()
	slot0._laststorageDeadLineHasDay = nil

	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	if slot0._itemDeadline then
		TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
	end
end

function slot0._onRefreshDeadline(slot0)
	if slot0._itemDeadline and slot0._itemDeadline > 0 then
		gohelper.setActive(slot0._txttime.gameObject, true)

		if slot0._itemDeadline - ServerTime.now() <= 0 then
			ItemRpc.instance:sendGetItemListRequest()
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
			gohelper.setActive(slot0._godeadline, false)

			return
		end

		slot0._txttime.text, slot0._txtformat.text, slot0._storageDeadLineHasDay = TimeUtil.secondToRoughTime(math.floor(slot1), true)

		gohelper.setActive(slot0._godeadline, true)

		if slot0._laststorageDeadLineHasDay == nil or slot0._laststorageDeadLineHasDay ~= slot0._storageDeadLineHasDay then
			UISpriteSetMgr.instance:setCommonSprite(slot0._imagetimebg, slot0._storageDeadLineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(slot0._imagetimeicon, slot0._storageDeadLineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txttime, slot0._storageDeadLineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(slot0._txtformat, slot0._storageDeadLineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(slot0._godeadlineEffect, not slot0._storageDeadLineHasDay)

			slot0._laststorageDeadLineHasDay = slot0._storageDeadLineHasDay
		end
	else
		gohelper.setActive(slot0._godeadline, false)
		gohelper.setActive(slot0._txttime.gameObject, false)
	end
end

function slot0._tryDoMainViewGuide(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if GameSceneMgr.instance:isClosing() then
		return
	end

	if not slot0:_hasOpenedOtherView() and MainController.instance:isInPopupFlow() and tonumber(GuideModel.instance:getFlagValue(GuideModel.GuideFlag.MainViewGuideId)) and slot3 > 0 and (MainViewGuideCondition.getCondition(slot3) == nil and true or slot4()) then
		GuideController.instance:dispatchEvent(GuideEvent.DoMainViewGuide, slot3)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.cancelTask(slot0._checkCamera, slot0)
	LateUpdateBeat:Remove(slot0._forceUpdateCameraPos, slot0)
	TaskDispatcher.cancelTask(slot0._hideViewRoot, slot0)
	TaskDispatcher.cancelTask(slot0.showStoreDeadline, slot0)
	slot0:registStoreDeadlineCall(false)
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	slot0:_refreshPower()
end

function slot0._refreshPower(slot0)
	slot0._txtpower.text = string.format("%s/%s", CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power) and slot3.quantity or 0, PlayerConfig.instance:getPlayerLevelCO(PlayerModel.instance:getPlayinfo().level).maxAutoRecoverPower)
end

function slot0._refreshSummonNewFlag(slot0)
	gohelper.setActive(slot0._imagesummonnew, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon) and SummonMainModel.instance:entryHasNew())
	gohelper.setActive(slot0._imagesummonfree, slot1 and SummonMainModel.instance:entryHasFree())
	gohelper.setActive(slot0._imagesummonreddot, slot1 and SummonMainModel.instance:entryNeedReddot())
end

function slot0._refreshBgm(slot0)
	slot2 = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_obj_b")
	slot3 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)

	gohelper.setActive(WeatherController.instance:getSceneNode("s01_obj_a/Anim/Effect/bgm"), BGMSwitchModel.instance:getMechineGear() == BGMSwitchEnum.Gear.On1 and slot3)
	gohelper.setActive(slot2, slot3)

	if not slot2 then
		logError("_refreshBgm no bgmGo")
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
