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
	arg_1_0._imagesummonnew1 = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/1/#image_summonnew")
	arg_1_0._imagesummonnew2 = gohelper.findChildImage(arg_1_0.viewGO, "right/#btn_summon/2/#image_summonnew")
	arg_1_0._btncopost = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#btn_copost")
	arg_1_0._gocopostred = gohelper.findChild(arg_1_0.viewGO, "right/#btn_copost/#go_reddot")
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
		local function var_27_0()
			BackpackController.instance:enterItemBackpack()
		end

		ItemRpc.instance:sendGetPowerMakerInfoRequest(false, false, var_27_0, arg_27_0)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Storage))
	end
end

function var_0_0._btnroomOnClick(arg_29_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Room))
	end
end

function var_0_0.OnNotifyEnterRoom(arg_30_0)
	arg_30_0:_btnroomOnClick()
end

function var_0_0._btnroleOnClick(arg_31_0)
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Role) then
		CharacterController.instance:enterCharacterBackpack()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Role))
	end
end

function var_0_0.OnNotifyEnterRole(arg_32_0)
	arg_32_0:_btnroleOnClick()
end

function var_0_0._btnvisitOnClick(arg_33_0)
	return
end

function var_0_0._btncostOnClick(arg_34_0)
	return
end

function var_0_0._OnDailyRefresh(arg_35_0)
	local var_35_0, var_35_1 = StoreHelper.getRecommendStoreSecondTabConfig()

	if var_35_1 and #var_35_1 > 0 then
		StoreRpc.instance:sendGetStoreInfosRequest(var_35_1)
	end

	ActivityRpc.instance:sendGetActivityInfosRequest()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.VersionActivityEnterRedDot
	})
	PlayerController.instance:updateAssistRewardCount()
end

function var_0_0._editableInitView(arg_36_0)
	arg_36_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_36_0._onCurrencyChange, arg_36_0)
	arg_36_0:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerinfo, arg_36_0._setPlayerInfo, arg_36_0)
	arg_36_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_36_0._refreshBackpack, arg_36_0)
	arg_36_0:addEventCb(SummonController.instance, SummonEvent.onNewPoolChanged, arg_36_0._refreshSummonNewFlag, arg_36_0)
	arg_36_0:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, arg_36_0._refreshSummonNewFlag, arg_36_0)
	arg_36_0:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, arg_36_0._refreshSummonNewFlag, arg_36_0)
	arg_36_0:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, arg_36_0._refreshBtns, arg_36_0)
	arg_36_0:addEventCb(MainController.instance, MainEvent.OnChangeGMBtnStatus, arg_36_0._refreshGMBtn, arg_36_0)
	arg_36_0:addEventCb(MainController.instance, MainEvent.SetMainViewVisible, arg_36_0._setViewVisible, arg_36_0)
	arg_36_0:addEventCb(MainController.instance, MainEvent.SetMainViewRootVisible, arg_36_0._setViewRootVisible, arg_36_0)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, arg_36_0._onCloseFullView, arg_36_0, LuaEventSystem.Low)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_36_0._onOpenFullView, arg_36_0)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_36_0._onCloseView, arg_36_0)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_36_0._onOpenView, arg_36_0)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_36_0._onCloseViewFinish, arg_36_0)
	arg_36_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, arg_36_0._OnDailyRefresh, arg_36_0)
	arg_36_0:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, arg_36_0._refreshBgm, arg_36_0)
	arg_36_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, arg_36_0._onStartSwitchScene, arg_36_0)
	arg_36_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinish, arg_36_0._onSwitchSceneFinish, arg_36_0)
	arg_36_0:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, arg_36_0._onRefreshNoticeRedDot, arg_36_0)
	arg_36_0:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, arg_36_0._onRefreshNoticeRedDot, arg_36_0)
	arg_36_0:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, arg_36_0._onUpdateAssistRewardCount, arg_36_0)
	arg_36_0:_refreshRedDot()
	arg_36_0:_refreshPower()
	arg_36_0:_refreshBgm()
	arg_36_0:_refreshBackpack()
	arg_36_0:_refreshSummonNewFlag()
	arg_36_0:_setPlayerInfo(PlayerModel.instance:getPlayinfo())
	arg_36_0:_updateMainSceneClothes()
	arg_36_0:showKeyTips()

	local var_36_0 = AudioEnum.UI

	gohelper.addUIClickAudio(arg_36_0._btnstorage.gameObject, var_36_0.Play_UI_Warehouse)
	gohelper.addUIClickAudio(arg_36_0._btnroom.gameObject, var_36_0.play_ui_moor_open)
	gohelper.addUIClickAudio(arg_36_0._btnhide.gameObject, var_36_0.play_ui_main_shield)
	gohelper.addUIClickAudio(arg_36_0._btnswitchrole.gameObject, var_36_0.play_ui_thumbnail_click)
	gohelper.addUIClickAudio(arg_36_0._btnsummon.gameObject, var_36_0.play_ui_callfor_open)
	gohelper.addUIClickAudio(arg_36_0._btncopost.gameObject, var_36_0.play_ui_role_open)
	gohelper.addUIClickAudio(arg_36_0._btnquest.gameObject, var_36_0.UI_Mission_open)
	gohelper.addUIClickAudio(arg_36_0._btnbank.gameObject, var_36_0.play_ui_bank_open)
	gohelper.addUIClickAudio(arg_36_0._btnrole.gameObject, var_36_0.play_ui_role_open)
	gohelper.addUIClickAudio(arg_36_0._btnplayerinfo.gameObject, var_36_0.Play_UI_Magazines)
	gohelper.addUIClickAudio(arg_36_0._btnpower.gameObject, var_36_0.Play_UI_Enterhuoxing)
	gohelper.addUIClickAudio(arg_36_0._btnmail.gameObject, var_36_0.UI_Mail_open)

	arg_36_0._animator = arg_36_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_36_0._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	arg_36_0._cameraAnimator.speed = 1
	arg_36_0._animatorRight = gohelper.findChildComponent(arg_36_0.viewGO, "right", typeof(UnityEngine.Animator))
	arg_36_0._openOtherView = false
	arg_36_0._goroomImage = gohelper.findChild(arg_36_0.viewGO, "right/#btn_room")
	arg_36_0._roomCanvasGroup = gohelper.onceAddComponent(arg_36_0._goroomImage, typeof(UnityEngine.CanvasGroup))
	arg_36_0._openMainThumbnailTime = Time.realtimeSinceStartup
