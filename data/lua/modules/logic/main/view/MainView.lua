module("modules.logic.main.view.MainView", package.seeall)

local var_0_0 = class("MainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._golightspinecontrol = gohelper.findChild(arg_1_0.viewGO, "#go_lightspinecontrol")
	arg_1_0._btnquest = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_quest")
	arg_1_0._gotaskreddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_quest/#go_taskreddot")
	arg_1_0._btnstorage = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_storage")
	arg_1_0._godeadline = gohelper.findChild(arg_1_0.viewGO, "left/#btn_storage/#go_deadline")
	arg_1_0._godeadlineEffect = gohelper.findChild(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/#effect")
	arg_1_0._imagetimebg = gohelper.findChildImage(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/timebg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/#txt_time")
	arg_1_0._imagetimeicon = gohelper.findChildImage(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/#txt_time/timeicon")
	arg_1_0._txtformat = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_storage/#go_deadline/#txt_time/#txt_format")
	arg_1_0._gostoragereddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_storage/#go_storagereddot")
	arg_1_0._btnbank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_bank")
	arg_1_0._gobankreddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_bank/#go_bankreddot")
	arg_1_0._godeadlinebank = gohelper.findChild(arg_1_0.viewGO, "left/#btn_bank/#go_deadlinebank")
	arg_1_0._gobankeffect = gohelper.findChild(arg_1_0.viewGO, "left/#btn_bank/#go_bankeffect")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "right")
	arg_1_0._btnroom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_room")
	arg_1_0._goroomlock = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_roomlock")
	arg_1_0._goroomreddot = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_roomreddot")
	arg_1_0._gogreendot = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_roomreddot/#go_greendot")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_roomreddot/#go_reddot")
	arg_1_0._goroomgiftreddot = gohelper.findChild(arg_1_0.viewGO, "right/#btn_room/#go_v1a9actroom")
	arg_1_0._gobanners = gohelper.findChild(arg_1_0.viewGO, "left/#go_banners")
	arg_1_0._goactivity = gohelper.findChild(arg_1_0.viewGO, "left/#go_activity")
	arg_1_0._btnswitchrole = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_switchrole")
	arg_1_0._gothumbnialreddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_switchrole/#go_thumbnailreddot")
	arg_1_0._btnplayerinfo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left_top/playerinfos/info/#btn_playerinfo")
	arg_1_0._imageslider = gohelper.findChildImage(arg_1_0.viewGO, "left_top/playerinfos/info/#image_slider")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "left_top/playerinfos/txtContainer/#txt_name")
	arg_1_0._txtid = gohelper.findChildText(arg_1_0.viewGO, "left_top/playerinfos/txtContainer/#txt_id")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "left_top/playerinfos/txtContainer/layout/#txt_level")
	arg_1_0._goplayerreddot = gohelper.findChild(arg_1_0.viewGO, "left_top/#go_reddot")
	arg_1_0._btnmail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_mail")
	arg_1_0._gomailreddot = gohelper.findChild(arg_1_0.viewGO, "left/#btn_mail/#go_mailreddot")

	local var_1_0 = GMController.instance:getGMNode("mainview", gohelper.findChild(arg_1_0.viewGO, "left_top/btns"))

	if var_1_0 then
		arg_1_0._btngm = gohelper.findChildButtonWithAudio(var_1_0, "#btn_gm")
	end

	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._btnpower = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_power")
	arg_1_0._btnrole = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_role")
	arg_1_0._btnsummon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_summon")
	arg_1_0._btncopost = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_copost")
	arg_1_0._gocopostred = gohelper.findChild(arg_1_0.viewGO, "right/#btn_copost/#go_reddot")
	arg_1_0._imagesummonnew = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/#image_summonnew")
	arg_1_0._imagesummonnew1 = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/1/#image_summonnew")
	arg_1_0._imagesummonnew2 = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/2/#image_summonnew")
	arg_1_0._imagesummonfree = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/#image_free")
	arg_1_0._imagesummonreddot = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/#image_summonreddot")
	arg_1_0._txtpower = gohelper.findChildText(arg_1_0.viewGO, "right/txtContainer/#txt_power")
	arg_1_0._gospinescale = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale")
	arg_1_0._golightspine = gohelper.findChild(arg_1_0.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	arg_1_0._gocontentbg = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_contentbg")
	arg_1_0._txtanacn = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_cn")
	arg_1_0._txtanaen = gohelper.findChildText(arg_1_0.viewGO, "bottom/#txt_ana_en")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_hide")
	arg_1_0._btnbgm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_bgm")
	arg_1_0._gobgmnone = gohelper.findChild(arg_1_0.viewGO, "#btn_bgm/none")
	arg_1_0._gobgmplay = gohelper.findChild(arg_1_0.viewGO, "#btn_bgm/playing")
	arg_1_0._btnlimitedshow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "limitedshow/#btn_limitedshow")
	arg_1_0._golimitedshow = gohelper.findChild(arg_1_0.viewGO, "limitedshow")
	arg_1_0._pcBtnHide = gohelper.findChild(arg_1_0._btnhide.gameObject, "#go_pcbtn")
	arg_1_0._pcBtnRoom = gohelper.findChild(arg_1_0._btnroom.gameObject, "#go_pcbtn")
	arg_1_0._pcBtnCharactor = gohelper.findChild(arg_1_0._btnrole.gameObject, "#go_pcbtn")
	arg_1_0._pcBtnSummon = gohelper.findChild(arg_1_0._btnsummon.gameObject, "#go_pcbtn")

	gohelper.setActive(arg_1_0._btnlimitedshow.gameObject, true)
	gohelper.setActive(arg_1_0._golimitedshow, false)

	arg_1_0._showMainView = true

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnquest:AddClickListener(arg_2_0._btnquestOnClick, arg_2_0)
	arg_2_0._btnstorage:AddClickListener(arg_2_0._btnstorageOnClick, arg_2_0)
	arg_2_0._btnbank:AddClickListener(arg_2_0._btnbankOnClick, arg_2_0)
	arg_2_0._btnroom:AddClickListener(arg_2_0._btnroomOnClick, arg_2_0)
	arg_2_0._btnswitchrole:AddClickListener(arg_2_0._btnswitchroleOnClick, arg_2_0)
	arg_2_0._btnplayerinfo:AddClickListener(arg_2_0._btnplayerinfoOnClick, arg_2_0)
	arg_2_0._btnmail:AddClickListener(arg_2_0._btnmailOnClick, arg_2_0)

	if arg_2_0._btngm then
		arg_2_0._btngm:AddClickListener(arg_2_0._btngmOnClick, arg_2_0)
	end

	arg_2_0._btnpower:AddClickListener(arg_2_0._btnpowerOnClick, arg_2_0)
	arg_2_0._btnrole:AddClickListener(arg_2_0._btnroleOnClick, arg_2_0)
	arg_2_0._btnsummon:AddClickListener(arg_2_0._btnsummonOnClick, arg_2_0)
	arg_2_0._btncopost:AddClickListener(arg_2_0._btncopostOnClick, arg_2_0)
	arg_2_0._btnhide:AddClickListener(arg_2_0._btnhideOnClick, arg_2_0)
	arg_2_0._btnbgm:AddClickListener(arg_2_0._btnbgmOnClick, arg_2_0)
	arg_2_0._btnlimitedshow:AddClickListener(arg_2_0._btnlimitedshowOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifySetMainViewVisible, arg_2_0.OnNotifySetMainViewVisible, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRoom, arg_2_0.OnNotifyEnterRoom, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRole, arg_2_0.OnNotifyEnterRole, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSummon, arg_2_0.OnNotifyEnterSummon, arg_2_0)
	arg_2_0:addEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, arg_2_0.showKeyTips, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnquest:RemoveClickListener()
	arg_3_0._btnstorage:RemoveClickListener()
	arg_3_0._btnbank:RemoveClickListener()
	arg_3_0._btnroom:RemoveClickListener()
	arg_3_0._btnswitchrole:RemoveClickListener()
	arg_3_0._btnplayerinfo:RemoveClickListener()
	arg_3_0._btnmail:RemoveClickListener()

	if arg_3_0._btngm then
		arg_3_0._btngm:RemoveClickListener()
	end

	arg_3_0._btnpower:RemoveClickListener()
	arg_3_0._btnrole:RemoveClickListener()
	arg_3_0._btnsummon:RemoveClickListener()
	arg_3_0._btncopost:RemoveClickListener()
	arg_3_0._btnhide:RemoveClickListener()
	arg_3_0._btnbgm:RemoveClickListener()
	arg_3_0._btnlimitedshow:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifySetMainViewVisible, arg_3_0.OnNotifySetMainViewVisible, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRoom, arg_3_0.OnNotifyEnterRoom, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRole, arg_3_0.OnNotifyEnterRole, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSummon, arg_3_0.OnNotifyEnterSummon, arg_3_0)
	arg_3_0:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, arg_3_0.showKeyTips, arg_3_0)
