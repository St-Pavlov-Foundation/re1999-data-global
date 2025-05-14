module("modules.logic.login.view.LoginView", package.seeall)

local var_0_0 = class("LoginView", BaseView)
local var_0_1 = -8
local var_0_2 = 3
local var_0_3 = 10

function var_0_0.ctor(arg_1_0)
	arg_1_0._loginFlow = nil
	arg_1_0._httpStartGameFlow = nil
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._serverGO = gohelper.findChild(arg_2_0.viewGO, "server")
	arg_2_0._txtServerName = gohelper.findChildText(arg_2_0._serverGO, "Text")
	arg_2_0._txt_version = gohelper.findChildText(arg_2_0.viewGO, "#txt_version")
	arg_2_0._serverStateGOList = {}

	for iter_2_0 = 0, 2 do
		local var_2_0 = gohelper.findChild(arg_2_0.viewGO, "server/imgState" .. iter_2_0)

		arg_2_0._serverStateGOList[iter_2_0] = var_2_0
	end

	arg_2_0._btnServerList = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "server/btnServerList")
	arg_2_0._btnLogin = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "center_text/btnLogin")
	arg_2_0._btnPolicy = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "rightbtn_group/#btn_policy")
	arg_2_0._btnAccount = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "rightbtn_group/#btn_account")
	arg_2_0._btnNotice = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "rightbtn_group/#btn_notice")
	arg_2_0._goBtnNotice = gohelper.findChild(arg_2_0.viewGO, "rightbtn_group/#btn_notice")
	arg_2_0._btnNoticeLongPress = SLFramework.UGUI.UILongPressListener.Get(arg_2_0._goBtnNotice)
	arg_2_0._btnFix = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "rightbtn_group/#btn_fix")
	arg_2_0._btnScan = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "rightbtn_group/#btn_scan")
	arg_2_0._btnSet = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "rightbtn_group/#btn_set")
	arg_2_0._btnQuit = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "rightbtn_group/#btn_switch")
	arg_2_0._originBgGo = gohelper.find("UIRoot/OriginBg")
	arg_2_0._goClickMask = gohelper.findChild(arg_2_0.viewGO, "click_mask")
	arg_2_0._goEffect = gohelper.findChild(arg_2_0.viewGO, "imgBg/effect")
	arg_2_0._imgLogo = gohelper.findChildSingleImage(arg_2_0.viewGO, "logo")
	arg_2_0._btnAgeFit = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "leftbtn/#btn_agefit")
	arg_2_0._btnexit = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "rightbtn_group/#btn_exit")
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnServerList:AddClickListener(arg_3_0._onClickServerList, arg_3_0)
	arg_3_0._btnLogin:AddClickListener(arg_3_0._onClickLogin, arg_3_0)
	arg_3_0._btnAccount:AddClickListener(arg_3_0._onClickAccount, arg_3_0)
	arg_3_0._btnNotice:AddClickListener(arg_3_0._onClickNotice, arg_3_0)
	arg_3_0._btnFix:AddClickListener(arg_3_0._onClickFix, arg_3_0)
	arg_3_0._btnScan:AddClickListener(arg_3_0._onClickScan, arg_3_0)
	arg_3_0._btnPolicy:AddClickListener(arg_3_0._onClickPolicy, arg_3_0)
	arg_3_0._btnAgeFit:AddClickListener(arg_3_0._onClickAgeFit, arg_3_0)
	arg_3_0._btnexit:AddClickListener(arg_3_0.exit, arg_3_0)
	arg_3_0:addEventCb(LoginController.instance, LoginEvent.SelectServerItem, arg_3_0._onSelectServerItem, arg_3_0)
	arg_3_0:addEventCb(LoginController.instance, LoginEvent.OnSdkLoginReturn, arg_3_0._onSdkLoginReturn, arg_3_0)
	arg_3_0:addEventCb(LoginController.instance, LoginEvent.SystemLoginFail, arg_3_0._onSystemLoginFail, arg_3_0)
	arg_3_0:addEventCb(LoginController.instance, LoginEvent.OnLogout, arg_3_0._onLoginOut, arg_3_0)
	arg_3_0:addEventCb(LoginController.instance, LoginEvent.OnLoginBgLoaded, arg_3_0._onBgLoaded, arg_3_0)
	arg_3_0._btnNoticeLongPress:SetLongPressTime({
		isDebugBuild and var_0_2 or var_0_3,
		1
	})
	arg_3_0._btnNoticeLongPress:AddLongPressListener(arg_3_0._onNoticeLongPress, arg_3_0)
	arg_3_0._btnQuit:AddClickListener(arg_3_0._onClickQuit, arg_3_0)
	arg_3_0._btnSet:AddClickListener(arg_3_0._onClickSet, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnServerList:RemoveClickListener()
	arg_4_0._btnLogin:RemoveClickListener()
	arg_4_0._btnAccount:RemoveClickListener()
	arg_4_0._btnNotice:RemoveClickListener()
	arg_4_0._btnFix:RemoveClickListener()
	arg_4_0._btnScan:RemoveClickListener()
	arg_4_0._btnPolicy:RemoveClickListener()
	arg_4_0._btnAgeFit:RemoveClickListener()
	arg_4_0._btnexit:RemoveClickListener()
	arg_4_0._btnQuit:RemoveClickListener()
	arg_4_0._btnSet:RemoveClickListener()
	arg_4_0._btnNoticeLongPress:RemoveLongPressListener()
	TaskDispatcher.cancelTask(arg_4_0._delayForLogout, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._endSdkBlock, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onLoginTimeout, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._startLoginFlow, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._login, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._sdkRelogin, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._startGameAfterCanvasFade, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onOpenAnimDone, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onClickLogin, arg_4_0)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0._sdkLoginSucc = SDKMgr.instance:isLoginSuccess()

	BootResMgr.instance:dispose()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
	TaskDispatcher.runDelay(arg_5_0._onOpenAnimDone, arg_5_0, 0.333)
	arg_5_0._imgLogo:LoadImage(ResUrl.getLoginBgLangIcon("bg_logo"), arg_5_0._onLogoLoaded, arg_5_0)
	gohelper.addUIClickAudio(arg_5_0._btnLogin.gameObject, AudioEnum.UI.UI_Common_Click)

	arg_5_0._serverMO = ServerMO.New()
	arg_5_0._serverMO.id = 1
	arg_5_0._serverMO.name = ""
	arg_5_0._serverMO.state = 0

	local var_5_0 = UnityEngine.Application.version
	local var_5_1 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
	local var_5_2 = BootNativeUtil.getAppVersion()

	arg_5_0._txt_version.text = string.format("V%s-%s-%s", var_5_0, var_5_1, tostring(var_5_2))

	arg_5_0:_updateServerInfo()

	local var_5_3 = tostring(SDKMgr.instance:getChannelId()) == "102"

	gohelper.setActive(arg_5_0._btnAgeFit.gameObject, not var_5_3 and SettingsModel.instance:isZhRegion())
	gohelper.setActive(arg_5_0._goClickMask, false)
	NavigateMgr.instance:addEscape(arg_5_0.viewName, arg_5_0._onEscapeBtnClick, arg_5_0, false)

	if arg_5_0.viewParam and arg_5_0.viewParam.isModuleLogout then
		if arg_5_0.viewParam.isSdkLogout then
			arg_5_0:_showEnterGameBtn(false, var_5_3)
		else
			arg_5_0:_showEnterGameBtn(true)
			arg_5_0:_startLoginFlow()
		end
	else
		arg_5_0:_showEnterGameBtn(false, var_5_3)
	end

	gohelper.setActive(arg_5_0._btnexit, BootNativeUtil.isWindows() and false)
end

function var_0_0._onOpenAnimDone(arg_6_0)
	arg_6_0._openAnimDone = true

	arg_6_0:_checkOpenDone()
end

function var_0_0._onLogoLoaded(arg_7_0)
	arg_7_0._logoLoaded = true

	arg_7_0:_checkOpenDone()
end

function var_0_0._onBgLoaded(arg_8_0)
	arg_8_0._bgLoaded = true

	arg_8_0:_checkOpenDone()
end

function var_0_0._checkOpenDone(arg_9_0)
	if arg_9_0._openAnimDone and arg_9_0._logoLoaded and arg_9_0._bgLoaded then
		TaskDispatcher.runDelay(arg_9_0._login, arg_9_0, 0.01)
	end
end

function var_0_0._login(arg_10_0)
	local var_10_0 = "LoginView:ShowSettingsPCSystemView"

	if BootNativeUtil.isWindows() and UnityEngine.PlayerPrefs.HasKey(var_10_0) == false then
		UnityEngine.PlayerPrefs.SetFloat(var_10_0, 1)

		local var_10_1 = {
			closeCallback = arg_10_0._login2,
			closeCallbackObj = arg_10_0
		}

		ViewMgr.instance:openView(ViewName.SettingsPCSystemView, var_10_1)
	else
		arg_10_0:_login2()
	end
end

function var_0_0._login2(arg_11_0)
	if SDKMgr.instance:useSimulateLogin() then
		ViewMgr.instance:closeView(ViewName.ServerListView)
		ViewMgr.instance:openView(ViewName.SimulateLoginView)
	else
		SDKMgr.instance:login()
	end
end

function var_0_0._startSdkBlock(arg_12_0)
	if BootNativeUtil.isWindows() then
		UIBlockMgrExtend.setNeedCircleMv(false)
	else
		UIBlockMgrExtend.CircleMvDelay = 5
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.SdkLogin)
end

