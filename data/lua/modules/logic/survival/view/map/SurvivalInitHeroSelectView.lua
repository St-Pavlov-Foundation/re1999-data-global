module("modules.logic.survival.view.map.SurvivalInitHeroSelectView", package.seeall)

local var_0_0 = class("SurvivalInitHeroSelectView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gononecharacter = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_nonecharacter")
	arg_1_0._gocharacterinfo = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	arg_1_0._gospecialitem = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	arg_1_0._txtlevelmax = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	arg_1_0._btncharacter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	arg_1_0._btntrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_trial")
	arg_1_0._goBalance = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#go_balance")
	arg_1_0._goheroLvTxt = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/Text")
	arg_1_0._golevelWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	arg_1_0._txtlevelWithTalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	arg_1_0._txtlevelmaxWithTalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	arg_1_0._btncharacterWithTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	arg_1_0._btntrialWithTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_trial")
	arg_1_0._goBalanceWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#go_balance")
	arg_1_0._goheroLvTxtWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	arg_1_0._txttalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	arg_1_0._txttalentType = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talentType")
	arg_1_0._btnattribute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	arg_1_0._gopassiveskills = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	arg_1_0._gorolecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card")
	arg_1_0._goScrollContent = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	arg_1_0._scrollquickedit = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_quickedit")
	arg_1_0._gorolesort = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	arg_1_0._btnexskillrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	arg_1_0._btnquickedit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	arg_1_0._goexarrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	arg_1_0._gosearchfilter = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter")
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/#btn_closefilterview")
	arg_1_0._godmgitem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/dmgContainer/#go_dmgitem")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/attrContainer/#go_attritem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_reset")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_ok")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ops/#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ops/#btn_cancel")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnexskillrank:AddClickListener(arg_2_0._btnexskillrankOnClick, arg_2_0)
	arg_2_0._btnclassify:AddClickListener(arg_2_0._btnclassifyOnClick, arg_2_0)
	arg_2_0._btncharacter:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
	arg_2_0._btntrial:AddClickListener(arg_2_0._btntrialOnClick, arg_2_0)
	arg_2_0._btncharacterWithTalent:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
	arg_2_0._btntrialWithTalent:AddClickListener(arg_2_0._btntrialOnClick, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._btnattributeOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btnquickedit:AddClickListener(arg_2_0._btnquickeditOnClick, arg_2_0)
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btncloseFilterViewOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnexskillrank:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
	arg_3_0._btncharacter:RemoveClickListener()
	arg_3_0._btntrial:RemoveClickListener()
	arg_3_0._btncharacterWithTalent:RemoveClickListener()
	arg_3_0._btntrialWithTalent:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnquickedit:RemoveClickListener()
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
end

function var_0_0._btncloseFilterViewOnClick(arg_4_0)
	arg_4_0._selectDmgs = LuaUtil.deepCopy(arg_4_0._curDmgs)
	arg_4_0._selectAttrs = LuaUtil.deepCopy(arg_4_0._curAttrs)
	arg_4_0._selectLocations = LuaUtil.deepCopy(arg_4_0._curLocations)

	arg_4_0:_refreshBtnIcon()
	gohelper.setActive(arg_4_0._gosearchfilter, false)
end

function var_0_0._btnclassifyOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gosearchfilter, true)
	arg_5_0:_refreshFilterView()
end

function var_0_0._btnresetOnClick(arg_6_0)
	for iter_6_0 = 1, 2 do
		arg_6_0._selectDmgs[iter_6_0] = false
	end

	for iter_6_1 = 1, 6 do
		arg_6_0._selectAttrs[iter_6_1] = false
	end

	for iter_6_2 = 1, 6 do
		arg_6_0._selectLocations[iter_6_2] = false
	end

	arg_6_0:_refreshBtnIcon()
	arg_6_0:_refreshFilterView()
end

