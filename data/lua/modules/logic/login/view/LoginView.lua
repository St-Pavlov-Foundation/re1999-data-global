module("modules.logic.login.view.LoginView", package.seeall)

slot0 = class("LoginView", BaseView)
slot1 = -8

function slot0.ctor(slot0)
	slot0._loginFlow = nil
	slot0._httpStartGameFlow = nil
end

function slot0.onInitView(slot0)
	slot0._serverGO = gohelper.findChild(slot0.viewGO, "server")
	slot0._txtServerName = gohelper.findChildText(slot0._serverGO, "Text")
	slot4 = "#txt_version"
	slot0._txt_version = gohelper.findChildText(slot0.viewGO, slot4)
	slot0._serverStateGOList = {}

	for slot4 = 0, 2 do
		slot0._serverStateGOList[slot4] = gohelper.findChild(slot0.viewGO, "server/imgState" .. slot4)
	end

	slot0._btnServerList = gohelper.findChildButtonWithAudio(slot0.viewGO, "server/btnServerList")
	slot0._btnLogin = gohelper.findChildButtonWithAudio(slot0.viewGO, "center_text/btnLogin")
	slot0._btnPolicy = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtn_group/#btn_policy")
	slot0._btnAccount = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtn_group/#btn_account")
	slot0._btnNotice = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtn_group/#btn_notice")
	slot0._btnFix = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtn_group/#btn_fix")
	slot0._btnScan = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtn_group/#btn_scan")
	slot0._btnSet = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtn_group/#btn_set")
	slot0._btnQuit = gohelper.findChildButtonWithAudio(slot0.viewGO, "rightbtn_group/#btn_switch")
	slot0._originBgGo = gohelper.find("UIRoot/OriginBg")
	slot0._goClickMask = gohelper.findChild(slot0.viewGO, "click_mask")
	slot0._goEffect = gohelper.findChild(slot0.viewGO, "imgBg/effect")
	slot0._imgLogo = gohelper.findChildSingleImage(slot0.viewGO, "logo")
	slot0._btnAgeFit = gohelper.findChildButtonWithAudio(slot0.viewGO, "leftbtn/#btn_agefit")
end

function slot0.addEvents(slot0)
	slot0._btnServerList:AddClickListener(slot0._onClickServerList, slot0)
	slot0._btnLogin:AddClickListener(slot0._onClickLogin, slot0)
	slot0._btnAccount:AddClickListener(slot0._onClickAccount, slot0)
	slot0._btnNotice:AddClickListener(slot0._onClickNotice, slot0)
	slot0._btnFix:AddClickListener(slot0._onClickFix, slot0)
	slot0._btnScan:AddClickListener(slot0._onClickScan, slot0)
	slot0._btnPolicy:AddClickListener(slot0._onClickPolicy, slot0)
	slot0._btnAgeFit:AddClickListener(slot0._onClickAgeFit, slot0)
	slot0:addEventCb(LoginController.instance, LoginEvent.SelectServerItem, slot0._onSelectServerItem, slot0)
	slot0:addEventCb(LoginController.instance, LoginEvent.OnSdkLoginReturn, slot0._onSdkLoginReturn, slot0)
	slot0:addEventCb(LoginController.instance, LoginEvent.SystemLoginFail, slot0._onSystemLoginFail, slot0)
	slot0:addEventCb(LoginController.instance, LoginEvent.OnLogout, slot0._onLoginOut, slot0)
	slot0:addEventCb(LoginController.instance, LoginEvent.OnLoginBgLoaded, slot0._onBgLoaded, slot0)
	slot0._btnQuit:AddClickListener(slot0._onClickQuit, slot0)
	slot0._btnSet:AddClickListener(slot0._onClickSet, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnServerList:RemoveClickListener()
	slot0._btnLogin:RemoveClickListener()
	slot0._btnAccount:RemoveClickListener()
	slot0._btnNotice:RemoveClickListener()
	slot0._btnFix:RemoveClickListener()
	slot0._btnScan:RemoveClickListener()
	slot0._btnPolicy:RemoveClickListener()
	slot0._btnAgeFit:RemoveClickListener()
	slot0._btnQuit:RemoveClickListener()
	slot0._btnSet:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0._delayForLogout, slot0)
	TaskDispatcher.cancelTask(slot0._endSdkBlock, slot0)
	TaskDispatcher.cancelTask(slot0._onLoginTimeout, slot0)
	TaskDispatcher.cancelTask(slot0._startLoginFlow, slot0)
	TaskDispatcher.cancelTask(slot0._login, slot0)
	TaskDispatcher.cancelTask(slot0._sdkRelogin, slot0)
	TaskDispatcher.cancelTask(slot0._startGameAfterCanvasFade, slot0)
	TaskDispatcher.cancelTask(slot0._onOpenAnimDone, slot0)
	TaskDispatcher.cancelTask(slot0._onClickLogin, slot0)