function var_0_0._endSdkBlock(arg_13_0)
	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.SdkLogin)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0._logout(arg_14_0)
	if SDKMgr.instance:useSimulateLogin() then
		ViewMgr.instance:openView(ViewName.SimulateLoginView)
	else
		arg_14_0._webLoginSuccess = nil

		LoginController.instance:sdkLogout()
	end
end

function var_0_0.exit(arg_15_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.exitGame, MsgBoxEnum.BoxType.Yes_No, function()
		ProjBooter.instance:quitGame()
	end)
end

function var_0_0.onClose(arg_17_0)
	arg_17_0:_clearState()
end

function var_0_0.onUpdateParam(arg_18_0)
	arg_18_0:_showEnterGameBtn(true)
	arg_18_0:_startLoginFlow()
end

function var_0_0._startLoginFlow(arg_19_0)
	if arg_19_0._loginFlow then
		return
	end

	arg_19_0._loginFlow = FlowSequence.New()

	if SDKMgr.instance:useSimulateLogin() then
		arg_19_0._loginFlow:addWork(SimulateLoginWork.New())
	end

	arg_19_0._loginFlow:addWork(CheckVersionWork.New())
	arg_19_0._loginFlow:addWork(WebLoginWork.New())
	arg_19_0._loginFlow:registerDoneListener(arg_19_0._onLoginDone, arg_19_0)
	arg_19_0._loginFlow:start({
		useBackupUrl = LoginModel.instance:getUseBackup()
	})
	UIBlockMgr.instance:startBlock(UIBlockKey.WebLogin)
