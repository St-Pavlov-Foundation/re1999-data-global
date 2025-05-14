module("modules.logic.herogroup.view.CharacterSkillContainer", package.seeall)

local var_0_0 = class("CharacterSkillContainer", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._goskills = gohelper.findChild(arg_1_1, "line/go_skills")
	arg_1_0._skillitems = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		local var_1_0 = gohelper.findChild(arg_1_0._goskills, "skillicon" .. tostring(iter_1_0))
		local var_1_1 = {
			icon = gohelper.findChildSingleImage(var_1_0, "imgIcon"),
			tag = gohelper.findChildSingleImage(var_1_0, "tag/tagIcon"),
			btn = gohelper.findChildButtonWithAudio(var_1_0, "bg", AudioEnum.UI.Play_ui_role_description),
			index = iter_1_0
		}

		var_1_1.btn:AddClickListener(arg_1_0._onSkillCardClick, arg_1_0, var_1_1.index)

		arg_1_0._skillitems[iter_1_0] = var_1_1
	end
end

function var_0_0.onDestroy(arg_2_0)
	for iter_2_0 = 1, 3 do
		arg_2_0._skillitems[iter_2_0].btn:RemoveClickListener()
		arg_2_0._skillitems[iter_2_0].icon:UnLoadImage()
		arg_2_0._skillitems[iter_2_0].tag:UnLoadImage()
	end
end

function var_0_0.onUpdateMO(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0._heroId = arg_3_1
	arg_3_0._heroName = HeroConfig.instance:getHeroCO(arg_3_0._heroId).name
	arg_3_0._heroMo = arg_3_3
	arg_3_0._isBalance = arg_3_4
	arg_3_0._showAttributeOption = arg_3_2 or CharacterEnum.showAttributeOption.ShowCurrent

	arg_3_0:_refreshSkillUI()
end

function var_0_0._refreshSkillUI(arg_4_0)
	if arg_4_0._heroId then
		local var_4_0 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(arg_4_0._heroId, arg_4_0._showAttributeOption, arg_4_0._heroMo)

		for iter_4_0, iter_4_1 in pairs(var_4_0) do
			local var_4_1 = lua_skill.configDict[iter_4_1]

			if not var_4_1 then
				logError(string.format("heroID : %s, skillId not found : %s", arg_4_0._heroId, iter_4_1))
			end

			arg_4_0._skillitems[iter_4_0].icon:LoadImage(ResUrl.getSkillIcon(var_4_1.icon))
			arg_4_0._skillitems[iter_4_0].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_4_1.showTag))
			gohelper.setActive(arg_4_0._skillitems[iter_4_0].tag.gameObject, iter_4_0 ~= 3)
		end
	end
end

function var_0_0._onSkillCardClick(arg_5_0, arg_5_1)
	if arg_5_0._heroId then
		local var_5_0 = {}
		local var_5_1 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(arg_5_0._heroId, arg_5_0._showAttributeOption, arg_5_0._heroMo)

		var_5_0.super = arg_5_1 == 3
		var_5_0.skillIdList = var_5_1[arg_5_1]
		var_5_0.isBalance = arg_5_0._isBalance
		var_5_0.monsterName = arg_5_0._heroName
		var_5_0.heroId = arg_5_0._heroId
		var_5_0.heroMo = arg_5_0._heroMo
		var_5_0.skillIndex = arg_5_1

		ViewMgr.instance:openView(ViewName.SkillTipView, var_5_0)
	end
end

return var_0_0