end

function slot0.onOpen(slot0)
	slot0._sdkLoginSucc = SDKMgr.instance:isLoginSuccess()

	BootResMgr.instance:dispose()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
	TaskDispatcher.runDelay(slot0._onOpenAnimDone, slot0, 0.333)
	slot0._imgLogo:LoadImage(ResUrl.getLoginBgLangIcon("bg_logo"), slot0._onLogoLoaded, slot0)
	gohelper.addUIClickAudio(slot0._btnLogin.gameObject, AudioEnum.UI.UI_Common_Click)

	slot0._serverMO = ServerMO.New()
	slot0._serverMO.id = 1
	slot0._serverMO.name = ""
	slot0._serverMO.state = 0
	slot0._txt_version.text = string.format("V%s-%s-%s", UnityEngine.Application.version, SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr, tostring(BootNativeUtil.getAppVersion()))

	slot0:_updateServerInfo()
	gohelper.setActive(slot0._btnAgeFit.gameObject, not (tostring(SDKMgr.instance:getChannelId()) == "102") and SettingsModel.instance:isZhRegion())
	gohelper.setActive(slot0._goClickMask, false)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscapeBtnClick, slot0, false)

	if slot0.viewParam and slot0.viewParam.isModuleLogout then
		if slot0.viewParam.isSdkLogout then
			slot0:_showEnterGameBtn(false, slot4)
		else
			slot0:_showEnterGameBtn(true)
			slot0:_startLoginFlow()
		end
	else
		slot0:_showEnterGameBtn(false, slot4)
	end
end

function slot0._onOpenAnimDone(slot0)
	slot0._openAnimDone = true

	slot0:_checkOpenDone()
end

function slot0._onLogoLoaded(slot0)
	slot0._logoLoaded = true

	slot0:_checkOpenDone()
end

function slot0._onBgLoaded(slot0)
	slot0._bgLoaded = true

	slot0:_checkOpenDone()
end

function slot0._checkOpenDone(slot0)
	if slot0._openAnimDone and slot0._logoLoaded and slot0._bgLoaded then
		TaskDispatcher.runDelay(slot0._login, slot0, 0.01)
	end
end

function slot0._login(slot0)
	slot1 = "LoginView:ShowSettingsPCSystemView"

	if BootNativeUtil.isWindows() and UnityEngine.PlayerPrefs.HasKey(slot1) == false then
		UnityEngine.PlayerPrefs.SetFloat(slot1, 1)
		ViewMgr.instance:openView(ViewName.SettingsPCSystemView, {
			closeCallback = slot0._login2,
			closeCallbackObj = slot0
		})
	else
		slot0:_login2()
	end
end

function slot0._login2(slot0)
	if SDKMgr.instance:useSimulateLogin() then
		ViewMgr.instance:closeView(ViewName.ServerListView)
		ViewMgr.instance:openView(ViewName.SimulateLoginView)
	else
		SDKMgr.instance:login()
	end
end

function slot0._startSdkBlock(slot0)
	if BootNativeUtil.isWindows() then
		UIBlockMgrExtend.setNeedCircleMv(false)
	else
		UIBlockMgrExtend.CircleMvDelay = 5
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.SdkLogin)
end

function slot0._endSdkBlock(slot0)
	UIBlockMgrExtend.CircleMvDelay = nil

	UIBlockMgr.instance:endBlock(UIBlockKey.SdkLogin)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0._logout(slot0)
	if SDKMgr.instance:useSimulateLogin() then
		ViewMgr.instance:openView(ViewName.SimulateLoginView)
	else
		slot0._webLoginSuccess = nil

		LoginController.instance:sdkLogout()
	end
