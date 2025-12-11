module("modules.logic.survival.view.rewardinherit.SurvivalRewardInheritNpcItem", package.seeall)

local var_0_0 = class("SurvivalRewardInheritNpcItem", LuaCompBase)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0.go_Container = gohelper.findChild(arg_2_0.viewGO, "#go_Container")
	arg_2_0.go_image_Line = gohelper.findChild(arg_2_0.viewGO, "#go_image_Line")
	arg_2_0.customItems = {}
end

function var_0_0.getItemAnimators(arg_3_0)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.customItems) do
		table.insert(var_3_0, iter_3_1.animGo)
	end

	return var_3_0
end

function var_0_0.onStart(arg_4_0)
	return
end

function var_0_0.addEventListeners(arg_5_0)
	return
end

function var_0_0.removeEventListeners(arg_6_0)
	return
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.updateMo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0 = arg_8_1.listData

	arg_8_0.selectHandbookMo = arg_8_2

	local var_8_1 = arg_8_1.isShowLine

	arg_8_0.viewContainer = arg_8_1.viewContainer
	arg_8_0.lineYOffset = arg_8_1.lineYOffset or 0

	gohelper.setActive(arg_8_0.go_image_Line, var_8_1)
	recthelper.setAnchorY(arg_8_0.go_image_Line.transform, arg_8_0.lineYOffset)

	local var_8_2 = arg_8_0.viewContainer:getSetting().otherRes.survivalhandbooknpcitem
	local var_8_3 = #arg_8_0.customItems
	local var_8_4 = #var_8_0

	for iter_8_0 = 1, var_8_4 do
		local var_8_5 = var_8_0[iter_8_0].survivalHandbookMo
		local var_8_6 = var_8_0[iter_8_0].isSelect

		if var_8_3 < iter_8_0 then
			local var_8_7 = arg_8_0.viewContainer:getResInst(var_8_2, arg_8_0.go_Container)

			arg_8_0.customItems[iter_8_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_8_7, SurvivalHandbookNpcItem)
		end

		arg_8_0.customItems[iter_8_0]:updateMo(var_8_5)

		if var_8_5.isUnlock and arg_8_1.isShowCost then
			arg_8_0.customItems[iter_8_0]:showExtendCost()
		end

		arg_8_0.customItems[iter_8_0]:setClickCallback(arg_8_3, arg_8_4)
		arg_8_0.customItems[iter_8_0]:setRewardInherit(var_8_6)
		arg_8_0.customItems[iter_8_0]:setSelect(arg_8_0.selectHandbookMo and arg_8_0:getInheritId(arg_8_0.selectHandbookMo) == arg_8_0:getInheritId(var_8_5))
	end

	for iter_8_1 = var_8_4 + 1, var_8_3 do
		arg_8_0.customItems[iter_8_1]:updateMo(nil)
	end
end

function var_0_0.getInheritId(arg_9_0, arg_9_1)
	return SurvivalRewardInheritModel.instance:getInheritId(arg_9_1)
end

return var_0_0
