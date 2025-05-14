module("modules.logic.backpack.view.BackpackPropView", package.seeall)

local var_0_0 = class("BackpackPropView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")

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
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, arg_4_0._updateItemList, arg_4_0)
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = BackpackModel.instance:getCurCategoryId() or ItemEnum.CategoryType.Material

	arg_6_0.viewContainer:setCurrentSelectCategoryId(var_6_0)

	local var_6_1 = BackpackModel.instance:getCategoryItemlist(var_6_0)

	BackpackPropListModel.instance:setCategoryPropItemList(var_6_1)
end

function var_0_0._updateItemList(arg_7_0)
	arg_7_0._itemList = BackpackModel.instance:getBackpackList()

	BackpackModel.instance:setBackpackItemList(arg_7_0._itemList)
	arg_7_0:onOpen()
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, arg_9_0._updateItemList, arg_9_0)
end

return var_0_0
