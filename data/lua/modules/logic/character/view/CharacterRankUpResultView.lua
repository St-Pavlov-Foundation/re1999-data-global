module("modules.logic.character.view.CharacterRankUpResultView", package.seeall)

local var_0_0 = class("CharacterRankUpResultView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgimg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bgimg")
	arg_1_0._simagecenterbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_centerbg")
	arg_1_0._gospine = gohelper.findChild(arg_1_0.viewGO, "spineContainer/#go_spine")
	arg_1_0._gorighttop = gohelper.findChild(arg_1_0.viewGO, "#go_righttop")
	arg_1_0._goranknormal = gohelper.findChild(arg_1_0.viewGO, "rank/#go_ranknormal")
	arg_1_0._goimagemask = gohelper.findChild(arg_1_0.viewGO, "#scroll_info/image_mask")
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

	arg_5_0._uiSpine:setShareRT(CharacterVoiceEnum.RTShareType.Normal, arg_5_0.viewName)
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

	arg_5_0:_initSpecialEffectItem()
end

function var_0_0._initSpecialEffectItem(arg_6_0)
	arg_6_0._specialEffectItem = arg_6_0:getUserDataTb_()

	local var_6_0 = gohelper.findChild(arg_6_0._goeffect, "#go_SpecialEffect")
	local var_6_1 = arg_6_0:getUserDataTb_()

	var_6_1.go = var_6_0
	var_6_1.txt = gohelper.findChildText(var_6_0, "#txt_SpecialEffect")
	arg_6_0._specialEffectItem[1] = var_6_1

	gohelper.setSibling(var_6_1.go, 0)

	local var_6_2 = arg_6_0:getUserDataTb_()

	var_6_2.go = gohelper.cloneInPlace(var_6_0)
	var_6_2.txt = gohelper.findChildText(var_6_2.go, "#txt_SpecialEffect")

	gohelper.setSibling(var_6_2.go, 1)

	arg_6_0._specialEffectItem[2] = var_6_2
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0.heroMo = HeroModel.instance:getByHeroId(arg_8_0.viewParam)

	arg_8_0:_refreshView()
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_8_0._onCloseViewFinish, arg_8_0, LuaEventSystem.Low)
	arg_8_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_8_0._onOpenViewFinish, arg_8_0, LuaEventSystem.Low)
	arg_8_0:_showMask()
end

function var_0_0._showMask(arg_9_0)
	if arg_9_0.heroMo and CharacterVoiceEnum.RankUpResultShowMask[arg_9_0.heroMo.heroId] then
		gohelper.setActive(arg_9_0._goimagemask, true)

		return
	end

	gohelper.setActive(arg_9_0._goimagemask, false)
end

function var_0_0._onOpenViewFinish(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.CharacterSkinFullScreenView and arg_10_0._uiSpine then
		arg_10_0._uiSpine:hideModelEffect()
	end
end

function var_0_0._onCloseViewFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.CharacterSkinFullScreenView and arg_11_0._uiSpine then
		arg_11_0._uiSpine:showModelEffect()
	end
end

function var_0_0._refreshView(arg_12_0)
	arg_12_0:_refreshSpine()
	arg_12_0:_refreshRank()
	arg_12_0:_refreshEffect()
	arg_12_0:_refreshAttribute()
end

function var_0_0._refreshSpine(arg_13_0)
	local var_13_0 = SkinConfig.instance:getSkinCo(arg_13_0.heroMo.skin)

	arg_13_0._uiSpine:setResPath(var_13_0, arg_13_0._onSpineLoaded, arg_13_0)

	local var_13_1 = var_13_0.characterRankUpViewOffset
	local var_13_2

	if string.nilorempty(var_13_1) then
		var_13_2 = SkinConfig.instance:getSkinOffset(var_13_0.characterViewOffset)

		local var_13_3 = CommonConfig.instance:getConstStr(ConstEnum.CharacterTitleViewOffset)
		local var_13_4 = SkinConfig.instance:getSkinOffset(var_13_3)

		var_13_2[1] = var_13_2[1] + var_13_4[1]
		var_13_2[2] = var_13_2[2] + var_13_4[2]
		var_13_2[3] = var_13_2[3] + var_13_4[3]
	else
		var_13_2 = SkinConfig.instance:getSkinOffset(var_13_1)
	end

	recthelper.setAnchor(arg_13_0._gospine.transform, tonumber(var_13_2[1]), tonumber(var_13_2[2]))
	transformhelper.setLocalScale(arg_13_0._gospine.transform, tonumber(var_13_2[3]), tonumber(var_13_2[3]), tonumber(var_13_2[3]))
end

function var_0_0._refreshRank(arg_14_0)
	local var_14_0 = arg_14_0.heroMo.rank
	local var_14_1 = HeroConfig.instance:getMaxRank(arg_14_0.heroMo.config.rare)

	for iter_14_0 = 1, 3 do
		gohelper.setActive(arg_14_0._norrank.insights[iter_14_0].go, var_14_1 == iter_14_0)

		for iter_14_1 = 1, iter_14_0 do
			if iter_14_1 <= var_14_0 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._norrank.insights[iter_14_0].lights[iter_14_1]:GetComponent("Image"), "#f59d3d")
			else
				SLFramework.UGUI.GuiHelper.SetColor(arg_14_0._norrank.insights[iter_14_0].lights[iter_14_1]:GetComponent("Image"), "#646161")
			end
		end
	end

	gohelper.setActive(arg_14_0._norrank.eyes[1], var_14_1 ~= var_14_0 - 1)
	gohelper.setActive(arg_14_0._norrank.eyes[2], var_14_1 == var_14_0 - 1)
