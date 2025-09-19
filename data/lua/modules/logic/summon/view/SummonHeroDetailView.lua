module("modules.logic.summon.view.SummonHeroDetailView", package.seeall)

local var_0_0 = class("SummonHeroDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg")
	arg_1_0._simageredlight = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/lightcontainer/#simage_redlight")
	arg_1_0._gocharacterinfo = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	arg_1_0._gospecialitem = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	arg_1_0._gofourword = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_fourword")
	arg_1_0._gothreeword = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_threeword")
	arg_1_0._gotwoword = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_twoword")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	arg_1_0._btnexskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/exskill/#btn_exskill")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	arg_1_0._gopassiveskills = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	arg_1_0._btnattribute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	arg_1_0._simagecharacter = gohelper.findChildSingleImage(arg_1_0.viewGO, "charactercontainer/#simage_character")
	arg_1_0._gostarList = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_starList")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnuniqueSkill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#btn_uniqueSkill")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._btnattributeOnClick, arg_2_0)
	arg_2_0._btnexskill:AddClickListener(arg_2_0._btnexskillOnClick, arg_2_0)
	arg_2_0._btnuniqueSkill:AddClickListener(arg_2_0._btnuniqueSkillOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnexskill:RemoveClickListener()
	arg_3_0._btnuniqueSkill:RemoveClickListener()
end

var_0_0.HpAttrId = 101
var_0_0.AttackAttrId = 102
var_0_0.DefenseAttrId = 103
var_0_0.MdefenseAttrId = 104
var_0_0.TechnicAttrId = 105

function var_0_0._btnpassiveskillOnClick(arg_4_0)
	local var_4_0 = {}

	var_4_0.tag = "passiveskill"
	var_4_0.heroid = arg_4_0._heroId
	var_4_0.tipPos = Vector2.New(909, -13.8)
	var_4_0.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}
	var_4_0.buffTipsX = 1666
	var_4_0.showAttributeOption = CharacterEnum.showAttributeOption.ShowMin

	CharacterController.instance:openCharacterTipView(var_4_0)
end

function var_0_0._btnattributeOnClick(arg_5_0)
	local var_5_0 = {}

	var_5_0.tag = "attribute"
	var_5_0.heroid = arg_5_0._heroId
	var_5_0.showAttributeOption = CharacterEnum.showAttributeOption.ShowMin

	CharacterController.instance:openCharacterTipView(var_5_0)
end