end

function var_0_0._btnhideOnClick(arg_4_0)
	MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, false)

	local var_4_0 = LimitedRoleController.instance:getNeedPlayLimitedCO()

	gohelper.setActive(arg_4_0._golimitedshow, var_4_0 ~= nil)

	arg_4_0.viewContainer._canvasGroup.interactable = var_4_0 ~= nil
end

function var_0_0.OnNotifySetMainViewVisible(arg_5_0)
	if arg_5_0._showMainView then
		arg_5_0:_btnhideOnClick()
	else
		GameStateMgr.instance:dispatchEvent(GameStateEvent.OnTouchScreenUp)
	end
end

function var_0_0.showKeyTips(arg_6_0)
	PCInputController.instance:showkeyTips(arg_6_0._pcBtnHide, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.hide)
	PCInputController.instance:showkeyTips(arg_6_0._pcBtnRoom, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Room)
	PCInputController.instance:showkeyTips(arg_6_0._pcBtnCharactor, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Role)
	PCInputController.instance:showkeyTips(arg_6_0._pcBtnSummon, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Summon)
end

function var_0_0._btnbgmOnClick(arg_7_0)
	arg_7_0._animator:Play("mainview_bgm", 0, 0)
	BGMSwitchController.instance:openBGMSwitchView()
end

function var_0_0._btnlimitedshowOnClick(arg_8_0)
	local var_8_0 = LimitedRoleController.instance:getNeedPlayLimitedCO()

	if var_8_0 then
		LimitedRoleController.instance:play(LimitedRoleEnum.Stage.MainVisibleClick, var_8_0)
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
		gohelper.setActive(arg_8_0._golimitedshow, false)
	end
end

