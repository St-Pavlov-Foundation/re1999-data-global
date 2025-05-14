module("modules.logic.gm.view.Checker_HeroVoiceMouth", package.seeall)

local var_0_0 = class("Checker_HeroVoiceMouth", Checker_Hero)
local var_0_1 = string.split
local var_0_2 = string.format
local var_0_3 = "auto_bizui|"
local var_0_4 = "pause"
local var_0_5 = "_auto"

local function var_0_6(arg_1_0)
	arg_1_0._okExec = true

	arg_1_0:appendLine(var_0_2("%s(%s) skin %s: ", arg_1_0:heroName(), arg_1_0:heroId(), arg_1_0:skinId()))
	arg_1_0:pushMarkLine()
	arg_1_0:addIndent()
end

local function var_0_7(arg_2_0)
	arg_2_0:subIndent()

	local var_2_0 = arg_2_0:popMarkLine()

	if arg_2_0._okExec then
		arg_2_0:pushIndent()
		arg_2_0:appendWithIndex(arg_2_0:makeColorStr("ok", Checker_Base.Color.Green), var_2_0)
		arg_2_0:popIndent()
	end
end

local function var_0_8(arg_3_0, arg_3_1)
	arg_3_0._okLoop = true

	arg_3_0:appendLine(var_0_2("audio %s: ", arg_3_1.audio))
	arg_3_0:pushMarkLine()
	arg_3_0:addIndent()
end

local function var_0_9(arg_4_0, arg_4_1)
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

local function var_0_10(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._okCheck = true

	arg_5_0:appendLine(var_0_2("%s: ", arg_5_2))
	arg_5_0:pushMarkLine()
	arg_5_0:addIndent()
end

local function var_0_11(arg_6_0, arg_6_1, arg_6_2)
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

	arg_7_0._mouthActionList = {
		[AudioMgr.instance:getIdFromString("Smallmouth")] = "xiao",
		[AudioMgr.instance:getIdFromString("Mediumsizedmouth")] = "zhong",
		[AudioMgr.instance:getIdFromString("Largemouth")] = "da"
	}
end

function var_0_0._onExec_Spine(arg_8_0, arg_8_1)
	arg_8_0:_onExecInner(arg_8_1, arg_8_1.hasAnimation)
end

function var_0_0._onExec_Live2d(arg_9_0, arg_9_1)
	arg_9_0:_onExecInner(arg_9_1, arg_9_1.hasExpression)
end

function var_0_0._onExecInner(arg_10_0, arg_10_1, arg_10_2)
	var_0_6(arg_10_0)

	local var_10_0 = arg_10_0:skincharacterVoiceCOList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		var_0_8(arg_10_0, iter_10_1)
		arg_10_0:_check(arg_10_1, arg_10_2, iter_10_1, "mouth")
		arg_10_0:_check(arg_10_1, arg_10_2, iter_10_1, "twmouth")
		arg_10_0:_check(arg_10_1, arg_10_2, iter_10_1, "jpmouth")
		arg_10_0:_check(arg_10_1, arg_10_2, iter_10_1, "enmouth")
		arg_10_0:_check(arg_10_1, arg_10_2, iter_10_1, "krmouth")
		var_0_9(arg_10_0, iter_10_1)
	end

	var_0_7(arg_10_0)
end

function var_0_0._check(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4)
	var_0_10(arg_11_0, arg_11_3, arg_11_4)
	arg_11_0:_onCheck(arg_11_1, arg_11_2, arg_11_3[arg_11_4])
	var_0_11(arg_11_0, arg_11_3, arg_11_4)
end

function var_0_0._onCheck(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if string.nilorempty(arg_12_3) then
		return
	end

	if string.find(arg_12_3, var_0_3) then
		local var_12_0 = StoryAnimName.T_BiZui

		if not arg_12_2(arg_12_1, var_12_0) then
			local var_12_1 = "not exist animation '" .. tostring(var_12_0) .. "'"

			arg_12_0:appendLine("'" .. var_0_3 .. "': " .. var_12_1)

			arg_12_0._okCheck = false
		end

		arg_12_3 = string.gsub(arg_12_3, var_0_3, "")
	end

	local var_12_2 = var_0_1(arg_12_3, "|")

	for iter_12_0 = #var_12_2, 1, -1 do
		local var_12_3 = var_12_2[iter_12_0]
		local var_12_4 = var_0_1(var_12_3, "#")
		local var_12_5 = ""

		if string.find(var_12_3, var_0_4) then
			-- block empty
		else
			local var_12_6 = "t_" .. tostring(var_12_4[1])

			if not (var_12_4[1] == var_0_5) and not arg_12_2(arg_12_1, var_12_6) then
				var_12_5 = "not exist animation '" .. tostring(var_12_6) .. "'"
			end

			local var_12_7 = tonumber(var_12_4[2])
			local var_12_8 = tonumber(var_12_4[3])
			local var_12_9

			if var_12_7 and var_12_8 then
				var_12_9 = var_12_8 - var_12_7
			end

			if not var_12_9 then
				if not var_12_7 then
					if var_12_5 ~= "" then
						var_12_5 = var_12_5 .. ","
					end

					var_12_5 = var_12_5 .. "startTime == nil"
				end

				if not var_12_8 then
					if var_12_5 ~= "" then
						var_12_5 = var_12_5 .. ","
					end

					var_12_5 = var_12_5 .. "endTime == nil"
				end
			elseif var_12_9 <= 0 then
				if var_12_5 ~= "" then
					var_12_5 = var_12_5 .. ","
				end

				var_12_5 = var_12_5 .. "duration <= 0"
			end
		end

		if var_12_5 ~= "" then
			arg_12_0:appendLine("'" .. var_12_3 .. "': " .. var_12_5)

			arg_12_0._okCheck = false
		end
	end
end

return var_0_0
