module("modules.logic.login.controller.LoginController", package.seeall)

slot0 = class("LoginController", BaseController)
slot1, slot2, slot3, slot4, slot5 = GameUrlConfig.getLoginUrls(false)
slot6, slot7, slot8, slot9, slot10 = GameUrlConfig.getLoginUrls(true)
slot0.HeartBeatInterval = 10
slot0.MaxReconnectCount = 3

function slot0.get_getSessionIdUrl(slot0, slot1)
	return slot1 and uv0 or uv1
end

function slot0.get_httpWebLoginUrl(slot0, slot1)
	return slot1 and uv0 or uv1
end

function slot0.get_getServerListUrl(slot0, slot1)
	return slot1 and uv0 or uv1
end

function slot0.get_startGameUrl(slot0, slot1)
	return slot1 and uv0 or uv1
end

function slot0.onInit(slot0)
	slot0.enteredGame = false
end

function slot0.onInitFinish(slot0)
	slot0._moduleLoginFlow = FlowSequence.New()
	slot0._moduleLoginFlow.flowName = "moduleLoginFlow"

	slot0._moduleLoginFlow:addWork(LoginPreInfoWork.New())
	slot0._moduleLoginFlow:addWork(LoginPreLoadWork.New())
	slot0._moduleLoginFlow:addWork(LoginGetInfoWork.New())
	slot0._moduleLoginFlow:addWork(LoginParseFightConfigWork.New())
	slot0._moduleLoginFlow:addWork(LoginFirstGuideWork.New())
	slot0._moduleLoginFlow:addWork(LoginEnterMainSceneWork.New())
	slot0._moduleLoginFlow:registerDoneListener(slot0._onModuleLoginDone, slot0)

	slot0._moduleLogoutFlow = FlowSequence.New()
	slot0._moduleLogoutFlow.flowName = "moduleLogoutFlow"

	slot0._moduleLogoutFlow:addWork(LogoutSocketWork.New())
	slot0._moduleLogoutFlow:addWork(LogoutCleanWork.New())
	slot0._moduleLogoutFlow:addWork(LogoutOpenLoginWork.New())
	slot0._moduleLogoutFlow:registerDoneListener(slot0._onModuleLogoutDone, slot0)
end

function slot0.addConstEvents(slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, slot0._onLostConnect, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, slot0._onReconnectSucc, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectFail, slot0._promptReconnectAgain, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnServerKickedOut, slot0._onServerKickedOut, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostMessage, slot0._onLostMessage, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.StopLoading, slot0._stopModuleLogin, slot0)
end

function slot0.dispose(slot0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostConnect, slot0._onLostConnect, slot0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnReconnectSucc, slot0._onReconnectSucc, slot0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnReconnectFail, slot0._promptReconnectAgain, slot0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnServerKickedOut, slot0._onServerKickedOut, slot0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostMessage, slot0._onLostMessage, slot0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.StopLoading, slot0._stopModuleLogin, slot0)
	slot0._moduleLoginFlow:stop()
	slot0._moduleLogoutFlow:stop()
end

function slot0.reInit(slot0)
	slot0.enteredGame = false
end

function slot0.login(slot0, slot1)
	if canLogNormal then
		logNormal("LoginController:login" .. debug.traceback("", 2))
	end

	ViewMgr.instance:openView(ViewName.LoginView, slot1, true)
end

function slot0.logout(slot0, slot1)
	if canLogNormal then
		logNormal("LoginController:logout" .. debug.traceback("", 2))
	end

	TimeDispatcher.instance:stopTick()
	slot0:_moduleLogout(LuaSocketMgr.instance:isConnected(), false, slot1)
end

function slot0.onSdkLogout(slot0)
	LoginModel.instance:clearDatas()
	TimeDispatcher.instance:stopTick()

	if ViewMgr.instance:isOpen(ViewName.LoginView) then
		SDKMgr.instance:login()
	else
		slot0:_moduleLogout(LuaSocketMgr.instance:isConnected(), true)
	end
end

function slot0.sdkLogout(slot0)
	LoginModel.instance:clearDatas()
	SDKMgr.instance:logout()
end

function slot0.startLogin(slot0)
	slot0:_startLogin()
end