end

function var_0_0._onLoginDone(arg_20_0, arg_20_1)
	if not arg_20_0._loginFlow then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		arg_20_0:_clearState()
	end

	if arg_20_1 then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		arg_20_0:_trackEventHostSwitchLogin()
		LoginModel.instance:resetFailCount()
		arg_20_0:_endSdkBlock()

		arg_20_0._serverMO = arg_20_0._loginFlow.context.serverMO
		arg_20_0._webLoginSuccess = arg_20_0._loginFlow.context.webLoginSuccess

		arg_20_0:_updateServerInfo()
		SDKDataTrackMgr.instance:trackChooseServerEvent()

		if SLFramework.FrameworkSettings.IsEditor then
			arg_20_0:_requestServerList(arg_20_0._toSelectEditorLastLoginServer)
		elseif not isDebugBuild then
			arg_20_0:_requestServerList(arg_20_0._toSelectDefaultLoginServer)
		end

		UIBlockMgrExtend.instance:setTips()
	elseif arg_20_0._loginFlow.context.resultCode == var_0_1 then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		arg_20_0:_onSdkExpired()
	else
		LoginModel.instance:inverseUseBackup()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
			LoginModel.instance:resetFailAlertCount()
			GameFacade.showMessageBox(MessageBoxIdDefine.NoServerList, MsgBoxEnum.BoxType.Yes)
			UIBlockMgrExtend.instance:setTips()
		else
			arg_20_0:_failWebLoginAgain()
			UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr())
		end
	end

	arg_20_0._loginFlow:unregisterDoneListener(arg_20_0._onLoginDone, arg_20_0)

	arg_20_0._loginFlow = nil
