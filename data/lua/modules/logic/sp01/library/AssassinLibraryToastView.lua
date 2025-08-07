module("modules.logic.sp01.library.AssassinLibraryToastView", package.seeall)

local var_0_0 = class("AssassinLibraryToastView", BaseView)
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
	arg_4_0._maxCount = 3
	arg_4_0._showNextToastInterval = 0.1
	arg_4_0.hadTask = false

	local var_4_0 = arg_4_0._gotemplate.transform

	arg_4_0._itemHeight = recthelper.getHeight(var_4_0)
	arg_4_0._itemWidth = recthelper.getWidth(var_4_0)

	recthelper.setAnchor(arg_4_0._gotemplate.transform, var_0_1, var_0_1)
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(AssassinController.instance, AssassinEvent.RecycleToast, arg_6_0._doRecycleAnimation, arg_6_0)
	arg_6_0:addToastMsgList(arg_6_0.viewParam)
end

function var_0_0.onUpdateParam(arg_7_0)
	arg_7_0:addToastMsgList(arg_7_0.viewParam)
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._showToast, arg_8_0)

	arg_8_0.hadTask = false
	arg_8_0.close = true
end

function var_0_0.addToastMsgList(arg_9_0, arg_9_1)
	if not arg_9_1 or arg_9_0.close then
		return
	end

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		arg_9_0:addToastMsg(iter_9_1)
	end
end

function var_0_0.addToastMsg(arg_10_0, arg_10_1)
	table.insert(arg_10_0._cacheMsgList, arg_10_1)

	if not arg_10_0.hadTask then
		arg_10_0:_showToast()
		TaskDispatcher.runRepeat(arg_10_0._showToast, arg_10_0, arg_10_0._showNextToastInterval)

		arg_10_0.hadTask = true
	end
end

function var_0_0._showToast(arg_11_0)
	local var_11_0 = table.remove(arg_11_0._cacheMsgList, 1)

	if not var_11_0 then
		TaskDispatcher.cancelTask(arg_11_0._showToast, arg_11_0)

		arg_11_0.hadTask = false

		return
	end

	local var_11_1 = table.remove(arg_11_0._freeList, 1)

	if not var_11_1 then
		local var_11_2 = gohelper.clone(arg_11_0._gotemplate, arg_11_0._gopoint)

		var_11_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_2, AssassinLibraryToastItem)
	end

	local var_11_3

	if #arg_11_0._usingList >= arg_11_0._maxCount then
		local var_11_4 = arg_11_0._usingList[1]

		arg_11_0:_doRecycleAnimation(var_11_4, true)
	end

	table.insert(arg_11_0._usingList, var_11_1)
	var_11_1:setMsg(var_11_0)
	var_11_1:appearAnimation(var_11_0)
	arg_11_0:_refreshAllItemsAnimation()
end

function var_0_0._doRecycleAnimation(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = tabletool.indexOf(arg_12_0._usingList, arg_12_1)

	if var_12_0 then
		table.remove(arg_12_0._usingList, var_12_0)
	end

	arg_12_1:clearAllTask()
	arg_12_1:quitAnimation(arg_12_0._recycleToast, arg_12_0)
end

function var_0_0._recycleToast(arg_13_0, arg_13_1)
	arg_13_1:reset()
	table.insert(arg_13_0._freeList, arg_13_1)

	if #arg_13_0._usingList <= 0 then
		arg_13_0:closeThis()
	end
end

function var_0_0._refreshAllItemsAnimation(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._usingList) do
		local var_14_1 = (1 - iter_14_0) * arg_14_0._itemHeight

		if iter_14_0 == #arg_14_0._usingList then
			recthelper.setAnchorY(iter_14_1.tr, var_14_1)
		else
			iter_14_1:upAnimation(var_14_1)
		end
	end
end

return var_0_0