function var_0_0._btnexskillOnClick(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:_getReplaceSkillHeroMO(arg_6_0._heroId, arg_6_0._skinId)

	CharacterController.instance:openCharacterExSkillView({
		fromHeroDetailView = true,
		heroId = arg_6_0._heroId,
		showAttributeOption = CharacterEnum.showAttributeOption.ShowMin,
		heroMo = var_6_0
	})
end

function var_0_0._btnuniqueSkillOnClick(arg_7_0)
	local var_7_0 = arg_7_0._nextSkillOnClickTime or 0

	if arg_7_0._replaceHeroMOParams and var_7_0 <= Time.time then
		if arg_7_0._replaceHeroMOParams.rank == arg_7_0._replaceHeroMOParams.replaceSkillRank then
			arg_7_0._replaceHeroMOParams.rank = 1
		else
			arg_7_0._replaceHeroMOParams.rank = arg_7_0._replaceHeroMOParams.replaceSkillRank
		end

		TaskDispatcher.cancelTask(arg_7_0._onDelayRefeshSkill, arg_7_0)
		TaskDispatcher.runDelay(arg_7_0._onDelayRefeshSkill, arg_7_0, 0.16)

		arg_7_0._nextSkillOnClickTime = Time.time + 0.2

		arg_7_0._animator:Play("switch", 0, 0)
	end
end

function var_0_0._onDelayRefeshSkill(arg_8_0)
	arg_8_0:_refreshSkill(arg_8_0._heroId)
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))

	arg_9_0._imagecharacter = gohelper.findChildImage(arg_9_0.viewGO, "charactercontainer/#simage_character")
	arg_9_0._animator = arg_9_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_9_0._careerGOs = {}

	gohelper.setActive(arg_9_0._gospecialitem, false)
	arg_9_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	for iter_9_0 = 1, 6 do
		arg_9_0["_gostar" .. iter_9_0] = gohelper.findChild(arg_9_0._gostarList, "star" .. iter_9_0)
	end

	arg_9_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_9_0._goskill, CharacterSkillContainer)
	arg_9_0._attributevalues = {}

	for iter_9_1 = 1, 5 do
		local var_9_0 = arg_9_0:getUserDataTb_()

		var_9_0.value = gohelper.findChildText(arg_9_0._goattribute, "attribute" .. tostring(iter_9_1) .. "/txt_attribute")
		var_9_0.name = gohelper.findChildText(arg_9_0._goattribute, "attribute" .. tostring(iter_9_1) .. "/name")
		var_9_0.icon = gohelper.findChildImage(arg_9_0._goattribute, "attribute" .. tostring(iter_9_1) .. "/icon")
		var_9_0.rate = gohelper.findChildImage(arg_9_0._goattribute, "attribute" .. tostring(iter_9_1) .. "/rate")

		gohelper.setActive(var_9_0.rate.gameObject, false)

		arg_9_0._attributevalues[iter_9_1] = var_9_0
	end

	arg_9_0._passiveskillGOs = {}

	for iter_9_2 = 1, 3 do
		local var_9_1 = arg_9_0:_findPassiveskillitems(iter_9_2)

		table.insert(arg_9_0._passiveskillGOs, var_9_1)
	end

	arg_9_0._passiveskillGOs[0] = arg_9_0:_findPassiveskillitems(4)
end

function var_0_0._findPassiveskillitems(arg_10_0, arg_10_1)
	return (gohelper.findChild(arg_10_0._gopassiveskills, "passiveskill" .. arg_10_1))
end

function var_0_0._refreshUI(arg_11_0)
	gohelper.setActive(arg_11_0._btnuniqueSkill, arg_11_0._replaceHeroMOParams)
	arg_11_0:_refreshHero(arg_11_0._heroId)
	arg_11_0:_refreshSkin(arg_11_0._skinId)
end

function var_0_0._getSkinId(arg_12_0)
	for iter_12_0 = CharacterModel.instance:getMaxRank(arg_12_0._heroId), 1, -1 do
		local var_12_0 = GameUtil.splitString2(SkillConfig.instance:getherorankCO(arg_12_0._heroId, iter_12_0).effect, true, "|", "#")

		for iter_12_1, iter_12_2 in pairs(var_12_0) do
			if tonumber(iter_12_2[1]) == 3 then
				return tonumber(iter_12_2[2])
			end
		end
	end

	return nil
end