end

function slot0.onClose(slot0)
	slot0:_clearState()
end

function slot0.onUpdateParam(slot0)
	slot0:_showEnterGameBtn(true)
	slot0:_startLoginFlow()
end

function slot0._startLoginFlow(slot0)
	if slot0._loginFlow then
		return
	end

	slot0._loginFlow = FlowSequence.New()

	if SDKMgr.instance:useSimulateLogin() then
		slot0._loginFlow:addWork(SimulateLoginWork.New())
	end

	slot0._loginFlow:addWork(CheckVersionWork.New())
	slot0._loginFlow:addWork(WebLoginWork.New())
	slot0._loginFlow:registerDoneListener(slot0._onLoginDone, slot0)
	slot0._loginFlow:start({
		useBackupUrl = LoginModel.instance:getUseBackup()
	})
	UIBlockMgr.instance:startBlock(UIBlockKey.WebLogin)
end

function slot0._onLoginDone(slot0, slot1)
	if not slot0._loginFlow then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		slot0:_clearState()
	end

	if slot1 then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		slot0:_trackEventHostSwitchLogin()
		LoginModel.instance:resetFailCount()
		slot0:_endSdkBlock()

		slot0._serverMO = slot0._loginFlow.context.serverMO
		slot0._webLoginSuccess = slot0._loginFlow.context.webLoginSuccess

		slot0:_updateServerInfo()
		SDKDataTrackMgr.instance:trackChooseServerEvent()

		if SLFramework.FrameworkSettings.IsEditor then
			slot0:_requestServerList(slot0._toSelectEditorLastLoginServer)
		elseif not isDebugBuild then
			slot0:_requestServerList(slot0._toSelectDefaultLoginServer)
		end

		UIBlockMgrExtend.instance:setTips()
	elseif slot0._loginFlow.context.resultCode == uv0 then
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		slot0:_onSdkExpired()
	else
		LoginModel.instance:inverseUseBackup()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
			LoginModel.instance:resetFailAlertCount()
			GameFacade.showMessageBox(MessageBoxIdDefine.NoServerList, MsgBoxEnum.BoxType.Yes)
			UIBlockMgrExtend.instance:setTips()
		else
			slot0:_failWebLoginAgain()
			UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr())
		end
	end

	slot0._loginFlow:unregisterDoneListener(slot0._onLoginDone, slot0)

	slot0._loginFlow = nil
end

function slot0._failWebLoginAgain(slot0)
	if slot0._sdkLoginSucc then
		TaskDispatcher.runDelay(slot0._startLoginFlow, slot0, 1)
	else
		UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
		TaskDispatcher.runDelay(slot0._login, slot0, 1)
	end
end

function slot0._clearState(slot0)
	TaskDispatcher.cancelTask(slot0._onLoginTimeout, slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.HttpLogin)
	UIBlockMgr.instance:endBlock(UIBlockKey.WebLogin)
	slot0:_endSdkBlock()

	if slot0._loginFlow then
		slot0._loginFlow:stop()
		slot0._loginFlow:unregisterDoneListener(slot0._onLoginDone, slot0)

		slot0._loginFlow = nil
	end

	if slot0._httpStartGameFlow then
		slot0._httpStartGameFlow:stop()

		slot0._httpStartGameFlow = nil
	end

	if slot0._serverListRequestId then
		SLFramework.SLWebRequest.Instance:Stop(slot0._serverListRequestId)

		slot0._serverListRequestId = nil
	end
end

function slot0._onClickServerList(slot0)
	ViewMgr.instance:openView(ViewName.ServerListView, {
		useBackupUrl = LoginModel.instance:getUseBackup()
	})
end

