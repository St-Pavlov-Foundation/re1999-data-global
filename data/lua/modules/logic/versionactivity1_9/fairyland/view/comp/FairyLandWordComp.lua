module("modules.logic.versionactivity1_9.fairyland.view.comp.FairyLandWordComp", package.seeall)

local var_0_0 = class("FairyLandWordComp", LuaCompBase)
local var_0_1 = "<size=40><alpha=#00>.<alpha=#ff></size>"

local function var_0_2(arg_1_0)
	local var_1_0

	if LangSettings.instance:isEn() then
		var_1_0 = {
			string.byte(arg_1_0, 1, -1)
		}

		for iter_1_0 = 1, #var_1_0 do
			if var_1_0[iter_1_0] == 32 then
				var_1_0[iter_1_0] = var_0_1
			else
				var_1_0[iter_1_0] = string.char(var_1_0[iter_1_0])
			end
		end
	else
		var_1_0 = LuaUtil.getUCharArr(arg_1_0)
	end

	return var_1_0 or {}
end

var_0_0.WordInterval = 3.5
var_0_0.WordTxtPosYOffset = 5
var_0_0.WordTxtPosXOffset = 2
var_0_0.WordTxtInterval = 0.1
var_0_0.WordTxtOpen = 0.5
var_0_0.WordTxtIdle = 1.1
var_0_0.WordTxtClose = 0.5
var_0_0.WordLine2Delay = 1

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._co = arg_2_1.co
	arg_2_0._res1 = arg_2_1.res1
	arg_2_0._res2 = arg_2_1.res2
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1

	arg_3_0:createTxt()
end

function var_0_0.createTxt(arg_4_0)
	local var_4_0 = var_0_0.WordTxtOpen + var_0_0.WordTxtIdle + var_0_0.WordTxtClose

	arg_4_0._allAnimWork = {}

	local var_4_1 = arg_4_0._co.question
	local var_4_2 = var_0_2(var_4_1)
	local var_4_3 = 0
	local var_4_4 = 1

	for iter_4_0 = 1, #var_4_2 do
		local var_4_5, var_4_6 = arg_4_0:getRes(arg_4_0.go, arg_4_0._res1)

		var_4_6.text = var_4_2[iter_4_0]
		var_4_3 = var_4_3 + var_4_6.preferredWidth + var_0_0.WordTxtPosXOffset

		local var_4_7 = var_4_6.transform.parent

		recthelper.setWidth(var_4_7, var_4_6.preferredWidth)
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "open",
			anim = var_4_5,
			time = (var_4_4 - 1) * var_0_0.WordTxtInterval
		})

		var_4_4 = var_4_4 + 1
	end

	local var_4_8 = var_0_2(arg_4_0._co.answer)

	var_4_8[0] = "——"

	for iter_4_1 = 0, #var_4_8 do
		local var_4_9, var_4_10 = arg_4_0:getRes(arg_4_0.go, arg_4_0._res2)

		var_4_10.text = var_4_8[iter_4_1]
		var_4_3 = var_4_3 + var_4_10.preferredWidth + var_0_0.WordTxtPosXOffset

		local var_4_11 = var_4_10.transform.parent

		recthelper.setWidth(var_4_11, var_4_10.preferredWidth)
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "open",
			anim = var_4_9,
			time = (var_4_4 - 1) * var_0_0.WordTxtInterval
		})

		var_4_4 = var_4_4 + 1
	end

	local var_4_12 = var_4_0 + var_0_0.WordTxtInterval * (#var_4_2 - 1)
	local var_4_13 = 0

	if #var_4_8 > 0 then
		var_4_13 = var_4_0 + var_0_0.WordTxtInterval * (#var_4_8 - 1)
	end

	local var_4_14 = math.max(var_4_12, var_4_13)

	table.sort(arg_4_0._allAnimWork, var_0_0.sortAnim)
	recthelper.setAnchor(arg_4_0.go.transform, -var_4_3 + 40, 0)
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

local var_0_3 = typeof(UnityEngine.Animator)

function var_0_0.getRes(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = gohelper.clone(arg_7_2, arg_7_1)
	local var_7_1 = gohelper.findChildTextMesh(var_7_0, "txt")
	local var_7_2 = var_7_0:GetComponent(var_0_3)

	gohelper.setActive(var_7_0, true)
	var_7_2:Play("open", 0, 0)
	var_7_2:Update(0)

	var_7_2.enabled = false

	return var_7_2, var_7_1
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.nextStep, arg_8_0)
end

return var_0_0
