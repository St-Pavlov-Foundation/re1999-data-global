-- chunkname: @modules/logic/main/view/MainView.lua

module("modules.logic.main.view.MainView", package.seeall)

local MainView = class("MainView", BaseView)

function MainView:onInitView()
	self._golightspinecontrol = gohelper.findChild(self.viewGO, "#go_lightspinecontrol")
	self._btnquest = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_quest")
	self._gotaskreddot = gohelper.findChild(self.viewGO, "left/#btn_quest/#go_taskreddot")
	self._btnstorage = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_storage")
	self._godeadline = gohelper.findChild(self.viewGO, "left/#btn_storage/#go_deadline")
	self._godeadlineEffect = gohelper.findChild(self.viewGO, "left/#btn_storage/#go_deadline/#effect")
	self._imagetimebg = gohelper.findChildImage(self.viewGO, "left/#btn_storage/#go_deadline/timebg")
	self._txttime = gohelper.findChildText(self.viewGO, "left/#btn_storage/#go_deadline/#txt_time")
	self._imagetimeicon = gohelper.findChildImage(self.viewGO, "left/#btn_storage/#go_deadline/#txt_time/timeicon")
	self._txtformat = gohelper.findChildText(self.viewGO, "left/#btn_storage/#go_deadline/#txt_time/#txt_format")
	self._gostoragereddot = gohelper.findChild(self.viewGO, "left/#btn_storage/#go_storagereddot")
	self._btnbank = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_bank")
	self._gobankreddot = gohelper.findChild(self.viewGO, "left/#btn_bank/#go_bankreddot")
	self._godeadlinebank = gohelper.findChild(self.viewGO, "left/#btn_bank/#go_deadlinebank")
	self._gobankeffect = gohelper.findChild(self.viewGO, "left/#btn_bank/#go_bankeffect")
	self._goright = gohelper.findChild(self.viewGO, "right")
	self._btnroom = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_room")
	self._goroomlock = gohelper.findChild(self.viewGO, "right/#btn_room/#go_roomlock")
	self._goroomreddot = gohelper.findChild(self.viewGO, "right/#btn_room/#go_roomreddot")
	self._gogreendot = gohelper.findChild(self.viewGO, "right/#btn_room/#go_roomreddot/#go_greendot")
	self._goreddot = gohelper.findChild(self.viewGO, "right/#btn_room/#go_roomreddot/#go_reddot")
	self._goroomgiftreddot = gohelper.findChild(self.viewGO, "right/#btn_room/#go_v1a9actroom")
	self._gobanners = gohelper.findChild(self.viewGO, "left/#go_banners")
	self._goactivity = gohelper.findChild(self.viewGO, "left/#go_activity")
	self._btnswitchrole = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_switchrole")
	self._gothumbnialreddot = gohelper.findChild(self.viewGO, "left/#btn_switchrole/#go_thumbnailreddot")
	self._btnplayerinfo = gohelper.findChildButtonWithAudio(self.viewGO, "left_top/playerinfos/info/#btn_playerinfo")
	self._imageslider = gohelper.findChildImage(self.viewGO, "left_top/playerinfos/info/#image_slider")
	self._txtname = gohelper.findChildText(self.viewGO, "left_top/playerinfos/txtContainer/#txt_name")
	self._txtid = gohelper.findChildText(self.viewGO, "left_top/playerinfos/txtContainer/#txt_id")
	self._txtlevel = gohelper.findChildText(self.viewGO, "left_top/playerinfos/txtContainer/layout/#txt_level")
	self._goplayerreddot = gohelper.findChild(self.viewGO, "left_top/#go_reddot")
	self._btnmail = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_mail")
	self._gomailreddot = gohelper.findChild(self.viewGO, "left/#btn_mail/#go_mailreddot")

	local guideGMNode = GMController.instance:getGMNode("mainview", gohelper.findChild(self.viewGO, "left_top/btns"))

	if guideGMNode then
		self._btngm = gohelper.findChildButtonWithAudio(guideGMNode, "#btn_gm")
	end

	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")
	self._btnpower = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_power")
	self._btnrole = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_role")
	self._btnsummon = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_summon")
	self._btncopost = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_copost")
	self._gocopostred = gohelper.findChild(self.viewGO, "right/#btn_copost/#go_reddot")
	self._imagesummonfree = gohelper.findChildImage(self.viewGO, "right/#btn_summon/#image_free")
	self._imagesummonreddot = gohelper.findChildImage(self.viewGO, "right/#btn_summon/#image_summonreddot")
	self._txtpower = gohelper.findChildText(self.viewGO, "right/txtContainer/#txt_power")
	self._gospinescale = gohelper.findChild(self.viewGO, "#go_spine_scale")
	self._golightspine = gohelper.findChild(self.viewGO, "#go_spine_scale/lightspine/#go_lightspine")
	self._gocontentbg = gohelper.findChild(self.viewGO, "bottom/#go_contentbg")
	self._txtanacn = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_cn")
	self._txtanaen = gohelper.findChildText(self.viewGO, "bottom/#txt_ana_en")
	self._btnhide = gohelper.findChildButtonWithAudio(self.viewGO, "left/#btn_hide")
	self._btnbgm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_bgm")
	self._gobgmnone = gohelper.findChild(self.viewGO, "#btn_bgm/none")
	self._gobgmplay = gohelper.findChild(self.viewGO, "#btn_bgm/playing")
	self._btnlimitedshow = gohelper.findChildButtonWithAudio(self.viewGO, "limitedshow/#btn_limitedshow")
	self._golimitedshow = gohelper.findChild(self.viewGO, "limitedshow")
	self._pcBtnHide = gohelper.findChild(self._btnhide.gameObject, "#go_pcbtn")
	self._pcBtnRoom = gohelper.findChild(self._btnroom.gameObject, "#go_pcbtn")
	self._pcBtnCharactor = gohelper.findChild(self._btnrole.gameObject, "#go_pcbtn")
	self._pcBtnSummon = gohelper.findChild(self._btnsummon.gameObject, "#go_pcbtn")

	gohelper.setActive(self._btnlimitedshow.gameObject, true)
	gohelper.setActive(self._golimitedshow, false)

	self._showMainView = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MainView:addEvents()
	self._btnquest:AddClickListener(self._btnquestOnClick, self)
	self._btnstorage:AddClickListener(self._btnstorageOnClick, self)
	self._btnbank:AddClickListener(self._btnbankOnClick, self)
	self._btnroom:AddClickListener(self._btnroomOnClick, self)
	self._btnswitchrole:AddClickListener(self._btnswitchroleOnClick, self)
	self._btnplayerinfo:AddClickListener(self._btnplayerinfoOnClick, self)
	self._btnmail:AddClickListener(self._btnmailOnClick, self)

	if self._btngm then
		self._btngm:AddClickListener(self._btngmOnClick, self)
	end

	self._btnpower:AddClickListener(self._btnpowerOnClick, self)
	self._btnrole:AddClickListener(self._btnroleOnClick, self)
	self._btnsummon:AddClickListener(self._btnsummonOnClick, self)
	self._btncopost:AddClickListener(self._btncopostOnClick, self)
	self._btnhide:AddClickListener(self._btnhideOnClick, self)
	self._btnbgm:AddClickListener(self._btnbgmOnClick, self)
	self._btnlimitedshow:AddClickListener(self._btnlimitedshowOnClick, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifySetMainViewVisible, self.OnNotifySetMainViewVisible, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRoom, self.OnNotifyEnterRoom, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRole, self.OnNotifyEnterRole, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSummon, self.OnNotifyEnterSummon, self)
	self:addEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, self.showKeyTips, self)
	self:addEventCb(SignInController.instance, SignInEvent.GetSignInReply, self._onReceiveSupplementMonthCardReply, self)
