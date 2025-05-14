module("modules.logic.login.view.ServerListItem", package.seeall)

local var_0_0 = class("ServerListItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._serverStateGOList = {}

	for iter_1_0 = 0, 2 do
		arg_1_0._serverStateGOList[iter_1_0] = gohelper.findChild(arg_1_1, "imgState" .. iter_1_0)
	end

	arg_1_0._txtServerName = gohelper.findChildText(arg_1_1, "Text")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0._txtServerName.text = arg_4_0._mo.name

	for iter_4_0 = 0, 2 do
		gohelper.setActive(arg_4_0._serverStateGOList[iter_4_0], iter_4_0 == arg_4_0._mo.state)
	end
end

function var_0_0._onClick(arg_5_0)
	LoginController.instance:dispatchEvent(LoginEvent.SelectServerItem, arg_5_0._mo)
	arg_5_0._view:closeThis()
end

return var_0_0