function slot0._onClickLogin(slot0)
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.start_game)

	if slot0._delayLogout then
		logWarn("LoginView:_onClickLogin, delayLogout")

		return
	end

	if not GameChannelConfig.isSlsdk() and not SDKMgr.instance:isLogin() then
		logNormal("LoginView:_onClickLogin,isLogin flag is false")
		slot0:_delayForLogout()
		slot0:_login()

		return
	end

	if not slot0._webLoginSuccess then
		logWarn("LoginView:_onClickLogin, not web login, try again!")
		slot0:_startLoginFlow()

		return
	end

	UIBlockMgr.instance:startBlock(UIBlockKey.HttpLogin)

	if slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup)) then
		slot1.alpha = 1
	end

	TaskDispatcher.cancelTask(slot0._onLoginTimeout, slot0)
	TaskDispatcher.runDelay(slot0._onLoginTimeout, slot0, 60)

	slot0._httpStartGameFlow = FlowSequence.New()

	slot0._httpStartGameFlow:addWork(CheckVersionWork.New(slot0._restartHttpStartGame, slot0))
	slot0._httpStartGameFlow:addWork(HttpStartGameWork.New())
	slot0._httpStartGameFlow:registerDoneListener(slot0._onHttpStartGameDone, slot0)
	slot0._httpStartGameFlow:start({
		useBackupUrl = LoginModel.instance:getUseBackup(),
		lastServerMO = slot0._serverMO
	})
end

function slot0._restartHttpStartGame(slot0)
	logNormal("LoginView:_restartHttpStartGame")
	slot0:_clearState()
	slot0:_onClickLogin()
end

function slot0._onHttpStartGameDone(slot0, slot1)
	if slot1 then
		slot0:_trackEventHostSwitchIpRequest()
		LoginModel.instance:resetFailCount()

		if SLFramework.FrameworkSettings.IsEditor then
			PlayerPrefsHelper.setNumber(PlayerPrefsKey.LastLoginServerForPC, slot0._serverMO.id)
		end

		gohelper.setActive(slot0._originBgGo, false)
		gohelper.setActive(slot0._goClickMask, true)

		if slot0.viewGO:GetComponent(typeof(UnityEngine.Animator)) then
			slot2:Play(UIAnimationName.Close)
		end

		TaskDispatcher.runDelay(slot0._startGameAfterCanvasFade, slot0, 0.4)
		UIBlockMgrExtend.instance:setTips()
		slot0:_clearState()
	elseif slot0._httpStartGameFlow and slot0._httpStartGameFlow.context and slot0._httpStartGameFlow.context.resultCode and slot2 == uv0 then
		slot0:_onSdkExpired()
		slot0:_clearState()
	elseif slot0._httpStartGameFlow and not slot0._httpStartGameFlow.context.dontReconnect then
		LoginModel.instance:inverseUseBackup()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			LoginModel.instance:resetFailAlertCount()
			GameFacade.showMessageBox(MessageBoxIdDefine.LoginLostConnect2, MsgBoxEnum.BoxType.Yes_No, function ()
				uv0:_onClickLogin()
			end)
			UIBlockMgrExtend.instance:setTips()
			slot0:_clearState()
		else
			TaskDispatcher.runDelay(slot0._onClickLogin, slot0, 0.01)
			UIBlockMgrExtend.instance:setTips(LoginModel.instance:getFailCountBlockStr())
		end
	else
		slot0:_clearState()
	end
end

function slot0._onSdkExpired(slot0)
	logWarn("登录信息已过期，需重新调起sdk登录")
	slot0:_showEnterGameBtn(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.SdkTimeoutRelogin, MsgBoxEnum.BoxType.Yes, function ()
		TaskDispatcher.runDelay(uv0._sdkRelogin, uv0, 0.3)
	end)
end

function slot0._startGameAfterCanvasFade(slot0)
	LoginController.instance:startLogin()
end

function slot0._onEscapeBtnClick(slot0)
	if SLFramework.FrameworkSettings.IsEditor then
		slot0:_onClickAccount()

		return
	end

	SDKMgr.instance:exitSdk()
end

function slot0.onClickModalMask(slot0)
	slot0:_onClickLogin()
end

function slot0._onLoginTimeout(slot0)
	slot0:_clearState()
	logWarn("http登录超时，请稍后重试")
end

function slot0._onClickAccount(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.LogoutThisDevice, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0._delayLogout = true

		uv0:_showEnterGameBtn(false)
		TaskDispatcher.runDelay(uv0._delayForLogout, uv0, 0.45)
	end)