end

function MainView:removeEvents()
	self._btnquest:RemoveClickListener()
	self._btnstorage:RemoveClickListener()
	self._btnbank:RemoveClickListener()
	self._btnroom:RemoveClickListener()
	self._btnswitchrole:RemoveClickListener()
	self._btnplayerinfo:RemoveClickListener()
	self._btnmail:RemoveClickListener()

	if self._btngm then
		self._btngm:RemoveClickListener()
	end

	self._btnpower:RemoveClickListener()
	self._btnrole:RemoveClickListener()
	self._btnsummon:RemoveClickListener()
	self._btncopost:RemoveClickListener()
	self._btnhide:RemoveClickListener()
	self._btnbgm:RemoveClickListener()
	self._btnlimitedshow:RemoveClickListener()
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifySetMainViewVisible, self.OnNotifySetMainViewVisible, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRoom, self.OnNotifyEnterRoom, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterRole, self.OnNotifyEnterRole, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEnterSummon, self.OnNotifyEnterSummon, self)
	self:removeEventCb(SettingsController.instance, SettingsEvent.OnKeyTipsChange, self.showKeyTips, self)
end

function MainView:_btnhideOnClick()
	MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, false)

	local limitedCO = LimitedRoleController.instance:getNeedPlayLimitedCO()

	gohelper.setActive(self._golimitedshow, limitedCO ~= nil)

	self.viewContainer._canvasGroup.interactable = limitedCO ~= nil
end

function MainView:OnNotifySetMainViewVisible()
	if self._showMainView then
		self:_btnhideOnClick()
	else
		GameStateMgr.instance:dispatchEvent(GameStateEvent.OnTouchScreenUp)
	end
end

function MainView:showKeyTips()
	PCInputController.instance:showkeyTips(self._pcBtnHide, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.hide)
	PCInputController.instance:showkeyTips(self._pcBtnRoom, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Room)
	PCInputController.instance:showkeyTips(self._pcBtnCharactor, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Role)
	PCInputController.instance:showkeyTips(self._pcBtnSummon, PCInputModel.Activity.MainActivity, PCInputModel.MainActivityFun.Summon)
end

function MainView:_btnbgmOnClick()
	self._animator:Play("mainview_bgm", 0, 0)
	BGMSwitchController.instance:openBGMSwitchView()
end

