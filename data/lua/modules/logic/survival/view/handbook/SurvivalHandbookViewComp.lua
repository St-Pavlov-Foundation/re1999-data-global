module("modules.logic.survival.view.handbook.SurvivalHandbookViewComp", package.seeall)

local var_0_0 = class("SurvivalHandbookViewComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.canvasGroup = gohelper.onceAddComponent(arg_1_1, gohelper.Type_CanvasGroup)
end

function var_0_0.onOpen(arg_2_0)
	return
end

function var_0_0.onClose(arg_3_0)
	return
end

return var_0_0
