module("modules.logic.season.controller.Activity104EquipBookController", package.seeall)

local var_0_0 = class("Activity104EquipBookController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1)
	Activity104Controller.instance:registerCallback(Activity104Event.GetAct104ItemChange, arg_1_0.handleItemChanged, arg_1_0)
	Activity104EquipItemBookModel.instance:initDatas(arg_1_1)
end

function var_0_0.onCloseView(arg_2_0)
	Activity104Controller.instance:unregisterCallback(Activity104Event.GetAct104ItemChange, arg_2_0.handleItemChanged, arg_2_0)
	Activity104EquipItemBookModel.instance:flushRecord()
	Activity104Controller.instance:dispatchEvent(Activity104Event.OnPlayerPrefNewUpdate)
	Activity104EquipItemBookModel.instance:clear()
end

function var_0_0.changeSelect(arg_3_0, arg_3_1)
	Activity104EquipItemBookModel.instance:setSelectItemId(arg_3_1)
	Activity104EquipItemBookModel.instance:onModelUpdate()
	arg_3_0:dispatchEvent(Activity104Event.OnBookChangeSelectNotify)
end

function var_0_0.handleItemChanged(arg_4_0)
	local var_4_0 = Activity104EquipItemBookModel.instance.curSelectItemId

	Activity104EquipItemBookModel.instance:initList()
	Activity104EquipItemBookModel.instance:setSelectItemId(var_4_0)
	arg_4_0:notifyUpdateView()
end

function var_0_0.notifyUpdateView(arg_5_0)
	Activity104EquipItemBookModel.instance:onModelUpdate()
	arg_5_0:dispatchEvent(Activity104Event.OnBookUpdateNotify)
end

function var_0_0.setSelectTag(arg_6_0, arg_6_1)
	if Activity104EquipItemBookModel.instance.tagModel then
		Activity104EquipItemBookModel.instance.tagModel:selectTagIndex(arg_6_1)
		arg_6_0:handleItemChanged()
	end
end

function var_0_0.getFilterModel(arg_7_0)
	return Activity104EquipItemBookModel.instance.tagModel
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