end

function var_0_0._failWebLoginAgain(arg_21_0)
	if arg_21_0._sdkLoginSucc then
		TaskDispatcher.runDelay(arg_21_0._startLoginFlow, arg_21_0, 1)
	else
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		TaskDispatcher.runDelay(arg_21_0._login, arg_21_0, 1)
	end
end

function var_0_0._clearState(arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._onLoginTimeout, arg_22_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.HttpLogin)
	UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
	arg_22_0:_endSdkBlock()

	if arg_22_0._loginFlow then
		arg_22_0._loginFlow:stop()
		arg_22_0._loginFlow:unregisterDoneListener(arg_22_0._onLoginDone, arg_22_0)

		arg_22_0._loginFlow = nil
	end

	if arg_22_0._httpStartGameFlow then
		arg_22_0._httpStartGameFlow:stop()

		arg_22_0._httpStartGameFlow = nil
	end

	if arg_22_0._serverListRequestId then
		SLFramework.SLWebRequest.Instance:Stop(arg_22_0._serverListRequestId)

		arg_22_0._serverListRequestId = nil
	end
end

function var_0_0._onClickServerList(arg_23_0)
	ViewMgr.instance:openView(ViewName.ServerListView, {
		useBackupUrl = LoginModel.instance:getUseBackup()
	})
end

function var_0_0._onClickLogin(arg_24_0)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.start_game)

	if arg_24_0._delayLogout then
		logWarn("LoginView:_onClickLogin, delayLogout")

		return
	end

	if not GameChannelConfig.isSlsdk() and not SDKMgr.instance:isLogin() then
		logNormal("LoginView:_onClickLogin,isLogin flag is false")
		arg_24_0:_delayForLogout()
		arg_24_0:_login()

		return
	end

	if not arg_24_0._webLoginSuccess then
		logWarn("LoginView:_onClickLogin, not web login, try again!")
		arg_24_0:_startLoginFlow()

		return
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.HttpLogin)

	local var_24_0 = arg_24_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))

	if var_24_0 then
		var_24_0.alpha = 1
	end

	TaskDispatcher.cancelTask(arg_24_0._onLoginTimeout, arg_24_0)
	TaskDispatcher.runDelay(arg_24_0._onLoginTimeout, arg_24_0, 60)

	arg_24_0._httpStartGameFlow = FlowSequence.New()

	arg_24_0._httpStartGameFlow:addWork(CheckVersionWork.New(arg_24_0._restartHttpStartGame, arg_24_0))
	arg_24_0._httpStartGameFlow:addWork(HttpStartGameWork.New())
	arg_24_0._httpStartGameFlow:registerDoneListener(arg_24_0._onHttpStartGameDone, arg_24_0)
	arg_24_0._httpStartGameFlow:start({
		useBackupUrl = LoginModel.instance:getUseBackup(),
		lastServerMO = arg_24_0._serverMO
	})
end

function var_0_0._restartHttpStartGame(arg_25_0)
	logNormal("LoginView:_restartHttpStartGame")
	arg_25_0:_clearState()
	arg_25_0:_onClickLogin()
end

function var_0_0._onHttpStartGameDone(arg_26_0, arg_26_1)
	if arg_26_1 then
		arg_26_0:_trackEventHostSwitchIpRequest()
		LoginModel.instance:resetFailCount()

		if SLFramework.FrameworkSettings.IsEditor then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.LastLoginServerForPC, arg_26_0._serverMO.id)
		end

		gohelper.setActive(arg_26_0._originBgGo, false)
		gohelper.setActive(arg_26_0._goClickMask, true)

		local var_26_0 = arg_26_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

		if var_26_0 then
			var_26_0:Play(UIAnimationName.Close)
		end

		TaskDispatcher.runDelay(arg_26_0._startGameAfterCanvasFade, arg_26_0, 0.4)
		UIBlockMgrExtend.instance:setTips()
		arg_26_0:_clearState()
	else
		local var_26_1 = arg_26_0._httpStartGameFlow and arg_26_0._httpStartGameFlow.context and arg_26_0._httpStartGameFlow.context.resultCode

		if var_26_1 and var_26_1 == var_0_1 then
			arg_26_0:_onSdkExpired()
			arg_26_0:_clearState()
		elseif arg_26_0._httpStartGameFlow and not arg_26_0._httpStartGameFlow.context.dontReconnect then
			LoginModel.instance:inverseUseBackup()
			LoginModel.instance:incFailCount()

			if LoginModel.instance:isFailNeedAlert() then
				LoginModel.instance:resetFailAlertCount()
				GameFacade.showMessageBox(MessageBoxIdDefine.LoginLostConnect2, MsgBoxEnum.BoxType.Yes_No, function()
					arg_26_0:_onClickLogin()
				end)
				UIBlockMgrExtend.instance:setTips()
				arg_26_0:_clearState()
			else
				TaskDispatcher.runDelay(arg_26_0._onClickLogin, arg_26_0, 0.01)
				UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr())
			end
		else
			arg_26_0:_clearState()
		end
	end
