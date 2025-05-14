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

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._btnattributeOnClick, arg_2_0)
	arg_2_0._btnexskill:AddClickListener(arg_2_0._btnexskillOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnexskill:RemoveClickListener()
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
	CharacterController.instance:openCharacterExSkillView({
		fromHeroDetailView = true,
		heroId = arg_6_0._heroId,
		showAttributeOption = CharacterEnum.showAttributeOption.ShowMin
	})
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))

	arg_7_0._imagecharacter = gohelper.findChildImage(arg_7_0.viewGO, "charactercontainer/#simage_character")
	arg_7_0._careerGOs = {}

	gohelper.setActive(arg_7_0._gospecialitem, false)
	arg_7_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	for iter_7_0 = 1, 6 do
		arg_7_0["_gostar" .. iter_7_0] = gohelper.findChild(arg_7_0._gostarList, "star" .. iter_7_0)
	end

	arg_7_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._goskill, CharacterSkillContainer)
	arg_7_0._attributevalues = {}

	for iter_7_1 = 1, 5 do
		local var_7_0 = arg_7_0:getUserDataTb_()

		var_7_0.value = gohelper.findChildText(arg_7_0._goattribute, "attribute" .. tostring(iter_7_1) .. "/txt_attribute")
		var_7_0.name = gohelper.findChildText(arg_7_0._goattribute, "attribute" .. tostring(iter_7_1) .. "/name")
		var_7_0.icon = gohelper.findChildImage(arg_7_0._goattribute, "attribute" .. tostring(iter_7_1) .. "/icon")
		var_7_0.rate = gohelper.findChildImage(arg_7_0._goattribute, "attribute" .. tostring(iter_7_1) .. "/rate")

		gohelper.setActive(var_7_0.rate.gameObject, false)

		arg_7_0._attributevalues[iter_7_1] = var_7_0
	end

	arg_7_0._passiveskillGOs = {}

	for iter_7_2 = 1, 3 do
		local var_7_1 = gohelper.findChild(arg_7_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills/passiveskill" .. iter_7_2)

		table.insert(arg_7_0._passiveskillGOs, var_7_1)
	end
end

function var_0_0._refreshUI(arg_8_0)
	arg_8_0:_refreshHero(arg_8_0._heroId)
	arg_8_0:_refreshSkin(arg_8_0._skinId)
end

function var_0_0._getSkinId(arg_9_0)
	for iter_9_0 = CharacterModel.instance:getMaxRank(arg_9_0._heroId), 1, -1 do
		local var_9_0 = GameUtil.splitString2(SkillConfig.instance:getherorankCO(arg_9_0._heroId, iter_9_0).effect, true, "|", "#")

		for iter_9_1, iter_9_2 in pairs(var_9_0) do
			if tonumber(iter_9_2[1]) == 3 then
				return tonumber(iter_9_2[2])
			end
		end
	end

	return nil
end

function var_0_0._refreshHero(arg_10_0, arg_10_1)
	local var_10_0 = HeroConfig.instance:getHeroCO(arg_10_1)

	for iter_10_0 = 1, 6 do
		gohelper.setActive(arg_10_0["_gostar" .. iter_10_0], iter_10_0 <= CharacterEnum.Star[var_10_0.rare])
	end

	arg_10_0._txtname.text = var_10_0.name
	arg_10_0._txtnameen.text = var_10_0.nameEng

	UISpriteSetMgr.instance:setCharactergetSprite(arg_10_0._imagecareericon, "charactercareer" .. tostring(var_10_0.career))
	UISpriteSetMgr.instance:setCommonSprite(arg_10_0._imagedmgtype, "dmgtype" .. tostring(var_10_0.dmgType))

	local var_10_1 = CharacterModel.instance:getMaxRank(arg_10_1)
	local var_10_2 = CharacterModel.instance:getrankEffects(arg_10_1, var_10_1)[1]
	local var_10_3 = HeroConfig.instance:getShowLevel(var_10_2)

	arg_10_0._txtlevel.text = string.format("%d/%d", var_10_3, var_10_3)

	arg_10_0:_refreshSpecial(arg_10_1, var_10_0)
	arg_10_0:_refreshSkill(arg_10_1)
	arg_10_0:_refreshPassiveSkill(arg_10_1, var_10_0)
	arg_10_0:_refreshAttribute(arg_10_1, var_10_0)
end

function var_0_0._refreshSpecial(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = {}

	if not string.nilorempty(arg_11_2.battleTag) then
		var_11_0 = string.split(arg_11_2.battleTag, "#")
	end

	for iter_11_0 = 1, #var_11_0 do
		local var_11_1 = arg_11_0._careerGOs[iter_11_0]

		if not var_11_1 then
			var_11_1 = arg_11_0:getUserDataTb_()
			var_11_1.go = gohelper.cloneInPlace(arg_11_0._gospecialitem, "item" .. iter_11_0)
			var_11_1.textfour = gohelper.findChildText(var_11_1.go, "#go_fourword/name")
			var_11_1.textthree = gohelper.findChildText(var_11_1.go, "#go_threeword/name")
			var_11_1.texttwo = gohelper.findChildText(var_11_1.go, "#go_twoword/name")
			var_11_1.containerfour = gohelper.findChild(var_11_1.go, "#go_fourword")
			var_11_1.containerthree = gohelper.findChild(var_11_1.go, "#go_threeword")
			var_11_1.containertwo = gohelper.findChild(var_11_1.go, "#go_twoword")

			table.insert(arg_11_0._careerGOs, var_11_1)
		end

		local var_11_2 = HeroConfig.instance:getBattleTagConfigCO(var_11_0[iter_11_0]).tagName
		local var_11_3 = GameUtil.utf8len(var_11_2)

		gohelper.setActive(var_11_1.containertwo, var_11_3 <= 2)
		gohelper.setActive(var_11_1.containerthree, var_11_3 == 3)
		gohelper.setActive(var_11_1.containerfour, var_11_3 >= 4)

		if var_11_3 <= 2 then
			var_11_1.texttwo.text = var_11_2
		elseif var_11_3 == 3 then
			var_11_1.textthree.text = var_11_2
		else
			var_11_1.textfour.text = var_11_2
		end

		gohelper.setActive(var_11_1.go, true)
	end

	for iter_11_1 = #var_11_0 + 1, #arg_11_0._careerGOs do
		gohelper.setActive(arg_11_0._careerGOs[iter_11_1].go, false)
	end
end

function var_0_0._refreshSkill(arg_12_0, arg_12_1)
	arg_12_0._skillContainer:onUpdateMO(arg_12_1, CharacterEnum.showAttributeOption.ShowMin)
end

function var_0_0._refreshPassiveSkill(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = SkillConfig.instance:getpassiveskillsCO(arg_13_1)
	local var_13_1 = var_13_0[1].skillPassive
	local var_13_2 = lua_skill.configDict[var_13_1]

	if not var_13_2 then
		logError("找不到角色被动技能, skillId: " .. tostring(var_13_1))
	end

	arg_13_0._txtpassivename.text = var_13_2.name

	for iter_13_0 = 1, #arg_13_0._passiveskillGOs do
		gohelper.setActive(arg_13_0._passiveskillGOs[iter_13_0], iter_13_0 <= #var_13_0)
	end
end

function var_0_0._refreshAttribute(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {
		var_0_0.HpAttrId,
		var_0_0.DefenseAttrId,
		var_0_0.TechnicAttrId,
		var_0_0.MdefenseAttrId,
		var_0_0.AttackAttrId
	}

	for iter_14_0 = 1, 5 do
		local var_14_1 = HeroConfig.instance:getHeroAttributeCO(var_14_0[iter_14_0])

		arg_14_0._attributevalues[iter_14_0].name.text = var_14_1.name

		CharacterController.instance:SetAttriIcon(arg_14_0._attributevalues[iter_14_0].icon, var_14_0[iter_14_0], GameUtil.parseColor("#9b795e"))
	end

	local var_14_2 = SkillConfig.instance:getherolevelCO(arg_14_1, 1)
	local var_14_3 = var_14_2.hp
	local var_14_4 = var_14_2.atk
	local var_14_5 = var_14_2.def
	local var_14_6 = var_14_2.mdef
	local var_14_7 = var_14_2.technic

	arg_14_0._attributevalues[1].value.text = var_14_3
	arg_14_0._attributevalues[2].value.text = var_14_5
	arg_14_0._attributevalues[3].value.text = var_14_7
	arg_14_0._attributevalues[4].value.text = var_14_6
	arg_14_0._attributevalues[5].value.text = var_14_4
end

function var_0_0._getLevel1Atrributes(arg_15_0)
	local var_15_0 = 1
	local var_15_1 = SkillConfig.instance:getherolevelCO(arg_15_0._heroId, var_15_0)

	return {
		[var_0_0.HpAttrId] = var_15_1.hp,
		[var_0_0.AttackAttrId] = var_15_1.atk,
		[var_0_0.DefenseAttrId] = var_15_1.def,
		[var_0_0.MdefenseAttrId] = var_15_1.mdef,
		[var_0_0.TechnicAttrId] = var_15_1.technic
	}
end

function var_0_0._getAttributeRates(arg_16_0, arg_16_1)
	local var_16_0 = SkillConfig.instance:getGrowCo()
	local var_16_1 = {
		[var_0_0.HpAttrId] = {},
		[var_0_0.AttackAttrId] = {},
		[var_0_0.DefenseAttrId] = {},
		[var_0_0.MdefenseAttrId] = {},
		[var_0_0.TechnicAttrId] = {}
	}

	for iter_16_0 = 1, 8 do
		table.insert(var_16_1[var_0_0.AttackAttrId], var_16_0[iter_16_0].atk)
		table.insert(var_16_1[var_0_0.HpAttrId], var_16_0[iter_16_0].hp)
		table.insert(var_16_1[var_0_0.DefenseAttrId], var_16_0[iter_16_0].def)
		table.insert(var_16_1[var_0_0.MdefenseAttrId], var_16_0[iter_16_0].mdef)
		table.insert(var_16_1[var_0_0.TechnicAttrId], var_16_0[iter_16_0].technic)
	end

	return {
		[var_0_0.HpAttrId] = arg_16_0:_countRate(arg_16_1[var_0_0.HpAttrId], var_16_1[var_0_0.HpAttrId], 8),
		[var_0_0.AttackAttrId] = arg_16_0:_countRate(arg_16_1[var_0_0.AttackAttrId], var_16_1[var_0_0.AttackAttrId], 8),
		[var_0_0.DefenseAttrId] = arg_16_0:_countRate(arg_16_1[var_0_0.DefenseAttrId], var_16_1[var_0_0.DefenseAttrId], 8),
		[var_0_0.MdefenseAttrId] = arg_16_0:_countRate(arg_16_1[var_0_0.MdefenseAttrId], var_16_1[var_0_0.MdefenseAttrId], 8),
		[var_0_0.TechnicAttrId] = arg_16_0:_countRate(arg_16_1[var_0_0.TechnicAttrId], var_16_1[var_0_0.TechnicAttrId], 8)
	}
end

function var_0_0._countRate(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	for iter_17_0 = 1, arg_17_3 - 1 do
		if arg_17_1 < arg_17_2[iter_17_0 + 1] then
			return iter_17_0
		end
	end

	return arg_17_3
end

function var_0_0._refreshSkin(arg_18_0, arg_18_1)
	local var_18_0 = SkinConfig.instance:getSkinCo(arg_18_1)

	if not var_18_0 then
		logError("没有找到配置, skinId: " .. tostring(arg_18_1))

		return
	end

	local var_18_1 = SkinConfig.instance:getSkinOffset(var_18_0.haloOffset)
	local var_18_2 = tonumber(var_18_1[1])
	local var_18_3 = tonumber(var_18_1[2])
	local var_18_4 = tonumber(var_18_1[3])

	recthelper.setAnchor(arg_18_0._simageredlight.transform, var_18_2, var_18_3)
	transformhelper.setLocalScale(arg_18_0._simageredlight.transform, var_18_4, var_18_4, var_18_4)

	arg_18_0._skinConfig = var_18_0

	arg_18_0._simagecharacter:LoadImage(ResUrl.getHeadIconImg(var_18_0.drawing), arg_18_0._onImageLoaded, arg_18_0)

	if arg_18_0._skinColorStr then
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0._imagecharacter, arg_18_0._skinColorStr)
	end
end

function var_0_0._onImageLoaded(arg_19_0)
	ZProj.UGUIHelper.SetImageSize(arg_19_0._simagecharacter.gameObject)

	local var_19_0 = SkinConfig.instance:getSkinOffset(arg_19_0._skinConfig.summonHeroViewOffset)

	recthelper.setAnchor(arg_19_0._simagecharacter.transform.parent, var_19_0[1], var_19_0[2])
	transformhelper.setLocalScale(arg_19_0._simagecharacter.transform.parent, var_19_0[3], var_19_0[3], var_19_0[3])
end

function var_0_0._initViewParam(arg_20_0)
	arg_20_0._characterDetailId = arg_20_0.viewParam.id
	arg_20_0._heroId = arg_20_0.viewParam.heroId
	arg_20_0._skinId = arg_20_0.viewParam.skinId
	arg_20_0._skinColorStr = arg_20_0.viewParam.skinColorStr or "#FFFFFF"

	if arg_20_0._skinId == nil then
		if arg_20_0._heroId then
			local var_20_0 = HeroConfig.instance:getHeroCO(arg_20_0._heroId)

			arg_20_0._skinId = arg_20_0:_getSkinId() or var_20_0.skinId
		end

		if arg_20_0._characterDetailId then
			local var_20_1 = SummonConfig.instance:getCharacterDetailConfig(arg_20_0._characterDetailId)

			arg_20_0._heroId = var_20_1.heroId
			arg_20_0._skinId = arg_20_0:_getSkinId() or var_20_1.skinId
		end
	end
end

function var_0_0.onUpdateParam(arg_21_0)
	arg_21_0:_initViewParam()
	arg_21_0:_refreshUI()
end

function var_0_0.onOpen(arg_22_0)
	arg_22_0:_initViewParam()
	arg_22_0:_refreshUI()
end

function var_0_0.onClose(arg_23_0)
	return
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._simageredlight:UnLoadImage()
	arg_24_0._simagebg:UnLoadImage()
end

return var_0_0