end

function var_0_0._refreshRedDot(arg_37_0)
	RedDotController.instance:addRedDot(arg_37_0._gotaskreddot, RedDotEnum.DotNode.TaskBtn)
	RedDotController.instance:addRedDot(arg_37_0._gomailreddot, RedDotEnum.DotNode.MailBtn)
	RedDotController.instance:addRedDot(arg_37_0._gocopostred, RedDotEnum.DotNode.CommandStationMain)
	RedDotController.instance:addRedDot(arg_37_0._gobankreddot, RedDotEnum.DotNode.StoreBtn, nil, arg_37_0.storeRedDotRefreshFunc, arg_37_0)
	RedDotController.instance:addRedDotTag(arg_37_0._goreddot, RedDotEnum.DotNode.MainRoomProductionFull)
	RedDotController.instance:addRedDotTag(arg_37_0._gogreendot, RedDotEnum.DotNode.MainRoomCharacterFaithGetFull)
	RedDotController.instance:addRedDotTag(arg_37_0._goroomgiftreddot, RedDotEnum.DotNode.RoomGift)

	arg_37_0.playerRedDot = RedDotController.instance:addMultiRedDot(arg_37_0._goplayerreddot, {}, arg_37_0.playerRedDotRefreshFunc, arg_37_0)
	arg_37_0.thumbnailRedDot = RedDotController.instance:addMultiRedDot(arg_37_0._gothumbnialreddot, {
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
	}, arg_37_0.thumbnailRedDotRefreshFunc, arg_37_0)
end

function var_0_0._onUpdateAssistRewardCount(arg_38_0)
	arg_38_0:playerRedDotRefreshFunc(arg_38_0.playerRedDot)
	arg_38_0:thumbnailRedDotRefreshFunc(arg_38_0.thumbnailRedDot)
