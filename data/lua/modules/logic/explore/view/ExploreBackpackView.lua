module("modules.logic.explore.view.ExploreBackpackView", package.seeall)

local var_0_0 = class("ExploreBackpackView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._gohasprop = gohelper.findChild(arg_1_0.viewGO, "#go_hasprop")
	arg_1_0._scrollprop = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_prop")
	arg_1_0._propcontent = gohelper.findChild(arg_1_0.viewGO, "mask/#scroll_prop/viewport/propcontent")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.OnItemChange, arg_2_0._updateItem, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorItemSelect, arg_2_0.OnItemKeyDown, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.OnItemChange, arg_3_0._updateItem, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyThirdDoorItemSelect, arg_3_0.OnItemKeyDown, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.itemList = {}
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_updateItem()
end

function var_0_0._updateItem(arg_7_0)
	local var_7_0 = ExploreBackpackModel.instance:getList()
	local var_7_1 = arg_7_0.viewContainer:getSetting().otherRes[1]

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		local var_7_2 = arg_7_0.itemList[iter_7_0]

		if var_7_2 == nil then
			local var_7_3 = arg_7_0:getResInst(var_7_1, arg_7_0._propcontent, "item")

			var_7_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_3, ExploreBackpackPropListItem)
		end

		gohelper.setActive(var_7_2.go, true)
		var_7_2:onUpdateMO(iter_7_1)

		arg_7_0.itemList[iter_7_0] = var_7_2

		local var_7_4 = gohelper.findChild(var_7_2.go, "#go_pcbtn")

		PCInputController.instance:showkeyTips(var_7_4, PCInputModel.Activity.thrityDoor, PCInputModel.thrityDoorFun.Item1 + iter_7_0 - 1)
	end

	for iter_7_2 = #var_7_0 + 1, #arg_7_0.itemList do
		gohelper.setActive(arg_7_0.itemList[iter_7_2].go, false)
	end

	gohelper.setActive(arg_7_0._goempty, #var_7_0 == 0)
	gohelper.setActive(arg_7_0._gohasprop, #var_7_0 > 0)
end

function var_0_0.onDestroyView(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.itemList) do
		iter_8_1:onDestroyView()
	end

	arg_8_0.itemList = nil
end

function var_0_0.OnItemKeyDown(arg_9_0, arg_9_1)
	if PCInputController.instance:isPopUpViewOpen({
		ViewName.ExploreBackpackView
	}) then
		return
	end

	if arg_9_0.itemList[arg_9_1] then
		arg_9_0.itemList[arg_9_1]:_onItemClick()
	end
end

return var_0_0
