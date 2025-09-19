module("modules.logic.survival.view.map.SurvivalToastView", package.seeall)

local var_0_0 = class("SurvivalToastView", BaseView)
local var_0_1 = 10000

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotemplate = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "#go_root")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._usingList = {}
	arg_2_0._freeList = {}
	arg_2_0._cacheMsgList = {}
	arg_2_0._maxCount = 3
	arg_2_0._showNextToastInterval = 0.1
	arg_2_0.hadTask = false

	recthelper.setAnchor(arg_2_0._gotemplate.transform, var_0_1, var_0_1)
end

function var_0_0.onOpen(arg_3_0)
	tabletool.addValues(arg_3_0._cacheMsgList, SurvivalMapModel.instance.showToastList)
	tabletool.clear(SurvivalMapModel.instance.showToastList)
	arg_3_0:addToastMsg()
	arg_3_0:addEventCb(SurvivalController.instance, SurvivalEvent.ShowToast, arg_3_0.addToastMsg, arg_3_0)
	arg_3_0:addEventCb(SurvivalController.instance, SurvivalEvent.RecycleToast, arg_3_0._doRecycleAnimation, arg_3_0)
end

function var_0_0.onClose(arg_4_0)
	arg_4_0:removeEventCb(SurvivalController.instance, SurvivalEvent.ShowToast, arg_4_0.addToastMsg, arg_4_0)
	arg_4_0:removeEventCb(SurvivalController.instance, SurvivalEvent.RecycleToast, arg_4_0._doRecycleAnimation, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._showToast, arg_4_0)

	arg_4_0.hadTask = false
end

function var_0_0.addToastMsg(arg_5_0, arg_5_1)
	if arg_5_1 then
		table.insert(arg_5_0._cacheMsgList, arg_5_1)
	end

	if not arg_5_0.hadTask and arg_5_0._cacheMsgList[1] then
		arg_5_0:_showToast()
		TaskDispatcher.runRepeat(arg_5_0._showToast, arg_5_0, arg_5_0._showNextToastInterval)

		arg_5_0.hadTask = true
	end
end

function var_0_0._showToast(arg_6_0)
	local var_6_0 = table.remove(arg_6_0._cacheMsgList, 1)

	if not var_6_0 then
		TaskDispatcher.cancelTask(arg_6_0._showToast, arg_6_0)

		arg_6_0.hadTask = false

		return
	end

	local var_6_1 = table.remove(arg_6_0._freeList, 1)

	if not var_6_1 then
		local var_6_2 = gohelper.clone(arg_6_0._gotemplate, arg_6_0._gopoint)

		var_6_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_2, SurvivalToastItem)
	end

	local var_6_3

	if #arg_6_0._usingList >= arg_6_0._maxCount then
		local var_6_4 = arg_6_0._usingList[1]

		arg_6_0:_doRecycleAnimation(var_6_4, true)
	end

	table.insert(arg_6_0._usingList, var_6_1)
	var_6_1:setMsg(var_6_0)
	var_6_1:appearAnimation(var_6_0)
	arg_6_0:_refreshAllItemsAnimation()
end

function var_0_0._doRecycleAnimation(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = tabletool.indexOf(arg_7_0._usingList, arg_7_1)

	if var_7_0 then
		table.remove(arg_7_0._usingList, var_7_0)
	end

	arg_7_1:clearAllTask()
	arg_7_1:quitAnimation(arg_7_0._recycleToast, arg_7_0)
end

function var_0_0._recycleToast(arg_8_0, arg_8_1)
	arg_8_1:reset()
	table.insert(arg_8_0._freeList, arg_8_1)
end

function var_0_0._refreshAllItemsAnimation(arg_9_0)
	local var_9_0 = 0

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._usingList) do
		local var_9_1 = iter_9_1:getHeight()

		if iter_9_0 == 1 then
			var_9_0 = var_9_0 - var_9_1 / 2
		end

		if iter_9_0 == #arg_9_0._usingList then
			recthelper.setAnchorY(iter_9_1.tr, var_9_0 + var_9_1 / 2)
		else
			iter_9_1:upAnimation(var_9_0 + var_9_1 / 2)
		end

		var_9_0 = var_9_0 + var_9_1 + 10
	end
end

return var_0_0