function MainView:_btnlimitedshowOnClick()
	local limitedCO = LimitedRoleController.instance:getNeedPlayLimitedCO()

	if limitedCO then
		LimitedRoleController.instance:play(LimitedRoleEnum.Stage.MainVisibleClick, limitedCO)
		MainController.instance:dispatchEvent(MainEvent.SetMainViewVisible, true)
		gohelper.setActive(self._golimitedshow, false)
	end
end

function MainView:_setViewVisible(value)
	local isStr = LuaUtil.isString(value)

	if isStr then
		value = value == "true"
	end

	self._showMainView = value

	gohelper.setActive(self._pcBtnHide, value)
	self._animator:Play(value and "mainview_in" or "mainview_out", 0, 0)

	self.viewContainer._canvasGroup.interactable = value

	if value then
		gohelper.setActive(self._golimitedshow, false)
	end
end

function MainView:_setViewRootVisible(value)
	TaskDispatcher.cancelTask(self._hideViewRoot, self)

	if value then
		self.viewContainer:_setVisible(true)
		gohelper.setActive(self.viewGO, value)
	else
		self.viewContainer:_setVisible(false)
		TaskDispatcher.runDelay(self._hideViewRoot, self, 1)
	end
end

function MainView:_hideViewRoot()
	gohelper.setActive(self.viewGO, false)
end

function MainView:_btnsummonOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Summon) then
		SummonController.instance:enterSummonScene()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Summon))
	end
end

function MainView:_btncopostOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.CommandStation) then
		CommandStationController.instance:openCommandStationEnterAnimView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.CommandStation))
	end
end

function MainView:OnNotifyEnterSummon()
	self:_btnsummonOnClick()
end

function MainView:_btnswitchroleOnClick()
	if Time.realtimeSinceStartup - self._openMainThumbnailTime <= 0.2 then
		return
	end

	MainController.instance:dispatchEvent(MainEvent.ForceStopVoice)

	self._openMainThumbnailTime = Time.realtimeSinceStartup

	TaskDispatcher.cancelTask(self._delayOpenMainThumbnailView, self)
	TaskDispatcher.runDelay(self._delayOpenMainThumbnailView, self, 0)
end

function MainView:_delayOpenMainThumbnailView()
	MainController.instance:openMainThumbnailView()
end

function MainView:_btnbankOnClick()
	StoreController.instance:checkAndOpenStoreView()
end

function MainView:_btnpowerOnClick()
	CurrencyController.instance:openPowerView()
end

function MainView:onOpen()
	UnityEngine.Shader.DisableKeyword("_TRANSVERSEALPHA_ON")
	self:_refreshGMBtn()
	self:_refreshBtns()
	WeatherController.instance:playAnim("s01_character_switch_in")
	MainController.instance:dispatchEvent(MainEvent.ShowMainView)
	self:_updateRedDot()
	TowerController.instance:dailyReddotRefresh()
end

function MainView:_updateRedDot()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.RoomBtn
	})
end

function MainView:_refreshGMBtn()
	if self._btngm then
		gohelper.setActive(self._btngm.gameObject, GMController.instance:isOpenGM())
	end
end

function MainView:_refreshBtns()
	local taskShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Task)

	gohelper.setActive(self._btnquest.gameObject, taskShow)

	local storageShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Storage)

	gohelper.setActive(self._btnstorage.gameObject, storageShow)

	local bankShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Bank)

	gohelper.setActive(self._btnbank.gameObject, bankShow)

	local roomShow = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Room)

	gohelper.setActive(self._btnroom.gameObject, roomShow)

	local isUnLockRoom = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room)

	self._roomCanvasGroup.alpha = isUnLockRoom and 1 or 0.65

	gohelper.setActive(self._goroomlock, not isUnLockRoom)
	gohelper.setActive(self._btnmail.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Mail))
	gohelper.setActive(self._btnsummon.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon))
	gohelper.setActive(self._btncopost.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.CommandStation) and not VersionValidator.instance:isInReviewing())
	gohelper.setActive(self._btnrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Role))
	gohelper.setActive(self._btnswitchrole.gameObject, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.MainThumbnail))
end

function MainView:_setBtnPos(btns)
	for k, v in ipairs(btns) do
		transformhelper.setLocalPosXY(v.transform, 60 + 85 * math.fmod(k - 1, 2), 195 - 85 * k)
	end
end

function MainView:_btnplayerinfoOnClick()
	local playerInfo = PlayerModel.instance:getPlayinfo()

	PlayerController.instance:openPlayerView(playerInfo, true)
end

function MainView:_btngmOnClick()
	ViewMgr.instance:openView(ViewName.GMToolView)
end

function MainView:_btnmailOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Mail) then
		MailController.instance:open()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Setting))
	end
end

function MainView:_btnquestOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Task) then
		TaskController.instance:enterTaskView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Task))
	end
end

function MainView:_btnstorageOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Storage) then
		local function cb()
			BackpackController.instance:enterItemBackpack()
		end

		ItemRpc.instance:sendGetPowerMakerInfoRequest(false, false, cb, self)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Storage))
	end
end

function MainView:_btnroomOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Room) then
		RoomController.instance:enterRoom(RoomEnum.GameMode.Ob)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Room))
	end
end

function MainView:OnNotifyEnterRoom()
	self:_btnroomOnClick()
end

