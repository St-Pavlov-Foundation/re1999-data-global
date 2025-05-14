module("modules.logic.login.controller.LoginController", package.seeall)

local var_0_0 = class("LoginController", BaseController)
local var_0_1, var_0_2, var_0_3, var_0_4, var_0_5 = GameUrlConfig.getLoginUrls(false)
local var_0_6, var_0_7, var_0_8, var_0_9, var_0_10 = GameUrlConfig.getLoginUrls(true)

var_0_0.HeartBeatInterval = 10
var_0_0.MaxReconnectCount = 3

function var_0_0.get_getSessionIdUrl(arg_1_0, arg_1_1)
	return arg_1_1 and var_0_7 or var_0_2
end

function var_0_0.get_httpWebLoginUrl(arg_2_0, arg_2_1)
	return arg_2_1 and var_0_8 or var_0_3
end

function var_0_0.get_getServerListUrl(arg_3_0, arg_3_1)
	return arg_3_1 and var_0_9 or var_0_4
end

function var_0_0.get_startGameUrl(arg_4_0, arg_4_1)
	return arg_4_1 and var_0_10 or var_0_5
end

function var_0_0.onInit(arg_5_0)
	arg_5_0.enteredGame = false
end

function var_0_0.onInitFinish(arg_6_0)
	arg_6_0._moduleLoginFlow = FlowSequence.New()
	arg_6_0._moduleLoginFlow.flowName = "moduleLoginFlow"

	arg_6_0._moduleLoginFlow:addWork(LoginPreInfoWork.New())
	arg_6_0._moduleLoginFlow:addWork(LoginPreLoadWork.New())
	arg_6_0._moduleLoginFlow:addWork(LoginGetInfoWork.New())
	arg_6_0._moduleLoginFlow:addWork(LoginParseFightConfigWork.New())
	arg_6_0._moduleLoginFlow:addWork(LoginFirstGuideWork.New())
	arg_6_0._moduleLoginFlow:addWork(LoginEnterMainSceneWork.New())
	arg_6_0._moduleLoginFlow:registerDoneListener(arg_6_0._onModuleLoginDone, arg_6_0)

	arg_6_0._moduleLogoutFlow = FlowSequence.New()
	arg_6_0._moduleLogoutFlow.flowName = "moduleLogoutFlow"

	arg_6_0._moduleLogoutFlow:addWork(LogoutSocketWork.New())
	arg_6_0._moduleLogoutFlow:addWork(LogoutCleanWork.New())
	arg_6_0._moduleLogoutFlow:addWork(LogoutOpenLoginWork.New())
	arg_6_0._moduleLogoutFlow:registerDoneListener(arg_6_0._onModuleLogoutDone, arg_6_0)
end

function var_0_0.addConstEvents(arg_7_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, arg_7_0._onLostConnect, arg_7_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, arg_7_0._onReconnectSucc, arg_7_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectFail, arg_7_0._promptReconnectAgain, arg_7_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnServerKickedOut, arg_7_0._onServerKickedOut, arg_7_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostMessage, arg_7_0._onLostMessage, arg_7_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.StopLoading, arg_7_0._stopModuleLogin, arg_7_0)
end

function var_0_0.dispose(arg_8_0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostConnect, arg_8_0._onLostConnect, arg_8_0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnReconnectSucc, arg_8_0._onReconnectSucc, arg_8_0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnReconnectFail, arg_8_0._promptReconnectAgain, arg_8_0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnServerKickedOut, arg_8_0._onServerKickedOut, arg_8_0)
	ConnectAliveMgr.instance:unregisterCallback(ConnectEvent.OnLostMessage, arg_8_0._onLostMessage, arg_8_0)
	GameSceneMgr.instance:unregisterCallback(SceneEventName.StopLoading, arg_8_0._stopModuleLogin, arg_8_0)
	arg_8_0._moduleLoginFlow:stop()
	arg_8_0._moduleLogoutFlow:stop()
end

function var_0_0.reInit(arg_9_0)
	arg_9_0.enteredGame = false
end

function var_0_0.login(arg_10_0, arg_10_1)
	if canLogNormal then
		logNormal("LoginController:login" .. debug.traceback("", 2))
	end

	ViewMgr.instance:openView(ViewName.LoginView, arg_10_1, true)
end

function var_0_0.logout(arg_11_0, arg_11_1)
	if canLogNormal then
		logNormal("LoginController:logout" .. debug.traceback("", 2))
	end

	TimeDispatcher.instance:stopTick()
	arg_11_0:_moduleLogout(LuaSocketMgr.instance:isConnected(), false, arg_11_1)
end

function var_0_0.onSdkLogout(arg_12_0)
	LoginModel.instance:clearDatas()
	TimeDispatcher.instance:stopTick()

	if ViewMgr.instance:isOpen(ViewName.LoginView) then
		SDKMgr.instance:login()
	else
		arg_12_0:_moduleLogout(LuaSocketMgr.instance:isConnected(), true)
	end
end

function var_0_0.sdkLogout(arg_13_0)
	LoginModel.instance:clearDatas()
	SDKMgr.instance:logout()
