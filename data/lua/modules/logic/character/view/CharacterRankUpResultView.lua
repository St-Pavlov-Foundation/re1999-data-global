module("modules.logic.character.view.CharacterRankUpResultView", package.seeall)

local var_0_0 = class("CharacterRankUpResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bgimg")
	arg_1_0._simagecenterbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_centerbg")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "spineContainer/#go_spine")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._goranknormal = gohelper.findChild(arg_1_0.viewGO, "rank/#go_ranknormal")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#scroll_info/viewport/#go_effect")
	arg_1_0._golevel = gohelper.findChild(arg_1_0._goeffect, "#go_level")
	arg_1_0._goskill = gohelper.findChild(arg_1_0._goeffect, "#go_skill")
	arg_1_0._txttalentlevel = gohelper.findChildText(arg_1_0._goeffect, "#go_talentlevel")
	arg_1_0._txtskillRankUp = gohelper.findChildText(arg_1_0._goeffect, "#go_skill/#txt_skillRankUp")
	arg_1_0._txtskillDetail = gohelper.findChildText(arg_1_0._goeffect, "#go_skill/skilldetail/#txt_skillDetail")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0._goeffect, "#go_attribute")
	arg_1_0._goattributedetail = gohelper.findChild(arg_1_0._goeffect, "#go_attribute/#go_attributedetail")
	arg_1_0._btnheroDetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_heroDetail")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnheroDetail:AddClickListener(arg_2_0._btnheroDetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnheroDetail:RemoveClickListener()
end

var_0_0.characterTalentLevel = {
	[2] = 10,
	[3] = 15
}

function var_0_0._btnheroDetailOnClick(arg_4_0)
	local var_4_0 = SkinConfig.instance:getSkinCo(arg_4_0._skinId)

	CharacterController.instance:openCharacterSkinFullScreenView(var_4_0, true)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagecenterbg:LoadImage(ResUrl.getCharacterIcon("guang_005"))

	arg_5_0._txtlevel = gohelper.findChildText(arg_5_0._goeffect, "#go_level")
	arg_5_0._uiSpine = GuiModelAgent.Create(arg_5_0._gospine, true)

	arg_5_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, CharacterVoiceEnum.NormalPriority.CharacterRankUpResultView)
	arg_5_0._uiSpine:useRT()

	arg_5_0._rareGos = arg_5_0:getUserDataTb_()
	arg_5_0._norrank = {}
	arg_5_0._norrank.insights = {}

	for iter_5_0 = 1, 3 do
		local var_5_0 = arg_5_0:getUserDataTb_()

		var_5_0.go = gohelper.findChild(arg_5_0._goranknormal, "insightlight" .. tostring(iter_5_0))
		var_5_0.lights = {}

		for iter_5_1 = 1, iter_5_0 do
			table.insert(var_5_0.lights, gohelper.findChild(var_5_0.go, "star" .. iter_5_1))
		end

		arg_5_0._norrank.insights[iter_5_0] = var_5_0
		arg_5_0._rareGos[iter_5_0] = gohelper.findChild(arg_5_0._txtskillDetail.gameObject, "rare" .. iter_5_0)
	end

	arg_5_0._norrank.eyes = arg_5_0:getUserDataTb_()

	for iter_5_2 = 1, 2 do
		table.insert(arg_5_0._norrank.eyes, gohelper.findChild(arg_5_0._goranknormal, "eyes/eye" .. tostring(iter_5_2)))
	end

	arg_5_0._attributeItems = arg_5_0:getUserDataTb_()

	for iter_5_3 = 1, 5 do
		local var_5_1 = {
			go = gohelper.findChild(arg_5_0._goattributedetail, "attributeItem" .. iter_5_3)
		}

		var_5_1.icon = gohelper.findChildImage(var_5_1.go, "image_icon")
		var_5_1.preNumTxt = gohelper.findChildText(var_5_1.go, "txt_prevnum")
		var_5_1.curNumTxt = gohelper.findChildText(var_5_1.go, "txt_nextnum")

		table.insert(arg_5_0._attributeItems, var_5_1)
	end
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.heroMo = HeroModel.instance:getByHeroId(arg_7_0.viewParam)

	arg_7_0:_refreshView()
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_7_0._onCloseViewFinish, arg_7_0, LuaEventSystem.Low)
	arg_7_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_7_0._onOpenViewFinish, arg_7_0, LuaEventSystem.Low)
