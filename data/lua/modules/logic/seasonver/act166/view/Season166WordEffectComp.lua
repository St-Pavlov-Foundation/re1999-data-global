module("modules.logic.seasonver.act166.view.Season166WordEffectComp", package.seeall)

local var_0_0 = class("Season166WordEffectComp", LuaCompBase)
local var_0_1 = "<size=40><alpha=#00>.<alpha=#ff></size>"
local var_0_2 = table.insert
local var_0_3 = string.gmatch

local function var_0_4(arg_1_0)
	if not arg_1_0 then
		return {}
	end

	local var_1_0 = {}

	for iter_1_0 in var_0_3(arg_1_0, "[%z\x01-\x7F\xC2-\xF4][\x80-\xBF]*") do
		if LangSettings.instance:isEn() and iter_1_0 == " " then
			iter_1_0 = var_0_1
		end

		var_0_2(var_1_0, iter_1_0)
	end

	return var_1_0
end

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._co = arg_2_1.co
	arg_2_0._res = arg_2_1.res
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0._line1 = gohelper.findChild(arg_3_1, "item/line1")
	arg_3_0._line2 = gohelper.findChild(arg_3_1, "item/line2")
	arg_3_0._effect = gohelper.findChild(arg_3_1, "item/effect")
	arg_3_0._animEffect = arg_3_0._effect:GetComponent(gohelper.Type_Animator)

	arg_3_0:createTxt()
end

function var_0_0.createTxt(arg_4_0)
	local var_4_0 = Season166Enum.WordTxtOpen + Season166Enum.WordTxtIdle + Season166Enum.WordTxtClose

	arg_4_0._allAnimWork = {}

	local var_4_1 = string.split(arg_4_0._co.desc, "\n")
	local var_4_2 = var_0_4(var_4_1[1]) or {}
	local var_4_3 = 0

	for iter_4_0 = 1, #var_4_2 do
		local var_4_4, var_4_5 = arg_4_0:getRes(arg_4_0._line1, false)

		var_4_5.text = var_4_2[iter_4_0]
		var_4_3 = var_4_3 + var_4_5.preferredWidth + Season166Enum.WordTxtPosXOffset

		local var_4_6 = var_4_5.transform.parent

		recthelper.setWidth(var_4_6, var_4_5.preferredWidth)
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "open",
			anim = var_4_4,
			time = (iter_4_0 - 1) * Season166Enum.WordTxtInterval
		})
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "close",
			anim = var_4_4,
			time = (iter_4_0 - 1) * Season166Enum.WordTxtInterval + var_4_0 - Season166Enum.WordTxtClose
		})
	end

	local var_4_7 = 0
	local var_4_8 = var_0_4(var_4_1[2]) or {}

	for iter_4_1 = 1, #var_4_8 do
		local var_4_9, var_4_10 = arg_4_0:getRes(arg_4_0._line2, false)

		var_4_10.text = var_4_8[iter_4_1]
		var_4_7 = var_4_7 + var_4_10.preferredWidth + Season166Enum.WordTxtPosXOffset

		local var_4_11 = var_4_10.transform.parent

		recthelper.setWidth(var_4_11, var_4_10.preferredWidth)
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "open",
			anim = var_4_9,
			time = (iter_4_1 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay
		})
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "close",
			anim = var_4_9,
			time = (iter_4_1 - 1) * Season166Enum.WordTxtInterval + Season166Enum.WordLine2Delay + var_4_0 - Season166Enum.WordTxtClose
		})
	end

	local var_4_12 = var_4_0 + Season166Enum.WordTxtInterval * (#var_4_2 - 1)
	local var_4_13 = 0

	if #var_4_8 > 0 then
		var_4_13 = var_4_0 + Season166Enum.WordTxtInterval * (#var_4_8 - 1)
	end

	local var_4_14 = math.max(var_4_12, var_4_13)

	table.insert(arg_4_0._allAnimWork, {
		showEndEffect = true,
		time = var_4_14 - Season166Enum.WordTxtClose
	})
	table.insert(arg_4_0._allAnimWork, {
		destroy = true,
		time = var_4_14
	})
	table.sort(arg_4_0._allAnimWork, var_0_0.sortAnim)
	arg_4_0:nextStep()
end

function var_0_0.nextStep(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.nextStep, arg_5_0)

	local var_5_0 = table.remove(arg_5_0._allAnimWork, 1)

	if not var_5_0 then
		return
	end

	if var_5_0.destroy then
		gohelper.destroy(arg_5_0.go)

		return
	elseif var_5_0.showEndEffect then
		arg_5_0._animEffect:Play(UIAnimationName.Close, 0, 0)
	elseif var_5_0.playAnim == "open" then
		var_5_0.anim.enabled = true
	else
		var_5_0.anim:Play(var_5_0.playAnim, 0, 0)
	end

	local var_5_1 = arg_5_0._allAnimWork[1]

	if not var_5_1 then
		return
	end

	TaskDispatcher.runDelay(arg_5_0.nextStep, arg_5_0, var_5_1.time - var_5_0.time)
end

function var_0_0.sortAnim(arg_6_0, arg_6_1)
	return arg_6_0.time < arg_6_1.time
end

local var_0_5 = typeof(UnityEngine.Animator)

function var_0_0.getRes(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = gohelper.clone(arg_7_0._res, arg_7_1)
	local var_7_1 = gohelper.findChildSingleImage(var_7_0, "img")
	local var_7_2 = gohelper.findChildTextMesh(var_7_0, "txt")
	local var_7_3 = var_7_0:GetComponent(var_0_5)

	gohelper.setActive(var_7_1, arg_7_2)
	gohelper.setActive(var_7_2, not arg_7_2)
	gohelper.setActive(var_7_0, true)
	var_7_3:Play("open", 0, 0)
	var_7_3:Update(0)

	var_7_3.enabled = false

	return var_7_3, arg_7_2 and var_7_1 or var_7_2
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.nextStep, arg_8_0)
end

return var_0_0