end

function var_0_0.startLogin(arg_14_0)
	arg_14_0:_startLogin()
end

function var_0_0._startLogin(arg_15_0)
	if LoginModel.instance:isNotLogin() then
		arg_15_0:_startBlock()
		LoginModel.instance:doingLogin()

		arg_15_0._enableModuleLogin = true

		arg_15_0:_socketConnectAndLogin()
	elseif LoginModel.instance:isDoingLogin() then
		logError("正在登录游戏，无法重复登录")
	elseif LoginModel.instance:isDoneLogin() then
		logError("已经登录游戏，无法重复登录")
	end
end

function var_0_0._socketConnectAndLogin(arg_16_0)
	logNormal(string.format("login %s:%d  userName = %s  sessionId = %s", LoginModel.instance.serverIp, LoginModel.instance.serverPort, LoginModel.instance.userName, LoginModel.instance.sessionId))

	arg_16_0._callbackId = SystemLoginRpc.instance:addCallback(1, arg_16_0._onSystemLoginCallback, arg_16_0)

	local var_16_0 = LoginModel.instance.serverIp
	local var_16_1 = LoginModel.instance.serverPort

	if arg_16_0._useBak then
		var_16_0 = LoginModel.instance.serverBakIp
		var_16_1 = LoginModel.instance.serverBakPort
	end

	arg_16_0._systemLoginStatus = nil

	ConnectAliveMgr.instance:login(var_16_0, var_16_1, LoginModel.instance.userName, LoginModel.instance.sessionId, arg_16_0._onLogin, arg_16_0)
end

function var_0_0._startBlock(arg_17_0)
	UIBlockMgr.instance:startBlock(UIBlockKey.Login)
end

function var_0_0._endBlock(arg_18_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.Login)
end

function var_0_0._onSystemLoginCallback(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	arg_19_0._systemLoginStatus = arg_19_2

	arg_19_0:_removeSystemLoginCallback()
end

function var_0_0._removeSystemLoginCallback(arg_20_0)
	if arg_20_0._callbackId then
		SystemLoginRpc.instance:removeCallbackById(arg_20_0._callbackId)

		arg_20_0._callbackId = nil
	end
end

function var_0_0._onLogin(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_1 and not arg_21_0._useBak and not string.nilorempty(LoginModel.instance.serverBakIp) and arg_21_2 and arg_21_2.socketFail and not arg_21_0._systemLoginStatus then
		arg_21_0._useBak = true

		LoginModel.instance:notLogin()
		logNormal("业务层 登录失败，切换备用节点")
		TaskDispatcher.runDelay(arg_21_0._socketConnectAndLogin, arg_21_0, 0.5)

		return
	end

	arg_21_0:_removeSystemLoginCallback()
	arg_21_0:_endBlock()

	if arg_21_1 then
		LoginModel.instance:doneLogin()

		arg_21_0._reconectTimes = 0
		arg_21_0._enableModuleLogin = true

		logNormal("<color=#00FF00>业务层 登录成功，可以开始做逻辑了</color>")
		arg_21_0:_startHeartBeat()
		SDKController.instance:onLoginSuccess()
		StatController.instance:sendBaseProperties()
		arg_21_0:_moduleLogin()
	elseif not arg_21_0._systemLoginStatus then
		LoginModel.instance:notLogin()
		logNormal("<color=#FFA500>业务层 socket连接失败，请选择重连or取消</color>")
		var_0_0.instance:dispatchEvent(LoginEvent.SystemLoginFail)
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginFail, MsgBoxEnum.BoxType.Yes_No, function()
			arg_21_0:_socketConnectAndLogin()
		end, function()
			arg_21_0:logout()
		end)

		if arg_21_0._useBak then
			logError("业务层 登录失败，备用节点都不行")
		end
	elseif arg_21_0._systemLoginStatus ~= 0 then
		LoginModel.instance:notLogin()
		logNormal("<color=#FFA500>业务层 系统登录失败</color>")
		var_0_0.instance:dispatchEvent(LoginEvent.SystemLoginFail)

		local var_21_0 = arg_21_2 and arg_21_2.msg or "resultCode:" .. arg_21_0._systemLoginStatus

		MessageBoxController.instance:showSystemMsgBoxByStr(var_21_0, MsgBoxEnum.BoxType.Yes, function()
			arg_21_0:logout()
		end)
	else
		LoginModel.instance:notLogin()
		logNormal("系统登录失败，不能重连了，可能是黑号/write back now")
		var_0_0.instance:dispatchEvent(LoginEvent.SystemLoginFail)
		arg_21_0:logout()
	end

	arg_21_0._useBak = nil
end

function var_0_0._onLostMessage(arg_25_0)
	logNormal("<color=red>丢包了</color>")
	arg_25_0:_stopHeartBeat()

	arg_25_0._reconectTimes = 3

	arg_25_0:_promptReconnectAgain()
end

function var_0_0._onLostConnect(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0:_stopHeartBeat()
	arg_26_0:_promptReconnectAgain(arg_26_1, arg_26_2)
end

function var_0_0._delayReConnect(arg_27_0)
	ConnectAliveMgr.instance:reconnect()
end

function var_0_0._onReconnectSucc(arg_28_0)
	arg_28_0._reconectTimes = 0

	logNormal("<color=#00FF00>业务层 收到 断线重连成功</color>")
	arg_28_0:_startHeartBeat()
end

function var_0_0.stopReconnect(arg_29_0)
	ConnectAliveMgr.instance:reconnect()
end

function var_0_0._startHeartBeat(arg_30_0)
	TaskDispatcher.runRepeat(arg_30_0._sendHeartBeat, arg_30_0, var_0_0.HeartBeatInterval)
end

function var_0_0.stopHeartBeat(arg_31_0)
	TaskDispatcher.cancelTask(arg_31_0._sendHeartBeat, arg_31_0)
end

function var_0_0._stopHeartBeat(arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._sendHeartBeat, arg_32_0)
end

function var_0_0._sendHeartBeat(arg_33_0)
	CommonRpc.instance:sendGetServerTimeRequest()
end

function var_0_0._promptReconnectAgain(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0._reconectTimes = arg_34_0._reconectTimes + 1

	if arg_34_1 then
		MessageBoxController.instance:showMsgBoxByStr(arg_34_2, MsgBoxEnum.BoxType.Yes, function()
			arg_34_0._moduleLoginFlow:stop()
			var_0_0.instance:logout()
		end, nil)
	elseif arg_34_0._reconectTimes > var_0_0.MaxReconnectCount then
		logNormal("<color=#FFA500>断线重连次数过多，确认网络已断开，返回登陆界面</color>")
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect1, MsgBoxEnum.BoxType.Yes, function()
			arg_34_0._moduleLoginFlow:stop()
			var_0_0.instance:logout()
		end, nil)
	else
		UIBlockMgr.instance:endAll()
		logNormal("<color=#FFA500>业务层 收到 断线重连失败，需要用户操作</color>")
		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginLostConnect2, MsgBoxEnum.BoxType.Yes_No, function()
			ConnectAliveMgr.instance:reconnect()
		end, function()
			arg_34_0._moduleLoginFlow:stop()
			var_0_0.instance:logout()
		end)
	end
end

function var_0_0._tryReconnect(arg_39_0)
	ConnectAliveMgr.instance:reconnect()
end

function var_0_0._stopModuleLogin(arg_40_0)
	arg_40_0._enableModuleLogin = false
end

function var_0_0._onServerKickedOut(arg_41_0, arg_41_1, arg_41_2)
	ConnectAliveMgr.instance:logout()

	if arg_41_2 == -10 then
		logNormal("设备解绑，退出sdk")
		arg_41_0:sdkLogout()
	end

	arg_41_0:_stopHeartBeat()

	local var_41_0 = arg_41_1

	if lua_language_coder.configDict[arg_41_1] or lua_language_prefab.configDict[arg_41_1] then
		var_41_0 = luaLang(arg_41_1)
	end

	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.LoginReturn, MsgBoxEnum.BoxType.Yes, function()
		if arg_41_1 == "repeat login" and GameChannelConfig.isEfun() then
			arg_41_0:sdkLogout()
		else
			var_0_0.instance:logout()
		end
	end, nil, nil, nil, nil, nil, var_41_0)
