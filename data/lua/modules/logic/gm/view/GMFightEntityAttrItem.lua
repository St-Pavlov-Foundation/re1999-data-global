module("modules.logic.gm.view.GMFightEntityAttrItem", package.seeall)

local var_0_0 = class("GMFightEntityAttrItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._txt_base = gohelper.findChildText(arg_1_1, "base")
	arg_1_0._txt_fix = gohelper.findChildText(arg_1_1, "fix")
	arg_1_0._txt_part_fix = gohelper.findChildText(arg_1_1, "partfix")
	arg_1_0._txt_test = gohelper.findChildText(arg_1_1, "test")
	arg_1_0._txt_part_test = gohelper.findChildText(arg_1_1, "parttest")
	arg_1_0._txt_final = gohelper.findChildText(arg_1_1, "final")
	arg_1_0._txt_base_value = gohelper.findChildText(arg_1_1, "base/value")
	arg_1_0._txt_fix_value = gohelper.findChildText(arg_1_1, "fix/value")
	arg_1_0._txt_part_fix_value = gohelper.findChildText(arg_1_1, "partfix/value")
	arg_1_0._txt_final_value = gohelper.findChildText(arg_1_1, "final/value")
	arg_1_0._input_test = gohelper.findChildTextMeshInputField(arg_1_1, "test/input")
	arg_1_0._input_part_test = gohelper.findChildTextMeshInputField(arg_1_1, "parttest/input")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._input_test:AddOnEndEdit(arg_2_0._onFixEndEdit, arg_2_0)
	arg_2_0._input_part_test:AddOnEndEdit(arg_2_0._onPartFixEndEdit, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._input_test:RemoveOnEndEdit()
	arg_3_0._input_part_test:RemoveOnEndEdit()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = lua_character_attribute.configDict[arg_4_1.id]
	local var_4_1 = var_4_0 and var_4_0.name or tostring(arg_4_1.id)

	arg_4_0._txt_base.text = var_4_1 .. "基础值"
	arg_4_0._txt_fix.text = var_4_1 .. "百分比修正值"
	arg_4_0._txt_part_fix.text = var_4_1 .. "固定值修正值"
	arg_4_0._txt_test.text = "外挂百分比修正值"
	arg_4_0._txt_part_test.text = "外挂固定值修正值"
	arg_4_0._txt_final.text = var_4_1 .. "最终值"
	arg_4_0._txt_base_value.text = arg_4_1.base
	arg_4_0._txt_fix_value.text = arg_4_1.add * 0.001
	arg_4_0._txt_part_fix_value.text = arg_4_1.partAdd

	arg_4_0._input_test:SetText(arg_4_1.test * 0.001)
	arg_4_0._input_part_test:SetText(arg_4_1.partTest)

	arg_4_0._txt_final_value.text = arg_4_1.final
end

function var_0_0._onFixEndEdit(arg_5_0)
	local var_5_0 = arg_5_0._input_test:GetText()
	local var_5_1 = tonumber(var_5_0) or 0
	local var_5_2 = math.floor(var_5_1 * 1000)
	local var_5_3 = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightChangeAttr %s %d %d", tostring(var_5_3.id), arg_5_0._mo.id, var_5_2))
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

function var_0_0._onPartFixEndEdit(arg_6_0)
	local var_6_0 = arg_6_0._input_part_test:GetText()
	local var_6_1 = tonumber(var_6_0) or 0
	local var_6_2 = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightChangePartAttr %s %d %d", tostring(var_6_2.id), arg_6_0._mo.id, var_6_1))
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

return var_0_0
