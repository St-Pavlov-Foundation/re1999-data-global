module("modules.logic.survival.view.shelter.SurvivalDecreeSelectView", package.seeall)

local var_0_0 = class("SurvivalDecreeSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goItem = gohelper.findChild(arg_1_0.viewGO, "#go_Select/#scroll/Viewport/LayoutGroup/#go_Item")
	arg_1_0.goLayout = gohelper.findChild(arg_1_0.viewGO, "#go_Select/#scroll/Viewport/LayoutGroup")
	arg_1_0.sizeFitter = arg_1_0.goLayout:GetComponent(gohelper.Type_ContentSizeFitter)
	arg_1_0.layout = arg_1_0.goLayout:GetComponent(gohelper.Type_VerticalLayoutGroup)

	gohelper.setActive(arg_1_0.goItem, false)

	arg_1_0.itemList = {}
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:refreshParam()
	arg_4_0:refreshView()
	arg_4_0:playOpenAnim()
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:refreshParam()
	arg_5_0:refreshView()
end

function var_0_0.refreshParam(arg_6_0)
	arg_6_0.decreesProp = arg_6_0.viewParam.panel.decreesProp
end

function var_0_0.refreshView(arg_7_0)
	for iter_7_0 = 1, #arg_7_0.decreesProp.decreesId do
		arg_7_0:getItem(iter_7_0):updateItem(iter_7_0, arg_7_0.decreesProp.decreesId[iter_7_0])
	end
end

function var_0_0.getItem(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.itemList[arg_8_1]

	if not var_8_0 then
		local var_8_1 = gohelper.cloneInPlace(arg_8_0.goItem, tostring(arg_8_1))

		var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_1, SurvivalDecreeSelectItem)
		arg_8_0.itemList[arg_8_1] = var_8_0
	end

	return var_8_0
end

function var_0_0.playOpenAnim(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.itemList) do
		gohelper.setActive(iter_9_1.viewGO, false)
	end

	arg_9_0._animIndex = 0

	TaskDispatcher.runRepeat(arg_9_0._playItemOpenAnim, arg_9_0, 0.06, #arg_9_0.itemList)
end

function var_0_0._playItemOpenAnim(arg_10_0)
	arg_10_0._animIndex = arg_10_0._animIndex + 1

	local var_10_0 = arg_10_0.itemList[arg_10_0._animIndex]

	if var_10_0 then
		gohelper.setActive(var_10_0.viewGO, true)
	end

	if arg_10_0._animIndex >= #arg_10_0.itemList then
		TaskDispatcher.cancelTask(arg_10_0._playItemOpenAnim, arg_10_0)
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

return var_0_0
