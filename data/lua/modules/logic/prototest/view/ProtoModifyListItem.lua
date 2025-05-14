module("modules.logic.prototest.view.ProtoModifyListItem", package.seeall)

local var_0_0 = class("ProtoModifyListItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._txtKey = gohelper.findChildText(arg_1_1, "txtKey")
	arg_1_0._txtValue = gohelper.findChildText(arg_1_1, "txtValue")
	arg_1_0._btnRemove = gohelper.findChildButtonWithAudio(arg_1_1, "btnRemove")
	arg_1_0._btnAdd = gohelper.findChildButtonWithAudio(arg_1_1, "btnAdd")
	arg_1_0._click = gohelper.getClick(arg_1_1)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnRemove:AddClickListener(arg_2_0._onClickRemove, arg_2_0)
	arg_2_0._btnAdd:AddClickListener(arg_2_0._onClickAdd, arg_2_0)
	arg_2_0._click:AddClickListener(arg_2_0._onClickThis, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnRemove:RemoveClickListener()
	arg_3_0._btnAdd:RemoveClickListener()
	arg_3_0._click:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	if isTypeOf(arg_4_1, ProtoTestCaseParamMO) then
		local var_4_0 = arg_4_1.repeated and "[" .. arg_4_1.key .. "]" or arg_4_1.key
		local var_4_1 = ProtoEnum.LabelType[arg_4_1.pLabel]
		local var_4_2 = arg_4_1.pType == ProtoEnum.ParamType.proto and arg_4_1.struct or ProtoEnum.ParamType[arg_4_1.pType]

		arg_4_0._txtKey.text = var_4_0 .. "  <color=#A42316>" .. var_4_1 .. " - " .. var_4_2 .. "</color>"
		arg_4_0._txtValue.text = arg_4_1:getParamDescLine()

		gohelper.setActive(arg_4_0._txtKey.gameObject, true)
		gohelper.setActive(arg_4_0._txtValue.gameObject, true)
		gohelper.setActive(arg_4_0._btnRemove.gameObject, arg_4_1.repeated)
		gohelper.setActive(arg_4_0._btnAdd.gameObject, false)
	else
		gohelper.setActive(arg_4_0._txtKey.gameObject, false)
		gohelper.setActive(arg_4_0._txtValue.gameObject, false)
		gohelper.setActive(arg_4_0._btnRemove.gameObject, false)
		gohelper.setActive(arg_4_0._btnAdd.gameObject, true)
	end
end

function var_0_0._onClickThis(arg_5_0)
	ProtoTestMgr.instance:dispatchEvent(ProtoEnum.OnClickModifyItem, arg_5_0._mo.id)
end

function var_0_0._onClickRemove(arg_6_0)
	ProtoModifyModel.instance:removeRepeatedParam(arg_6_0._mo.id)
end

function var_0_0._onClickAdd(arg_7_0)
	ProtoModifyModel.instance:addRepeatedParam()
	ProtoTestCaseModel.instance:onModelUpdate()
end

return var_0_0
