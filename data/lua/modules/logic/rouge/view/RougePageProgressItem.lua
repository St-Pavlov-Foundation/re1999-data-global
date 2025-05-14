module("modules.logic.rouge.view.RougePageProgressItem", package.seeall)

local var_0_0 = class("RougePageProgressItem", UserDataDispose)
local var_0_1 = {
	line2 = 3,
	line1 = 2,
	finished = 0,
	line3 = 4,
	unfinished = 1
}

var_0_0.LineStateEnum = {
	Edit = 2,
	Locked = 3,
	Done = 1
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._parent = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1.gameObject
	arg_2_0._transFinished = arg_2_1:GetChild(var_0_1.finished)
	arg_2_0._transUnFinished = arg_2_1:GetChild(var_0_1.unfinished)
	arg_2_0._transLine1 = arg_2_1:GetChild(var_0_1.line1)
	arg_2_0._transLine2 = arg_2_1:GetChild(var_0_1.line2)
	arg_2_0._transLine3 = arg_2_1:GetChild(var_0_1.line3)
end

function var_0_0.setActive(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.viewGO, arg_3_1)
end

function var_0_0.setHighLight(arg_4_0, arg_4_1)
	GameUtil.setActive01(arg_4_0._transFinished, arg_4_1)
	GameUtil.setActive01(arg_4_0._transUnFinished, not arg_4_1)
end

function var_0_0.setLineActive(arg_5_0, arg_5_1, arg_5_2)
	GameUtil.setActive01(arg_5_0["_transLine" .. arg_5_1], arg_5_2)
end

function var_0_0.setLineActiveByState(arg_6_0, arg_6_1)
	GameUtil.setActive01(arg_6_0._transLine1, arg_6_1 == var_0_0.LineStateEnum.Done)
	GameUtil.setActive01(arg_6_0._transLine2, arg_6_1 == var_0_0.LineStateEnum.Edit)
	GameUtil.setActive01(arg_6_0._transLine3, arg_6_1 == var_0_0.LineStateEnum.Locked)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0:onDestroyView()
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0:__onDispose()
end

return var_0_0