function var_0_0._btnokOnClick(arg_7_0)
	gohelper.setActive(arg_7_0._gosearchfilter, false)

	local var_7_0 = {}

	for iter_7_0 = 1, 2 do
		if arg_7_0._selectDmgs[iter_7_0] then
			table.insert(var_7_0, iter_7_0)
		end
	end

	local var_7_1 = {}

	for iter_7_1 = 1, 6 do
		if arg_7_0._selectAttrs[iter_7_1] then
			table.insert(var_7_1, iter_7_1)
		end
	end

	local var_7_2 = {}

	for iter_7_2 = 1, 6 do
		if arg_7_0._selectLocations[iter_7_2] then
			table.insert(var_7_2, iter_7_2)
		end
	end

	if #var_7_0 == 0 then
		var_7_0 = {
			1,
			2
		}
	end

	if #var_7_1 == 0 then
		var_7_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_7_2 == 0 then
		var_7_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_7_3, var_7_4 = transformhelper.getLocalPos(arg_7_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_7_0._goScrollContent.transform, var_7_3, arg_7_0._initScrollContentPosY)

	local var_7_5 = {
		dmgs = var_7_0,
		careers = var_7_1,
		locations = var_7_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_7_5, false, CharacterEnum.FilterType.Survival)

	arg_7_0._curDmgs = LuaUtil.deepCopy(arg_7_0._selectDmgs)
	arg_7_0._curAttrs = LuaUtil.deepCopy(arg_7_0._selectAttrs)
	arg_7_0._curLocations = LuaUtil.deepCopy(arg_7_0._selectLocations)

	arg_7_0:_refreshBtnIcon()
	arg_7_0:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0._btnpassiveskillOnClick(arg_8_0)
	if not arg_8_0._heroMO then
		return
	end

	local var_8_0 = {}

	var_8_0.tag = "passiveskill"
	var_8_0.heroid = arg_8_0._heroMO.heroId
	var_8_0.heroMo = arg_8_0._heroMO
	var_8_0.tipPos = Vector2.New(851, -59)
	var_8_0.buffTipsX = 1603
	var_8_0.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}
	var_8_0.isBalance = true

	CharacterController.instance:openCharacterTipView(var_8_0)
end

function var_0_0._btnconfirmOnClick(arg_9_0)
	if arg_9_0._isShowQuickEdit then
		arg_9_0:closeThis()

		return
	end

	arg_9_0._groupModel:trySetHeroMo(arg_9_0._heroMO)
	arg_9_0:closeThis()
end

function var_0_0._btncancelOnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._btncharacterOnClick(arg_11_0)
	if arg_11_0._heroMO then
		local var_11_0 = arg_11_0._groupModel:getList()

		CharacterController.instance:openCharacterView(arg_11_0._heroMO, var_11_0)
	end
end

function var_0_0._btntrialOnClick(arg_12_0)
	return
end

function var_0_0._btnattributeOnClick(arg_13_0)
	if arg_13_0._heroMO then
		local var_13_0 = {}

		var_13_0.tag = "attribute"
		var_13_0.heroid = arg_13_0._heroMO.heroId
		var_13_0.showExtraAttr = true
		var_13_0.fromSurvivalHeroGroupEditView = true
		var_13_0.heroMo = arg_13_0._heroMO
		var_13_0.isBalance = true

		CharacterController.instance:openCharacterTipView(var_13_0)
	end
end

function var_0_0._btnexskillrankOnClick(arg_14_0)
	local var_14_0, var_14_1 = transformhelper.getLocalPos(arg_14_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_14_0._goScrollContent.transform, var_14_0, arg_14_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.Survival)
	arg_14_0:_refreshBtnIcon()
	arg_14_0:_refreshCurScrollBySort()
end

function var_0_0._btnlvrankOnClick(arg_15_0)
	local var_15_0, var_15_1 = transformhelper.getLocalPos(arg_15_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_15_0._goScrollContent.transform, var_15_0, arg_15_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.Survival)
	arg_15_0:_refreshBtnIcon()
	arg_15_0:_refreshCurScrollBySort()
end

function var_0_0._btnrarerankOnClick(arg_16_0)
	local var_16_0, var_16_1 = transformhelper.getLocalPos(arg_16_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_16_0._goScrollContent.transform, var_16_0, arg_16_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.Survival)
	arg_16_0:_refreshBtnIcon()
	arg_16_0:_refreshCurScrollBySort()
end

function var_0_0._btnquickeditOnClick(arg_17_0)
	arg_17_0._isShowQuickEdit = not arg_17_0._isShowQuickEdit

	arg_17_0:_refreshBtnIcon()
	arg_17_0:_refreshEditMode()

	if arg_17_0._isShowQuickEdit then
		local var_17_0 = arg_17_0._groupModel:getList()[1]

		if var_17_0 then
			arg_17_0._groupModel:selectCell(1, true)
			arg_17_0:_onHeroItemClick(var_17_0)
		else
			arg_17_0:_onHeroItemClick(nil)
		end
	else
		arg_17_0:_onHeroItemClick(arg_17_0._groupModel:getList()[1])

		for iter_17_0, iter_17_1 in ipairs(arg_17_0._groupModel:getList()) do
			if arg_17_0._groupModel:getMoIndex(iter_17_1) > 0 then
				arg_17_0._groupModel:selectCell(iter_17_0, true)
			end
		end
	end
end

