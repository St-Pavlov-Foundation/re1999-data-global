module("modules.logic.gm.view.GMFightEntitySkillItem", package.seeall)

local var_0_0 = class("GMFightEntitySkillItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._id = gohelper.findChildTextMeshInputField(arg_1_1, "id")
	arg_1_0._name = gohelper.findChildTextMeshInputField(arg_1_1, "name")
	arg_1_0._level = gohelper.findChildText(arg_1_1, "level")
	arg_1_0._effect = gohelper.findChildTextMeshInputField(arg_1_1, "effect")
	arg_1_0._type = gohelper.findChildTextMeshInputField(arg_1_1, "type")
	arg_1_0._btnDel = gohelper.findChildButtonWithAudio(arg_1_1, "btnDel")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btnDel:AddClickListener(arg_2_0._onClickDel, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btnDel:RemoveClickListener()
end

local var_0_1 = {
	"现实创伤",
	"精神创伤",
	"减益",
	"增益",
	"反制",
	"治疗"
}

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._skillCO = arg_4_1

	local var_4_0 = GMFightEntityModel.instance.entityMO

	gohelper.setActive(arg_4_0._btnDel.gameObject, var_4_0:isPassiveSkill(arg_4_0._skillCO.id))
	arg_4_0._id:SetText(tostring(arg_4_0._skillCO.id))
	arg_4_0._name:SetText(arg_4_0._skillCO.name)

	if var_4_0:isPassiveSkill(arg_4_0._skillCO.id) then
		arg_4_0._level.text = "被动"
	elseif FightCardDataHelper.isBigSkill(arg_4_0._skillCO.id) then
		arg_4_0._level.text = "大招"
	else
		arg_4_0._level.text = var_4_0:getSkillLv(arg_4_0._skillCO.id)
	end

	arg_4_0._effect:SetText(tostring(arg_4_0._skillCO.skillEffect))

	local var_4_1 = var_0_1[arg_4_0._skillCO.effectTag] or "无"

	arg_4_0._type:SetText(var_4_1)
end

function var_0_0._onClickDel(arg_5_0)
	GameFacade.showToast(ToastEnum.IconId, "del skill " .. arg_5_0._skillCO.name)

	local var_5_0 = GMFightEntityModel.instance.entityMO

	GMRpc.instance:sendGMRequest(string.format("fightDelPassiveSkill %s %s", tostring(var_5_0.id), tostring(arg_5_0._skillCO.id)))
	var_5_0:removePassiveSkill(arg_5_0._skillCO.id)
	GMFightEntityModel.instance:setEntityMO(var_5_0)
end

return var_0_0