end

function var_0_0._onOpenViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CharacterSkinFullScreenView and arg_8_0._uiSpine then
		arg_8_0._uiSpine:hideModelEffect()
	end
end

function var_0_0._onCloseViewFinish(arg_9_0, arg_9_1)
	if arg_9_1 == ViewName.CharacterSkinFullScreenView and arg_9_0._uiSpine then
		arg_9_0._uiSpine:showModelEffect()
	end
end

function var_0_0._refreshView(arg_10_0)
	arg_10_0:_refreshSpine()
	arg_10_0:_refreshRank()
	arg_10_0:_refreshEffect()
	arg_10_0:_refreshAttribute()
end

function var_0_0._refreshSpine(arg_11_0)
	local var_11_0 = SkinConfig.instance:getSkinCo(arg_11_0.heroMo.skin)

	arg_11_0._uiSpine:setResPath(var_11_0, arg_11_0._onSpineLoaded, arg_11_0)

	local var_11_1 = var_11_0.characterRankUpViewOffset
	local var_11_2

	if string.nilorempty(var_11_1) then
		var_11_2 = SkinConfig.instance:getSkinOffset(var_11_0.characterViewOffset)

		local var_11_3 = CommonConfig.instance:getConstStr(ConstEnum.CharacterTitleViewOffset)
		local var_11_4 = SkinConfig.instance:getSkinOffset(var_11_3)

		var_11_2[1] = var_11_2[1] + var_11_4[1]
		var_11_2[2] = var_11_2[2] + var_11_4[2]
		var_11_2[3] = var_11_2[3] + var_11_4[3]
	else
		var_11_2 = SkinConfig.instance:getSkinOffset(var_11_1)
	end

	recthelper.setAnchor(arg_11_0._gospine.transform, tonumber(var_11_2[1]), tonumber(var_11_2[2]))
	transformhelper.setLocalScale(arg_11_0._gospine.transform, tonumber(var_11_2[3]), tonumber(var_11_2[3]), tonumber(var_11_2[3]))
end

function var_0_0._refreshRank(arg_12_0)
	local var_12_0 = arg_12_0.heroMo.rank
	local var_12_1 = HeroConfig.instance:getMaxRank(arg_12_0.heroMo.config.rare)

	for iter_12_0 = 1, 3 do
		gohelper.setActive(arg_12_0._norrank.insights[iter_12_0].go, var_12_1 == iter_12_0)

		for iter_12_1 = 1, iter_12_0 do
			if iter_12_1 <= var_12_0 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._norrank.insights[iter_12_0].lights[iter_12_1]:GetComponent("Image"), "#f59d3d")
			else
				SLFramework.UGUI.GuiHelper.SetColor(arg_12_0._norrank.insights[iter_12_0].lights[iter_12_1]:GetComponent("Image"), "#646161")
			end
		end
	end

	gohelper.setActive(arg_12_0._norrank.eyes[1], var_12_1 ~= var_12_0 - 1)
	gohelper.setActive(arg_12_0._norrank.eyes[2], var_12_1 == var_12_0 - 1)
end