end

function var_0_0._moduleLogin(arg_43_0)
	if not arg_43_0._enableModuleLogin then
		return
	end

	arg_43_0._moduleLoginFlow:start({})
end

function var_0_0._onModuleLoginDone(arg_44_0, arg_44_1)
	if arg_44_1 then
		logNormal("游戏登入流程结束，已进入主场景")
		TimeDispatcher.instance:startTick()
		var_0_0.instance:dispatchEvent(LoginEvent.OnLoginEnterMainScene)

		arg_44_0.enteredGame = true
	else
		logWarn("游戏登入流程失败！")
	end
end

function var_0_0._moduleLogout(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	arg_45_0.enteredGame = false

	TaskDispatcher.cancelTask(arg_45_0._socketConnectAndLogin, arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._delayReConnect, arg_45_0)
	TaskDispatcher.cancelTask(arg_45_0._tryReconnect, arg_45_0)
	arg_45_0:_stopHeartBeat()
	PopupController.instance:clear()
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_UI_Bus)
	var_0_0.instance:dispatchEvent(LoginEvent.OnBeginLogout)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.OpenLoading, SceneType.Main)
	arg_45_0._moduleLogoutFlow:start({
		isConnected = arg_45_1,
		isSdkLogout = arg_45_2,
		isVoicePackageDonwload = arg_45_3
	})
end

function var_0_0._onModuleLogoutDone(arg_46_0, arg_46_1)
	if arg_46_1 then
		logNormal("返回登陆界面")
	else
		logWarn("返回登陆失败！")
	end

	var_0_0.instance:dispatchEvent(LoginEvent.OnLogout)
	GameSceneMgr.instance:dispatchEvent(SceneEventName.CloseLoading)
end

function var_0_0.isEnteredGame(arg_47_0)
	return arg_47_0.enteredGame
end

var_0_0.instance = var_0_0.New()

return var_0_0