end

function var_0_0._onSdkExpired(arg_28_0)
	logWarn("登录信息已过期，需重新调起sdk登录")
	arg_28_0:_showEnterGameBtn(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.SdkTimeoutRelogin, MsgBoxEnum.BoxType.Yes, function()
		TaskDispatcher.runDelay(arg_28_0._sdkRelogin, arg_28_0, 0.3)
	end)
end

function var_0_0._startGameAfterCanvasFade(arg_30_0)
	LoginController.instance:startLogin()
end

function var_0_0._onEscapeBtnClick(arg_31_0)
	if SLFramework.FrameworkSettings.IsEditor then
		arg_31_0:_onClickAccount()

		return
	end

	SDKMgr.instance:exitSdk()
end

function var_0_0.onClickModalMask(arg_32_0)
	arg_32_0:_onClickLogin()
end

function var_0_0._onLoginTimeout(arg_33_0)
	arg_33_0:_clearState()
	logWarn("http登录超时，请稍后重试")
end

function var_0_0._onClickAccount(arg_34_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.LogoutThisDevice, MsgBoxEnum.BoxType.Yes_No, function()
		arg_34_0._delayLogout = true

		arg_34_0:_showEnterGameBtn(false)
		TaskDispatcher.runDelay(arg_34_0._delayForLogout, arg_34_0, 0.45)
	end)
end

function var_0_0._delayForLogout(arg_36_0)
	arg_36_0._delayLogout = false

	arg_36_0:_showEnterGameBtn(false)
	arg_36_0:_logout()
end

function var_0_0._onClickNotice(arg_37_0)
	if VersionValidator.instance:isInReviewing() then
		logWarn("in reviewing ...")

		return
	end

	if arg_37_0._noticeBtnPressed and not arg_37_0._noticeBtnClickable then
		arg_37_0._noticeBtnClickable = true

		return
	else
		arg_37_0._noticeBtnPressed = false
		arg_37_0._noticeBtnClickable = true
	end

	NoticeController.instance:openNoticeView()
end

function var_0_0._onClickQuit(arg_38_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitGame, MsgBoxEnum.BoxType.Yes_No, arg_38_0._quitGame)
end

function var_0_0._quitGame(arg_39_0)
	UnityEngine.Application.Quit()
end

function var_0_0._onClickSet(arg_40_0)
	ViewMgr.instance:openView(ViewName.SettingsPCSystemView)
end

function var_0_0._onClickFix(arg_41_0)
	if arg_41_0._noticeBtnPressed then
		GMController.instance:initProfilerCmdFileCheck()

		arg_41_0._noticeBtnPressed = false
	else
		ViewMgr.instance:openView(ViewName.FixResTipView, {
			callback = arg_41_0.reallyFix,
			callbackObj = arg_41_0
		})
	end
end

function var_0_0._onNoticeLongPress(arg_42_0)
	arg_42_0._noticeBtnPressed = true
	arg_42_0._noticeBtnClickable = false

	BenchmarkApi.AndroidLog("_onNoticeLongPress")
end

function var_0_0._onClickPolicy(arg_43_0)
	SDKMgr.instance:showAgreement()
end

function var_0_0._onClickAgeFit(arg_44_0)
	ViewMgr.instance:openView(ViewName.SdkFitAgeTipView)
end

