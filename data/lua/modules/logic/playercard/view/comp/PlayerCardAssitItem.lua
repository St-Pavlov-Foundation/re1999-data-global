module("modules.logic.playercard.view.comp.PlayerCardAssitItem", package.seeall)

local var_0_0 = class("PlayerCardAssitItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.goEmpty = gohelper.findChild(arg_1_1, "empty")
	arg_1_0.goRole = gohelper.findChild(arg_1_1, "#go_roleitem")
	arg_1_0.simageHead = gohelper.findChildSingleImage(arg_1_1, "#go_roleitem/rolehead")
	arg_1_0.imageCareer = gohelper.findChildImage(arg_1_1, "#go_roleitem/career")
	arg_1_0.imageLevel = gohelper.findChildImage(arg_1_1, "#go_roleitem/layout/level")
	arg_1_0.txtLevel = gohelper.findChildTextMesh(arg_1_1, "#go_roleitem/layout/#txt_level")
	arg_1_0.imagQuality = gohelper.findChildImage(arg_1_1, "#go_roleitem/quality")
	arg_1_0.goExskill = gohelper.findChild(arg_1_1, "#go_exskill")
	arg_1_0.imageExskill = gohelper.findChildImage(arg_1_1, "#go_exskill/#image_exskill")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "#btn_clickarea")
	arg_1_0.goSelectedEff = gohelper.findChild(arg_1_1, "selected_eff")
end

function var_0_0.playSelelctEffect(arg_2_0)
	gohelper.setActive(arg_2_0.goSelectedEff, false)
	gohelper.setActive(arg_2_0.goSelectedEff, true)
	PlayerCardController.instance:playChangeEffectAudio()
end

function var_0_0.setData(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.info = arg_3_1
	arg_3_0.isPlayerSelf = arg_3_2
	arg_3_0.compType = arg_3_3

	arg_3_0:showcharacterinfo(arg_3_1)
end

local var_0_1 = {
	0.23,
	0.42,
	0.59,
	0.78,
	1
}

function var_0_0.showcharacterinfo(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1 and arg_4_1 ~= 0 and arg_4_1.heroId and arg_4_1.heroId ~= "0" and arg_4_1.heroId ~= 0

	gohelper.setActive(arg_4_0.goEmpty, arg_4_0.isPlayerSelf and not var_4_0)
	gohelper.setActive(arg_4_0.goRole, var_4_0)

	if var_4_0 then
		if arg_4_0.isPlayerSelf then
			arg_4_1 = HeroModel.instance:getByHeroId(arg_4_1.heroId)
		end

		local var_4_1 = HeroConfig.instance:getHeroCO(arg_4_1.heroId)
		local var_4_2 = SkinConfig.instance:getSkinCo(arg_4_1.skin)

		arg_4_0.simageHead:LoadImage(ResUrl.getHeadIconSmall(var_4_2.retangleIcon))

		local var_4_3, var_4_4 = HeroConfig.instance:getShowLevel(arg_4_1.level)

		UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageCareer, string.format("lssx_%s", var_4_1.career), true)

		if var_4_4 > 1 then
			UISpriteSetMgr.instance:setCommonSprite(arg_4_0.imageLevel, string.format("dongxi_xiao_%s", var_4_4 - 1), true)
			gohelper.setActive(arg_4_0.imageLevel, true)
		else
			gohelper.setActive(arg_4_0.imageLevel, false)
		end

		arg_4_0.txtLevel.text = var_4_3

		local var_4_5 = arg_4_1.exSkillLevel and var_0_1[arg_4_1.exSkillLevel] or 0

		arg_4_0.imageExskill.fillAmount = var_4_5

		gohelper.setActive(arg_4_0.goExskill, var_4_5 > 0)
		UISpriteSetMgr.instance:setRoomSprite(arg_4_0.imagQuality, "quality_" .. CharacterEnum.Color[var_4_1.rare])

		arg_4_0.heroId = var_4_1.id
	else
		gohelper.setActive(arg_4_0.goExskill, false)

		arg_4_0.heroId = nil
	end

	if arg_4_0.notIsFirst and arg_4_0.heroId ~= arg_4_0.tempHeroId then
		arg_4_0:playSelelctEffect()
	end

	arg_4_0.tempHeroId = arg_4_0.heroId
	arg_4_0.notIsFirst = true
end

function var_0_0.btnClickOnClick(arg_5_0)
	if arg_5_0.isPlayerSelf and arg_5_0.compType == PlayerCardEnum.CompType.Normal then
		ViewMgr.instance:openView(ViewName.ShowCharacterView, {
			notRepeatUpdateAssistReward = true
		})
	end
end

function var_0_0.addEventListeners(arg_6_0)
	arg_6_0.btnClick:AddClickListener(arg_6_0.btnClickOnClick, arg_6_0)
end

function var_0_0.removeEventListeners(arg_7_0)
	arg_7_0.btnClick:RemoveClickListener()
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0.simageHead:UnLoadImage()
end

return var_0_0
