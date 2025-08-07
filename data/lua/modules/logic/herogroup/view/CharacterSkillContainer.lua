module("modules.logic.herogroup.view.CharacterSkillContainer", package.seeall)

local var_0_0 = class("CharacterSkillContainer", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._goskills = gohelper.findChild(arg_2_1, "line/go_skills")
	arg_2_0._skillitems = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 3 do
		local var_2_0 = gohelper.findChild(arg_2_0._goskills, "skillicon" .. tostring(iter_2_0))
		local var_2_1 = {
			icon = gohelper.findChildSingleImage(var_2_0, "imgIcon"),
			tag = gohelper.findChildSingleImage(var_2_0, "tag/tagIcon"),
			btn = gohelper.findChildButtonWithAudio(var_2_0, "bg", AudioEnum.UI.Play_ui_role_description),
			index = iter_2_0
		}

		var_2_1.btn:AddClickListener(arg_2_0._onSkillCardClick, arg_2_0, var_2_1.index)

		arg_2_0._skillitems[iter_2_0] = var_2_1
	end
end

function var_0_0.onDestroy(arg_3_0)
	for iter_3_0 = 1, 3 do
		arg_3_0._skillitems[iter_3_0].btn:RemoveClickListener()
		arg_3_0._skillitems[iter_3_0].icon:UnLoadImage()
		arg_3_0._skillitems[iter_3_0].tag:UnLoadImage()
	end
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	arg_4_0._heroId = arg_4_1
	arg_4_0._heroName = HeroConfig.instance:getHeroCO(arg_4_0._heroId).name
	arg_4_0._heroMo = arg_4_3
	arg_4_0._isBalance = arg_4_4
	arg_4_0._showAttributeOption = arg_4_2 or CharacterEnum.showAttributeOption.ShowCurrent

	arg_4_0:_refreshSkillUI()
end

function var_0_0._refreshSkillUI(arg_5_0)
	if arg_5_0._heroId then
		local var_5_0 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(arg_5_0._heroId, arg_5_0._showAttributeOption, arg_5_0._heroMo)

		for iter_5_0, iter_5_1 in pairs(var_5_0) do
			local var_5_1 = lua_skill.configDict[iter_5_1]

			if not var_5_1 then
				logError(string.format("heroID : %s, skillId not found : %s", arg_5_0._heroId, iter_5_1))
			end

			arg_5_0._skillitems[iter_5_0].icon:LoadImage(ResUrl.getSkillIcon(var_5_1.icon))
			arg_5_0._skillitems[iter_5_0].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. var_5_1.showTag))
			gohelper.setActive(arg_5_0._skillitems[iter_5_0].tag.gameObject, iter_5_0 ~= 3)
		end
	end
end

function var_0_0._onSkillCardClick(arg_6_0, arg_6_1)
	if arg_6_0._heroId then
		local var_6_0 = {}
		local var_6_1 = SkillConfig.instance:getHeroAllSkillIdDictByExSkillLevel(arg_6_0._heroId, arg_6_0._showAttributeOption, arg_6_0._heroMo)

		var_6_0.super = arg_6_1 == 3
		var_6_0.skillIdList = var_6_1[arg_6_1]
		var_6_0.isBalance = arg_6_0._isBalance
		var_6_0.monsterName = arg_6_0._heroName
		var_6_0.heroId = arg_6_0._heroId
		var_6_0.heroMo = arg_6_0._heroMo
		var_6_0.skillIndex = arg_6_1

		if arg_6_0._param then
			var_6_0.anchorX = arg_6_0._param.skillTipX
			var_6_0.anchorY = arg_6_0._param.skillTipY
			var_6_0.adjustBuffTip = arg_6_0._param.adjustBuffTip
			var_6_0.showAssassinBg = arg_6_0._param.showAssassinBg
		end

		ViewMgr.instance:openView(ViewName.SkillTipView, var_6_0)
	end
end

return var_0_0
