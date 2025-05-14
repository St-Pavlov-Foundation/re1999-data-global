module("modules.logic.toast.view.ToastView", package.seeall)

local var_0_0 = class("ToastView", BaseView)
local var_0_1 = 10000

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotemplate = gohelper.findChild(arg_1_0.viewGO, "#go_template")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "#go_point")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._usingList = {}
	arg_4_0._freeList = {}
	arg_4_0._cacheMsgList = {}
	arg_4_0._maxCount = 4
	arg_4_0.space = 5
	arg_4_0._showNextToastInterval = 0.1
	arg_4_0.hadTask = false

	local var_4_0 = arg_4_0._gotemplate.transform

	arg_4_0._itemHeight = recthelper.getHeight(var_4_0)
	arg_4_0._itemWidth = recthelper.getWidth(var_4_0)

	arg_4_0:_initExpandedSpace()
	recthelper.setAnchor(arg_4_0._gotemplate.transform, var_0_1, var_0_1)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onDestroyView(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:addToastMsg(arg_7_0.viewParam)

	local var_7_0 = ToastController.instance._msgList

	while #var_7_0 > 0 do
		arg_7_0:addToastMsg(table.remove(var_7_0, 1))
	end

	arg_7_0:addEventCb(ToastController.instance, ToastEvent.ShowToast, arg_7_0.addToastMsg, arg_7_0)
	arg_7_0:addEventCb(ToastController.instance, ToastEvent.RecycleToast, arg_7_0._doRecycleAnimation, arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0:removeEventCb(ToastController.instance, ToastEvent.ShowToast, arg_8_0.addToastMsg, arg_8_0)
	arg_8_0:removeEventCb(ToastController.instance, ToastEvent.RecycleToast, arg_8_0._doRecycleAnimation, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._showToast, arg_8_0)

	arg_8_0.hadTask = false
end

function var_0_0.addToastMsg(arg_9_0, arg_9_1)
	table.insert(arg_9_0._cacheMsgList, arg_9_1)

	if not arg_9_0.hadTask then
		arg_9_0:_showToast()
		TaskDispatcher.runRepeat(arg_9_0._showToast, arg_9_0, arg_9_0._showNextToastInterval)

		arg_9_0.hadTask = true
	end
end

function var_0_0._showToast(arg_10_0)
	local var_10_0 = table.remove(arg_10_0._cacheMsgList, 1)

	if not var_10_0 then
		TaskDispatcher.cancelTask(arg_10_0._showToast, arg_10_0)

		arg_10_0.hadTask = false

		return
	end

	local var_10_1 = table.remove(arg_10_0._freeList, 1)

	if not var_10_1 then
		local var_10_2 = gohelper.clone(arg_10_0._gotemplate, arg_10_0._gopoint)

		var_10_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_10_2, ToastItem)
	end

	local var_10_3

	if #arg_10_0._usingList >= arg_10_0._maxCount then
		local var_10_4 = arg_10_0._usingList[1]

		arg_10_0:_doRecycleAnimation(var_10_4, true)
	end

	table.insert(arg_10_0._usingList, var_10_1)
	var_10_1:setMsg(var_10_0)
	var_10_1:appearAnimation(var_10_0)
	arg_10_0:_refreshAllItemsAnimation()
end

function var_0_0._doRecycleAnimation(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = tabletool.indexOf(arg_11_0._usingList, arg_11_1)

	if var_11_0 then
		table.remove(arg_11_0._usingList, var_11_0)
	end

	arg_11_1:clearAllTask()
	arg_11_1:quitAnimation(arg_11_0._recycleToast, arg_11_0)
end

function var_0_0._recycleToast(arg_12_0, arg_12_1)
	arg_12_1:reset()
	table.insert(arg_12_0._freeList, arg_12_1)
end

function var_0_0._refreshAllItemsAnimation(arg_13_0)
	local var_13_0 = 0

	arg_13_0._preAnchorY = 0

	for iter_13_0 = 1, #arg_13_0._usingList do
		if iter_13_0 > 1 then
			local var_13_1 = arg_13_0._usingList[iter_13_0 - 1]:getToastItemHeight()
			local var_13_2 = arg_13_0._usingList[iter_13_0]:getToastItemHeight()
			local var_13_3 = var_13_1 > arg_13_0._templateMinHeight and var_13_2 > arg_13_0._templateMinHeight and arg_13_0._spaceWhenExpanded or arg_13_0.space

			var_13_0 = arg_13_0._preAnchorY - var_13_1 - var_13_3
		end

		arg_13_0._preAnchorY = var_13_0

		if iter_13_0 == #arg_13_0._usingList then
			recthelper.setAnchorY(arg_13_0._usingList[iter_13_0].tr, var_13_0)
		else
			arg_13_0._usingList[iter_13_0]:upAnimation(var_13_0)
		end
	end
end

function var_0_0._initExpandedSpace(arg_14_0)
	local var_14_0 = gohelper.findChild(arg_14_0.viewGO, "#go_template/#go_normal/bg").transform
	local var_14_1 = arg_14_0._gotemplate:GetComponent(typeof(UnityEngine.UI.LayoutElement))

	arg_14_0._spaceWhenExpanded = arg_14_0.space
	arg_14_0._templateMinHeight = var_14_1.minHeight

	if var_14_0.anchorMin.y == 0 and var_14_0.anchorMax.y == 1 then
		arg_14_0._spaceWhenExpanded = (var_14_0.offsetMax.y - var_14_0.offsetMin.y) * 0.5
	end
end

return var_0_0
