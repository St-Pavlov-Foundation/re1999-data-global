module("modules.logic.survival.view.bubble.SurvivalBubbleView", package.seeall)

local var_0_0 = class("SurvivalBubbleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.root = gohelper.findChild(arg_1_0.viewGO, "bubbleview")
	arg_1_0.res = gohelper.findChild(arg_1_0.root, "res")
	arg_1_0.container = gohelper.findChild(arg_1_0.root, "container")
	arg_1_0.bubbleItem = gohelper.findChild(arg_1_0.res, "bubbleItem")
	arg_1_0.survivalBubbleComp = SurvivalMapHelper.instance:getSurvivalBubbleComp()
	arg_1_0.bubbleDic = {}
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(arg_2_0.survivalBubbleComp, SurvivalEvent.OnShowBubble, arg_2_0.onShowBubble, arg_2_0)
	arg_2_0:addEventCb(arg_2_0.survivalBubbleComp, SurvivalEvent.OnRemoveBubble, arg_2_0.onRemoveBubble, arg_2_0)
end

function var_0_0.onOpen(arg_3_0)
	return
end

function var_0_0.onClose(arg_4_0)
	return
end

function var_0_0.onShowBubble(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.id
	local var_5_1 = arg_5_1.survivalBubble
	local var_5_2 = gohelper.clone(arg_5_0.bubbleItem, arg_5_0.container)
	local var_5_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_2, SurvivalDialogueItem)

	var_5_3:setData(var_5_0, var_5_1, arg_5_0.container)

	arg_5_0.bubbleDic[var_5_0] = var_5_3
end

function var_0_0.onRemoveBubble(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.id

	gohelper.destroy(arg_6_0.bubbleDic[var_6_0].go)

	arg_6_0.bubbleDic[var_6_0] = nil
end

function var_0_0.onDestroyView(arg_7_0)
	return
end

return var_0_0
