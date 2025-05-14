module("modules.logic.versionactivity2_2.act173.controller.Activity173Controller", package.seeall)

local var_0_0 = class("Activity173Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.onInitFinish(arg_3_0)
	return
end

function var_0_0.addConstEvents(arg_4_0)
	return
end

function var_0_0.openActivity173FullView(arg_5_0)
	ViewMgr.instance:openView(ViewName.Activity173FullView)
end

function var_0_0.numberDisplay(arg_6_0)
	local var_6_0 = tonumber(arg_6_0)

	if var_6_0 <= 9999 then
		return var_6_0
	else
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("activity173panelview_tenThousand"), math.floor(var_6_0 / 10000))
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
