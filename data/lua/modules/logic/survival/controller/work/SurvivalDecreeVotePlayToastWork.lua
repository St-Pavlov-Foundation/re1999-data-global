module("modules.logic.survival.controller.work.SurvivalDecreeVotePlayToastWork", package.seeall)

local var_0_0 = class("SurvivalDecreeVotePlayToastWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.canJump = true

	arg_1_0:initParam(arg_1_1)
end

function var_0_0.initParam(arg_2_0, arg_2_1)
	arg_2_0.toastList = {}
	arg_2_0.goVoteState = arg_2_1.goVoteState
	arg_2_0.toastDataList = arg_2_1.toastDataList
	arg_2_0.goTipsItem = arg_2_1.goTipsItem
end

function var_0_0.onStart(arg_3_0)
	gohelper.setActive(arg_3_0.goVoteState, true)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.toastList) do
		gohelper.setActive(iter_3_1.go, false)
	end

	arg_3_0.toastCount = #arg_3_0.toastDataList
	arg_3_0.curToastIndex = 0

	if arg_3_0.toastCount > 0 then
		TaskDispatcher.runRepeat(arg_3_0.playNextToast, arg_3_0, 0.3, arg_3_0.toastCount)
	else
		arg_3_0:onPlayFinish()
	end
end

function var_0_0.playNextToast(arg_4_0)
	arg_4_0.curToastIndex = arg_4_0.curToastIndex + 1

	if arg_4_0.curToastIndex > arg_4_0.toastCount then
		return
	end

	local var_4_0 = arg_4_0:getToastItem(arg_4_0.curToastIndex)
	local var_4_1 = arg_4_0.toastDataList[arg_4_0.curToastIndex]
	local var_4_2 = var_4_1.config.name

	if var_4_1.isAgree then
		var_4_0.txt.text = formatLuaLang("survival_decreevote_tips_agree", var_4_2)
	else
		var_4_0.txt.text = formatLuaLang("survival_decreevote_tips_disagree", var_4_2)
	end

	gohelper.setActive(var_4_0.go, true)

	if arg_4_0.curToastIndex == arg_4_0.toastCount then
		arg_4_0:onPlayFinish()
	end
end

function var_0_0.getToastItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.toastList[arg_5_1]

	if not var_5_0 then
		var_5_0 = {
			go = gohelper.cloneInPlace(arg_5_0.goTipsItem)
		}
		var_5_0.txt = gohelper.findChildTextMesh(var_5_0.go, "#txt_Tips")
		arg_5_0.toastList[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_0.onPlayFinish(arg_6_0)
	arg_6_0:onDone(true)
end

function var_0_0.clearWork(arg_7_0)
	gohelper.setActive(arg_7_0.goVoteState, false)
	TaskDispatcher.cancelTask(arg_7_0.playNextToast, arg_7_0)
end

return var_0_0