function var_0_0._setViewVisible(arg_9_0, arg_9_1)
	if LuaUtil.isString(arg_9_1) then
		arg_9_1 = arg_9_1 == "true"
	end

	arg_9_0._showMainView = arg_9_1

	gohelper.setActive(arg_9_0._pcBtnHide, arg_9_1)
	arg_9_0._animator:Play(arg_9_1 and "mainview_in" or "mainview_out", 0, 0)

	arg_9_0.viewContainer._canvasGroup.interactable = arg_9_1

	if arg_9_1 then
		gohelper.setActive(arg_9_0._golimitedshow, false)
	end
end

function var_0_0._setViewRootVisible(arg_10_0, arg_10_1)
	TaskDispatcher.cancelTask(arg_10_0._hideViewRoot, arg_10_0)

	if arg_10_1 then
		arg_10_0.viewContainer:_setVisible(true)
		gohelper.setActive(arg_10_0.viewGO, arg_10_1)
	else
		arg_10_0.viewContainer:_setVisible(false)
		TaskDispatcher.runDelay(arg_10_0._hideViewRoot, arg_10_0, 1)
	end
end

function var_0_0._hideViewRoot(arg_11_0)
	gohelper.setActive(arg_11_0.viewGO, false)
end

function var_0_0._btnsummonOnClick(arg_12_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Summon) then
		SummonController.instance:enterSummonScene()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Summon))
	end
end

function var_0_0._btncopostOnClick(arg_13_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation) then
		CommandStationController.instance:openCommandStationEnterAnimView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.CommandStation))
	end
end

function var_0_0.OnNotifyEnterSummon(arg_14_0)
	arg_14_0:_btnsummonOnClick()
end

function var_0_0._btnswitchroleOnClick(arg_15_0)
	if Time.realtimeSinceStartup - arg_15_0._openMainThumbnailTime <= 0.2 then
		return
	end

	MainController.instance:openMainThumbnailView()
end

function var_0_0._btnbankOnClick(arg_16_0)
	StoreController.instance:checkAndOpenStoreView()
end

function var_0_0._btnpowerOnClick(arg_17_0)
	CurrencyController.instance:openPowerView()
end

function var_0_0.onOpen(arg_18_0)
	UnityEngine.Shader.DisableKeyword("_TRANSVERSEALPHA_ON")
	arg_18_0:_refreshGMBtn()
	arg_18_0:_refreshBtns()
	WeatherController.instance:playAnim("s01_character_switch_in")
	MainController.instance:dispatchEvent(MainEvent.ShowMainView)
	arg_18_0:_updateRedDot()
	TowerController.instance:dailyReddotRefresh()
end

function var_0_0._updateRedDot(arg_19_0)
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.RoomBtn
	})
end

function var_0_0._refreshGMBtn(arg_20_0)
	if arg_20_0._btngm then
		gohelper.setActive(arg_20_0._btngm.gameObject, GMController.instance:isOpenGM())
	end
end

function var_0_0._refreshBtns(arg_21_0)
	local var_21_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Task)

	gohelper.setActive(arg_21_0._btnquest.gameObject, var_21_0)

	local var_21_1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Storage)

	gohelper.setActive(arg_21_0._btnstorage.gameObject, var_21_1)

	local var_21_2 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Bank)

	gohelper.setActive(arg_21_0._btnbank.gameObject, var_21_2)

	local var_21_3 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Room)

	gohelper.setActive(arg_21_0._btnroom.gameObject, var_21_3)

	local var_21_4 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room)

	arg_21_0._roomCanvasGroup.alpha = var_21_4 and 1 or 0.65

	gohelper.setActive(arg_21_0._goroomlock, not var_21_4)
	gohelper.setActive(arg_21_0._btnmail.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Mail))
	gohelper.setActive(arg_21_0._btnsummon.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon))
	gohelper.setActive(arg_21_0._btncopost.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.CommandStation) and not VersionValidator.instance:isInReviewing())
	gohelper.setActive(arg_21_0._btnrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Role))
	gohelper.setActive(arg_21_0._btnswitchrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.MainThumbnail))
end

function var_0_0._setBtnPos(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_1) do
		transformhelper.setLocalPosXY(iter_22_1.transform, 60 + 85 * math.fmod(iter_22_0 - 1, 2), 195 - 85 * iter_22_0)
	end
end

function var_0_0._btnplayerinfoOnClick(arg_23_0)
	local var_23_0 = PlayerModel.instance:getPlayinfo()

	PlayerController.instance:openPlayerView(var_23_0, true)
end

function var_0_0._btngmOnClick(arg_24_0)
	ViewMgr.instance:openView(ViewName.GMToolView)
end

function var_0_0._btnmailOnClick(arg_25_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MailController.instance:open()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Setting))
	end
end

function var_0_0._btnquestOnClick(arg_26_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Task) then
		TaskController.instance:enterTaskView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Task))
	end
end

function var_0_0._btnstorageOnClick(arg_27_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Storage) then
		BackpackController.instance:enterItemBackpack()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Storage))
	end
end

function var_0_0._btnroomOnClick(arg_28_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Room))
	end
end

function var_0_0.OnNotifyEnterRoom(arg_29_0)
	arg_29_0:_btnroomOnClick()
end

function var_0_0._btnroleOnClick(arg_30_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Role) then
		CharacterController.instance:enterCharacterBackpack()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Role))
	end
end

function var_0_0.OnNotifyEnterRole(arg_31_0)
	arg_31_0:_btnroleOnClick()
end

function var_0_0._btnvisitOnClick(arg_32_0)
	return
end

function var_0_0._btncostOnClick(arg_33_0)
	return
end