function var_0_0._attrBtnOnClick(arg_18_0, arg_18_1)
	arg_18_0._selectAttrs[arg_18_1] = not arg_18_0._selectAttrs[arg_18_1]

	arg_18_0:_refreshFilterView()
end

function var_0_0._dmgBtnOnClick(arg_19_0, arg_19_1)
	if not arg_19_0._selectDmgs[arg_19_1] then
		arg_19_0._selectDmgs[3 - arg_19_1] = arg_19_0._selectDmgs[arg_19_1]
	end

	arg_19_0._selectDmgs[arg_19_1] = not arg_19_0._selectDmgs[arg_19_1]

	arg_19_0:_refreshFilterView()
end

function var_0_0._locationBtnOnClick(arg_20_0, arg_20_1)
	arg_20_0._selectLocations[arg_20_1] = not arg_20_0._selectLocations[arg_20_1]

	arg_20_0:_refreshFilterView()
end

function var_0_0._onHeroItemClick(arg_21_0, arg_21_1)
	arg_21_0._heroMO = arg_21_1

	arg_21_0:_refreshCharacterInfo()
end

function var_0_0._refreshCharacterInfo(arg_22_0)
	if arg_22_0._heroMO then
		gohelper.setActive(arg_22_0._gononecharacter, false)
		gohelper.setActive(arg_22_0._gocharacterinfo, true)
		arg_22_0:_refreshSkill()
		arg_22_0:_refreshMainInfo()
		arg_22_0:_refreshAttribute()
		arg_22_0:_refreshPassiveSkill()
	else
		gohelper.setActive(arg_22_0._gononecharacter, true)
		gohelper.setActive(arg_22_0._gocharacterinfo, false)
	end
end