function var_0_0._refreshEffect(arg_13_0)
	local var_13_0 = SkillConfig.instance:getherorankCO(arg_13_0.heroMo.heroId, arg_13_0.heroMo.rank)

	if not var_13_0 or var_13_0.effects == "" then
		gohelper.setActive(arg_13_0._goeffect, false)

		return
	end

	gohelper.setActive(arg_13_0._goeffect, true)
	gohelper.setActive(arg_13_0._txttalentlevel.gameObject, false)
	gohelper.setActive(arg_13_0._golevel, false)
	gohelper.setActive(arg_13_0._goskill, false)
	gohelper.setActive(arg_13_0._btnheroDetail.gameObject, false)

	local var_13_1 = string.split(var_13_0.effect, "|")

	for iter_13_0 = 1, #var_13_1 do
		local var_13_2 = string.splitToNumber(var_13_1[iter_13_0], "#")

		if var_13_2[1] == 1 then
			gohelper.setActive(arg_13_0._golevel, true)

			local var_13_3 = HeroConfig.instance:getShowLevel(tonumber(var_13_2[2]))
			local var_13_4 = {
				arg_13_0.heroMo.config.name,
				tostring(var_13_3)
			}

			arg_13_0._txtlevel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("character_rankupresult_levellimit"), var_13_4)
		elseif var_13_2[1] == 2 then
			gohelper.setActive(arg_13_0._goskill, true)

			local var_13_5 = CharacterModel.instance:getMaxUnlockPassiveLevel(arg_13_0.heroMo.heroId)
			local var_13_6 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(arg_13_0.heroMo.heroId, arg_13_0.heroMo.exSkillLevel)

			for iter_13_1, iter_13_2 in pairs(arg_13_0._rareGos) do
				gohelper.setActive(iter_13_2, false)
			end

			gohelper.setActive(arg_13_0._rareGos[var_13_5], true)

			local var_13_7 = lua_skill.configDict[var_13_6[1].skillPassive].name

			arg_13_0._txtskillRankUp.text = string.format(luaLang("character_rankupresult_skill"), tostring(var_13_7))

			local var_13_8 = var_13_6[var_13_5].skillPassive
			local var_13_9 = FightConfig.instance:getSkillEffectDesc(arg_13_0.heroMo:getHeroName(), lua_skill.configDict[var_13_8])

			arg_13_0._txtskillDetail.text = HeroSkillModel.instance:skillDesToSpot(var_13_9, "#CE9358", "#CE9358")
		elseif var_13_2[1] == 3 then
			gohelper.setActive(arg_13_0._btnheroDetail.gameObject, true)

			arg_13_0._skinId = var_13_2[2]
		end
	end

	local var_13_10 = arg_13_0.heroMo.rank - 1

	gohelper.setActive(arg_13_0._txttalentlevel.gameObject, var_13_10 > 1)

	if var_13_10 > 1 then
		local var_13_11 = luaLang("talent_characterrankup_talentlevellimit" .. CharacterEnum.TalentTxtByHeroType[arg_13_0.heroMo.config.heroType])

		arg_13_0._txttalentlevel.text = string.format(var_13_11, var_0_0.characterTalentLevel[var_13_10])
	end
end

function var_0_0._refreshAttribute(arg_14_0)
	local var_14_0 = arg_14_0:getCurrentHeroAttribute()
	local var_14_1 = arg_14_0:getHeroPreAttribute()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._attributeItems) do
		UISpriteSetMgr.instance:setCommonSprite(iter_14_1.icon, "icon_att_" .. CharacterEnum.BaseAttrIdList[iter_14_0])

		iter_14_1.preNumTxt.text = var_14_1[iter_14_0]
		iter_14_1.curNumTxt.text = var_14_0[iter_14_0]
	end
end

function var_0_0.getHeroPreAttribute(arg_15_0)
	return arg_15_0:_getHeroAttribute(arg_15_0.heroMo.level - 1, arg_15_0.heroMo.rank - 1)
end

function var_0_0.getCurrentHeroAttribute(arg_16_0)
	return arg_16_0:_getHeroAttribute()
end

function var_0_0._getHeroAttribute(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1 = arg_17_1 or arg_17_0.heroMo.level
	arg_17_2 = arg_17_2 or arg_17_0.heroMo.rank

	local var_17_0

	if arg_17_0.heroMo:hasDefaultEquip() then
		var_17_0 = {
			arg_17_0.heroMo.defaultEquipUid
		}
	end

	return arg_17_0.heroMo:getTotalBaseAttrList(var_17_0, arg_17_1, arg_17_2)
end

function var_0_0.onClose(arg_18_0)
	arg_18_0._simagecenterbg:UnLoadImage()
	arg_18_0._uiSpine:setModelVisible(false)
end

function var_0_0.onDestroyView(arg_19_0)
	if arg_19_0._uiSpine then
		arg_19_0._uiSpine:onDestroy()

		arg_19_0._uiSpine = nil
	end
end

return var_0_0
