module("modules.logic.rouge.view.RougeIllustrationListPage", package.seeall)

local var_0_0 = class("RougeIllustrationListPage", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0._goList = arg_4_0:getUserDataTb_()
	arg_4_0._itemList = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, RougeEnum.IllustrationNumOfPage do
		arg_4_0._goList[iter_4_0] = gohelper.findChild(arg_4_0.viewGO, tostring(iter_4_0))
	end
end

function var_0_0._getItem(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._itemList[arg_5_1]

	if not var_5_0 then
		local var_5_1 = arg_5_0._goList[arg_5_1]
		local var_5_2 = arg_5_0._view.viewContainer._viewSetting.otherRes[2]
		local var_5_3 = arg_5_0._view.viewContainer:getResInst(var_5_2, var_5_1)

		var_5_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_5_3, RougeIllustrationListItem)
		arg_5_0._itemList[arg_5_1] = var_5_0
	end

	return var_5_0
end

function var_0_0._editableAddEvents(arg_6_0)
	return
end

function var_0_0._editableRemoveEvents(arg_7_0)
	return
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0.viewGO, not arg_8_1.isSplitSpace)

	if arg_8_1.isSplitSpace then
		return
	end

	for iter_8_0 = 1, RougeEnum.IllustrationNumOfPage do
		local var_8_0 = arg_8_1[iter_8_0]
		local var_8_1 = arg_8_0._goList[iter_8_0]

		gohelper.setActive(var_8_1, var_8_0 ~= nil)

		if var_8_0 then
			arg_8_0:_getItem(iter_8_0):onUpdateMO(var_8_0)
		end
	end
end

function var_0_0.onSelect(arg_9_0, arg_9_1)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
