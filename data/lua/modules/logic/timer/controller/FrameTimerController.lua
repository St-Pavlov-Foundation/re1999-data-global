module("modules.logic.timer.controller.FrameTimerController", package.seeall)

local var_0_0 = class("FrameTimerController", BaseController)
local var_0_1 = _G.FrameTimer
local var_0_2 = table.insert
local var_0_3 = _G.rawset
local var_0_4 = _G.callWithCatch
local var_0_5 = {}
local var_0_6 = {}

local function var_0_7(arg_1_0)
	if not arg_1_0 then
		return
	end

	if not arg_1_0.func then
		return
	end

	arg_1_0:Stop()
	var_0_3(var_0_6, arg_1_0.func, nil)

	arg_1_0.func = nil

	var_0_2(var_0_5, arg_1_0)
end

local function var_0_8()
	for iter_2_0, iter_2_1 in pairs(var_0_6) do
		var_0_7(iter_2_1)
	end
end

function var_0_0.onInit(arg_3_0)
	arg_3_0:reInit()
end

function var_0_0.reInit(arg_4_0)
	var_0_8()
end

function var_0_0.register(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_3 = arg_5_3 or 3
	arg_5_4 = arg_5_4 or 1

	local var_5_0

	local function var_5_1()
		if arg_5_1 then
			var_0_4(arg_5_1, arg_5_2)
		end

		if var_5_0.loop <= 0 then
			var_0_7(var_5_0)
		end
	end

	if #var_0_5 > 0 then
		var_5_0 = table.remove(var_0_5)

		var_5_0:Reset(var_5_1, arg_5_3, arg_5_4)
	else
		var_5_0 = var_0_1.New(var_5_1, arg_5_3, arg_5_4)
	end

	var_0_6[var_5_1] = var_5_0

	return var_5_0
end

function var_0_0.unregister(arg_7_0, arg_7_1)
	var_0_7(arg_7_1)
end

function var_0_0.onDestroyViewMember(arg_8_0, arg_8_1)
	if arg_8_0[arg_8_1] then
		var_0_7(arg_8_0[arg_8_1])

		arg_8_0[arg_8_1] = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
