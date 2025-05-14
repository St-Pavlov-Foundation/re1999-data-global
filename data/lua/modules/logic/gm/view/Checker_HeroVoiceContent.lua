module("modules.logic.gm.view.Checker_HeroVoiceContent", package.seeall)

local var_0_0 = class("Checker_HeroVoiceContent", Checker_Hero)
local var_0_1 = string.split
local var_0_2 = string.format

local function var_0_3(arg_1_0)
	arg_1_0._okExec = true

	arg_1_0:appendLine(var_0_2("%s(%s) skin %s: ", arg_1_0:heroName(), arg_1_0:heroId(), arg_1_0:skinId()))
	arg_1_0:pushMarkLine()
	arg_1_0:addIndent()
end

local function var_0_4(arg_2_0)
	arg_2_0:subIndent()

	local var_2_0 = arg_2_0:popMarkLine()

	if arg_2_0._okExec then
		arg_2_0:pushIndent()
		arg_2_0:appendWithIndex(arg_2_0:makeColorStr("ok", Checker_Base.Color.Green), var_2_0)
		arg_2_0:popIndent()
	end
end

local function var_0_5(arg_3_0, arg_3_1)
	arg_3_0._okLoop = true

	arg_3_0:appendLine(var_0_2("audio %s: ", arg_3_1.audio))
	arg_3_0:pushMarkLine()
	arg_3_0:addIndent()
end

local function var_0_6(arg_4_0, arg_4_1)
	arg_4_0:subIndent()

	local var_4_0 = arg_4_0:popMarkLine()

	if arg_4_0._okLoop then
		arg_4_0:pushIndent()
		arg_4_0:appendWithIndex(arg_4_0:makeColorStr("ok", Checker_Base.Color.Green), var_4_0)
		arg_4_0:popIndent()
	else
		arg_4_0._okExec = false
	end
end

local function var_0_7(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._okCheck = true

	arg_5_0:appendLine(var_0_2("%s: ", arg_5_2))
	arg_5_0:pushMarkLine()
	arg_5_0:addIndent()
end

local function var_0_8(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:subIndent()

	local var_6_0 = arg_6_0:popMarkLine()

	if arg_6_0._okCheck then
		arg_6_0:pushIndent()
		arg_6_0:appendWithIndex(arg_6_0:makeColorStr("ok", Checker_Base.Color.Green), var_6_0)
		arg_6_0:popIndent()
	else
		arg_6_0._okLoop = false
	end
end

function var_0_0.ctor(arg_7_0, ...)
	Checker_Hero.ctor(arg_7_0, ...)
end

function var_0_0._onExec_Spine(arg_8_0, arg_8_1)
	arg_8_0:_onExecInner(arg_8_1)
end

function var_0_0._onExec_Live2d(arg_9_0, arg_9_1)
	arg_9_0:_onExecInner(arg_9_1)
end

function var_0_0._onExecInner(arg_10_0, arg_10_1)
	var_0_3(arg_10_0)

	local var_10_0 = arg_10_0:skincharacterVoiceCOList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		var_0_5(arg_10_0, iter_10_1)
		arg_10_0:_check(arg_10_1, iter_10_1, "content")
		arg_10_0:_check(arg_10_1, iter_10_1, "twcontent")
		arg_10_0:_check(arg_10_1, iter_10_1, "jpcontent")
		arg_10_0:_check(arg_10_1, iter_10_1, "encontent")
		arg_10_0:_check(arg_10_1, iter_10_1, "krcontent")
		var_0_6(arg_10_0, iter_10_1)
	end

	var_0_4(arg_10_0)
end

function var_0_0._check(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	var_0_7(arg_11_0, arg_11_2, arg_11_3)
	arg_11_0:_onCheck(arg_11_1, arg_11_2[arg_11_3])
	var_0_8(arg_11_0, arg_11_2, arg_11_3)
end

function var_0_0._onCheck(arg_12_0, arg_12_1, arg_12_2)
	if string.nilorempty(arg_12_2) then
		return
	end

	local var_12_0 = var_0_1(arg_12_2, "|")

	for iter_12_0 = #var_12_0, 1, -1 do
		local var_12_1 = var_12_0[iter_12_0]
		local var_12_2 = var_0_1(var_12_1, "#")
		local var_12_3 = var_12_2[1]

		if not string.nilorempty(var_12_3) then
			local var_12_4 = tonumber(var_12_2[2])
			local var_12_5 = ""

			if string.nilorempty(var_12_4) then
				var_12_5 = "没有配置时间"
			elseif var_12_4 < 0 then
				if var_12_5 ~= "" then
					var_12_5 = var_12_5 .. ","
				end

				var_12_5 = var_12_5 .. "startTime(" .. tostring(var_12_4) .. ") < 0"
			end

			if var_12_5 ~= "" then
				arg_12_0:appendLine("'" .. var_12_1 .. "': " .. var_12_5)

				arg_12_0._okCheck = false
			end
		end
	end
end

return var_0_0