function var_0_0._refreshMainInfo(arg_23_0)
	if arg_23_0._heroMO then
		gohelper.setActive(arg_23_0._btntrial.gameObject, arg_23_0._heroMO:isTrial())
		gohelper.setActive(arg_23_0._btntrialWithTalent.gameObject, arg_23_0._heroMO:isTrial())
		UISpriteSetMgr.instance:setCommonSprite(arg_23_0._imagecareericon, "sx_biandui_" .. tostring(arg_23_0._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(arg_23_0._imagedmgtype, "dmgtype" .. tostring(arg_23_0._heroMO.config.dmgType))

		arg_23_0._txtname.text = arg_23_0._heroMO:getHeroName()
		arg_23_0._txtnameen.text = arg_23_0._heroMO.config.nameEng

		local var_23_0 = arg_23_0._heroMO.rank >= CharacterEnum.TalentRank and arg_23_0._heroMO.talent > 0

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			var_23_0 = false
		end

		local var_23_1 = 0
		local var_23_2 = 0
		local var_23_3 = 0
		local var_23_4 = false

		if not arg_23_0._heroMO:isTrial() then
			local var_23_5

			var_23_1, var_23_5, var_23_3 = SurvivalBalanceHelper.getHeroBalanceInfo(arg_23_0._heroMO.heroId)

			if var_23_5 and var_23_5 >= CharacterEnum.TalentRank and var_23_3 > 0 then
				var_23_4 = true
			end
		end

		local var_23_6 = var_23_1 and var_23_1 > arg_23_0._heroMO.level
		local var_23_7 = var_23_4 and (not var_23_0 or var_23_3 > arg_23_0._heroMO.talent)

		if var_23_0 or var_23_4 then
			gohelper.setActive(arg_23_0._golevel, false)
			gohelper.setActive(arg_23_0._golevelWithTalent, true)
			gohelper.setActive(arg_23_0._goBalanceWithTalent, var_23_6 or var_23_7)
			gohelper.setActive(arg_23_0._goheroLvTxtWithTalent, true)

			if var_23_6 then
				local var_23_8, var_23_9 = HeroConfig.instance:getShowLevel(var_23_1)
				local var_23_10 = CharacterModel.instance:getrankEffects(arg_23_0._heroMO.heroId, var_23_9)[1]
				local var_23_11 = HeroConfig.instance:getShowLevel(var_23_10)

				arg_23_0._txtlevelWithTalent.text = "<color=#8fb1cc>" .. tostring(var_23_8)
				arg_23_0._txtlevelmaxWithTalent.text = string.format("/%d", var_23_11)
			else
				local var_23_12 = CharacterModel.instance:getrankEffects(arg_23_0._heroMO.heroId, arg_23_0._heroMO.rank)[1]
				local var_23_13 = HeroConfig.instance:getShowLevel(arg_23_0._heroMO.level)
				local var_23_14 = HeroConfig.instance:getShowLevel(var_23_12)

				arg_23_0._txtlevelWithTalent.text = tostring(var_23_13)
				arg_23_0._txtlevelmaxWithTalent.text = string.format("/%d", var_23_14)
			end

			if var_23_7 then
				arg_23_0._txttalent.text = "<color=#8fb1cc>Lv.<size=40>" .. tostring(var_23_3)
			else
				arg_23_0._txttalent.text = "Lv.<size=40>" .. tostring(arg_23_0._heroMO.talent)
			end

			arg_23_0._txttalentType.text = luaLang("talent_character_talentcn" .. arg_23_0._heroMO:getTalentTxtByHeroType())
		else
			gohelper.setActive(arg_23_0._golevel, true)
			gohelper.setActive(arg_23_0._golevelWithTalent, false)
			gohelper.setActive(arg_23_0._goBalance, var_23_6)
			gohelper.setActive(arg_23_0._goheroLvTxt, not var_23_6)

			if var_23_6 then
				local var_23_15, var_23_16 = HeroConfig.instance:getShowLevel(var_23_1)
				local var_23_17 = CharacterModel.instance:getrankEffects(arg_23_0._heroMO.heroId, var_23_16)[1]
				local var_23_18 = HeroConfig.instance:getShowLevel(var_23_17)

				arg_23_0._txtlevel.text = "<color=#8fb1cc>" .. tostring(var_23_15)
				arg_23_0._txtlevelmax.text = string.format("/%d", var_23_18)
			else
				local var_23_19 = CharacterModel.instance:getrankEffects(arg_23_0._heroMO.heroId, arg_23_0._heroMO.rank)[1]
				local var_23_20 = HeroConfig.instance:getShowLevel(arg_23_0._heroMO.level)
				local var_23_21 = HeroConfig.instance:getShowLevel(var_23_19)

				arg_23_0._txtlevel.text = tostring(var_23_20)
				arg_23_0._txtlevelmax.text = string.format("/%d", var_23_21)
			end
		end

		local var_23_22 = {}

		if not string.nilorempty(arg_23_0._heroMO.config.battleTag) then
			var_23_22 = string.split(arg_23_0._heroMO.config.battleTag, "#")
		end

		for iter_23_0 = 1, #var_23_22 do
			local var_23_23 = arg_23_0._careerGOs[iter_23_0]

			if not var_23_23 then
				var_23_23 = arg_23_0:getUserDataTb_()
				var_23_23.go = gohelper.cloneInPlace(arg_23_0._gospecialitem, "item" .. iter_23_0)
				var_23_23.textfour = gohelper.findChildText(var_23_23.go, "#go_fourword/name")
				var_23_23.textthree = gohelper.findChildText(var_23_23.go, "#go_threeword/name")
				var_23_23.texttwo = gohelper.findChildText(var_23_23.go, "#go_twoword/name")
				var_23_23.containerfour = gohelper.findChild(var_23_23.go, "#go_fourword")
				var_23_23.containerthree = gohelper.findChild(var_23_23.go, "#go_threeword")
				var_23_23.containertwo = gohelper.findChild(var_23_23.go, "#go_twoword")

				table.insert(arg_23_0._careerGOs, var_23_23)
			end

			local var_23_24 = HeroConfig.instance:getBattleTagConfigCO(var_23_22[iter_23_0]).tagName
			local var_23_25 = GameUtil.utf8len(var_23_24)

			gohelper.setActive(var_23_23.containertwo, var_23_25 <= 2)
			gohelper.setActive(var_23_23.containerthree, var_23_25 == 3)
			gohelper.setActive(var_23_23.containerfour, var_23_25 >= 4)

			if var_23_25 <= 2 then
				var_23_23.texttwo.text = var_23_24
			elseif var_23_25 == 3 then
				var_23_23.textthree.text = var_23_24
			else
				var_23_23.textfour.text = var_23_24
			end

			gohelper.setActive(var_23_23.go, true)
		end

		for iter_23_1 = #var_23_22 + 1, #arg_23_0._careerGOs do
			gohelper.setActive(arg_23_0._careerGOs[iter_23_1].go, false)
		end
	end
end

function var_0_0._refreshAttribute(arg_24_0)
	if arg_24_0._heroMO then
		local var_24_0 = HeroGroupTrialModel.instance:getById(arg_24_0._originalHeroUid)
		local var_24_1

		if var_24_0 then
			var_24_1 = var_24_0.trialEquipMo
		end

		local var_24_2 = arg_24_0._heroMO:getTotalBaseAttrDict(arg_24_0._equips, nil, nil, true, var_24_1, SurvivalBalanceHelper.getHeroBalanceInfo)

		for iter_24_0, iter_24_1 in ipairs(CharacterEnum.BaseAttrIdList) do
			local var_24_3 = HeroConfig.instance:getHeroAttributeCO(iter_24_1)

			arg_24_0._attributevalues[iter_24_0].name.text = var_24_3.name
			arg_24_0._attributevalues[iter_24_0].value.text = var_24_2[iter_24_1]

			CharacterController.instance:SetAttriIcon(arg_24_0._attributevalues[iter_24_0].icon, iter_24_1)
		end
	end
end

function var_0_0._refreshPassiveSkill(arg_25_0)
	if not arg_25_0._heroMO then
		return
	end

	local var_25_0 = arg_25_0._heroMO:getpassiveskillsCO()
	local var_25_1 = var_25_0[1].skillPassive
	local var_25_2 = lua_skill.configDict[var_25_1]

	if not var_25_2 then
		logError("找不到角色被动技能, skillId: " .. tostring(var_25_1))
	else
		arg_25_0._txtpassivename.text = var_25_2.name
	end

	local var_25_3 = 0

	if not arg_25_0._heroMO:isTrial() then
		var_25_3 = SurvivalBalanceHelper.getHeroBalanceLv(arg_25_0._heroMO.heroId)
	end

	local var_25_4 = var_25_3 > arg_25_0._heroMO.level
	local var_25_5, var_25_6 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_25_0._heroMO.heroId, math.max(arg_25_0._heroMO.level, var_25_3))

	for iter_25_0 = 1, #var_25_0 do
		local var_25_7 = iter_25_0 <= var_25_5

		gohelper.setActive(arg_25_0._passiveskillitems[iter_25_0].on, var_25_7 and not var_25_4)
		gohelper.setActive(arg_25_0._passiveskillitems[iter_25_0].off, not var_25_7)
		gohelper.setActive(arg_25_0._passiveskillitems[iter_25_0].balance, var_25_7 and var_25_4)
		gohelper.setActive(arg_25_0._passiveskillitems[iter_25_0].go, true)
	end

	for iter_25_1 = #var_25_0 + 1, #arg_25_0._passiveskillitems do
		gohelper.setActive(arg_25_0._passiveskillitems[iter_25_1].go, false)
	end

	if var_25_0[0] then
		gohelper.setActive(arg_25_0._passiveskillitems[0].on, true)
		gohelper.setActive(arg_25_0._passiveskillitems[0].off, false)
		gohelper.setActive(arg_25_0._passiveskillitems[0].balance, var_25_4)
		gohelper.setActive(arg_25_0._passiveskillitems[0].go, true)
	else
		gohelper.setActive(arg_25_0._passiveskillitems[0].go, false)
	end
end

function var_0_0._refreshSkill(arg_26_0)
	arg_26_0._skillContainer:onUpdateMO(arg_26_0._heroMO and arg_26_0._heroMO.heroId, nil, arg_26_0._heroMO, true)
end

function var_0_0._refreshBtnIcon(arg_27_0)
	local var_27_0 = CharacterModel.instance:getRankState()
	local var_27_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.Survival)

	gohelper.setActive(arg_27_0._lvBtns[1], var_27_1 ~= 1)
	gohelper.setActive(arg_27_0._lvBtns[2], var_27_1 == 1)
	gohelper.setActive(arg_27_0._rareBtns[1], var_27_1 ~= 2)
	gohelper.setActive(arg_27_0._rareBtns[2], var_27_1 == 2)

	local var_27_2 = false

	for iter_27_0, iter_27_1 in pairs(arg_27_0._selectDmgs) do
		if iter_27_1 then
			var_27_2 = true
		end
	end

	for iter_27_2, iter_27_3 in pairs(arg_27_0._selectAttrs) do
		if iter_27_3 then
			var_27_2 = true
		end
	end

	for iter_27_4, iter_27_5 in pairs(arg_27_0._selectLocations) do
		if iter_27_5 then
			var_27_2 = true
		end
	end

	gohelper.setActive(arg_27_0._classifyBtns[1], not var_27_2)
	gohelper.setActive(arg_27_0._classifyBtns[2], var_27_2)
	HeroGroupTrialModel.instance:sortByLevelAndRare(var_27_1 == 1, var_27_0[var_27_1] == 1)
	transformhelper.setLocalScale(arg_27_0._lvArrow[1], 1, var_27_0[1], 1)
	transformhelper.setLocalScale(arg_27_0._lvArrow[2], 1, var_27_0[1], 1)
	transformhelper.setLocalScale(arg_27_0._rareArrow[1], 1, var_27_0[2], 1)
	transformhelper.setLocalScale(arg_27_0._rareArrow[2], 1, var_27_0[2], 1)
