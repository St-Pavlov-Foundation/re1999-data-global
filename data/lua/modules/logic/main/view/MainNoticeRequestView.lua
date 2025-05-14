module("modules.logic.main.view.MainNoticeRequestView", package.seeall)

local var_0_0 = class("MainNoticeRequestView", BaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

var_0_0.RequestCD = 600

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0, LuaEventSystem.Low)
	arg_4_0:requestNotice()
end

function var_0_0._onCloseView(arg_5_0)
	if ViewHelper.instance:checkViewOnTheTop(arg_5_0.viewName) then
		arg_5_0:requestNotice()
	end
end

function var_0_0.requestNotice(arg_6_0)
	local var_6_0 = MainController.instance:getLastRequestNoticeTime()

	if var_6_0 and Time.realtimeSinceStartup - var_6_0 < var_0_0.RequestCD then
		return
	end

	MainController.instance:setRequestNoticeTime()
	NoticeController.instance:startRequest()
end

return var_0_0
