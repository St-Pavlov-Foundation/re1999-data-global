module("modules.logic.toughbattle.view.ToughBattleWordComp", package.seeall)

local var_0_0 = class("ToughBattleWordComp", LuaCompBase)
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

function var_0_0.ctor(arg_2_0, arg_2_1)
	arg_2_0._co = arg_2_1.co
	arg_2_0._res = arg_2_1.res
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0.go = arg_3_1
	arg_3_0._sign = gohelper.findChild(arg_3_1, "sign")
	arg_3_0._line1 = gohelper.findChild(arg_3_1, "line1")
	arg_3_0._line2 = gohelper.findChild(arg_3_1, "line2")

	arg_3_0:createTxt()
end

function var_0_0.createTxt(arg_4_0)
	local var_4_0 = ToughBattleEnum.WordTxtOpen + ToughBattleEnum.WordTxtIdle + ToughBattleEnum.WordTxtClose

	arg_4_0._allAnimWork = {}

	local var_4_1, var_4_2 = arg_4_0:getRes(arg_4_0._sign, true)

	var_4_2:LoadImage(ResUrl.getSignature(arg_4_0._co.sign))

	local var_4_3 = string.split(arg_4_0._co.desc, "\n")
	local var_4_4 = var_0_2(var_4_3[1])

	for iter_4_0 = 1, #var_4_4 do
		local var_4_5, var_4_6 = arg_4_0:getRes(arg_4_0._line1, false)

		var_4_6.text = var_4_4[iter_4_0]

		local var_4_7 = var_4_6.transform.parent

		recthelper.setWidth(var_4_7, var_4_6.preferredWidth)
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "open",
			anim = var_4_5,
			time = (iter_4_0 - 1) * ToughBattleEnum.WordTxtInterval
		})
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "close",
			anim = var_4_5,
			time = (iter_4_0 - 1) * ToughBattleEnum.WordTxtInterval + var_4_0 - ToughBattleEnum.WordTxtClose
		})
	end

	local var_4_8 = var_0_2(var_4_3[2])

	for iter_4_1 = 1, #var_4_8 do
		local var_4_9, var_4_10 = arg_4_0:getRes(arg_4_0._line2, false)

		var_4_10.text = var_4_8[iter_4_1]

		local var_4_11 = var_4_10.transform.parent

		recthelper.setWidth(var_4_11, var_4_10.preferredWidth)
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "open",
			anim = var_4_9,
			time = (iter_4_1 - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordLine2Delay
		})
		table.insert(arg_4_0._allAnimWork, {
			playAnim = "close",
			anim = var_4_9,
			time = (iter_4_1 - 1) * ToughBattleEnum.WordTxtInterval + ToughBattleEnum.WordLine2Delay + var_4_0 - ToughBattleEnum.WordTxtClose
		})
	end

	table.insert(arg_4_0._allAnimWork, {
		playAnim = "open",
		time = 0,
		anim = var_4_1
	})

	local var_4_12 = var_4_0 + ToughBattleEnum.WordTxtInterval * (#var_4_4 - 1)
	local var_4_13 = 0

	if #var_4_8 > 0 then
		var_4_13 = var_4_0 + ToughBattleEnum.WordTxtInterval * (#var_4_8 - 1)
	end

	local var_4_14 = math.max(var_4_12, var_4_13)

	table.insert(arg_4_0._allAnimWork, {
		playAnim = "close",
		anim = var_4_1,
		time = var_4_14 - ToughBattleEnum.WordTxtClose
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
	local var_7_0 = gohelper.clone(arg_7_0._res, arg_7_1)
	local var_7_1 = gohelper.findChildSingleImage(var_7_0, "img")
	local var_7_2 = gohelper.findChildTextMesh(var_7_0, "txt")
	local var_7_3 = var_7_0:GetComponent(var_0_3)

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