end

function var_0_0.playerRedDotRefreshFunc(arg_39_0, arg_39_1)
	arg_39_1:defaultRefreshDot()

	if not arg_39_1.show then
		arg_39_1.show = PlayerModel.instance:isHasAssistReward()

		arg_39_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0._onRefreshNoticeRedDot(arg_40_0)
	arg_40_0:thumbnailRedDotRefreshFunc(arg_40_0.thumbnailRedDot)
end

function var_0_0.thumbnailRedDotRefreshFunc(arg_41_0, arg_41_1)
	arg_41_1:defaultRefreshDot()

	local var_41_0 = arg_41_1.show

	if not var_41_0 then
		var_41_0 = var_41_0 or NoticeModel.instance:hasNotRedNotice()
		var_41_0 = var_41_0 or PlayerModel.instance:isHasAssistReward()
		var_41_0 = var_41_0 or BGMSwitchController.instance:hasBgmRedDot()
		var_41_0 = var_41_0 or LifeCircleController.instance:isShowRed()
		var_41_0 = var_41_0 or HandbookController.instance:hasAnyHandBookSkinGroupRedDot()
		var_41_0 = var_41_0 or FightUISwitchModel.instance:isNewUnlockStyle()
		var_41_0 = var_41_0 or ClickUISwitchModel.instance:hasReddot()
		arg_41_1.show = var_41_0

		arg_41_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.showBankNewEffect(arg_42_0, arg_42_1)
	gohelper.setActive(arg_42_0._gobankeffect, arg_42_1)
end

function var_0_0.storeRedDotRefreshFunc(arg_43_0, arg_43_1)
	arg_43_1:defaultRefreshDot()
	arg_43_0:showBankNewEffect(false)

	if not arg_43_1.show and StoreModel.instance:isHasTaskGoodsReward() then
		arg_43_1.show = true

		arg_43_1:showRedDot(RedDotEnum.Style.Normal)
		arg_43_0:showStoreDeadline(false)
		arg_43_0:registStoreDeadlineCall(false)

		return
	end

	local var_43_0 = StoreHelper.getRecommendStoreSecondTabConfig()

	for iter_43_0, iter_43_1 in ipairs(var_43_0) do
		if StoreController.instance:isNeedShowRedDotNewTag(iter_43_1) and not StoreController.instance:isEnteredRecommendStore(iter_43_1.id) then
			arg_43_1.show = true

			arg_43_1:showRedDot(RedDotEnum.Style.NewTag)
			arg_43_1:SetRedDotTrsWithType(RedDotEnum.Style.NewTag, 9.7, 4.2)
			arg_43_0:showStoreDeadline(false)
			arg_43_0:registStoreDeadlineCall(false)
			arg_43_0:showBankNewEffect(true)

			return
		end
	end

	local var_43_1 = StoreModel.instance:getAllRedDotInfo()

	if var_43_1 then
		local var_43_2 = false

		for iter_43_2, iter_43_3 in pairs(var_43_1) do
			local var_43_3 = StoreModel.instance:getGoodsMO(iter_43_3.uid)

			if var_43_3 then
				local var_43_4 = var_43_3.refreshTime == StoreEnum.ChargeRefreshTime.Month

				var_43_2 = var_43_3.refreshTime == StoreEnum.ChargeRefreshTime.Week or var_43_4

				if StoreConfig.instance:isPackageStore(var_43_3.belongStoreId) then
					local var_43_5 = ServerTime.now()

					var_43_2 = var_43_5 >= var_43_3.newStartTime and var_43_5 <= var_43_3.newEndTime
				end

				if var_43_3.belongStoreId == StoreEnum.StoreId.Skin then
					var_43_2 = true
				end
			end

			if var_43_2 then
				break
			end
		end

		if var_43_2 then
			arg_43_1.show = true

			arg_43_1:showRedDot(RedDotEnum.Style.NewTag)
			arg_43_1:SetRedDotTrsWithType(RedDotEnum.Style.NewTag, 9.7, 4.2)
			arg_43_0:showBankNewEffect(true)
		end

		arg_43_0:showStoreDeadline(not var_43_2 and not arg_43_1.show)
		arg_43_0:registStoreDeadlineCall(not var_43_2 and not arg_43_1.show)

		return
	end

	if not arg_43_1.show and StoreModel.instance:isRedTabReadOnceClient(StoreEnum.StoreId.EventPackage) then
		arg_43_1.show = true

		arg_43_1:showRedDot(RedDotEnum.Style.Normal)
	end

	arg_43_0:registStoreDeadlineCall(true)
	arg_43_0:showStoreDeadline(true)