end

function slot0._delayForLogout(slot0)
	slot0._delayLogout = false

	slot0:_showEnterGameBtn(false)
	slot0:_logout()
end

function slot0._onClickNotice(slot0)
	if VersionValidator.instance:isInReviewing() then
		logWarn("in reviewing ...")

		return
	end

	NoticeController.instance:openNoticeView()
end

function slot0._onClickQuit(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.QuitGame, MsgBoxEnum.BoxType.Yes_No, slot0._quitGame)
end

function slot0._quitGame(slot0)
	UnityEngine.Application.Quit()
end

function slot0._onClickSet(slot0)
	ViewMgr.instance:openView(ViewName.SettingsPCSystemView)
end

function slot0._onClickFix(slot0)
	ViewMgr.instance:openView(ViewName.FixResTipView, {
		callback = slot0.reallyFix,
		callbackObj = slot0
	})
end

function slot0._onClickPolicy(slot0)
	SDKMgr.instance:showAgreement()
end

function slot0._onClickAgeFit(slot0)
	ViewMgr.instance:openView(ViewName.SdkFitAgeTipView)
end

function slot0.reallyFix(slot0)
	PlayerPrefsHelper.deleteAll()
	ZProj.GameHelper.DeleteAllCache()

	if BootNativeUtil.isWindows() then
		slot1 = UnityEngine.Application.persistentDataPath
		slot2 = System.Collections.Generic.List_string.New()

		slot2:Add(slot1 .. "/logicLog")
		slot2:Add(slot1 .. "/Player.log")
		SLFramework.FileHelper.ClearDirWithIgnore(slot1, nil, slot2)
	end

	MessageBoxController.instance:setEnableClickAudio(false)
	GameFacade.showMessageBox(MessageBoxIdDefine.FixFinished, MsgBoxEnum.BoxType.Yes, function ()
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

function slot0._onClickScan(slot0)
	SDKMgr.instance:pcLoginForQrCode()
end

function slot0._updateServerInfo(slot0)
	slot0._txtServerName.text = slot0._serverMO and slot0._serverMO.name or ""

	if slot0._serverMO then
		for slot4 = 0, 2 do
			gohelper.setActive(slot0._serverStateGOList[slot4], slot4 == slot0._serverMO.state)
		end
	end
end

function slot0._showEnterGameBtn(slot0, slot1, slot2)
	slot0._isShowEnterGameBtn = slot1

	gohelper.setActive(slot0._serverGO, slot1 and (SLFramework.FrameworkSettings.IsEditor or isDebugBuild))
	gohelper.setActive(slot0._btnLogin.gameObject, slot1 and not slot2)

	if SLFramework.FrameworkSettings.IsEditor then
		gohelper.setActive(slot0._btnLogin.gameObject, slot1)
	end

	slot0:_showAccountBtn(slot1)
end

function slot0._showAccountBtn(slot0, slot1)
	gohelper.setActive(slot0._btnAccount.gameObject, slot1 and SDKModel.instance:isDmm() == false)
	gohelper.setActive(slot0._btnNotice.gameObject, slot1 and not VersionValidator.instance:isInReviewing() and not GameFacade.isExternalTest() and (not SDKMgr.getShowNotice or SDKMgr.instance:getShowNotice()))
	gohelper.setActive(slot0._btnFix.gameObject, slot1)
	gohelper.setActive(slot0._btnScan.gameObject, slot1 and SDKMgr.instance:isShowPcLoginButton())
	gohelper.setActive(slot0._btnPolicy.gameObject, slot1 and SDKMgr.instance:isShowAgreementButton())
	gohelper.setActive(slot0._btnQuit.gameObject, slot1 and BootNativeUtil.isWindows())
	gohelper.setActive(slot0._btnSet.gameObject, slot1 and BootNativeUtil.isWindows())

	slot0._isShowAccountBtn = slot1
end

function slot0._onSelectServerItem(slot0, slot1)
	slot0._serverMO = slot1

	slot0:_updateServerInfo()
end

function slot0._onSdkLoginReturn(slot0, slot1, slot2)
	slot0:_endSdkBlock()
	slot0:_startSdkBlock()
	TaskDispatcher.cancelTask(slot0._endSdkBlock, slot0)
	TaskDispatcher.runDelay(slot0._endSdkBlock, slot0, 0.5)

	if not slot1 then
		slot0:_showAccountBtn(true)

		slot0._sdkLoginSucc = nil
	else
		slot0._sdkLoginSucc = true
	end
end

function slot0._onSystemLoginFail(slot0)
	slot0:_clearState()
end

function slot0._onLoginOut(slot0)
	slot0._sdkLoginSucc = nil

	slot0:_showEnterGameBtn(false)
end

function slot0._sdkRelogin(slot0)
	slot0._sdkLoginSucc = nil

	slot0:_showEnterGameBtn(false)
	slot0:_logout()
end

function slot0._requestServerList(slot0, slot1)
	slot3 = {}

	table.insert(slot3, string.format("sessionId=%s", LoginModel.instance.sessionId))
	table.insert(slot3, string.format("zoneId=%s", 0))

	slot0._onServerListCallback = slot1
	slot0._serverListRequestId = SLFramework.SLWebRequest.Instance:Get(LoginController.instance:get_getServerListUrl(LoginModel.instance:getUseBackup()) .. "?" .. table.concat(slot3, "&"), slot0._onServerListRespone, slot0)
end

function slot0._onServerListRespone(slot0, slot1, slot2)
	slot0._serverListRequestId = nil

	if not slot1 then
		return
	end

	if string.nilorempty(slot2) then
		return
	end

	if not cjson.decode(slot2) or not slot3.resultCode or slot3.resultCode ~= 0 or not slot3.zoneInfos then
		return
	end

	if slot0._onServerListCallback then
		slot0._onServerListCallback = nil

		slot0:_onServerListCallback(slot2, slot3)
	end
end

function slot0._toSelectEditorLastLoginServer(slot0, slot1, slot2)
	if PlayerPrefsHelper.getNumber(PlayerPrefsKey.LastLoginServerForPC, nil) then
		slot7 = slot2.zoneInfos

		ServerListModel.instance:setServerList(slot7)

		for slot7, slot8 in ipairs(slot2.zoneInfos) do
			if slot8.id == slot3 then
				slot0._serverMO = {
					id = slot8.id,
					name = slot8.name,
					prefix = slot8.prefix,
					state = slot8.state
				}

				slot0:_updateServerInfo()

				break
			end
		end
	end
end

function slot0._toSelectDefaultLoginServer(slot0, slot1, slot2)
	slot6 = slot2.zoneInfos

	ServerListModel.instance:setServerList(slot6)

	for slot6, slot7 in ipairs(slot2.zoneInfos) do
		if slot7.default == true then
			slot0._serverMO = {
				id = slot7.id,
				name = slot7.name,
				prefix = slot7.prefix,
				state = slot7.state
			}

			slot0:_updateServerInfo()

			break
		end
	end
end

function slot0._trackEventHostSwitchLogin(slot0)
	if LoginModel.instance:getFailCount() > 0 then
		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_login",
			[StatEnum.EventProperties.CurrentHost] = LoginController.instance:get_httpWebLoginUrl(LoginModel.instance:getUseBackup()),
			[StatEnum.EventProperties.SwitchCount] = LoginModel.instance:getFailCount()
		})
	end
end

function slot0._trackEventHostSwitchIpRequest(slot0)
	if LoginModel.instance:getFailCount() > 0 then
		StatController.instance:track(StatEnum.EventName.EventHostSwitch, {
			[StatEnum.EventProperties.GameScene] = "scene_iprequest",
			[StatEnum.EventProperties.CurrentHost] = LoginController.instance:get_startGameUrl(LoginModel.instance:getUseBackup()),
			[StatEnum.EventProperties.SwitchCount] = LoginModel.instance:getFailCount()
		})
	end
end

function slot0.onDestroyView(slot0)
	slot0._openAnimDone = nil
	slot0._logoLoaded = nil
	slot0._bgLoaded = nil

	if slot0._originBgGo then
		gohelper.destroy(slot0._originBgGo)

		slot0._originBgGo = nil
	end

	slot0._imgLogo:UnLoadImage()
end

return slot0