end

function var_0_0._refreshEffect(arg_15_0)
	local var_15_0 = SkillConfig.instance:getherorankCO(arg_15_0.heroMo.heroId, arg_15_0.heroMo.rank)

	if not var_15_0 or var_15_0.effects == "" then
		gohelper.setActive(arg_15_0._goeffect, false)

		return
	end

	gohelper.setActive(arg_15_0._goeffect, true)
	gohelper.setActive(arg_15_0._txttalentlevel.gameObject, false)
	gohelper.setActive(arg_15_0._golevel, false)
	gohelper.setActive(arg_15_0._goskill, false)
	gohelper.setActive(arg_15_0._btnheroDetail.gameObject, false)

	local var_15_1 = string.split(var_15_0.effect, "|")

	for iter_15_0 = 1, #var_15_1 do
		local var_15_2 = string.splitToNumber(var_15_1[iter_15_0], "#")

		if var_15_2[1] == 1 then
			gohelper.setActive(arg_15_0._golevel, true)

			local var_15_3 = HeroConfig.instance:getShowLevel(tonumber(var_15_2[2]))
			local var_15_4 = {
				arg_15_0.heroMo.config.name,
				var_15_3
			}

			arg_15_0._txtlevel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("character_rankupresult_levellimit"), var_15_4)
		elseif var_15_2[1] == 2 then
			gohelper.setActive(arg_15_0._goskill, true)

			local var_15_5 = CharacterModel.instance:getMaxUnlockPassiveLevel(arg_15_0.heroMo.heroId)
			local var_15_6 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(arg_15_0.heroMo.heroId, arg_15_0.heroMo.exSkillLevel)

			for iter_15_1, iter_15_2 in pairs(arg_15_0._rareGos) do
				gohelper.setActive(iter_15_2, false)
			end

			gohelper.setActive(arg_15_0._rareGos[var_15_5], true)

			local var_15_7 = lua_skill.configDict[var_15_6[1].skillPassive]
			local var_15_8 = var_15_7 and var_15_7.name or ""

			arg_15_0._txtskillRankUp.text = string.format(luaLang("character_rankupresult_skill"), tostring(var_15_8))

			local var_15_9 = var_15_6[var_15_5].skillPassive
			local var_15_10 = FightConfig.instance:getSkillEffectDesc(arg_15_0.heroMo:getHeroName(), lua_skill.configDict[var_15_9])

			arg_15_0._txtskillDetail.text = HeroSkillModel.instance:skillDesToSpot(var_15_10, "#CE9358", "#CE9358")
		elseif var_15_2[1] == 3 then
			gohelper.setActive(arg_15_0._btnheroDetail.gameObject, true)

			arg_15_0._skinId = var_15_2[2]
		end
	end

	local var_15_11 = arg_15_0.heroMo.rank - 1

	gohelper.setActive(arg_15_0._txttalentlevel.gameObject, var_15_11 > 1)

	if var_15_11 > 1 then
		local var_15_12 = luaLang("talent_characterrankup_talentlevellimit" .. arg_15_0.heroMo:getTalentTxtByHeroType())

		arg_15_0._txttalentlevel.text = string.format(var_15_12, var_0_0.characterTalentLevel[var_15_11])
	end

	arg_15_0:_cheskExtra()
	arg_15_0:_refreshSpecialEffect()
