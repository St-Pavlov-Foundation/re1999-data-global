module("modules.logic.survival.controller.work.SurvivalSummaryActNpcWork", package.seeall)

local var_0_0 = class("SurvivalSummaryActNpcWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.SurvivalSummaryNpcHUD = arg_1_1.SurvivalSummaryNpcHUD
	arg_1_0.bubbleList = {}
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = SurvivalMapHelper.instance:getScene()

	arg_2_0.npcDataList = var_2_0.actProgress.npcDataList
	arg_2_0.npcList = var_2_0.actProgress.npcList

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.npcList) do
		local var_2_1 = arg_2_0.npcDataList[iter_2_0]

		arg_2_0:createBubbleItem(var_2_1.id, var_2_1.upInfo, iter_2_1.go)
	end

	AudioMgr.instance:trigger(AudioEnum3_1.Survival.ui_mingdi_tansuo_bubble_eject)
	arg_2_0:onDone(true)
end

function var_0_0.createBubbleItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = gohelper.cloneInPlace(arg_3_0.SurvivalSummaryNpcHUD)

	gohelper.setActive(var_3_0, true)

	local var_3_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_0, SurvivalSummaryNpcHUD, arg_3_3)

	var_3_1:setData(arg_3_1, arg_3_2)
	table.insert(arg_3_0.bubbleList, var_3_1)
end

function var_0_0.playCloseAnim(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.bubbleList) do
		iter_4_1:playCloseAnim()
	end
end

function var_0_0.onDestroy(arg_5_0)
	var_0_0.super.onDestroy(arg_5_0)
end

return var_0_0