function slot0._startLogin(slot0)
	if LoginModel.instance:isNotLogin() then
		slot0:_startBlock()
		LoginModel.instance:doingLogin()

		slot0._enableModuleLogin = true

		slot0:_socketConnectAndLogin()
	elseif LoginModel.instance:isDoingLogin() then
		logError("正在登录游戏，无法重复登录")
	elseif LoginModel.instance:isDoneLogin() then
		logError("已经登录游戏，无法重复登录")
	end
end

function slot0._socketConnectAndLogin(slot0)
	logNormal(string.format("login %s:%d  userName = %s  sessionId = %s", LoginModel.instance.serverIp, LoginModel.instance.serverPort, LoginModel.instance.userName, LoginModel.instance.sessionId))

	slot0._callbackId = SystemLoginRpc.instance:addCallback(1, slot0._onSystemLoginCallback, slot0)
	slot1 = LoginModel.instance.serverIp
	slot2 = LoginModel.instance.serverPort

	if slot0._useBak then
		slot1 = LoginModel.instance.serverBakIp
		slot2 = LoginModel.instance.serverBakPort
	end

	slot0._systemLoginStatus = nil

	ConnectAliveMgr.instance:login(slot1, slot2, LoginModel.instance.userName, LoginModel.instance.sessionId, slot0._onLogin, slot0)
end

function slot0._startBlock(slot0)
	UIBlockMgr.instance:startBlock(UIBlockKey.Login)
end

function slot0._endBlock(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.Login)
end

function slot0._onSystemLoginCallback(slot0, slot1, slot2, slot3)
	slot0._systemLoginStatus = slot2

	slot0:_removeSystemLoginCallback()
end

function slot0._removeSystemLoginCallback(slot0)
	if slot0._callbackId then
		SystemLoginRpc.instance:removeCallbackById(slot0._callbackId)

		slot0._callbackId = nil
	end
end

function slot0._onLogin(slot0, slot1, slot2)
	if not slot1 and not slot0._useBak and not string.nilorempty(LoginModel.instance.serverBakIp) and slot2 and slot2.socketFail and not slot0._systemLoginStatus then
		slot0._useBak = true

		LoginModel.instance:notLogin()
		logNormal("业务层 登录失败，切换备用节点")
		TaskDispatcher.runDelay(slot0._socketConnectAndLogin, slot0, 0.5)

		return
	end

	slot0:_removeSystemLoginCallback()
	slot0:_endBlock()

	if slot1 then
		LoginModel.instance:doneLogin()

		slot0._reconectTimes = 0
		slot0._enableModuleLogin = true

		logNormal("<color=#00FF00>业务层 登录成功，可以开始做逻辑了</color>")
		slot0:_startHeartBeat()
		SDKController.instance:onLoginSuccess()
		StatController.instance:sendBaseProperties()
		slot0:_moduleLogin()
	elseif not slot0._systemLoginStatus then
		LoginModel.instance:notLogin()
		logNormal("<color=#FFA500>业务层 socket连接失败，请选择重连or取消</color>")
		uv0.instance:dispatchEvent(LoginEvent.SystemLoginFail)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginFail, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0:_socketConnectAndLogin()
		end, function ()
			uv0:logout()
		end)

		if slot0._useBak then
			logError("业务层 登录失败，备用节点都不行")
		end
	elseif slot0._systemLoginStatus ~= 0 then
		LoginModel.instance:notLogin()
		logNormal("<color=#FFA500>业务层 系统登录失败</color>")
		uv0.instance:dispatchEvent(LoginEvent.SystemLoginFail)
		MessageBoxController.instance:showSystemMsgBoxByStr(slot2 and slot2.msg or "resultCode:" .. slot0._systemLoginStatus, MsgBoxEnum.BoxType.Yes, function ()
			uv0:logout()
		end)
	else
		LoginModel.instance:notLogin()
		logNormal("系统登录失败，不能重连了，可能是黑号/write back now")
		uv0.instance:dispatchEvent(LoginEvent.SystemLoginFail)
		slot0:logout()
	end

	slot0._useBak = nil
end

function slot0._onLostMessage(slot0)
	logNormal("<color=red>丢包了</color>")
	slot0:_stopHeartBeat()

	slot0._reconectTimes = 3

	slot0:_promptReconnectAgain()
end

function slot0._onLostConnect(slot0, slot1, slot2)
	slot0:_stopHeartBeat()
	slot0:_promptReconnectAgain(slot1, slot2)
end

function slot0._delayReConnect(slot0)
	ConnectAliveMgr.instance:reconnect()
end

