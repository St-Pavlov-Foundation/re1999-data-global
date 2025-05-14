module("modules.logic.seasonver.act123.controller.Season123EquipBookController", package.seeall)

local var_0_0 = class("Season123EquipBookController", BaseController)

function var_0_0.changeSelect(arg_1_0, arg_1_1)
	Season123EquipBookModel.instance:setCurSelectItemId(arg_1_1)
	Season123EquipBookModel.instance:onModelUpdate()
	arg_1_0:dispatchEvent(Season123Event.OnEquipBookItemChangeSelect)
end

function var_0_0.setSelectTag(arg_2_0, arg_2_1)
	if Season123EquipBookModel.instance.tagModel then
		Season123EquipBookModel.instance.tagModel:selectTagIndex(arg_2_1)
		arg_2_0:handleItemChange()
	end
end

function var_0_0.handleItemChange(arg_3_0)
	local var_3_0 = Season123EquipBookModel.instance.curSelectItemId

	Season123EquipBookModel.instance:initList()
	Season123EquipBookModel.instance:setCurSelectItemId(var_3_0)

	if not Season123EquipBookModel.instance.curSelectItemId then
		Season123EquipBookModel.instance:selectFirstCard()
	end

	Season123EquipBookModel.instance:onModelUpdate()
	arg_3_0:dispatchEvent(Season123Event.OnRefleshEquipBookView)
end

function var_0_0.onCloseView(arg_4_0)
	Season123EquipBookModel.instance:flushRecord()
	Season123EquipBookModel.instance:clear()
	Season123DecomposeModel.instance:release()
	Season123DecomposeModel.instance:clear()
end

function var_0_0.openBatchDecomposeView(arg_5_0, arg_5_1)
	Season123DecomposeModel.instance:initDatas(arg_5_1)
	Season123ViewHelper.openView(arg_5_1, "BatchDecomposeView", {
		actId = arg_5_1
	})
end

function var_0_0.clearItemSelectState(arg_6_0)
	Season123DecomposeModel.instance:clearCurSelectItem()
	arg_6_0:dispatchEvent(Season123Event.OnRefleshDecomposeItemUI)
end

var_0_0.instance = var_0_0.New()

return var_0_0