function var_0_0._OnDailyRefresh(arg_34_0)
	local var_34_0, var_34_1 = StoreHelper.getRecommendStoreSecondTabConfig()

	if var_34_1 and #var_34_1 > 0 then
		StoreRpc.instance:sendGetStoreInfosRequest(var_34_1)
	end

	ActivityRpc.instance:sendGetActivityInfosRequest()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.VersionActivityEnterRedDot
	})
	PlayerController.instance:updateAssistRewardCount()
end

function var_0_0._editableInitView(arg_35_0)
	arg_35_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_35_0._onCurrencyChange, arg_35_0)
	arg_35_0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerinfo, arg_35_0._setPlayerInfo, arg_35_0)
	arg_35_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_35_0._refreshBackpack, arg_35_0)
	arg_35_0:addEventCb(SummonController.instance, SummonEvent.onNewPoolChanged, arg_35_0._refreshSummonNewFlag, arg_35_0)
	arg_35_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_35_0._refreshSummonNewFlag, arg_35_0)
	arg_35_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_35_0._refreshSummonNewFlag, arg_35_0)
	arg_35_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_35_0._refreshBtns, arg_35_0)
	arg_35_0:addEventCb(MainController.instance, MainEvent.OnChangeGMBtnStatus, arg_35_0._refreshGMBtn, arg_35_0)
	arg_35_0:addEventCb(MainController.instance, MainEvent.SetMainViewVisible, arg_35_0._setViewVisible, arg_35_0)
	arg_35_0:addEventCb(MainController.instance, MainEvent.SetMainViewRootVisible, arg_35_0._setViewRootVisible, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_35_0._onCloseFullView, arg_35_0, LuaEventSystem.Low)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_35_0._onOpenFullView, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_35_0._onCloseView, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_35_0._onOpenView, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_35_0._onCloseViewFinish, arg_35_0)
	arg_35_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_35_0._OnDailyRefresh, arg_35_0)
	arg_35_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, arg_35_0._refreshBgm, arg_35_0)
	arg_35_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, arg_35_0._onStartSwitchScene, arg_35_0)
	arg_35_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinish, arg_35_0._onSwitchSceneFinish, arg_35_0)
	arg_35_0:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, arg_35_0._onRefreshNoticeRedDot, arg_35_0)
	arg_35_0:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, arg_35_0._onRefreshNoticeRedDot, arg_35_0)
	arg_35_0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, arg_35_0._onUpdateAssistRewardCount, arg_35_0)
	arg_35_0:_refreshRedDot()
	arg_35_0:_refreshPower()
	arg_35_0:_refreshBgm()
	arg_35_0:_refreshBackpack()
	arg_35_0:_refreshSummonNewFlag()
	arg_35_0:_setPlayerInfo(PlayerModel.instance:getPlayinfo())
	arg_35_0:_updateMainSceneClothes()
	arg_35_0:showKeyTips()

	local var_35_0 = AudioEnum.UI

	gohelper.addUIClickAudio(arg_35_0._btnstorage.gameObject, var_35_0.Play_UI_Warehouse)
	gohelper.addUIClickAudio(arg_35_0._btnroom.gameObject, var_35_0.play_ui_moor_open)
	gohelper.addUIClickAudio(arg_35_0._btnhide.gameObject, var_35_0.play_ui_main_shield)
	gohelper.addUIClickAudio(arg_35_0._btnswitchrole.gameObject, var_35_0.play_ui_thumbnail_click)
	gohelper.addUIClickAudio(arg_35_0._btnsummon.gameObject, var_35_0.play_ui_callfor_open)
	gohelper.addUIClickAudio(arg_35_0._btncopost.gameObject, var_35_0.play_ui_role_open)
	gohelper.addUIClickAudio(arg_35_0._btnquest.gameObject, var_35_0.UI_Mission_open)
	gohelper.addUIClickAudio(arg_35_0._btnbank.gameObject, var_35_0.play_ui_bank_open)
	gohelper.addUIClickAudio(arg_35_0._btnrole.gameObject, var_35_0.play_ui_role_open)
	gohelper.addUIClickAudio(arg_35_0._btnplayerinfo.gameObject, var_35_0.Play_UI_Magazines)
	gohelper.addUIClickAudio(arg_35_0._btnpower.gameObject, var_35_0.Play_UI_Enterhuoxing)
	gohelper.addUIClickAudio(arg_35_0._btnmail.gameObject, var_35_0.UI_Mail_open)

	arg_35_0._animator = arg_35_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_35_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_35_0._cameraAnimator.speed = 1
	arg_35_0._animatorRight = gohelper.findChildComponent(arg_35_0.viewGO, "right", typeof(UnityEngine.Animator))
	arg_35_0._openOtherView = false
	arg_35_0._goroomImage = gohelper.findChild(arg_35_0.viewGO, "right/#btn_room")
	arg_35_0._roomCanvasGroup = gohelper.onceAddComponent(arg_35_0._goroomImage, typeof(UnityEngine.CanvasGroup))
	arg_35_0._openMainThumbnailTime = Time.realtimeSinceStartup
end