end

function var_0_0._refreshFilterView(arg_28_0)
	for iter_28_0 = 1, 2 do
		gohelper.setActive(arg_28_0._dmgUnselects[iter_28_0], not arg_28_0._selectDmgs[iter_28_0])
		gohelper.setActive(arg_28_0._dmgSelects[iter_28_0], arg_28_0._selectDmgs[iter_28_0])
	end

	for iter_28_1 = 1, 6 do
		gohelper.setActive(arg_28_0._attrUnselects[iter_28_1], not arg_28_0._selectAttrs[iter_28_1])
		gohelper.setActive(arg_28_0._attrSelects[iter_28_1], arg_28_0._selectAttrs[iter_28_1])
	end

	for iter_28_2 = 1, 6 do
		gohelper.setActive(arg_28_0._locationUnselects[iter_28_2], not arg_28_0._selectLocations[iter_28_2])
		gohelper.setActive(arg_28_0._locationSelects[iter_28_2], arg_28_0._selectLocations[iter_28_2])
	end
end

function var_0_0._updateHeroList(arg_29_0)
	local var_29_0 = {}

	for iter_29_0 = 1, 2 do
		if arg_29_0._selectDmgs[iter_29_0] then
			table.insert(var_29_0, iter_29_0)
		end
	end

	local var_29_1 = {}

	for iter_29_1 = 1, 6 do
		if arg_29_0._selectAttrs[iter_29_1] then
			table.insert(var_29_1, iter_29_1)
		end
	end

	local var_29_2 = {}

	for iter_29_2 = 1, 6 do
		if arg_29_0._selectLocations[iter_29_2] then
			table.insert(var_29_2, iter_29_2)
		end
	end

	if #var_29_0 == 0 then
		var_29_0 = {
			1,
			2
		}
	end

	if #var_29_1 == 0 then
		var_29_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_29_2 == 0 then
		var_29_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_29_3 = {
		dmgs = var_29_0,
		careers = var_29_1,
		locations = var_29_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_29_3, false, CharacterEnum.FilterType.Survival)
	arg_29_0:_refreshBtnIcon()
	arg_29_0._groupModel:initHeroList()