function MainView:_btnroleOnClick()
	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Role) then
		CharacterController.instance:enterCharacterBackpack()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Role))
	end
end

function MainView:OnNotifyEnterRole()
	self:_btnroleOnClick()
end

function MainView:_btnvisitOnClick()
	return
end

function MainView:_btncostOnClick()
	return
end

function MainView:_OnDailyRefresh()
	local _, storeIds = StoreHelper.getRecommendStoreSecondTabConfig()

	if storeIds and #storeIds > 0 then
		StoreRpc.instance:sendGetStoreInfosRequest(storeIds)
	end

	ActivityRpc.instance:sendGetActivityInfosRequest()
	RedDotRpc.instance:sendGetRedDotInfosRequest({
		RedDotEnum.DotNode.VersionActivityEnterRedDot
	})
	PlayerController.instance:updateAssistRewardCount()
end

function MainView:_editableInitView()
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self:addEventCb(PlayerController.instance, PlayerEvent.ChangePlayerinfo, self._setPlayerInfo, self)
	self:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshBackpack, self)
	self:addEventCb(SummonController.instance, SummonEvent.onNewPoolChanged, self._refreshSummonNewFlag, self)
	self:addEventCb(SummonController.instance, SummonEvent.onSummonInfoGot, self._refreshSummonNewFlag, self)
	self:addEventCb(RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self._refreshSummonNewFlag, self)
	self:addEventCb(MainController.instance, MainEvent.OnFuncUnlockRefresh, self._refreshBtns, self)
	self:addEventCb(MainController.instance, MainEvent.OnChangeGMBtnStatus, self._refreshGMBtn, self)
	self:addEventCb(MainController.instance, MainEvent.SetMainViewVisible, self._setViewVisible, self)
	self:addEventCb(MainController.instance, MainEvent.SetMainViewRootVisible, self._setViewRootVisible, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, self._onOpenFullView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
	self:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnDailyRefresh, self._OnDailyRefresh, self)
	self:addEventCb(BGMSwitchController.instance, BGMSwitchEvent.SelectPlayGear, self._refreshBgm, self)
	self:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.StartSwitchScene, self._onStartSwitchScene, self)
	self:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchSceneFinish, self._onSwitchSceneFinish, self)
	self:addEventCb(SignInController.instance, SignInEvent.OnReceiveSupplementMonthCardReply, self._onReceiveSupplementMonthCardReply, self)
	self:addEventCb(NoticeController.instance, NoticeEvent.OnRefreshRedDot, self._onRefreshNoticeRedDot, self)
	self:addEventCb(NoticeController.instance, NoticeEvent.OnGetNoticeInfo, self._onRefreshNoticeRedDot, self)
	self:addEventCb(PlayerController.instance, PlayerEvent.UpdateAssistRewardCount, self._onUpdateAssistRewardCount, self)

	self._imagesummonnews = self:getUserDataTb_()

	for _, skinId in pairs(MainUISwitchEnum.Skin) do
		local newName = string.format("right/#btn_summon/%s/#image_summonnew", skinId)
		local new = gohelper.findChild(self.viewGO, newName)

		table.insert(self._imagesummonnews, new)
	end

	self:_refreshRedDot()
	self:_refreshPower()
	self:_refreshBgm()
	self:_refreshBackpack()
	self:_refreshSummonNewFlag()
	self:_setPlayerInfo(PlayerModel.instance:getPlayinfo())
	self:_updateMainSceneClothes()
	self:showKeyTips()

	local audioEnum = AudioEnum.UI

	gohelper.addUIClickAudio(self._btnstorage.gameObject, audioEnum.Play_UI_Warehouse)
	gohelper.addUIClickAudio(self._btnroom.gameObject, audioEnum.play_ui_moor_open)
	gohelper.addUIClickAudio(self._btnhide.gameObject, audioEnum.play_ui_main_shield)
	gohelper.addUIClickAudio(self._btnswitchrole.gameObject, audioEnum.play_ui_thumbnail_click)
	gohelper.addUIClickAudio(self._btnsummon.gameObject, audioEnum.play_ui_callfor_open)
	gohelper.addUIClickAudio(self._btncopost.gameObject, audioEnum.play_ui_role_open)
	gohelper.addUIClickAudio(self._btnquest.gameObject, audioEnum.UI_Mission_open)
	gohelper.addUIClickAudio(self._btnbank.gameObject, audioEnum.play_ui_bank_open)
	gohelper.addUIClickAudio(self._btnrole.gameObject, audioEnum.play_ui_role_open)
	gohelper.addUIClickAudio(self._btnplayerinfo.gameObject, audioEnum.Play_UI_Magazines)
	gohelper.addUIClickAudio(self._btnpower.gameObject, audioEnum.Play_UI_Enterhuoxing)
	gohelper.addUIClickAudio(self._btnmail.gameObject, audioEnum.UI_Mail_open)

	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._cameraAnimator = CameraMgr.instance:getCameraRootAnimator()
	self._cameraAnimator.speed = 1
	self._animatorRight = gohelper.findChildComponent(self.viewGO, "right", typeof(UnityEngine.Animator))
	self._openOtherView = false
	self._goroomImage = gohelper.findChild(self.viewGO, "right/#btn_room")
	self._roomCanvasGroup = gohelper.onceAddComponent(self._goroomImage, typeof(UnityEngine.CanvasGroup))
	self._openMainThumbnailTime = Time.realtimeSinceStartup