function var_0_0._refreshRedDot(arg_36_0)
	RedDotController.instance:addRedDot(arg_36_0._gotaskreddot, RedDotEnum.DotNode.TaskBtn)
	RedDotController.instance:addRedDot(arg_36_0._gomailreddot, RedDotEnum.DotNode.MailBtn)
	RedDotController.instance:addRedDot(arg_36_0._gocopostred, RedDotEnum.DotNode.CommandStationMain)
	RedDotController.instance:addRedDot(arg_36_0._gobankreddot, RedDotEnum.DotNode.StoreBtn, nil, arg_36_0.storeRedDotRefreshFunc, arg_36_0)
	RedDotController.instance:addRedDotTag(arg_36_0._goreddot, RedDotEnum.DotNode.MainRoomProductionFull)
	RedDotController.instance:addRedDotTag(arg_36_0._gogreendot, RedDotEnum.DotNode.MainRoomCharacterFaithGetFull)
	RedDotController.instance:addRedDotTag(arg_36_0._goroomgiftreddot, RedDotEnum.DotNode.RoomGift)

	arg_36_0.playerRedDot = RedDotController.instance:addMultiRedDot(arg_36_0._goplayerreddot, {}, arg_36_0.playerRedDotRefreshFunc, arg_36_0)
	arg_36_0.thumbnailRedDot = RedDotController.instance:addMultiRedDot(arg_36_0._gothumbnialreddot, {
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
	}, arg_36_0.thumbnailRedDotRefreshFunc, arg_36_0)
end

function var_0_0._onUpdateAssistRewardCount(arg_37_0)
	arg_37_0:playerRedDotRefreshFunc(arg_37_0.playerRedDot)
	arg_37_0:thumbnailRedDotRefreshFunc(arg_37_0.thumbnailRedDot)
end

function var_0_0.playerRedDotRefreshFunc(arg_38_0, arg_38_1)
	arg_38_1:defaultRefreshDot()

	if not arg_38_1.show then
		arg_38_1.show = PlayerModel.instance:isHasAssistReward()

		arg_38_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0._onRefreshNoticeRedDot(arg_39_0)
	arg_39_0:thumbnailRedDotRefreshFunc(arg_39_0.thumbnailRedDot)
end

function var_0_0.thumbnailRedDotRefreshFunc(arg_40_0, arg_40_1)
	arg_40_1:defaultRefreshDot()

	local var_40_0 = arg_40_1.show

	if not var_40_0 then
		var_40_0 = var_40_0 or NoticeModel.instance:hasNotRedNotice()
		var_40_0 = var_40_0 or PlayerModel.instance:isHasAssistReward()
		var_40_0 = var_40_0 or BGMSwitchController.instance:hasBgmRedDot()
		var_40_0 = var_40_0 or LifeCircleController.instance:isShowRed()
		var_40_0 = var_40_0 or HandbookController.instance:hasAnyHandBookSkinGroupRedDot()
		var_40_0 = var_40_0 or FightUISwitchModel.instance:isNewUnlockStyle()
		arg_40_1.show = var_40_0

		arg_40_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.showBankNewEffect(arg_41_0, arg_41_1)
	gohelper.setActive(arg_41_0._gobankeffect, arg_41_1)
end

function var_0_0.storeRedDotRefreshFunc(arg_42_0, arg_42_1)
	arg_42_1:defaultRefreshDot()
	arg_42_0:showBankNewEffect(false)

	if not arg_42_1.show and StoreModel.instance:isHasTaskGoodsReward() then
		arg_42_1.show = true

		arg_42_1:showRedDot(RedDotEnum.Style.Normal)
		arg_42_0:showStoreDeadline(false)
		arg_42_0:registStoreDeadlineCall(false)

		return
	end

	local var_42_0 = StoreHelper.getRecommendStoreSecondTabConfig()

	for iter_42_0, iter_42_1 in ipairs(var_42_0) do
		if StoreController.instance:isNeedShowRedDotNewTag(iter_42_1) and not StoreController.instance:isEnteredRecommendStore(iter_42_1.id) then
			arg_42_1.show = true

			arg_42_1:showRedDot(RedDotEnum.Style.NewTag)
			arg_42_1:SetRedDotTrsWithType(RedDotEnum.Style.NewTag, 9.7, 4.2)
			arg_42_0:showStoreDeadline(false)
			arg_42_0:registStoreDeadlineCall(false)
			arg_42_0:showBankNewEffect(true)

			return
		end
	end

	local var_42_1 = StoreModel.instance:getAllRedDotInfo()

	if var_42_1 then
		local var_42_2 = false

		for iter_42_2, iter_42_3 in pairs(var_42_1) do
			local var_42_3 = StoreModel.instance:getGoodsMO(iter_42_3.uid)

			if var_42_3 then
				local var_42_4 = var_42_3.refreshTime == StoreEnum.ChargeRefreshTime.Month

				var_42_2 = var_42_3.refreshTime == StoreEnum.ChargeRefreshTime.Week or var_42_4

				if StoreConfig.instance:isPackageStore(var_42_3.belongStoreId) then
					local var_42_5 = ServerTime.now()

					var_42_2 = var_42_5 >= var_42_3.newStartTime and var_42_5 <= var_42_3.newEndTime
				end
			end

			if var_42_2 then
				break
			end
		end

		if var_42_2 then
			arg_42_1.show = true

			arg_42_1:showRedDot(RedDotEnum.Style.NewTag)
			arg_42_1:SetRedDotTrsWithType(RedDotEnum.Style.NewTag, 9.7, 4.2)
			arg_42_0:showBankNewEffect(true)
		end

		arg_42_0:showStoreDeadline(not var_42_2 and not arg_42_1.show)
		arg_42_0:registStoreDeadlineCall(not var_42_2 and not arg_42_1.show)

		return
	end

	if not arg_42_1.show and StoreModel.instance:isRedTabReadOnceClient(StoreEnum.StoreId.EventPackage) then
		arg_42_1.show = true

		arg_42_1:showRedDot(RedDotEnum.Style.Normal)
	end

	arg_42_0:registStoreDeadlineCall(true)
	arg_42_0:showStoreDeadline(true)