function slot0._onReconnectSucc(slot0)
	slot0._reconectTimes = 0

	logNormal("<color=#00FF00>业务层 收到 断线重连成功</color>")
	slot0:_startHeartBeat()
end

function slot0.stopReconnect(slot0)
	ConnectAliveMgr.instance:reconnect()
end

function slot0._startHeartBeat(slot0)
	TaskDispatcher.runRepeat(slot0._sendHeartBeat, slot0, uv0.HeartBeatInterval)
end

function slot0.stopHeartBeat(slot0)
	TaskDispatcher.cancelTask(slot0._sendHeartBeat, slot0)
end

function slot0._stopHeartBeat(slot0)
	TaskDispatcher.cancelTask(slot0._sendHeartBeat, slot0)
end

function slot0._sendHeartBeat(slot0)
	CommonRpc.instance:sendGetServerTimeRequest()
end

function slot0._promptReconnectAgain(slot0, slot1, slot2)
	slot0._reconectTimes = slot0._reconectTimes + 1

	if slot1 then
		MessageBoxController.instance:showMsgBoxByStr(slot2, MsgBoxEnum.BoxType.Yes, function ()
			uv0._moduleLoginFlow:stop()
			uv1.instance:logout()
		end, nil)
	elseif uv0.MaxReconnectCount < slot0._reconectTimes then
		logNormal("<color=#FFA500>断线重连次数过多，确认网络已断开，返回登陆界面</color>")
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function ()
			uv0._moduleLoginFlow:stop()
			uv1.instance:logout()
		end, nil)
	else
		UIBlockMgr.instance:endAll()
		logNormal("<color=#FFA500>业务层 收到 断线重连失败，需要用户操作</color>")
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect2, MsgBoxEnum.BoxType.Yes_No, function ()
			ConnectAliveMgr.instance:reconnect()
		end, function ()
			uv0._moduleLoginFlow:stop()
			uv1.instance:logout()
		end)
	end
end

function slot0._tryReconnect(slot0)
	ConnectAliveMgr.instance:reconnect()
end

function slot0._stopModuleLogin(slot0)
	slot0._enableModuleLogin = false
end

function slot0._onServerKickedOut(slot0, slot1, slot2)
	ConnectAliveMgr.instance:logout()

	if slot2 == -10 then
		logNormal("设备解绑，退出sdk")
		slot0:sdkLogout()
	end

	slot0:_stopHeartBeat()

	slot3 = slot1

	if lua_language_coder.configDict[slot1] or lua_language_prefab.configDict[slot1] then
		slot3 = luaLang(slot1)
	end

	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginReturn, MsgBoxEnum.BoxType.Yes, function ()
		if uv0 == "repeat login" and GameChannelConfig.isEfun() then
			uv1:sdkLogout()
		else
			uv2.instance:logout()
		end
	end, nil, , , , , slot3)
end

function slot0._moduleLogin(slot0)
	if not slot0._enableModuleLogin then
		return
	end

	slot0._moduleLoginFlow:start({})
end

function slot0._onModuleLoginDone(slot0, slot1)
	if slot1 then
		logNormal("游戏登入流程结束，已进入主场景")
		TimeDispatcher.instance:startTick()
		uv0.instance:dispatchEvent(LoginEvent.OnLoginEnterMainScene)

		slot0.enteredGame = true
	else
		logWarn("游戏登入流程失败！")
	end
end

function slot0._moduleLogout(slot0, slot1, slot2, slot3)
	slot0.enteredGame = false

	TaskDispatcher.cancelTask(slot0._socketConnectAndLogin, slot0)
	TaskDispatcher.cancelTask(slot0._delayReConnect, slot0)
	TaskDispatcher.cancelTask(slot0._tryReconnect, slot0)
	slot0:_stopHeartBeat()
	PopupController.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	uv0.instance:dispatchEvent(LoginEvent.OnBeginLogout)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	slot0._moduleLogoutFlow:start({
		isConnected = slot1,
		isSdkLogout = slot2,
		isVoicePackageDonwload = slot3
	})
end

function slot0._onModuleLogoutDone(slot0, slot1)
	if slot1 then
		logNormal("返回登陆界面")
	else
		logWarn("返回登陆失败！")
	end

	uv0.instance:dispatchEvent(LoginEvent.OnLogout)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function slot0.isEnteredGame(slot0)
	return slot0.enteredGame
end

slot0.instance = slot0.New()

return slot0
