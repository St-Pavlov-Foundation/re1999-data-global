module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillDescItem", package.seeall)

local var_0_0 = class("VersionActivity1_6SkillDescItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._skillCfg = arg_1_2
	arg_1_0.go = arg_1_1
	arg_1_0.parentView = arg_1_3
	arg_1_0.txtlv = gohelper.findChildText(arg_1_1, "descripteitem/#txt_skillevel")
	arg_1_0.txtskillDesc = gohelper.findChildText(arg_1_1, "descripteitem/#txt_descripte")
	arg_1_0.canvasGroup = gohelper.onceAddComponent(arg_1_0.txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	arg_1_0.txtlvcanvasGroup = gohelper.onceAddComponent(arg_1_0.txtlv.gameObject, gohelper.Type_CanvasGroup)
	arg_1_0.goCurLvFlag = gohelper.findChild(arg_1_1, "descripteitem/#go_curlevel")
	arg_1_0.vx = gohelper.findChild(arg_1_1, "descripteitem/vx")
	arg_1_0.txtCostNum = gohelper.findChildText(arg_1_1, "descripteitem/#txt_descripte/Prop/#txt_Num")
	arg_1_0.imageCostIcon = gohelper.findChildImage(arg_1_1, "descripteitem/#txt_descripte/Prop/#simage_Prop")

	gohelper.setActive(arg_1_0.vx, false)

	arg_1_0._needUseSkillEffDescList = {}
	arg_1_0._needUseSkillEffDescList2 = {}
end

function var_0_0.refreshInfo(arg_2_0)
	local var_2_0 = arg_2_0._skillCfg.level
	local var_2_1 = arg_2_0._skillCfg.skillId
	local var_2_2 = arg_2_0._skillCfg.attrs
	local var_2_3 = VersionActivity1_6DungeonEnum.SkillKeyPointIdxs[var_2_0]

	arg_2_0.lv = var_2_0
	arg_2_0.txtlv.text = arg_2_0._skillCfg.level
	arg_2_0._hyperLinkClick = arg_2_0.txtskillDesc:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_2_0._hyperLinkClick:SetClickListener(arg_2_0._onHyperLinkClick, arg_2_0)

	local var_2_4 = ""

	if var_2_1 and var_2_1 ~= 0 then
		local var_2_5 = FightConfig.instance:getSkillEffectCO(var_2_1)

		var_2_4 = FightConfig.instance:getSkillEffectDesc(nil, var_2_5)
	elseif var_2_2 then
		local var_2_6 = string.splitToNumber(var_2_2, "#")
		local var_2_7 = var_2_6[1]
		local var_2_8 = var_2_6[2]
		local var_2_9 = lua_skill_effect.configDict[var_2_7]

		var_2_4 = arg_2_0._skillCfg.skillAttrDesc
	end

	local var_2_10 = HeroSkillModel.instance:formatDescWithColor(var_2_4, "#deaa79", "#7e99d0")
	local var_2_11 = arg_2_0:_buildLinkTag(var_2_10)

	arg_2_0.height = GameUtil.getTextHeightByLine(arg_2_0.txtskillDesc, var_2_11, 28, -3) + 42

	recthelper.setHeight(arg_2_0.go.transform, arg_2_0.height)

	arg_2_0.txtskillDesc.text = var_2_11
	arg_2_0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.txtskillDesc.gameObject, FixTmpBreakLine)

	arg_2_0._fixTmpBreakLine:refreshTmpContent(arg_2_0.txtskillDesc)

	local var_2_12 = Activity148Config.instance:getAct148CfgByTypeLv(arg_2_0._skillCfg.type, arg_2_0._skillCfg.level)

	if var_2_12 then
		local var_2_13 = var_2_12.cost
		local var_2_14 = string.splitToNumber(var_2_13, "#")[3]

		arg_2_0.txtCostNum.text = var_2_14
	end

	local var_2_15 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local var_2_16 = string.format("%s_1", var_2_15 and var_2_15.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_2_0.imageCostIcon, var_2_16)
end

function var_0_0._onHyperLinkClick(arg_3_0, arg_3_1, arg_3_2)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	arg_3_1 = arg_3_0._needUseSkillEffDescList2[tonumber(arg_3_1)]

	if not arg_3_0._needUseSkillEffDescList[arg_3_1] then
		return
	end

	arg_3_0.parentView:showBuffContainer(SkillConfig.instance:processSkillDesKeyWords(arg_3_1), arg_3_0._needUseSkillEffDescList[arg_3_1], arg_3_2)
end

function var_0_0._buildLinkTag(arg_4_0, arg_4_1)
	arg_4_1 = string.gsub(arg_4_1, "】", "]")
	arg_4_1 = string.gsub(arg_4_1, "【", "[")

	local var_4_0 = 0
	local var_4_1 = 0
	local var_4_2 = {}
	local var_4_3

	for iter_4_0, iter_4_1 in function()
		return string.find(arg_4_1, "[%[%]]", var_4_0)
	end do
		var_4_1 = var_4_1 + 1

		local var_4_4 = string.sub(arg_4_1, var_4_0, iter_4_0 - 1)

		if var_4_1 % 2 == 0 then
			local var_4_5 = arg_4_0:_buildSkillEffDescCo(var_4_4)

			if var_4_5 then
				local var_4_6 = SkillConfig.instance:processSkillDesKeyWords(var_4_4)

				var_4_4 = string.format("<u><link=%s>[%s]</link></u>", var_4_5, var_4_6)
			else
				var_4_4 = string.format("[%s]", var_4_4)
			end
		end

		table.insert(var_4_2, var_4_4)

		var_4_0 = iter_4_1 + 1
	end

	table.insert(var_4_2, string.sub(arg_4_1, var_4_0))

	return table.concat(var_4_2)
end

function var_0_0._buildSkillEffDescCo(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(lua_skill_eff_desc.configList) do
		if iter_6_1.name == arg_6_1 then
			if SkillHelper.canShowTag(iter_6_1) then
				local var_6_0 = tabletool.indexOf(arg_6_0._needUseSkillEffDescList2, arg_6_1)

				if not var_6_0 then
					var_6_0 = #arg_6_0._needUseSkillEffDescList2 + 1
					arg_6_0._needUseSkillEffDescList2[var_6_0] = arg_6_1
				end

				arg_6_0._needUseSkillEffDescList[arg_6_1] = iter_6_1.desc

				return var_6_0
			else
				return nil
			end
		end
	end
end

return var_0_0