function var_0_0.reallyFix(arg_45_0)
	PlayerPrefsHelper.deleteAll()
	ZProj.GameHelper.DeleteAllCache()

	if BootNativeUtil.isWindows() then
		local var_45_0 = UnityEngine.Application.persistentDataPath
		local var_45_1 = System.Collections.Generic.List_string.New()

		var_45_1:Add(var_45_0 .. "/logicLog")
		var_45_1:Add(var_45_0 .. "/Player.log")
		SLFramework.FileHelper.ClearDirWithIgnore(var_45_0, nil, var_45_1)
	end

	MessageBoxController.instance:setEnableClickAudio(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.FixFinished, MsgBoxEnum.BoxType.Yes, function()
		if BootNativeUtil.isAndroid() then
			if SDKMgr.restartGame ~= nil then
				SDKMgr.instance:restartGame()
			else
				ProjBooter.instance:quitGame()
			end
		else
			ProjBooter.instance:quitGame()
		end
	end)
end

function var_0_0._onClickScan(arg_47_0)
	SDKMgr.instance:pcLoginForQrCode()
end

function var_0_0._updateServerInfo(arg_48_0)
	arg_48_0._txtServerName.text = arg_48_0._serverMO and arg_48_0._serverMO.name or ""

	if arg_48_0._serverMO then
		for iter_48_0 = 0, 2 do
			gohelper.setActive(arg_48_0._serverStateGOList[iter_48_0], iter_48_0 == arg_48_0._serverMO.state)
		end
	end
end

