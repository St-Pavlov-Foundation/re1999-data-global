module("modules.logic.gm.view.GMFightEntityAttrItem", package.seeall)

slot0 = class("GMFightEntityAttrItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._txt_base = gohelper.findChildText(slot1, "base")
	slot0._txt_fix = gohelper.findChildText(slot1, "fix")
	slot0._txt_part_fix = gohelper.findChildText(slot1, "partfix")
	slot0._txt_test = gohelper.findChildText(slot1, "test")
	slot0._txt_part_test = gohelper.findChildText(slot1, "parttest")
	slot0._txt_final = gohelper.findChildText(slot1, "final")
	slot0._txt_base_value = gohelper.findChildText(slot1, "base/value")
	slot0._txt_fix_value = gohelper.findChildText(slot1, "fix/value")
	slot0._txt_part_fix_value = gohelper.findChildText(slot1, "partfix/value")
	slot0._txt_final_value = gohelper.findChildText(slot1, "final/value")
	slot0._input_test = gohelper.findChildTextMeshInputField(slot1, "test/input")
	slot0._input_part_test = gohelper.findChildTextMeshInputField(slot1, "parttest/input")
end

function slot0.addEventListeners(slot0)
	slot0._input_test:AddOnEndEdit(slot0._onFixEndEdit, slot0)
	slot0._input_part_test:AddOnEndEdit(slot0._onPartFixEndEdit, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._input_test:RemoveOnEndEdit()
	slot0._input_part_test:RemoveOnEndEdit()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot3 = lua_character_attribute.configDict[slot1.id] and slot2.name or tostring(slot1.id)
	slot0._txt_base.text = slot3 .. "基础值"
	slot0._txt_fix.text = slot3 .. "百分比修正值"
	slot0._txt_part_fix.text = slot3 .. "固定值修正值"
	slot0._txt_test.text = "外挂百分比修正值"
	slot0._txt_part_test.text = "外挂固定值修正值"
	slot0._txt_final.text = slot3 .. "最终值"
	slot0._txt_base_value.text = slot1.base
	slot0._txt_fix_value.text = slot1.add * 0.001
	slot0._txt_part_fix_value.text = slot1.partAdd

	slot0._input_test:SetText(slot1.test * 0.001)
	slot0._input_part_test:SetText(slot1.partTest)

	slot0._txt_final_value.text = slot1.final
end

function slot0._onFixEndEdit(slot0)
	GMRpc.instance:sendGMRequest(string.format("fightChangeAttr %s %d %d", tostring(GMFightEntityModel.instance.entityMO.id), slot0._mo.id, math.floor((tonumber(slot0._input_test:GetText()) or 0) * 1000)))
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

function slot0._onPartFixEndEdit(slot0)
	GMRpc.instance:sendGMRequest(string.format("fightChangePartAttr %s %d %d", tostring(GMFightEntityModel.instance.entityMO.id), slot0._mo.id, tonumber(slot0._input_part_test:GetText()) or 0))
	FightRpc.instance:sendGetEntityDetailInfosRequest()
end

return slot0