end

function var_0_0._onAttributeChanged(arg_30_0, arg_30_1, arg_30_2)
	CharacterModel.instance:setFakeLevel(arg_30_2, arg_30_1)
end

function var_0_0._refreshEditMode(arg_31_0)
	gohelper.setActive(arg_31_0._scrollquickedit, arg_31_0._isShowQuickEdit)
	gohelper.setActive(arg_31_0._scrollcard, not arg_31_0._isShowQuickEdit)
	gohelper.setActive(arg_31_0._goBtnEditQuickMode, arg_31_0._isShowQuickEdit)
	gohelper.setActive(arg_31_0._goBtnEditNormalMode, not arg_31_0._isShowQuickEdit)
end

function var_0_0._refreshCurScrollBySort(arg_32_0)
	arg_32_0._groupModel:initHeroList()
end

function var_0_0._editableInitView(arg_33_0)
	gohelper.setActive(arg_33_0._gospecialitem, false)

	arg_33_0._careerGOs = {}
	arg_33_0._imgBg = gohelper.findChildSingleImage(arg_33_0.viewGO, "bg/bgimg")
	arg_33_0._simageredlight = gohelper.findChildSingleImage(arg_33_0.viewGO, "bg/#simage_redlight")

	arg_33_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_33_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	arg_33_0._lvBtns = arg_33_0:getUserDataTb_()
	arg_33_0._lvArrow = arg_33_0:getUserDataTb_()
	arg_33_0._rareBtns = arg_33_0:getUserDataTb_()
	arg_33_0._rareArrow = arg_33_0:getUserDataTb_()
	arg_33_0._classifyBtns = arg_33_0:getUserDataTb_()
	arg_33_0._selectDmgs = {}
	arg_33_0._dmgSelects = arg_33_0:getUserDataTb_()
	arg_33_0._dmgUnselects = arg_33_0:getUserDataTb_()
	arg_33_0._dmgBtnClicks = arg_33_0:getUserDataTb_()
	arg_33_0._selectAttrs = {}
	arg_33_0._attrSelects = arg_33_0:getUserDataTb_()
	arg_33_0._attrUnselects = arg_33_0:getUserDataTb_()
	arg_33_0._attrBtnClicks = arg_33_0:getUserDataTb_()
	arg_33_0._selectLocations = {}
	arg_33_0._locationSelects = arg_33_0:getUserDataTb_()
	arg_33_0._locationUnselects = arg_33_0:getUserDataTb_()
	arg_33_0._locationBtnClicks = arg_33_0:getUserDataTb_()
	arg_33_0._curDmgs = {}
	arg_33_0._curAttrs = {}
	arg_33_0._curLocations = {}

	for iter_33_0 = 1, 2 do
		arg_33_0._lvBtns[iter_33_0] = gohelper.findChild(arg_33_0._btnlvrank.gameObject, "btn" .. tostring(iter_33_0))
		arg_33_0._lvArrow[iter_33_0] = gohelper.findChild(arg_33_0._lvBtns[iter_33_0], "txt/arrow").transform
		arg_33_0._rareBtns[iter_33_0] = gohelper.findChild(arg_33_0._btnrarerank.gameObject, "btn" .. tostring(iter_33_0))
		arg_33_0._rareArrow[iter_33_0] = gohelper.findChild(arg_33_0._rareBtns[iter_33_0], "txt/arrow").transform
		arg_33_0._classifyBtns[iter_33_0] = gohelper.findChild(arg_33_0._btnclassify.gameObject, "btn" .. tostring(iter_33_0))
		arg_33_0._dmgUnselects[iter_33_0] = gohelper.findChild(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_33_0 .. "/unselected")
		arg_33_0._dmgSelects[iter_33_0] = gohelper.findChild(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_33_0 .. "/selected")
		arg_33_0._dmgBtnClicks[iter_33_0] = gohelper.findChildButtonWithAudio(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_33_0 .. "/click")

		arg_33_0._dmgBtnClicks[iter_33_0]:AddClickListener(arg_33_0._dmgBtnOnClick, arg_33_0, iter_33_0)
	end

	for iter_33_1 = 1, 6 do
		arg_33_0._attrUnselects[iter_33_1] = gohelper.findChild(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_33_1 .. "/unselected")
		arg_33_0._attrSelects[iter_33_1] = gohelper.findChild(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_33_1 .. "/selected")
		arg_33_0._attrBtnClicks[iter_33_1] = gohelper.findChildButtonWithAudio(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_33_1 .. "/click")

		arg_33_0._attrBtnClicks[iter_33_1]:AddClickListener(arg_33_0._attrBtnOnClick, arg_33_0, iter_33_1)
	end

	for iter_33_2 = 1, 6 do
		arg_33_0._locationUnselects[iter_33_2] = gohelper.findChild(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_33_2 .. "/unselected")
		arg_33_0._locationSelects[iter_33_2] = gohelper.findChild(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_33_2 .. "/selected")
		arg_33_0._locationBtnClicks[iter_33_2] = gohelper.findChildButtonWithAudio(arg_33_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_33_2 .. "/click")

		arg_33_0._locationBtnClicks[iter_33_2]:AddClickListener(arg_33_0._locationBtnOnClick, arg_33_0, iter_33_2)
	end

	arg_33_0._goBtnEditQuickMode = gohelper.findChild(arg_33_0._btnquickedit.gameObject, "btn2")
	arg_33_0._goBtnEditNormalMode = gohelper.findChild(arg_33_0._btnquickedit.gameObject, "btn1")
	arg_33_0._attributevalues = {}

	for iter_33_3 = 1, 5 do
		local var_33_0 = arg_33_0:getUserDataTb_()

		var_33_0.value = gohelper.findChildText(arg_33_0._goattribute, "attribute" .. tostring(iter_33_3) .. "/txt_attribute")
		var_33_0.name = gohelper.findChildText(arg_33_0._goattribute, "attribute" .. tostring(iter_33_3) .. "/name")
		var_33_0.icon = gohelper.findChildImage(arg_33_0._goattribute, "attribute" .. tostring(iter_33_3) .. "/icon")
		arg_33_0._attributevalues[iter_33_3] = var_33_0
	end

	arg_33_0._passiveskillitems = {}

	for iter_33_4 = 1, 3 do
		arg_33_0._passiveskillitems[iter_33_4] = arg_33_0:_findPassiveskillitems(iter_33_4)
	end

	arg_33_0._passiveskillitems[0] = arg_33_0:_findPassiveskillitems(4)
	arg_33_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_33_0._goskill, CharacterSkillContainer)

	gohelper.setActive(arg_33_0._gononecharacter, false)
	gohelper.setActive(arg_33_0._gocharacterinfo, false)

	arg_33_0._animator = arg_33_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._findPassiveskillitems(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:getUserDataTb_()

	var_34_0.go = gohelper.findChild(arg_34_0._gopassiveskills, "passiveskill" .. arg_34_1)
	var_34_0.on = gohelper.findChild(var_34_0.go, "on")
	var_34_0.off = gohelper.findChild(var_34_0.go, "off")
	var_34_0.balance = gohelper.findChild(var_34_0.go, "balance")

	return var_34_0
end

function var_0_0.getGroupModel(arg_35_0)
	return SurvivalMapModel.instance:getInitGroup()
end

function var_0_0.onOpen(arg_36_0)
	arg_36_0._groupModel = arg_36_0:getGroupModel()
	arg_36_0._isShowQuickEdit = false
	arg_36_0._scrollcard.verticalNormalizedPosition = 1
	arg_36_0._scrollquickedit.verticalNormalizedPosition = 1

	for iter_36_0 = 1, 2 do
		arg_36_0._selectDmgs[iter_36_0] = false
	end

	for iter_36_1 = 1, 6 do
		arg_36_0._selectAttrs[iter_36_1] = false
	end

	for iter_36_2 = 1, 6 do
		arg_36_0._selectLocations[iter_36_2] = false
	end

	arg_36_0._heroMO = arg_36_0._groupModel:getList()[arg_36_0._groupModel.defaultIndex]

	arg_36_0:_refreshEditMode()
	arg_36_0:_refreshBtnIcon()
	arg_36_0:_refreshCharacterInfo()
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_36_0._updateHeroList, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_36_0._updateHeroList, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_36_0._updateHeroList, arg_36_0)
	arg_36_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_36_0._onHeroItemClick, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_36_0._refreshCharacterInfo, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_36_0._refreshCharacterInfo, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_36_0._refreshCharacterInfo, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_36_0._refreshCharacterInfo, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_36_0._refreshCharacterInfo, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_36_0._onAttributeChanged, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_36_0._showCharacterRankUpView, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_36_0._markFavorSuccess, arg_36_0)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_36_0._onOpenView, arg_36_0)
	arg_36_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_36_0._onCloseView, arg_36_0)
	arg_36_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_36_0._refreshCharacterInfo, arg_36_0)
	arg_36_0:addEventCb(AudioMgr.instance, AudioMgr.Evt_Trigger, arg_36_0._onAudioTrigger, arg_36_0)
	gohelper.addUIClickAudio(arg_36_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_36_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_36_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_36_0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_36_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_36_0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, arg_36_0._initScrollContentPosY = transformhelper.getLocalPos(arg_36_0._goScrollContent.transform)
end

function var_0_0.onClose(arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_37_0._updateHeroList, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_37_0._updateHeroList, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_37_0._updateHeroList, arg_37_0)
	arg_37_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_37_0._onHeroItemClick, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_37_0._refreshCharacterInfo, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_37_0._refreshCharacterInfo, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_37_0._refreshCharacterInfo, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_37_0._refreshCharacterInfo, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_37_0._refreshCharacterInfo, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_37_0._onAttributeChanged, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_37_0._showCharacterRankUpView, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_37_0._markFavorSuccess, arg_37_0)
	arg_37_0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_37_0._refreshCharacterInfo, arg_37_0)
	arg_37_0:removeEventCb(AudioMgr.instance, AudioMgr.Evt_Trigger, arg_37_0._onAudioTrigger, arg_37_0)
	CharacterModel.instance:setFakeLevel()
	arg_37_0._groupModel:clear()
	CommonHeroHelper.instance:resetGrayState()

	arg_37_0._selectDmgs = {}
	arg_37_0._selectAttrs = {}
	arg_37_0._selectLocations = {}
end

function var_0_0._onAudioTrigger(arg_38_0, arg_38_1)
	return
end

function var_0_0._onOpenView(arg_39_0, arg_39_1)
	return
end

function var_0_0._markFavorSuccess(arg_40_0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._onCloseView(arg_41_0, arg_41_1)
	return
end

function var_0_0._showCharacterRankUpView(arg_42_0, arg_42_1)
	arg_42_1()
end

function var_0_0.onDestroyView(arg_43_0)
	arg_43_0._imgBg:UnLoadImage()
	arg_43_0._simageredlight:UnLoadImage()

	arg_43_0._imgBg = nil
	arg_43_0._simageredlight = nil

	for iter_43_0 = 1, 2 do
		arg_43_0._dmgBtnClicks[iter_43_0]:RemoveClickListener()
	end

	for iter_43_1 = 1, 6 do
		arg_43_0._attrBtnClicks[iter_43_1]:RemoveClickListener()
	end

	for iter_43_2 = 1, 6 do
		arg_43_0._locationBtnClicks[iter_43_2]:RemoveClickListener()
	end
end

return var_0_0
