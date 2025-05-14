module("modules.logic.rouge.view.comp.RougeRoleSkillItemComp", package.seeall)

local var_0_0 = class("RougeRoleSkillItemComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._assitSkillIcon = gohelper.findChildSingleImage(arg_1_0._go, "imgIcon")
	arg_1_0._assitSkillTagIcon = gohelper.findChildSingleImage(arg_1_0._go, "tag/tagIcon")
	arg_1_0._click = gohelper.findChildButtonWithAudio(arg_1_0._go, "bg")

	arg_1_0._click:AddClickListener(arg_1_0._onClick, arg_1_0)
end

function var_0_0.setClickCallback(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._callback = arg_2_1
	arg_2_0._target = arg_2_2
end

function var_0_0.setHeroId(arg_3_0, arg_3_1)
	arg_3_0._heroId = arg_3_1
end

function var_0_0._onClick(arg_4_0)
	if arg_4_0._callback then
		arg_4_0._callback(arg_4_0._target)
	end
end

function var_0_0.setSelected(arg_5_0, arg_5_1)
	arg_5_0._frameGo = arg_5_0._frameGo or gohelper.findChild(arg_5_0._go, "selectframe")

	arg_5_0._frameGo:SetActive(arg_5_1)
end

function var_0_0.getSkillCO(arg_6_0)
	return arg_6_0._skillCO
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0._skillCO = arg_7_1

	arg_7_0._assitSkillIcon:LoadImage(ResUrl.getSkillIcon(arg_7_1.icon))
	arg_7_0._assitSkillTagIcon:LoadImage(ResUrl.getAttributeIcon("attribute_" .. arg_7_1.showTag))

	if arg_7_0._heroId then
		RougeModel.instance:getTeamInfo():setSupportSkill(arg_7_0._heroId, arg_7_1.id)
	end
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0._click:RemoveClickListener()
end

return var_0_0