function var_0_0._showEnterGameBtn(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = SLFramework.FrameworkSettings.IsEditor or isDebugBuild

	arg_49_0._isShowEnterGameBtn = arg_49_1

	gohelper.setActive(arg_49_0._serverGO, arg_49_1 and var_49_0)
	gohelper.setActive(arg_49_0._btnLogin.gameObject, arg_49_1 and not arg_49_2)

	if SLFramework.FrameworkSettings.IsEditor then
		gohelper.setActive(arg_49_0._btnLogin.gameObject, arg_49_1)
	end

	arg_49_0:_showAccountBtn(arg_49_1)
end

function var_0_0._showAccountBtn(arg_50_0, arg_50_1)
	gohelper.setActive(arg_50_0._btnAccount.gameObject, arg_50_1 and SDKModel.instance:isDmm() == false)

	local var_50_0 = not VersionValidator.instance:isInReviewing()
	local var_50_1 = not GameFacade.isExternalTest()
	local var_50_2 = not SDKMgr.getShowNotice or SDKMgr.instance:getShowNotice()

	gohelper.setActive(arg_50_0._btnNotice.gameObject, arg_50_1 and var_50_0 and var_50_1 and var_50_2)
	gohelper.setActive(arg_50_0._btnFix.gameObject, arg_50_1)
	gohelper.setActive(arg_50_0._btnScan.gameObject, arg_50_1 and SDKMgr.instance:isShowPcLoginButton())
	gohelper.setActive(arg_50_0._btnPolicy.gameObject, arg_50_1 and SDKMgr.instance:isShowAgreementButton())
	gohelper.setActive(arg_50_0._btnQuit.gameObject, arg_50_1 and BootNativeUtil.isWindows())
	gohelper.setActive(arg_50_0._btnSet.gameObject, arg_50_1 and BootNativeUtil.isWindows())

	arg_50_0._isShowAccountBtn = arg_50_1
end

function var_0_0._onSelectServerItem(arg_51_0, arg_51_1)
	arg_51_0._serverMO = arg_51_1

	arg_51_0:_updateServerInfo()
end

function var_0_0._onSdkLoginReturn(arg_52_0, arg_52_1, arg_52_2)
	arg_52_0:_endSdkBlock()
	arg_52_0:_startSdkBlock()
	TaskDispatcher.cancelTask(arg_52_0._endSdkBlock, arg_52_0)
	TaskDispatcher.runDelay(arg_52_0._endSdkBlock, arg_52_0, 0.5)

	if not arg_52_1 then
		arg_52_0:_showAccountBtn(true)

		arg_52_0._sdkLoginSucc = nil
	else
		arg_52_0._sdkLoginSucc = true
	end
end

function var_0_0._onSystemLoginFail(arg_53_0)
	arg_53_0:_clearState()
end

function var_0_0._onLoginOut(arg_54_0)
	arg_54_0._sdkLoginSucc = nil

	arg_54_0:_showEnterGameBtn(false)
end

function var_0_0._sdkRelogin(arg_55_0)
	arg_55_0._sdkLoginSucc = nil

	arg_55_0:_showEnterGameBtn(false)
	arg_55_0:_logout()
end

function var_0_0._requestServerList(arg_56_0, arg_56_1)
	local var_56_0 = LoginController.instance:get_getServerListUrl(LoginModel.instance:getUseBackup())
	local var_56_1 = {}

	table.insert(var_56_1, string.format("sessionId=%s", LoginModel.instance.sessionId))
	table.insert(var_56_1, string.format("zoneId=%s", 0))

	local var_56_2 = var_56_0 .. "?" .. table.concat(var_56_1, "&")

	arg_56_0._onServerListCallback = arg_56_1
	arg_56_0._serverListRequestId = SLFramework.SLWebRequest.Instance:Get(var_56_2, arg_56_0._onServerListRespone, arg_56_0)
end

function var_0_0._onServerListRespone(arg_57_0, arg_57_1, arg_57_2)
	arg_57_0._serverListRequestId = nil

	if not arg_57_1 then
		return
	end

	if string.nilorempty(arg_57_2) then
		return
	end

	local var_57_0 = cjson.decode(arg_57_2)

	if not var_57_0 or not var_57_0.resultCode or var_57_0.resultCode ~= 0 or not var_57_0.zoneInfos then
		return
	end

	if arg_57_0._onServerListCallback then
		local var_57_1 = arg_57_0._onServerListCallback

		arg_57_0._onServerListCallback = nil

		var_57_1(arg_57_0, arg_57_2, var_57_0)
	end
end

function var_0_0._toSelectEditorLastLoginServer(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.LastLoginServerForPC, nil)

	if var_58_0 then
		ServerListModel.instance:setServerList(arg_58_2.zoneInfos)

		for iter_58_0, iter_58_1 in ipairs(arg_58_2.zoneInfos) do
			if iter_58_1.id == var_58_0 then
				arg_58_0._serverMO = {
					id = iter_58_1.id,
					name = iter_58_1.name,
					prefix = iter_58_1.prefix,
					state = iter_58_1.state
				}

				arg_58_0:_updateServerInfo()

				break
			end
		end
	end
end

function var_0_0._toSelectDefaultLoginServer(arg_59_0, arg_59_1, arg_59_2)
	ServerListModel.instance:setServerList(arg_59_2.zoneInfos)

	for iter_59_0, iter_59_1 in ipairs(arg_59_2.zoneInfos) do
		if iter_59_1.default == true then
			arg_59_0._serverMO = {
				id = iter_59_1.id,
				name = iter_59_1.name,
				prefix = iter_59_1.prefix,
				state = iter_59_1.state
			}

			arg_59_0:_updateServerInfo()

			break
		end
	end
end

function var_0_0._trackEventHostSwitchLogin(arg_60_0)
	if LoginModel.instance:getFailCount() > 0 then
		local var_60_0 = LoginController.instance:get_httpWebLoginUrl(LoginModel.instance:getUseBackup())

		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_login",
			[StatEnum.EventProperties.CurrentHost] = var_60_0,
			[StatEnum.EventProperties.SwitchCount] = LoginModel.instance:getFailCount()
		})
	end
end

function var_0_0._trackEventHostSwitchIpRequest(arg_61_0)
	if LoginModel.instance:getFailCount() > 0 then
		local var_61_0 = LoginController.instance:get_startGameUrl(LoginModel.instance:getUseBackup())

		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_iprequest",
			[StatEnum.EventProperties.CurrentHost] = var_61_0,
			[StatEnum.EventProperties.SwitchCount] = LoginModel.instance:getFailCount()
		})
	end
end

function var_0_0.onDestroyView(arg_62_0)
	arg_62_0._openAnimDone = nil
	arg_62_0._logoLoaded = nil
	arg_62_0._bgLoaded = nil

	if arg_62_0._originBgGo then
		gohelper.destroy(arg_62_0._originBgGo)

		arg_62_0._originBgGo = nil
	end

	arg_62_0._imgLogo:UnLoadImage()
end

return var_0_0
