module("modules.logic.common.prerecvmsg.PreReciveLogicMsg", package.seeall)

local var_0_0 = class("PreReciveLogicMsg", BasePreReceiver)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0)
	LuaSocketMgr.instance:registerPreReceiver(arg_2_0)
end

function var_0_0.preReceiveMsg(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6)
	if arg_3_1 == 0 then
		return
	end

	if not lua_toast.configDict[arg_3_1] then
		logError("PreReciveLogicMsg:preReceiveMsg 没有为业务错误码：" .. arg_3_1 .. " 配置提示语！！《P飘字表》- export_飘字表")

		return
	end

	GameFacade.showToast(arg_3_1)
end

function var_0_0.preReceiveSysMsg(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	if arg_4_1 == 0 then
		return
	end

	LoginController.instance:_stopHeartBeat()
	GameSceneMgr.instance:dispatchEvent(SceneEventName.StopLoading)
	MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.ForbidLogin, MsgBoxEnum.BoxType.Yes, function()
		LoginController.instance:logout()
	end, nil, nil, nil, nil, nil, arg_4_4.reason)
end

var_0_0.instance = var_0_0.New()

return var_0_0