function var_0_0._refreshHero(arg_13_0, arg_13_1)
	local var_13_0 = HeroConfig.instance:getHeroCO(arg_13_1)

	for iter_13_0 = 1, 6 do
		gohelper.setActive(arg_13_0["_gostar" .. iter_13_0], iter_13_0 <= CharacterEnum.Star[var_13_0.rare])
	end

	arg_13_0._txtname.text = var_13_0.name
	arg_13_0._txtnameen.text = var_13_0.nameEng

	if var_13_0.id == 3113 and LangSettings.instance:isJp() then
		arg_13_0._txtnameen.text = ""
	end

	UISpriteSetMgr.instance:setCharactergetSprite(arg_13_0._imagecareericon, "charactercareer" .. tostring(var_13_0.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_13_0._imagedmgtype, "dmgtype" .. tostring(var_13_0.dmgType))

	local var_13_1 = CharacterModel.instance:getMaxRank(arg_13_1)
	local var_13_2 = CharacterModel.instance:getrankEffects(arg_13_1, var_13_1)[1]
	local var_13_3 = HeroConfig.instance:getShowLevel(var_13_2)

	arg_13_0._txtlevel.text = string.format("%d/%d", var_13_3, var_13_3)

	arg_13_0:_refreshSpecial(arg_13_1, var_13_0)
	arg_13_0:_refreshSkill(arg_13_1)
	arg_13_0:_refreshPassiveSkill(arg_13_1, var_13_0)
	arg_13_0:_refreshAttribute(arg_13_1, var_13_0)
end

function var_0_0._refreshSpecial(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}

	if not string.nilorempty(arg_14_2.battleTag) then
		var_14_0 = string.split(arg_14_2.battleTag, "#")
	end

	for iter_14_0 = 1, #var_14_0 do
		local var_14_1 = arg_14_0._careerGOs[iter_14_0]

		if not var_14_1 then
			var_14_1 = arg_14_0:getUserDataTb_()
			var_14_1.go = gohelper.cloneInPlace(arg_14_0._gospecialitem, "item" .. iter_14_0)
			var_14_1.textfour = gohelper.findChildText(var_14_1.go, "#go_fourword/name")
			var_14_1.textthree = gohelper.findChildText(var_14_1.go, "#go_threeword/name")
			var_14_1.texttwo = gohelper.findChildText(var_14_1.go, "#go_twoword/name")
			var_14_1.containerfour = gohelper.findChild(var_14_1.go, "#go_fourword")
			var_14_1.containerthree = gohelper.findChild(var_14_1.go, "#go_threeword")
			var_14_1.containertwo = gohelper.findChild(var_14_1.go, "#go_twoword")

			table.insert(arg_14_0._careerGOs, var_14_1)
		end

		local var_14_2 = HeroConfig.instance:getBattleTagConfigCO(var_14_0[iter_14_0]).tagName
		local var_14_3 = GameUtil.utf8len(var_14_2)

		gohelper.setActive(var_14_1.containertwo, var_14_3 <= 2)
		gohelper.setActive(var_14_1.containerthree, var_14_3 == 3)
		gohelper.setActive(var_14_1.containerfour, var_14_3 >= 4)

		if var_14_3 <= 2 then
			var_14_1.texttwo.text = var_14_2
		elseif var_14_3 == 3 then
			var_14_1.textthree.text = var_14_2
		else
			var_14_1.textfour.text = var_14_2
		end

		gohelper.setActive(var_14_1.go, true)
	end

	for iter_14_1 = #var_14_0 + 1, #arg_14_0._careerGOs do
		gohelper.setActive(arg_14_0._careerGOs[iter_14_1].go, false)
	end
end

function var_0_0._refreshSkill(arg_15_0, arg_15_1)
	arg_15_0._skillContainer:onUpdateMO(arg_15_1, CharacterEnum.showAttributeOption.ShowMin, arg_15_0._tempHeroMO)
end

function var_0_0._refreshPassiveSkill(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = SkillConfig.instance:getpassiveskillsCO(arg_16_1)
	local var_16_1 = var_16_0[1].skillPassive
	local var_16_2 = lua_skill.configDict[var_16_1]

	if not var_16_2 then
		logError("找不到角色被动技能, skillId: " .. tostring(var_16_1))
	end

	arg_16_0._txtpassivename.text = var_16_2.name

	for iter_16_0 = 1, #arg_16_0._passiveskillGOs do
		gohelper.setActive(arg_16_0._passiveskillGOs[iter_16_0], iter_16_0 <= #var_16_0)
	end

	gohelper.setActive(arg_16_0._passiveskillGOs[0], var_16_0[0] and true or false)
end

function var_0_0._refreshAttribute(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = {
		var_0_0.HpAttrId,
		var_0_0.DefenseAttrId,
		var_0_0.TechnicAttrId,
		var_0_0.MdefenseAttrId,
		var_0_0.AttackAttrId
	}

	for iter_17_0 = 1, 5 do
		local var_17_1 = HeroConfig.instance:getHeroAttributeCO(var_17_0[iter_17_0])

		arg_17_0._attributevalues[iter_17_0].name.text = var_17_1.name

		CharacterController.instance:SetAttriIcon(arg_17_0._attributevalues[iter_17_0].icon, var_17_0[iter_17_0], GameUtil.parseColor("#9b795e"))
	end

	local var_17_2 = SkillConfig.instance:getherolevelCO(arg_17_1, 1)
	local var_17_3 = var_17_2.hp
	local var_17_4 = var_17_2.atk
	local var_17_5 = var_17_2.def
	local var_17_6 = var_17_2.mdef
	local var_17_7 = var_17_2.technic

	arg_17_0._attributevalues[1].value.text = var_17_3
	arg_17_0._attributevalues[2].value.text = var_17_5
	arg_17_0._attributevalues[3].value.text = var_17_7
	arg_17_0._attributevalues[4].value.text = var_17_6
	arg_17_0._attributevalues[5].value.text = var_17_4
end

function var_0_0._getLevel1Atrributes(arg_18_0)
	local var_18_0 = 1
	local var_18_1 = SkillConfig.instance:getherolevelCO(arg_18_0._heroId, var_18_0)

	return {
		[var_0_0.HpAttrId] = var_18_1.hp,
		[var_0_0.AttackAttrId] = var_18_1.atk,
		[var_0_0.DefenseAttrId] = var_18_1.def,
		[var_0_0.MdefenseAttrId] = var_18_1.mdef,
		[var_0_0.TechnicAttrId] = var_18_1.technic
	}
end

function var_0_0._getAttributeRates(arg_19_0, arg_19_1)
	local var_19_0 = SkillConfig.instance:getGrowCo()
	local var_19_1 = {
		[var_0_0.HpAttrId] = {},
		[var_0_0.AttackAttrId] = {},
		[var_0_0.DefenseAttrId] = {},
		[var_0_0.MdefenseAttrId] = {},
		[var_0_0.TechnicAttrId] = {}
	}

	for iter_19_0 = 1, 8 do
		table.insert(var_19_1[var_0_0.AttackAttrId], var_19_0[iter_19_0].atk)
		table.insert(var_19_1[var_0_0.HpAttrId], var_19_0[iter_19_0].hp)
		table.insert(var_19_1[var_0_0.DefenseAttrId], var_19_0[iter_19_0].def)
		table.insert(var_19_1[var_0_0.MdefenseAttrId], var_19_0[iter_19_0].mdef)
		table.insert(var_19_1[var_0_0.TechnicAttrId], var_19_0[iter_19_0].technic)
	end

	return {
		[var_0_0.HpAttrId] = arg_19_0:_countRate(arg_19_1[var_0_0.HpAttrId], var_19_1[var_0_0.HpAttrId], 8),
		[var_0_0.AttackAttrId] = arg_19_0:_countRate(arg_19_1[var_0_0.AttackAttrId], var_19_1[var_0_0.AttackAttrId], 8),
		[var_0_0.DefenseAttrId] = arg_19_0:_countRate(arg_19_1[var_0_0.DefenseAttrId], var_19_1[var_0_0.DefenseAttrId], 8),
		[var_0_0.MdefenseAttrId] = arg_19_0:_countRate(arg_19_1[var_0_0.MdefenseAttrId], var_19_1[var_0_0.MdefenseAttrId], 8),
		[var_0_0.TechnicAttrId] = arg_19_0:_countRate(arg_19_1[var_0_0.TechnicAttrId], var_19_1[var_0_0.TechnicAttrId], 8)
	}
end

function var_0_0._countRate(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	for iter_20_0 = 1, arg_20_3 - 1 do
		if arg_20_1 < arg_20_2[iter_20_0 + 1] then
			return iter_20_0
		end
	end

	return arg_20_3
end

function var_0_0._refreshSkin(arg_21_0, arg_21_1)
	local var_21_0 = SkinConfig.instance:getSkinCo(arg_21_1)

	if not var_21_0 then
		logError("没有找到配置, skinId: " .. tostring(arg_21_1))

		return
	end

	local var_21_1 = SkinConfig.instance:getSkinOffset(var_21_0.haloOffset)
	local var_21_2 = tonumber(var_21_1[1])
	local var_21_3 = tonumber(var_21_1[2])
	local var_21_4 = tonumber(var_21_1[3])

	recthelper.setAnchor(arg_21_0._simageredlight.transform, var_21_2, var_21_3)
	transformhelper.setLocalScale(arg_21_0._simageredlight.transform, var_21_4, var_21_4, var_21_4)

	arg_21_0._skinConfig = var_21_0

	arg_21_0._simagecharacter:LoadImage(ResUrl.getHeadIconImg(var_21_0.drawing), arg_21_0._onImageLoaded, arg_21_0)

	if arg_21_0._skinColorStr then
		SLFramework.UGUI.GuiHelper.SetColor(arg_21_0._imagecharacter, arg_21_0._skinColorStr)
	end
end

function var_0_0._onImageLoaded(arg_22_0)
	ZProj.UGUIHelper.SetImageSize(arg_22_0._simagecharacter.gameObject)

	local var_22_0 = SkinConfig.instance:getSkinOffset(arg_22_0._skinConfig.summonHeroViewOffset)

	recthelper.setAnchor(arg_22_0._simagecharacter.transform.parent, var_22_0[1], var_22_0[2])
	transformhelper.setLocalScale(arg_22_0._simagecharacter.transform.parent, var_22_0[3], var_22_0[3], var_22_0[3])
end

function var_0_0._initViewParam(arg_23_0)
	arg_23_0._characterDetailId = arg_23_0.viewParam.id
	arg_23_0._heroId = arg_23_0.viewParam.heroId
	arg_23_0._skinId = arg_23_0.viewParam.skinId
	arg_23_0._skinColorStr = arg_23_0.viewParam.skinColorStr or "#FFFFFF"

	if arg_23_0._skinId == nil then
		if arg_23_0._heroId then
			local var_23_0 = HeroConfig.instance:getHeroCO(arg_23_0._heroId)

			arg_23_0._skinId = arg_23_0:_getSkinId() or var_23_0.skinId
		end

		if arg_23_0._characterDetailId then
			local var_23_1 = SummonConfig.instance:getCharacterDetailConfig(arg_23_0._characterDetailId)

			arg_23_0._heroId = var_23_1.heroId
			arg_23_0._skinId = arg_23_0:_getSkinId() or var_23_1.skinId
		end
	end

	arg_23_0._tempHeroMO, arg_23_0._replaceHeroMOParams = arg_23_0:_getReplaceSkillHeroMO(arg_23_0._heroId, arg_23_0._skinId)
end

function var_0_0._getReplaceSkillHeroMO(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = CharacterModel.instance:getReplaceSkillRankBySkinId(arg_24_2)

	if not var_24_0 or var_24_0 <= 1 then
		return
	end

	local var_24_1 = HeroModel.instance:getByHeroId(arg_24_1)

	if not var_24_1 then
		local var_24_2 = HeroConfig.instance:getHeroCO(arg_24_1)

		if var_24_2 then
			var_24_1 = HeroMo.New()

			var_24_1:initFromConfig(var_24_2)
		end
	end

	if var_24_1 then
		local var_24_3 = {
			rank = var_24_0,
			replaceSkillRank = var_24_0
		}

		return RoomHelper.mergeCfg(var_24_1, var_24_3), var_24_3
	end
end

function var_0_0.onUpdateParam(arg_25_0)
	arg_25_0:_initViewParam()
	arg_25_0:_refreshUI()
end

function var_0_0.onOpen(arg_26_0)
	arg_26_0:_initViewParam()
	arg_26_0:_refreshUI()
end

function var_0_0.onClose(arg_27_0)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	arg_28_0._simageredlight:UnLoadImage()
	arg_28_0._simagebg:UnLoadImage()
end

return var_0_0