end

function MainView:_refreshRedDot()
	RedDotController.instance:addRedDot(self._gotaskreddot, RedDotEnum.DotNode.TaskBtn)
	RedDotController.instance:addRedDot(self._gomailreddot, RedDotEnum.DotNode.MailBtn)
	RedDotController.instance:addRedDot(self._gocopostred, RedDotEnum.DotNode.CommandStationMain)

	self._redBank = RedDotController.instance:addRedDot(self._gobankreddot, RedDotEnum.DotNode.StoreBtn, nil, self.storeRedDotRefreshFunc, self)

	RedDotController.instance:addRedDotTag(self._goreddot, RedDotEnum.DotNode.MainRoomProductionFull)
	RedDotController.instance:addRedDotTag(self._gogreendot, RedDotEnum.DotNode.MainRoomCharacterFaithGetFull)
	RedDotController.instance:addRedDotTag(self._goroomgiftreddot, RedDotEnum.DotNode.RoomGift)

	self.playerRedDot = RedDotController.instance:addMultiRedDot(self._goplayerreddot, {}, self.playerRedDotRefreshFunc, self)
	self.thumbnailRedDot = RedDotController.instance:addMultiRedDot(self._gothumbnialreddot, {
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
	}, self.thumbnailRedDotRefreshFunc, self)
end

function MainView:_onUpdateAssistRewardCount()
	self:playerRedDotRefreshFunc(self.playerRedDot)
	self:thumbnailRedDotRefreshFunc(self.thumbnailRedDot)
end

function MainView:playerRedDotRefreshFunc(redDotIcon)
	redDotIcon:defaultRefreshDot()

	if not redDotIcon.show then
		local isHasAssistReward = PlayerModel.instance:isHasAssistReward()

		redDotIcon.show = isHasAssistReward

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function MainView:_onRefreshNoticeRedDot()
	self:thumbnailRedDotRefreshFunc(self.thumbnailRedDot)
end

function MainView:thumbnailRedDotRefreshFunc(redDotIcon)
	redDotIcon:defaultRefreshDot()

	local isShow = redDotIcon.show

	if not isShow then
		isShow = isShow or NoticeModel.instance:hasNotRedNotice()
		isShow = isShow or PlayerModel.instance:isHasAssistReward()
		isShow = isShow or BGMSwitchController.instance:hasBgmRedDot()
		isShow = isShow or LifeCircleController.instance:isShowRed()
		isShow = isShow or HandbookController.instance:hasAnyHandBookSkinGroupRedDot()
		isShow = isShow or FightUISwitchModel.instance:isNewUnlockStyle()
		isShow = isShow or ClickUISwitchModel.instance:hasReddot()
		redDotIcon.show = isShow

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end
end

function MainView:showBankNewEffect(state)
	gohelper.setActive(self._gobankeffect, state)
end

function MainView:storeRedDotRefreshFunc(redDotIcon)
	redDotIcon:defaultRefreshDot()
	self:showBankNewEffect(false)

	if not redDotIcon.show and StoreModel.instance:isHasTaskGoodsReward() then
		redDotIcon.show = true

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
		self:showStoreDeadline(false)
		self:registStoreDeadlineCall(false)

		return
	end

	if SignInModel.instance:getCanSupplementMonthCardDays() > 0 then
		redDotIcon.show = true

		redDotIcon:showRedDot(RedDotEnum.Style.SupplementMonthCard)
		self:showStoreDeadline(false)
		self:registStoreDeadlineCall(false)
		self:showBankNewEffect(true)

		return
	end

	local recommendStoreConfigList = StoreHelper.getRecommendStoreSecondTabConfig()

	for _, v in ipairs(recommendStoreConfigList) do
		if StoreController.instance:isNeedShowRedDotNewTag(v) and not StoreController.instance:isEnteredRecommendStore(v.id) then
			redDotIcon.show = true

			redDotIcon:showRedDot(RedDotEnum.Style.NewTag)
			redDotIcon:SetRedDotTrsWithType(RedDotEnum.Style.NewTag, 9.7, 4.2)
			self:showStoreDeadline(false)
			self:registStoreDeadlineCall(false)
			self:showBankNewEffect(true)

			return
		end
	end

	local storedotinfos = StoreModel.instance:getAllRedDotInfo()

	if storedotinfos then
		local showNew = false

		for _, v in pairs(storedotinfos) do
			local goodsMo = StoreModel.instance:getGoodsMO(v.uid)

			if goodsMo then
				local isPerMonthLimit = goodsMo.refreshTime == StoreEnum.ChargeRefreshTime.Month
				local isPerWeekLimit = goodsMo.refreshTime == StoreEnum.ChargeRefreshTime.Week

				showNew = isPerWeekLimit or isPerMonthLimit

				local isPackageStore = StoreConfig.instance:isPackageStore(goodsMo.belongStoreId)

				if isPackageStore then
					local serverTime = ServerTime.now()

					showNew = serverTime >= goodsMo.newStartTime and serverTime <= goodsMo.newEndTime
				end

				if goodsMo.belongStoreId == StoreEnum.StoreId.Skin then
					showNew = true
				end
			end

			if showNew then
				break
			end
		end

		if showNew then
			redDotIcon.show = true

			redDotIcon:showRedDot(RedDotEnum.Style.NewTag)
			redDotIcon:SetRedDotTrsWithType(RedDotEnum.Style.NewTag, 9.7, 4.2)
			self:showBankNewEffect(true)
		end

		self:showStoreDeadline(not showNew and not redDotIcon.show)
		self:registStoreDeadlineCall(not showNew and not redDotIcon.show)

		return
	end

	if not redDotIcon.show and StoreModel.instance:isRedTabReadOnceClient(StoreEnum.StoreId.EventPackage) then
		redDotIcon.show = true

		redDotIcon:showRedDot(RedDotEnum.Style.Normal)
	end

	self:registStoreDeadlineCall(true)
	self:showStoreDeadline(true)
