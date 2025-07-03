module("modules.logic.versionactivity2_7.towergift.view.DestinyStoneGiftPickChoiceListHeroItem", package.seeall)

local var_0_0 = class("DestinyStoneGiftPickChoiceListHeroItem", LuaCompBase)
local var_0_1 = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0._go, "rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0._go, "heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0._go, "career")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0._go, "name")
	arg_1_0._goexskill = gohelper.findChild(arg_1_1, "#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_1, "#go_exskill/#image_exskill")
	arg_1_0._goRankBg = gohelper.findChild(arg_1_1, "Rank")
	arg_1_0._goranks = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		arg_1_0._goranks[iter_1_0] = gohelper.findChild(arg_1_1, "Rank/rank" .. iter_1_0)
	end

	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	arg_4_0:refreshUI()
end

function var_0_0.setLock(arg_5_0)
	arg_5_0._btnClick:RemoveClickListener()
end

function var_0_0.refreshUI(arg_6_0)
	local var_6_0 = HeroConfig.instance:getHeroCO(arg_6_0._mo.id)

	if not var_6_0 then
		logError("DestinyStoneGiftPickChoiceListHeroItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(arg_6_0._mo.id))

		return
	end

	arg_6_0:refreshBaseInfo(var_6_0)
	arg_6_0:refreshExSkill()
end

function var_0_0.refreshBaseInfo(arg_7_0, arg_7_1)
	local var_7_0 = SkinConfig.instance:getSkinCo(arg_7_1.skinId)

	if not var_7_0 then
		logError("DestinyStoneGiftPickChoiceListHeroItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(arg_7_1.skinId))

		return
	end

	arg_7_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(var_7_0.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagecareer, "lssx_" .. arg_7_1.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_7_0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[arg_7_1.rare]))

	arg_7_0._txtname.text = arg_7_1.name

	local var_7_1 = arg_7_0._mo.rank - 1
	local var_7_2 = false

	for iter_7_0 = 1, 3 do
		local var_7_3 = iter_7_0 == var_7_1

		gohelper.setActive(arg_7_0._goranks[iter_7_0], var_7_3)

		var_7_2 = var_7_2 or var_7_3
	end

	gohelper.setActive(arg_7_0._goRankBg, var_7_2)
end

function var_0_0.refreshExSkill(arg_8_0)
	if not arg_8_0._mo:hasHero() or arg_8_0._mo:getSkillLevel() <= 0 then
		gohelper.setActive(arg_8_0._goexskill, false)

		return
	end

	gohelper.setActive(arg_8_0._goexskill, true)

	arg_8_0._imageexskill.fillAmount = var_0_1[arg_8_0._mo:getSkillLevel()] or 1
end

function var_0_0.onDestroy(arg_9_0)
	if not arg_9_0._isDisposed then
		arg_9_0._simageicon:UnLoadImage()
		arg_9_0:removeEvents()

		arg_9_0._isDisposed = true
	end
end

return var_0_0
