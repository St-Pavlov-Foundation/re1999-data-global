module("modules.logic.prototest.view.ProtoTestCaseItem", package.seeall)

local var_0_0 = class("ProtoTestCaseItem", MixScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
	arg_1_0._txtId = gohelper.findChildText(arg_1_1, "Txt_id")
	arg_1_0._txtFields = {
		gohelper.findChildText(arg_1_1, "Txt_field")
	}
	arg_1_0._btnRemove = gohelper.findChildButtonWithAudio(arg_1_1, "Btn_remove")
	arg_1_0._btnCopy = gohelper.findChildButtonWithAudio(arg_1_1, "Btn_copy")
	arg_1_0._btnSend = gohelper.findChildButtonWithAudio(arg_1_1, "Btn_send")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnRemove:AddClickListener(arg_2_0._onClickRemove, arg_2_0)
	arg_2_0._btnCopy:AddClickListener(arg_2_0._onClickCopy, arg_2_0)
	arg_2_0._btnSend:AddClickListener(arg_2_0._onClickSend, arg_2_0)
	gohelper.getClick(arg_2_0._go):AddClickListener(arg_2_0._onClickItem, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnRemove:RemoveClickListener()
	arg_3_0._btnCopy:RemoveClickListener()
	arg_3_0._btnSend:RemoveClickListener()
	gohelper.getClick(arg_3_0._go):RemoveClickListener()

	for iter_3_0 = 1, #arg_3_0._txtFields do
		local var_3_0 = arg_3_0._txtFields[iter_3_0]

		gohelper.getClick(var_3_0.gameObject):RemoveClickListener()
	end
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	recthelper.setHeight(arg_4_0._tr, arg_4_3)

	arg_4_0._mo = arg_4_1
	arg_4_0._txtId.text = arg_4_0._mo.id .. ". " .. arg_4_0._mo.struct

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._mo.value) do
		local var_4_0 = arg_4_0._txtFields[1].gameObject
		local var_4_1 = arg_4_0._txtFields[iter_4_0]

		if not var_4_1 then
			local var_4_2 = gohelper.clone(var_4_0, var_4_0.transform.parent.gameObject, var_4_0.name .. iter_4_0)

			var_4_1 = var_4_2:GetComponent(gohelper.Type_Text)
			var_4_1 = var_4_1 or var_4_2:GetComponent(gohelper.Type_TextMesh)

			recthelper.setAnchorY(var_4_1.transform, recthelper.getAnchorY(var_4_0.transform) - 28 * (iter_4_0 - 1))
			table.insert(arg_4_0._txtFields, var_4_1)
		end

		var_4_1.text = iter_4_1:getParamDescLine()

		gohelper.setActive(var_4_1.gameObject, true)
		gohelper.getClick(var_4_1.gameObject):AddClickListener(arg_4_0._onClickParam, arg_4_0, iter_4_0)
	end

	for iter_4_2 = #arg_4_0._mo.value + 1, #arg_4_0._txtFields do
		gohelper.setActive(arg_4_0._txtFields[iter_4_2].gameObject, false)
	end
end

function var_0_0._onClickItem(arg_5_0)
	ViewMgr.instance:openView(ViewName.ProtoModifyView, {
		protoMO = arg_5_0._mo
	})
end

function var_0_0._onClickParam(arg_6_0, arg_6_1)
	ViewMgr.instance:openView(ViewName.ProtoModifyView, {
		protoMO = arg_6_0._mo,
		paramId = arg_6_1
	})
end

function var_0_0._onClickRemove(arg_7_0)
	ProtoTestCaseModel.instance:remove(arg_7_0._mo)

	local var_7_0 = ProtoTestCaseModel.instance:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		iter_7_1.id = iter_7_0
	end

	ProtoTestCaseModel.instance:setList(var_7_0)
end

function var_0_0._onClickCopy(arg_8_0)
	local var_8_0 = arg_8_0._mo:clone()
	local var_8_1 = ProtoTestCaseModel.instance:getList()

	table.insert(var_8_1, var_8_0)

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		iter_8_1.id = iter_8_0
	end

	ProtoTestCaseModel.instance:setList(var_8_1)
end

function var_0_0._onClickSend(arg_9_0)
	local var_9_0 = arg_9_0._mo:buildProtoMsg()

	LuaSocketMgr.instance:sendMsg(var_9_0)
end

return var_0_0