end

function MainView:registStoreDeadlineCall(isRegist)
	if not self._isStoreDeadlineRunning and isRegist then
		TaskDispatcher.runRepeat(self.showStoreDeadline, self, 1)

		self._isStoreDeadlineRunning = true
	elseif self._isStoreDeadlineRunning and not isRegist then
		TaskDispatcher.cancelTask(self.showStoreDeadline, self)

		self._isStoreDeadlineRunning = false
	end
end

function MainView:showStoreDeadline(needShow)
	if not self.viewGO then
		return
	end

	local deadlineItem = self:getOrCreateStoreDeadline()

	deadlineItem.needShow = needShow or deadlineItem.needShow

	if deadlineItem.needShow then
		local deadlineHasDay = false
		local storeEntranceCfg = StoreConfig.instance:getTabConfig(StoreEnum.StoreId.LimitStore)
		local deadlineTimeSec = 0

		if storeEntranceCfg then
			local sec = StoreHelper.getRemainExpireTime(storeEntranceCfg)

			if sec and sec > 0 and sec <= TimeUtil.OneDaySecond * 7 then
				deadlineTimeSec = sec
			end
		end

		local decorateSec = StoreHelper.getRemainExpireTimeDeepByStoreId(StoreEnum.StoreId.DecorateStore)

		if decorateSec > 0 and decorateSec < TimeUtil.OneWeekSecond then
			deadlineTimeSec = deadlineTimeSec <= 0 and decorateSec or Mathf.Min(decorateSec, deadlineTimeSec)
		end

		if deadlineTimeSec > 0 then
			gohelper.setActive(deadlineItem.godeadline, true)
			gohelper.setActive(deadlineItem.txttime.gameObject, true)

			deadlineItem.txttime.text, deadlineItem.txtformat.text, deadlineHasDay = TimeUtil.secondToRoughTime(math.floor(deadlineTimeSec), true)

			UISpriteSetMgr.instance:setCommonSprite(deadlineItem.imagetimebg, deadlineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(deadlineItem.imagetimeicon, deadlineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(deadlineItem.txttime, deadlineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(deadlineItem.txtformat, deadlineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(deadlineItem.godeadlineEffect, not deadlineHasDay)

			return
		end
	end

	gohelper.setActive(deadlineItem.godeadline, false)
	gohelper.setActive(deadlineItem.txttime.gameObject, false)
end

function MainView:getOrCreateStoreDeadline()
	if not self._deadlineStore then
		self._deadlineStore = self:getUserDataTb_()
		self._deadlineStore.godeadline = self._godeadlinebank
		self._deadlineStore.godeadlineEffect = gohelper.findChild(self._deadlineStore.godeadline, "#effect")
		self._deadlineStore.txttime = gohelper.findChildText(self._deadlineStore.godeadline, "#txt_time")
		self._deadlineStore.txtformat = gohelper.findChildText(self._deadlineStore.godeadline, "#txt_time/#txt_format")
		self._deadlineStore.imagetimebg = gohelper.findChildImage(self._deadlineStore.godeadline, "timebg")
		self._deadlineStore.imagetimeicon = gohelper.findChildImage(self._deadlineStore.godeadline, "#txt_time/timeicon")
	end

	return self._deadlineStore
end

function MainView:_setPlayerInfo(playerinfo)
	local level = playerinfo.level

	self._txtlevel.text = playerinfo.level
	self._txtname.text = playerinfo.name
	self._txtid.text = "ID:" .. playerinfo.userId

	local exp_now = playerinfo.exp
	local exp_max = 0

	if level < CommonConfig.instance:getConstNum(ConstEnum.PlayerMaxLev) then
		exp_max = PlayerConfig.instance:getPlayerLevelCO(level + 1).exp
	else
		exp_max = PlayerConfig.instance:getPlayerLevelCO(level).exp
		exp_now = exp_max
	end

	self._imageslider.fillAmount = exp_now / exp_max

	if self._lastUpdateLevel ~= playerinfo.level then
		self._lastUpdateLevel = playerinfo.level
	end

	self:_refreshPower()
end

function MainView:_onCloseViewFinish(viewName)
	if viewName == ViewName.MainThumbnailView then
		self._startCheckTime = Time.realtimeSinceStartup

		TaskDispatcher.cancelTask(self._checkCamera, self)
		TaskDispatcher.runRepeat(self._checkCamera, self, 0)
		LateUpdateBeat:Add(self._forceUpdateCameraPos, self)
	end

	if viewName ~= ViewName.LoadingView then
		self:_tryDoMainViewGuide()
	end
end

function MainView:_forceUpdateCameraPos()
	self._openMainThumbnailTime = Time.realtimeSinceStartup

	local trace = CameraMgr.instance:getCameraTrace()

	trace.EnableTrace = true
	trace.EnableTrace = false
	trace.enabled = false
end

function MainView:_checkCamera()
	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	if not self._cameraAnimator.enabled or Time.realtimeSinceStartup - self._startCheckTime >= 2 then
		TaskDispatcher.cancelTask(self._checkCamera, self)

		local cameraGo = CameraMgr.instance:getCameraRootGO()

		transformhelper.setLocalPos(cameraGo.transform, 0, 0, 0)
		self:_forceUpdateCameraPos()
		LateUpdateBeat:Remove(self._forceUpdateCameraPos, self)
	end
end

function MainView:_onCloseView()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if GameSceneMgr.instance:isClosing() then
		return
	end

	if not self._openOtherView then
		return
	end

	if not self:_hasOpenedOtherView() then
		self:_tryDoMainViewGuide()
		self:_updateRedDot()
		PlayerController.instance:updateAssistRewardCount()
	end
end

function MainView:_onOpenView()
	if self:_hasOpenedOtherView() then
		self._openOtherView = true
	end
end

function MainView:_hasOpenedOtherView()
	local openViewNameList = ViewMgr.instance:getOpenViewNameList()

	openViewNameList = NavigateMgr.sortOpenViewNameList(openViewNameList)

	for i = #openViewNameList, 1, -1 do
		local openViewName = openViewNameList[i]
		local viewSetting = ViewMgr.instance:getSetting(openViewName)
		local viewContainer = ViewMgr.instance:getContainer(openViewName)

		if openViewName == ViewName.MainView then
			return false
		elseif viewSetting.layer == "POPUP_TOP" or viewSetting.layer == "POPUP" or viewSetting.layer == "HUD" then
			return true
		end
	end

	return true
end

function MainView:_onCloseFullView(viewName)
	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		self.viewContainer:_setVisible(false)

		return
	end

	if viewName == ViewName.DungeonView or viewName == ViewName.DungeonMapView then
		self:_updateMainSceneClothes()
	end

	if viewName == ViewName.BackpackView or viewName == ViewName.StoreView then
		return
	end

	local immediate = ViewMgr.instance:isOpen(ViewName.MailView) or ViewMgr.instance:isOpen(ViewName.TaskView)

	if self.viewGO.gameObject.activeInHierarchy then
		if self._animator then
			self._animator:Play("mainview_in", 0, immediate and 1 or 0)
		end

		if self._animatorRight then
			self._animatorRight:Play("mainview_right", 0, immediate and 1 or 0)
		end

		local animatorCurrency = gohelper.findChildComponent(self.viewGO, "#go_righttop/currencyview(Clone)", typeof(UnityEngine.Animator))

		if animatorCurrency then
			animatorCurrency:Play("currencyview_in", 0, immediate and 1 or 0)
		end
	end

	WeatherController.instance:playAnim("s01_character_switch_in")

	if self.viewContainer._isVisible then
		MainController.instance:dispatchEvent(MainEvent.ShowMainView)
	end
end

function MainView:_onOpenFullView(viewName)
	if viewName == ViewName.BackpackView or viewName == ViewName.StoreView then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.MainThumbnailView) then
		return
	end

	if self.viewGO.gameObject.activeInHierarchy then
		if self._animator then
			if viewName == ViewName.CharacterBackpackView then
				self._animator:Play("mainview_in_hero", 0, 0)
			else
				self._animator:Play("mainview_out", 0, 0)
			end
		end

		local animatorCurrency = gohelper.findChildComponent(self.viewGO, "#go_righttop/currencyview(Clone)", typeof(UnityEngine.Animator))

		if animatorCurrency then
			animatorCurrency:Play("currencyview_out", 0, 0)
		end
	end
end

function MainView:_onStartSwitchScene()
	return
end

function MainView:_onSwitchSceneFinish()
	self._showMainSceneClothes = nil
	self._clothesGo = nil

	self:_updateMainSceneClothes()
	self:_refreshBgm()
end

function MainView:_updateMainSceneClothes()
	if self._showMainSceneClothes then
		return
	end

	local episodeId = CommonConfig.instance:getConstNum(ConstEnum.MainSceneClothesEpisodeId)
	local showMainSceneClothes = DungeonModel.instance:hasPassLevelAndStory(episodeId)

	if self._showMainSceneClothes ~= showMainSceneClothes then
		self._showMainSceneClothes = showMainSceneClothes

		if not self._clothesGo then
			self._clothesGo = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_C_Obj_a/yifu")

			if not self._clothesGo then
				logError("_updateMainSceneClothes no clothesGo")
			end
		end

		gohelper.setActive(self._clothesGo, showMainSceneClothes)
	end
end

function MainView:_refreshBackpack()
	self._itemDeadline = BackpackModel.instance:getItemDeadline()
	self._laststorageDeadLineHasDay = nil

	self:_onRefreshDeadline()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)

	if self._itemDeadline then
		TaskDispatcher.runRepeat(self._onRefreshDeadline, self, 1)
	end
end

function MainView:_onRefreshDeadline()
	if self._itemDeadline and self._itemDeadline > 0 then
		gohelper.setActive(self._txttime.gameObject, true)

		local limitSec = self._itemDeadline - ServerTime.now()

		if limitSec <= 0 then
			ItemRpc.instance:autoUseExpirePowerItem()
			gohelper.setActive(self._godeadline, false)

			return
		end

		self._txttime.text, self._txtformat.text, self._storageDeadLineHasDay = TimeUtil.secondToRoughTime(math.floor(limitSec), true)

		gohelper.setActive(self._godeadline, true)

		if self._laststorageDeadLineHasDay == nil or self._laststorageDeadLineHasDay ~= self._storageDeadLineHasDay then
			UISpriteSetMgr.instance:setCommonSprite(self._imagetimebg, self._storageDeadLineHasDay and "daojishi_01" or "daojishi_02")
			UISpriteSetMgr.instance:setCommonSprite(self._imagetimeicon, self._storageDeadLineHasDay and "daojishiicon_01" or "daojishiicon_02")
			SLFramework.UGUI.GuiHelper.SetColor(self._txttime, self._storageDeadLineHasDay and "#98D687" or "#E99B56")
			SLFramework.UGUI.GuiHelper.SetColor(self._txtformat, self._storageDeadLineHasDay and "#98D687" or "#E99B56")
			gohelper.setActive(self._godeadlineEffect, not self._storageDeadLineHasDay)

			self._laststorageDeadLineHasDay = self._storageDeadLineHasDay
		end
	else
		gohelper.setActive(self._godeadline, false)
		gohelper.setActive(self._txttime.gameObject, false)
	end
end

function MainView:_tryDoMainViewGuide()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if GameSceneMgr.instance:isClosing() then
		return
	end

	local hasNoOhterView = not self:_hasOpenedOtherView()
	local inPopupFlow = MainController.instance:isInPopupFlow()

	if hasNoOhterView and not inPopupFlow then
		local mainViewGuideId = tonumber(GuideModel.instance:getFlagValue(GuideModel.GuideFlag.MainViewGuideId))

		if mainViewGuideId and mainViewGuideId > 0 then
			local condition = MainViewGuideCondition.getCondition(mainViewGuideId)
			local conditionPass = condition == nil and true or condition()

			if conditionPass then
				GuideController.instance:dispatchEvent(GuideEvent.DoMainViewGuide, mainViewGuideId)
			end
		end
	end
end

function MainView:onClose()
	TaskDispatcher.cancelTask(self._onRefreshDeadline, self)
	TaskDispatcher.cancelTask(self._checkCamera, self)
	LateUpdateBeat:Remove(self._forceUpdateCameraPos, self)
	TaskDispatcher.cancelTask(self._hideViewRoot, self)
	TaskDispatcher.cancelTask(self.showStoreDeadline, self)
	TaskDispatcher.cancelTask(self._delayOpenMainThumbnailView, self)
	self:registStoreDeadlineCall(false)
end

function MainView:_onCurrencyChange(changeIds)
	if not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:_refreshPower()
end

function MainView:_refreshPower()
	local level = PlayerModel.instance:getPlayinfo().level
	local recoverLimit = PlayerConfig.instance:getPlayerLevelCO(level).maxAutoRecoverPower
	local currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	local power = currencyMO and currencyMO.quantity or 0

	self._txtpower.text = string.format("%s/%s", power, recoverLimit)
end

function MainView:_refreshSummonNewFlag()
	local isSummonUnlock = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Summon)
	local hasNew = SummonMainModel.instance:entryHasNew()

	for _, new in ipairs(self._imagesummonnews) do
		gohelper.setActive(new, isSummonUnlock and hasNew)
	end

	local hasFree = SummonMainModel.instance:entryHasFree()

	gohelper.setActive(self._imagesummonfree, isSummonUnlock and hasFree)
end

function MainView:_refreshBgm()
	local lightGo = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Effect/bgm")
	local bgmGo = WeatherController.instance:getSceneNode("s01_obj_a/Anim/Obj/s01_obj_b")
	local isUnlock = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.BGMSwitch)
	local gear = BGMSwitchModel.instance:getMechineGear()

	gohelper.setActive(lightGo, gear == BGMSwitchEnum.Gear.On1 and isUnlock)
	gohelper.setActive(bgmGo, isUnlock)

	if not bgmGo then
		logError("_refreshBgm no bgmGo")
	end

	if not lightGo then
		logError("_refreshBgm no lightGo")
	end
end

function MainView:_onReceiveSupplementMonthCardReply()
	self:storeRedDotRefreshFunc(self._redBank)
end

function MainView:onUpdateParam()
	return
end

function MainView:onDestroyView()
	return
end

return MainView