end

function var_0_0.registStoreDeadlineCall(arg_44_0, arg_44_1)
	if not arg_44_0._isStoreDeadlineRunning and arg_44_1 then
		TaskDispatcher.runRepeat(arg_44_0.showStoreDeadline, arg_44_0, 1)

		arg_44_0._isStoreDeadlineRunning = true
	elseif arg_44_0._isStoreDeadlineRunning and not arg_44_1 then
		TaskDispatcher.cancelTask(arg_44_0.showStoreDeadline, arg_44_0)

		arg_44_0._isStoreDeadlineRunning = false
	end
end

function var_0_0.showStoreDeadline(arg_45_0, arg_45_1)
	if not arg_45_0.viewGO then
		return
	end

	local var_45_0 = arg_45_0:getOrCreateStoreDeadline()

	var_45_0.needShow = arg_45_1 or var_45_0.needShow

	if var_45_0.needShow then
		local var_45_1 = false
		local var_45_2 = StoreConfig.instance:getTabConfig(StoreEnum.StoreId.LimitStore)
		local var_45_3 = 0

		if var_45_2 then
			local var_45_4 = StoreHelper.getRemainExpireTime(var_45_2)

			if var_45_4 and var_45_4 > 0 and var_45_4 <= TimeUtil.OneDaySecond * 7 then
				var_45_3 = var_45_4
			end
		end

		local var_45_5 = StoreHelper.getRemainExpireTimeDeepByStoreId(StoreEnum.StoreId.DecorateStore)

		if var_45_5 > 0 and var_45_5 < TimeUtil.OneWeekSecond then
			var_45_3 = var_45_3 == 0 and var_45_5 or Mathf.Min(var_45_5, var_45_3)
		end

		if var_45_3 > 0 then
			gohelper.setActive(var_45_0.godeadline, true)
			gohelper.setActive(var_45_0.txttime.gameObject, true)

			local var_45_6

			var_45_0.txttime.text, var_45_0.txtformat.text, var_45_6 = TimeUtil.secondToRoughTime(math.floor(var_45_3), true)

			UISpriteSetMgr.instance:setCommonSprite(var_45_0.imagetimebg, var_45_6 and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(var_45_0.imagetimeicon, var_45_6 and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(var_45_0.txttime, var_45_6 and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(var_45_0.txtformat, var_45_6 and "#98D687" or "#E99B56")
			gohelper.setActive(var_45_0.godeadlineEffect, not var_45_6)

			return
		end
	end

	gohelper.setActive(var_45_0.godeadline, false)
	gohelper.setActive(var_45_0.txttime.gameObject, false)
end

function var_0_0.getOrCreateStoreDeadline(arg_46_0)
	if not arg_46_0._deadlineStore then
		arg_46_0._deadlineStore = arg_46_0:getUserDataTb_()
		arg_46_0._deadlineStore.godeadline = arg_46_0._godeadlinebank
		arg_46_0._deadlineStore.godeadlineEffect = gohelper.findChild(arg_46_0._deadlineStore.godeadline, "#effect")
		arg_46_0._deadlineStore.txttime = gohelper.findChildText(arg_46_0._deadlineStore.godeadline, "#txt_time")
		arg_46_0._deadlineStore.txtformat = gohelper.findChildText(arg_46_0._deadlineStore.godeadline, "#txt_time/#txt_format")
		arg_46_0._deadlineStore.imagetimebg = gohelper.findChildImage(arg_46_0._deadlineStore.godeadline, "timebg")
		arg_46_0._deadlineStore.imagetimeicon = gohelper.findChildImage(arg_46_0._deadlineStore.godeadline, "#txt_time/timeicon")
	end

	return arg_46_0._deadlineStore
end

function var_0_0._setPlayerInfo(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1.level

	arg_47_0._txtlevel.text = arg_47_1.level
	arg_47_0._txtname.text = arg_47_1.name
	arg_47_0._txtid.text = "ID:" .. arg_47_1.userId

	local var_47_1 = arg_47_1.exp
	local var_47_2 = 0

	if var_47_0 < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		var_47_2 = PlayerConfig.instance:getPlayerLevelCO(var_47_0 + 1).exp
	else
		var_47_2 = PlayerConfig.instance:getPlayerLevelCO(var_47_0).exp
		var_47_1 = var_47_2
	end

	arg_47_0._imageslider.fillAmount = var_47_1 / var_47_2

	if arg_47_0._lastUpdateLevel ~= arg_47_1.level then
		arg_47_0._lastUpdateLevel = arg_47_1.level
	end

	arg_47_0:_refreshPower()
end

function var_0_0._onCloseViewFinish(arg_48_0, arg_48_1)
	if arg_48_1 == ViewName.MainThumbnailView then
		arg_48_0._startCheckTime = Time.realtimeSinceStartup

		TaskDispatcher.cancelTask(arg_48_0._checkCamera, arg_48_0)
		TaskDispatcher.runRepeat(arg_48_0._checkCamera, arg_48_0, 0)
		LateUpdateBeat:Add(arg_48_0._forceUpdateCameraPos, arg_48_0)
	end

	if arg_48_1 ~= ViewName.LoadingView then
		arg_48_0:_tryDoMainViewGuide()
	end
end

function var_0_0._forceUpdateCameraPos(arg_49_0)
	arg_49_0._openMainThumbnailTime = Time.realtimeSinceStartup

	local var_49_0 = CameraMgr.instance:getCameraTrace()

	var_49_0.EnableTrace = true
	var_49_0.EnableTrace = false
	var_49_0.enabled = false
end

function var_0_0._checkCamera(arg_50_0)
	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	if not arg_50_0._cameraAnimator.enabled or Time.realtimeSinceStartup - arg_50_0._startCheckTime >= 2 then
		TaskDispatcher.cancelTask(arg_50_0._checkCamera, arg_50_0)

		local var_50_0 = CameraMgr.instance:getCameraRootGO()

		transformhelper.setLocalPos(var_50_0.transform, 0, 0, 0)
		arg_50_0:_forceUpdateCameraPos()
		LateUpdateBeat:Remove(arg_50_0._forceUpdateCameraPos, arg_50_0)
	end
end

function var_0_0._onCloseView(arg_51_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if GameSceneMgr.instance:isClosing() then
		return
	end

	if not arg_51_0._openOtherView then
		return
	end

	if not arg_51_0:_hasOpenedOtherView() then
		arg_51_0:_tryDoMainViewGuide()
		arg_51_0:_updateRedDot()
		PlayerController.instance:updateAssistRewardCount()
	end
end

function var_0_0._onOpenView(arg_52_0)
	if arg_52_0:_hasOpenedOtherView() then
		arg_52_0._openOtherView = true
	end
end

function var_0_0._hasOpenedOtherView(arg_53_0)
	local var_53_0 = ViewMgr.instance:getOpenViewNameList()
	local var_53_1 = NavigateMgr.sortOpenViewNameList(var_53_0)

	for iter_53_0 = #var_53_1, 1, -1 do
		local var_53_2 = var_53_1[iter_53_0]
		local var_53_3 = ViewMgr.instance:getSetting(var_53_2)
		local var_53_4 = ViewMgr.instance:getContainer(var_53_2)

		if var_53_2 == ViewName.MainView then
			return false
		elseif var_53_3.layer == "POPUP_TOP" or var_53_3.layer == "POPUP" or var_53_3.layer == "HUD" then
			return true
		end
	end

	return true
end

function var_0_0._onCloseFullView(arg_54_0, arg_54_1)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		arg_54_0.viewContainer:_setVisible(false)

		return
	end

	if arg_54_1 == ViewName.DungeonView or arg_54_1 == ViewName.DungeonMapView then
		arg_54_0:_updateMainSceneClothes()
	end

	if arg_54_1 == ViewName.BackpackView or arg_54_1 == ViewName.StoreView then
		return
	end

	local var_54_0 = ViewMgr.instance:isOpen(ViewName.MailView) or ViewMgr.instance:isOpen(ViewName.TaskView)

	if arg_54_0.viewGO.gameObject.activeInHierarchy then
		if arg_54_0._animator then
			arg_54_0._animator:Play("mainview_in", 0, var_54_0 and 1 or 0)
		end

		if arg_54_0._animatorRight then
			arg_54_0._animatorRight:Play("mainview_right", 0, var_54_0 and 1 or 0)
		end

		local var_54_1 = gohelper.findChildComponent(arg_54_0.viewGO, "#go_righttop/currencyview(Clone)", typeof(UnityEngine.Animator))

		if var_54_1 then
			var_54_1:Play("currencyview_in", 0, var_54_0 and 1 or 0)
		end
	end

	WeatherController.instance:playAnim("s01_character_switch_in")

	if arg_54_0.viewContainer._isVisible then
		MainController.instance:dispatchEvent(MainEvent.ShowMainView)
	end
end

function var_0_0._onOpenFullView(arg_55_0, arg_55_1)
	if arg_55_1 == ViewName.BackpackView or arg_55_1 == ViewName.StoreView then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		return
	end

	if arg_55_0.viewGO.gameObject.activeInHierarchy then
		if arg_55_0._animator then
			if arg_55_1 == ViewName.CharacterBackpackView then
				arg_55_0._animator:Play("mainview_in_hero", 0, 0)
			else
				arg_55_0._animator:Play("mainview_out", 0, 0)
			end
		end

		local var_55_0 = gohelper.findChildComponent(arg_55_0.viewGO, "#go_righttop/currencyview(Clone)", typeof(UnityEngine.Animator))

		if var_55_0 then
			var_55_0:Play("currencyview_out", 0, 0)
		end
	end
end

function var_0_0._onStartSwitchScene(arg_56_0)
	return
end

function var_0_0._onSwitchSceneFinish(arg_57_0)
	arg_57_0._showMainSceneClothes = nil
	arg_57_0._clothesGo = nil

	arg_57_0:_updateMainSceneClothes()
	arg_57_0:_refreshBgm()
end

function var_0_0._updateMainSceneClothes(arg_58_0)
	if arg_58_0._showMainSceneClothes then
		return
	end

	local var_58_0 = CommonConfig.instance:getConstNum(ConstEnum.MainSceneClothesEpisodeId)
	local var_58_1 = DungeonModel.instance:hasPassLevelAndStory(var_58_0)

	if arg_58_0._showMainSceneClothes ~= var_58_1 then
		arg_58_0._showMainSceneClothes = var_58_1

		if not arg_58_0._clothesGo then
			arg_58_0._clothesGo = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/yifu")

			if not arg_58_0._clothesGo then
				logError("_updateMainSceneClothes no clothesGo")
			end
		end

		gohelper.setActive(arg_58_0._clothesGo, var_58_1)
	end
end

function var_0_0._refreshBackpack(arg_59_0)
	arg_59_0._itemDeadline = BackpackModel.instance:getItemDeadline()
	arg_59_0._laststorageDeadLineHasDay = nil

	arg_59_0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(arg_59_0._onRefreshDeadline, arg_59_0)

	if arg_59_0._itemDeadline then
		TaskDispatcher.runRepeat(arg_59_0._onRefreshDeadline, arg_59_0, 1)
	end
end

function var_0_0._onRefreshDeadline(arg_60_0)
	if arg_60_0._itemDeadline and arg_60_0._itemDeadline > 0 then
		gohelper.setActive(arg_60_0._txttime.gameObject, true)

		local var_60_0 = arg_60_0._itemDeadline - ServerTime.now()

		if var_60_0 <= 0 then
			ItemRpc.instance:autoUseExpirePowerItem()
			gohelper.setActive(arg_60_0._godeadline, false)

			return
		end

		arg_60_0._txttime.text, arg_60_0._txtformat.text, arg_60_0._storageDeadLineHasDay = TimeUtil.secondToRoughTime(math.floor(var_60_0), true)

		gohelper.setActive(arg_60_0._godeadline, true)

		if arg_60_0._laststorageDeadLineHasDay == nil or arg_60_0._laststorageDeadLineHasDay ~= arg_60_0._storageDeadLineHasDay then
			UISpriteSetMgr.instance:setCommonSprite(arg_60_0._imagetimebg, arg_60_0._storageDeadLineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(arg_60_0._imagetimeicon, arg_60_0._storageDeadLineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(arg_60_0._txttime, arg_60_0._storageDeadLineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(arg_60_0._txtformat, arg_60_0._storageDeadLineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(arg_60_0._godeadlineEffect, not arg_60_0._storageDeadLineHasDay)

			arg_60_0._laststorageDeadLineHasDay = arg_60_0._storageDeadLineHasDay
		end
	else
		gohelper.setActive(arg_60_0._godeadline, false)
		gohelper.setActive(arg_60_0._txttime.gameObject, false)
	end
end

function var_0_0._tryDoMainViewGuide(arg_61_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if GameSceneMgr.instance:isClosing() then
		return
	end

	local var_61_0 = not arg_61_0:_hasOpenedOtherView()
	local var_61_1 = MainController.instance:isInPopupFlow()

	if var_61_0 and not var_61_1 then
		local var_61_2 = tonumber(GuideModel.instance:getFlagValue(GuideModel.GuideFlag.MainViewGuideId))

		if var_61_2 and var_61_2 > 0 then
			local var_61_3 = MainViewGuideCondition.getCondition(var_61_2)

			if var_61_3 == nil and true or var_61_3() then
				GuideController.instance:dispatchEvent(GuideEvent.DoMainViewGuide, var_61_2)
			end
		end
	end
end

function var_0_0.onClose(arg_62_0)
	TaskDispatcher.cancelTask(arg_62_0._onRefreshDeadline, arg_62_0)
	TaskDispatcher.cancelTask(arg_62_0._checkCamera, arg_62_0)
	LateUpdateBeat:Remove(arg_62_0._forceUpdateCameraPos, arg_62_0)
	TaskDispatcher.cancelTask(arg_62_0._hideViewRoot, arg_62_0)
	TaskDispatcher.cancelTask(arg_62_0.showStoreDeadline, arg_62_0)
	arg_62_0:registStoreDeadlineCall(false)
end

function var_0_0._onCurrencyChange(arg_63_0, arg_63_1)
	if not arg_63_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_63_0:_refreshPower()
end

function var_0_0._refreshPower(arg_64_0)
	local var_64_0 = PlayerModel.instance:getPlayinfo().level
	local var_64_1 = PlayerConfig.instance:getPlayerLevelCO(var_64_0).maxAutoRecoverPower
	local var_64_2 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	local var_64_3 = var_64_2 and var_64_2.quantity or 0

	arg_64_0._txtpower.text = string.format("%s/%s", var_64_3, var_64_1)
end

function var_0_0._refreshSummonNewFlag(arg_65_0)
	local var_65_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon)
	local var_65_1 = SummonMainModel.instance:entryHasNew()

	gohelper.setActive(arg_65_0._imagesummonnew1, var_65_0 and var_65_1)
	gohelper.setActive(arg_65_0._imagesummonnew2, var_65_0 and var_65_1)

	local var_65_2 = SummonMainModel.instance:entryHasFree()

	gohelper.setActive(arg_65_0._imagesummonfree, var_65_0 and var_65_2)
end

function var_0_0._refreshBgm(arg_66_0)
	local var_66_0 = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Effect/bgm")
	local var_66_1 = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_obj_b")
	local var_66_2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local var_66_3 = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(var_66_0, var_66_3 == BGMSwitchEnum.Gear.On1 and var_66_2)
	gohelper.setActive(var_66_1, var_66_2)

	if not var_66_1 then
		logError("_refreshBgm no bgmGo")
	end

	if not var_66_0 then
		logError("_refreshBgm no lightGo")
	end
end

function var_0_0.onUpdateParam(arg_67_0)
	return
end

function var_0_0.onDestroyView(arg_68_0)
	return
end

return var_0_0