end

function var_0_0.registStoreDeadlineCall(arg_43_0, arg_43_1)
	if not arg_43_0._isStoreDeadlineRunning and arg_43_1 then
		TaskDispatcher.runRepeat(arg_43_0.showStoreDeadline, arg_43_0, 1)

		arg_43_0._isStoreDeadlineRunning = true
	elseif arg_43_0._isStoreDeadlineRunning and not arg_43_1 then
		TaskDispatcher.cancelTask(arg_43_0.showStoreDeadline, arg_43_0)

		arg_43_0._isStoreDeadlineRunning = false
	end
end

function var_0_0.showStoreDeadline(arg_44_0, arg_44_1)
	if not arg_44_0.viewGO then
		return
	end

	local var_44_0 = arg_44_0:getOrCreateStoreDeadline()

	var_44_0.needShow = arg_44_1 or var_44_0.needShow

	if var_44_0.needShow then
		local var_44_1 = false
		local var_44_2 = StoreConfig.instance:getTabConfig(StoreEnum.StoreId.LimitStore)
		local var_44_3 = 0

		if var_44_2 then
			local var_44_4 = StoreHelper.getRemainExpireTime(var_44_2)

			if var_44_4 and var_44_4 > 0 and var_44_4 <= TimeUtil.OneDaySecond * 7 then
				var_44_3 = var_44_4
			end
		end

		local var_44_5 = StoreHelper.getRemainExpireTimeDeepByStoreId(StoreEnum.StoreId.DecorateStore)

		if var_44_5 > 0 and var_44_5 < TimeUtil.OneWeekSecond then
			var_44_3 = var_44_3 == 0 and var_44_5 or Mathf.Min(var_44_5, var_44_3)
		end

		if var_44_3 > 0 then
			gohelper.setActive(var_44_0.godeadline, true)
			gohelper.setActive(var_44_0.txttime.gameObject, true)

			local var_44_6

			var_44_0.txttime.text, var_44_0.txtformat.text, var_44_6 = TimeUtil.secondToRoughTime(math.floor(var_44_3), true)

			UISpriteSetMgr.instance:setCommonSprite(var_44_0.imagetimebg, var_44_6 and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(var_44_0.imagetimeicon, var_44_6 and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(var_44_0.txttime, var_44_6 and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(var_44_0.txtformat, var_44_6 and "#98D687" or "#E99B56")
			gohelper.setActive(var_44_0.godeadlineEffect, not var_44_6)

			return
		end
	end

	gohelper.setActive(var_44_0.godeadline, false)
	gohelper.setActive(var_44_0.txttime.gameObject, false)
end

function var_0_0.getOrCreateStoreDeadline(arg_45_0)
	if not arg_45_0._deadlineStore then
		arg_45_0._deadlineStore = arg_45_0:getUserDataTb_()
		arg_45_0._deadlineStore.godeadline = arg_45_0._godeadlinebank
		arg_45_0._deadlineStore.godeadlineEffect = gohelper.findChild(arg_45_0._deadlineStore.godeadline, "#effect")
		arg_45_0._deadlineStore.txttime = gohelper.findChildText(arg_45_0._deadlineStore.godeadline, "#txt_time")
		arg_45_0._deadlineStore.txtformat = gohelper.findChildText(arg_45_0._deadlineStore.godeadline, "#txt_time/#txt_format")
		arg_45_0._deadlineStore.imagetimebg = gohelper.findChildImage(arg_45_0._deadlineStore.godeadline, "timebg")
		arg_45_0._deadlineStore.imagetimeicon = gohelper.findChildImage(arg_45_0._deadlineStore.godeadline, "#txt_time/timeicon")
	end

	return arg_45_0._deadlineStore
end

function var_0_0._setPlayerInfo(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_1.level

	arg_46_0._txtlevel.text = arg_46_1.level
	arg_46_0._txtname.text = arg_46_1.name
	arg_46_0._txtid.text = "ID:" .. arg_46_1.userId

	local var_46_1 = arg_46_1.exp
	local var_46_2 = 0

	if var_46_0 < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		var_46_2 = PlayerConfig.instance:getPlayerLevelCO(var_46_0 + 1).exp
	else
		var_46_2 = PlayerConfig.instance:getPlayerLevelCO(var_46_0).exp
		var_46_1 = var_46_2
	end

	arg_46_0._imageslider.fillAmount = var_46_1 / var_46_2

	if arg_46_0._lastUpdateLevel ~= arg_46_1.level then
		arg_46_0._lastUpdateLevel = arg_46_1.level
	end

	arg_46_0:_refreshPower()
end

function var_0_0._onCloseViewFinish(arg_47_0, arg_47_1)
	if arg_47_1 == ViewName.MainThumbnailView then
		arg_47_0._startCheckTime = Time.realtimeSinceStartup

		TaskDispatcher.cancelTask(arg_47_0._checkCamera, arg_47_0)
		TaskDispatcher.runRepeat(arg_47_0._checkCamera, arg_47_0, 0)
		LateUpdateBeat:Add(arg_47_0._forceUpdateCameraPos, arg_47_0)
	end

	if arg_47_1 ~= ViewName.LoadingView then
		arg_47_0:_tryDoMainViewGuide()
	end
end

function var_0_0._forceUpdateCameraPos(arg_48_0)
	arg_48_0._openMainThumbnailTime = Time.realtimeSinceStartup

	local var_48_0 = CameraMgr.instance:getCameraTrace()

	var_48_0.EnableTrace = true
	var_48_0.EnableTrace = false
	var_48_0.enabled = false
end

function var_0_0._checkCamera(arg_49_0)
	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	if not arg_49_0._cameraAnimator.enabled or Time.realtimeSinceStartup - arg_49_0._startCheckTime >= 2 then
		TaskDispatcher.cancelTask(arg_49_0._checkCamera, arg_49_0)

		local var_49_0 = CameraMgr.instance:getCameraRootGO()

		transformhelper.setLocalPos(var_49_0.transform, 0, 0, 0)
		arg_49_0:_forceUpdateCameraPos()
		LateUpdateBeat:Remove(arg_49_0._forceUpdateCameraPos, arg_49_0)
	end
end

function var_0_0._onCloseView(arg_50_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if GameSceneMgr.instance:isClosing() then
		return
	end

	if not arg_50_0._openOtherView then
		return
	end

	if not arg_50_0:_hasOpenedOtherView() then
		arg_50_0:_tryDoMainViewGuide()
		arg_50_0:_updateRedDot()
		PlayerController.instance:updateAssistRewardCount()
	end
end

function var_0_0._onOpenView(arg_51_0)
	if arg_51_0:_hasOpenedOtherView() then
		arg_51_0._openOtherView = true
	end
end

function var_0_0._hasOpenedOtherView(arg_52_0)
	local var_52_0 = ViewMgr.instance:getOpenViewNameList()
	local var_52_1 = NavigateMgr.sortOpenViewNameList(var_52_0)

	for iter_52_0 = #var_52_1, 1, -1 do
		local var_52_2 = var_52_1[iter_52_0]
		local var_52_3 = ViewMgr.instance:getSetting(var_52_2)
		local var_52_4 = ViewMgr.instance:getContainer(var_52_2)

		if var_52_2 == ViewName.MainView then
			return false
		elseif var_52_3.layer == "POPUP_TOP" or var_52_3.layer == "POPUP" or var_52_3.layer == "HUD" then
			return true
		end
	end

	return true
end

function var_0_0._onCloseFullView(arg_53_0, arg_53_1)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		arg_53_0.viewContainer:_setVisible(false)

		return
	end

	if arg_53_1 == ViewName.DungeonView or arg_53_1 == ViewName.DungeonMapView then
		arg_53_0:_updateMainSceneClothes()
	end

	if arg_53_1 == ViewName.BackpackView or arg_53_1 == ViewName.StoreView then
		return
	end

	local var_53_0 = ViewMgr.instance:isOpen(ViewName.MailView) or ViewMgr.instance:isOpen(ViewName.TaskView)

	if arg_53_0.viewGO.gameObject.activeInHierarchy then
		if arg_53_0._animator then
			arg_53_0._animator:Play("mainview_in", 0, var_53_0 and 1 or 0)
		end

		if arg_53_0._animatorRight then
			arg_53_0._animatorRight:Play("mainview_right", 0, var_53_0 and 1 or 0)
		end

		local var_53_1 = gohelper.findChildComponent(arg_53_0.viewGO, "#go_righttop/currencyview(Clone)", typeof(UnityEngine.Animator))

		if var_53_1 then
			var_53_1:Play("currencyview_in", 0, var_53_0 and 1 or 0)
		end
	end

	WeatherController.instance:playAnim("s01_character_switch_in")

	if arg_53_0.viewContainer._isVisible then
		MainController.instance:dispatchEvent(MainEvent.ShowMainView)
	end
end

function var_0_0._onOpenFullView(arg_54_0, arg_54_1)
	if arg_54_1 == ViewName.BackpackView or arg_54_1 == ViewName.StoreView then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		return
	end

	if arg_54_0.viewGO.gameObject.activeInHierarchy then
		if arg_54_0._animator then
			if arg_54_1 == ViewName.CharacterBackpackView then
				arg_54_0._animator:Play("mainview_in_hero", 0, 0)
			else
				arg_54_0._animator:Play("mainview_out", 0, 0)
			end
		end

		local var_54_0 = gohelper.findChildComponent(arg_54_0.viewGO, "#go_righttop/currencyview(Clone)", typeof(UnityEngine.Animator))

		if var_54_0 then
			var_54_0:Play("currencyview_out", 0, 0)
		end
	end
end

function var_0_0._onStartSwitchScene(arg_55_0)
	return
end

function var_0_0._onSwitchSceneFinish(arg_56_0)
	arg_56_0._showMainSceneClothes = nil
	arg_56_0._clothesGo = nil

	arg_56_0:_updateMainSceneClothes()
	arg_56_0:_refreshBgm()
end

function var_0_0._updateMainSceneClothes(arg_57_0)
	if arg_57_0._showMainSceneClothes then
		return
	end

	local var_57_0 = CommonConfig.instance:getConstNum(ConstEnum.MainSceneClothesEpisodeId)
	local var_57_1 = DungeonModel.instance:hasPassLevelAndStory(var_57_0)

	if arg_57_0._showMainSceneClothes ~= var_57_1 then
		arg_57_0._showMainSceneClothes = var_57_1

		if not arg_57_0._clothesGo then
			arg_57_0._clothesGo = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/yifu")

			if not arg_57_0._clothesGo then
				logError("_updateMainSceneClothes no clothesGo")
			end
		end

		gohelper.setActive(arg_57_0._clothesGo, var_57_1)
	end
end

function var_0_0._refreshBackpack(arg_58_0)
	arg_58_0._itemDeadline = BackpackModel.instance:getItemDeadline()
	arg_58_0._laststorageDeadLineHasDay = nil

	arg_58_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_58_0._onRefreshDeadline, arg_58_0)

	if arg_58_0._itemDeadline then
		TaskDispatcher.runRepeat(arg_58_0._onRefreshDeadline, arg_58_0, 1)
	end
end

function var_0_0._onRefreshDeadline(arg_59_0)
	if arg_59_0._itemDeadline and arg_59_0._itemDeadline > 0 then
		gohelper.setActive(arg_59_0._txttime.gameObject, true)

		local var_59_0 = arg_59_0._itemDeadline - ServerTime.now()

		if var_59_0 <= 0 then
			ItemRpc.instance:sendGetItemListRequest()
			ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
			gohelper.setActive(arg_59_0._godeadline, false)

			return
		end

		arg_59_0._txttime.text, arg_59_0._txtformat.text, arg_59_0._storageDeadLineHasDay = TimeUtil.secondToRoughTime(math.floor(var_59_0), true)

		gohelper.setActive(arg_59_0._godeadline, true)

		if arg_59_0._laststorageDeadLineHasDay == nil or arg_59_0._laststorageDeadLineHasDay ~= arg_59_0._storageDeadLineHasDay then
			UISpriteSetMgr.instance:setCommonSprite(arg_59_0._imagetimebg, arg_59_0._storageDeadLineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(arg_59_0._imagetimeicon, arg_59_0._storageDeadLineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(arg_59_0._txttime, arg_59_0._storageDeadLineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(arg_59_0._txtformat, arg_59_0._storageDeadLineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(arg_59_0._godeadlineEffect, not arg_59_0._storageDeadLineHasDay)

			arg_59_0._laststorageDeadLineHasDay = arg_59_0._storageDeadLineHasDay
		end
	else
		gohelper.setActive(arg_59_0._godeadline, false)
		gohelper.setActive(arg_59_0._txttime.gameObject, false)
	end
end

function var_0_0._tryDoMainViewGuide(arg_60_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if GameSceneMgr.instance:isClosing() then
		return
	end

	local var_60_0 = not arg_60_0:_hasOpenedOtherView()
	local var_60_1 = MainController.instance:isInPopupFlow()

	if var_60_0 and not var_60_1 then
		local var_60_2 = tonumber(GuideModel.instance:getFlagValue(GuideModel.GuideFlag.MainViewGuideId))

		if var_60_2 and var_60_2 > 0 then
			local var_60_3 = MainViewGuideCondition.getCondition(var_60_2)

			if var_60_3 == nil and true or var_60_3() then
				GuideController.instance:dispatchEvent(GuideEvent.DoMainViewGuide, var_60_2)
			end
		end
	end
end

function var_0_0.onClose(arg_61_0)
	TaskDispatcher.cancelTask(arg_61_0._onRefreshDeadline, arg_61_0)
	TaskDispatcher.cancelTask(arg_61_0._checkCamera, arg_61_0)
	LateUpdateBeat:Remove(arg_61_0._forceUpdateCameraPos, arg_61_0)
	TaskDispatcher.cancelTask(arg_61_0._hideViewRoot, arg_61_0)
	TaskDispatcher.cancelTask(arg_61_0.showStoreDeadline, arg_61_0)
	arg_61_0:registStoreDeadlineCall(false)
end

function var_0_0._onCurrencyChange(arg_62_0, arg_62_1)
	if not arg_62_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_62_0:_refreshPower()
end

function var_0_0._refreshPower(arg_63_0)
	local var_63_0 = PlayerModel.instance:getPlayinfo().level
	local var_63_1 = PlayerConfig.instance:getPlayerLevelCO(var_63_0).maxAutoRecoverPower
	local var_63_2 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	local var_63_3 = var_63_2 and var_63_2.quantity or 0

	arg_63_0._txtpower.text = string.format("%s/%s", var_63_3, var_63_1)
end

function var_0_0._refreshSummonNewFlag(arg_64_0)
	local var_64_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon)
	local var_64_1 = SummonMainModel.instance:entryHasNew()

	gohelper.setActive(arg_64_0._imagesummonnew1, var_64_0 and var_64_1)
	gohelper.setActive(arg_64_0._imagesummonnew2, var_64_0 and var_64_1)

	local var_64_2 = SummonMainModel.instance:entryHasFree()

	gohelper.setActive(arg_64_0._imagesummonfree, var_64_0 and var_64_2)

	local var_64_3 = SummonMainModel.instance:entryNeedReddot()

	gohelper.setActive(arg_64_0._imagesummonreddot, var_64_0 and var_64_3)
end

function var_0_0._refreshBgm(arg_65_0)
	local var_65_0 = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Effect/bgm")
	local var_65_1 = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_obj_b")
	local var_65_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local var_65_3 = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(var_65_0, var_65_3 == BGMSwitchEnum.Gear.On1 and var_65_2)
	gohelper.setActive(var_65_1, var_65_2)

	if not var_65_1 then
		logError("_refreshBgm no bgmGo")
	end

	if not var_65_0 then
		logError("_refreshBgm no lightGo")
	end
end

function var_0_0.onUpdateParam(arg_66_0)
	return
end

function var_0_0.onDestroyView(arg_67_0)
	return
end

return var_0_0
