module("modules.logic.survival.view.handbook.SurvivalHandbookResultComp", package.seeall)

local var_0_0 = class("SurvivalHandbookResultComp", SurvivalHandbookViewComp)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._parentView = arg_1_1
	arg_1_0.handBookType = SurvivalEnum.HandBookType.Result
	arg_1_0.items = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0.content = gohelper.findChild(arg_2_1, "#scroll/viewport/content")
	arg_2_0.SurvivalHandbookResultItem = gohelper.findChild(arg_2_1, "#scroll/SurvivalHandbookResultItem")

	gohelper.setActive(arg_2_0.SurvivalHandbookResultItem, false)
end

function var_0_0.onStart(arg_3_0)
	arg_3_0:refresh()
	arg_3_0:playAnim()
	SurvivalHandbookController.instance:markNewHandbook(arg_3_0.handBookType)
end

function var_0_0.addEventListeners(arg_4_0)
	return
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0.onDestroy(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:playAnim()
end

function var_0_0.refresh(arg_8_0)
	local var_8_0 = SurvivalHandbookModel.instance.resultMos

	table.sort(var_8_0, SurvivalHandbookModel.instance.handBookSortFuncById)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = var_8_0[iter_8_0]
		local var_8_2 = gohelper.clone(arg_8_0.SurvivalHandbookResultItem, arg_8_0.content)

		gohelper.setActive(var_8_2, true)

		local var_8_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_2, SurvivalHandbookResultItem)

		var_8_3:setData({
			mo = var_8_1
		})
		table.insert(arg_8_0.items, var_8_3)
	end
end

function var_0_0.playAnim(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0.items) do
		local var_9_0 = iter_9_1:getAnimator()
		local var_9_1 = 0.03 * (iter_9_0 - 1)
		local var_9_2 = var_9_0:GetCurrentAnimatorStateInfo(0).length
		local var_9_3 = (0 - var_9_1) / var_9_2

		var_9_0:Play(UIAnimationName.Open, 0, var_9_3)
		var_9_0:Update(0)
	end
end

return var_0_0