end

function var_0_0._cheskExtra(arg_16_0)
	if arg_16_0.heroMo.extraMo then
		local var_16_0
		local var_16_1 = arg_16_0.heroMo.extraMo:getSkillTalentMo()

		if var_16_1 then
			var_16_0 = var_16_1:getUnlockRankStr(arg_16_0.heroMo.rank)
		end

		if arg_16_0.heroMo.extraMo:hasWeapon() then
			local var_16_2 = arg_16_0.heroMo.extraMo:getWeaponMo()

			if var_16_2 then
				var_16_0 = var_16_2:getUnlockRankStr(arg_16_0.heroMo.rank)
			end
		end

		if var_16_0 then
			for iter_16_0, iter_16_1 in ipairs(var_16_0) do
				if not arg_16_0._txtextra then
					arg_16_0._txtextra = arg_16_0:getUserDataTb_()
				end

				if not arg_16_0._txtextra[iter_16_0] then
					local var_16_3 = gohelper.cloneInPlace(arg_16_0._txtlevel.gameObject, "extra")

					arg_16_0._txtextra[iter_16_0] = var_16_3:GetComponent(typeof(TMPro.TMP_Text))
				end

				arg_16_0._txtextra[iter_16_0].text = iter_16_1
			end
		end
	end
end

function var_0_0._refreshSpecialEffect(arg_17_0)
	local var_17_0 = CharacterModel.instance:getSpecialEffectDesc(arg_17_0.heroMo.skin, arg_17_0.heroMo.rank - 1)
	local var_17_1 = 0

	if var_17_0 then
		for iter_17_0, iter_17_1 in ipairs(var_17_0) do
			arg_17_0._specialEffectItem[iter_17_0].txt.text = iter_17_1
			var_17_1 = var_17_1 + 1
		end
	end

	for iter_17_2 = 1, #arg_17_0._specialEffectItem do
		gohelper.setActive(arg_17_0._specialEffectItem[iter_17_2].go, iter_17_2 <= var_17_1)
	end
end

function var_0_0._refreshAttribute(arg_18_0)
	local var_18_0 = arg_18_0:getCurrentHeroAttribute()
	local var_18_1 = arg_18_0:getHeroPreAttribute()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._attributeItems) do
		UISpriteSetMgr.instance:setCommonSprite(iter_18_1.icon, "icon_att_" .. CharacterEnum.BaseAttrIdList[iter_18_0])

		iter_18_1.preNumTxt.text = var_18_1[iter_18_0]
		iter_18_1.curNumTxt.text = var_18_0[iter_18_0]
	end
end

function var_0_0.getHeroPreAttribute(arg_19_0)
	return arg_19_0:_getHeroAttribute(arg_19_0.heroMo.level - 1, arg_19_0.heroMo.rank - 1)
end

function var_0_0.getCurrentHeroAttribute(arg_20_0)
	return arg_20_0:_getHeroAttribute()
end

function var_0_0._getHeroAttribute(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1 = arg_21_1 or arg_21_0.heroMo.level
	arg_21_2 = arg_21_2 or arg_21_0.heroMo.rank

	local var_21_0

	if arg_21_0.heroMo:hasDefaultEquip() then
		var_21_0 = {
			arg_21_0.heroMo.defaultEquipUid
		}
	end

	return arg_21_0.heroMo:getTotalBaseAttrList(var_21_0, arg_21_1, arg_21_2)
end

function var_0_0.onClose(arg_22_0)
	arg_22_0._simagecenterbg:UnLoadImage()
	arg_22_0._uiSpine:setModelVisible(false)
end

function var_0_0.onDestroyView(arg_23_0)
	if arg_23_0._uiSpine then
		arg_23_0._uiSpine:onDestroy()

		arg_23_0._uiSpine = nil
	end
end

return var_0_0
