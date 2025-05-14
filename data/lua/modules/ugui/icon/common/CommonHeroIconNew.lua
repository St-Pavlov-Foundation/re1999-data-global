module("modules.ugui.icon.common.CommonHeroIconNew", package.seeall)

local var_0_0 = class("CommonHeroIconNew", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_1.transform
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.go, "#go_empty")
	arg_1_0._goHero = gohelper.findChild(arg_1_0.go, "#go_hero")
	arg_1_0._goBgFrame = gohelper.findChild(arg_1_0.go, "#go_hero/bgframe")
	arg_1_0._heroIcon = gohelper.findChildSingleImage(arg_1_0.go, "#go_hero/heroicon")
	arg_1_0._careerIcon = gohelper.findChildImage(arg_1_0.go, "#go_hero/career")
	arg_1_0._goLevel = gohelper.findChild(arg_1_0.go, "#go_hero/#go_level")
	arg_1_0._rankIcon = gohelper.findChildImage(arg_1_0.go, "#go_hero/#go_level/layout/#image_insight")
	arg_1_0._txtLvHead = gohelper.findChildText(arg_1_0.go, "#go_hero/#go_level/layout/#txt_lvHead")
	arg_1_0._txtLevel = gohelper.findChildText(arg_1_0.go, "#go_hero/#go_level/layout/#txt_level")
	arg_1_0._rareIcon = gohelper.findChildImage(arg_1_0.go, "#go_hero/rare")
	arg_1_0._clickCb = nil
	arg_1_0._clickCbObj = nil
	arg_1_0._btnClick = nil

	arg_1_0:isShowEmptyWhenNoneHero(true)
	arg_1_0:updateIsEmpty()
end

function var_0_0.addClickListener(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._clickCb = arg_2_1
	arg_2_0._clickCbObj = arg_2_2

	if not arg_2_0._btnClick then
		arg_2_0._btnClick = SLFramework.UGUI.UIClickListener.Get(arg_2_0.go)
	end

	arg_2_0._btnClick:AddClickListener(arg_2_0._onItemClick, arg_2_0)
end

function var_0_0._onItemClick(arg_3_0)
	if arg_3_0._clickCb then
		if arg_3_0._clickCbObj then
			arg_3_0._clickCb(arg_3_0._clickCbObj, arg_3_0._mo)
		else
			arg_3_0._clickCb(arg_3_0._mo)
		end
	end
end

function var_0_0.removeClickListener(arg_4_0)
	if arg_4_0._btnClick then
		arg_4_0._btnClick:RemoveClickListener()
	end

	arg_4_0._clickCb = nil
	arg_4_0._clickCbObj = nil
end

function var_0_0.getIsHasHero(arg_5_0)
	local var_5_0 = arg_5_0._mo and arg_5_0._mo.config
	local var_5_1 = var_5_0 and var_5_0.id

	return var_5_1 and var_5_1 ~= 0
end

function var_0_0.setScale(arg_6_0, arg_6_1)
	transformhelper.setLocalScale(arg_6_0.trans, arg_6_1, arg_6_1, arg_6_1)
end

function var_0_0.setAnchor(arg_7_0, arg_7_1, arg_7_2)
	recthelper.setAnchor(arg_7_0.trans, arg_7_1, arg_7_2)
end

function var_0_0.setIsBalance(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 and "#81abe5" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._rankIcon, var_8_0)
	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtLvHead, var_8_0)
	SLFramework.UGUI.GuiHelper.SetColor(arg_8_0._txtLevel, var_8_0)
end

function var_0_0.isShowEmptyWhenNoneHero(arg_9_0, arg_9_1)
	arg_9_0._isShowEmptyWhenNoneHero = arg_9_1

	if not arg_9_0:getIsHasHero() then
		gohelper.setActive(arg_9_0._goEmpty, arg_9_1)
	else
		gohelper.setActive(arg_9_0._goEmpty, false)
	end
end

function var_0_0.isShowBgFrame(arg_10_0, arg_10_1)
	gohelper.setActive(arg_10_0._goBgFrame, arg_10_1)
end

function var_0_0.isShowLevel(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_0._goLevel, arg_11_1)
end

function var_0_0.isShowRare(arg_12_0, arg_12_1)
	gohelper.setActive(arg_12_0._rareIcon.gameObject, arg_12_1)
end

function var_0_0.isShowCareer(arg_13_0, arg_13_1)
	gohelper.setActive(arg_13_0._careerIcon.gameObject, arg_13_1)
end

function var_0_0.onUpdateHeroId(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = HeroConfig.instance:getHeroCO(arg_14_1)

	if not var_14_0 then
		return
	end

	local var_14_1 = HeroMo.New()
	local var_14_2 = arg_14_2 or var_14_0.skinId

	var_14_1:init({
		heroId = arg_14_1,
		skin = var_14_2
	}, var_14_0)
	arg_14_0:onUpdateMO(var_14_1)
end

function var_0_0.onUpdateMO(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 and arg_15_1.config

	if not var_15_0 then
		arg_15_0:updateIsEmpty()

		return
	end

	arg_15_0._mo = arg_15_1

	local var_15_1 = tostring(var_15_0.career)

	UISpriteSetMgr.instance:setCommonSprite(arg_15_0._careerIcon, "lssx_" .. var_15_1)

	local var_15_2 = arg_15_0._mo.skin
	local var_15_3 = SkinConfig.instance:getSkinCo(var_15_2)

	if not var_15_3 then
		logError(string.format("CommonHeroIconNew:onUpdateMO error, skinConfig is nil, skinId: %s", var_15_2))

		return
	end

	local var_15_4 = ResUrl.getRoomHeadIcon(var_15_3.headIcon)

	arg_15_0._heroIcon:LoadImage(var_15_4)

	local var_15_5, var_15_6 = HeroConfig.instance:getShowLevel(arg_15_0._mo.level)

	if var_15_6 and var_15_6 > 1 then
		local var_15_7 = var_15_6 - 1

		UISpriteSetMgr.instance:setCommonSprite(arg_15_0._rankIcon, "dongxi_xiao_" .. var_15_7)
	else
		gohelper.setActive(arg_15_0._rankIcon.gameObject, false)
	end

	arg_15_0._txtLevel.text = var_15_5

	local var_15_8 = var_15_0.rare

	UISpriteSetMgr.instance:setCommonSprite(arg_15_0._rareIcon, "equipbar" .. CharacterEnum.Color[var_15_8])
	arg_15_0:updateIsEmpty()
end

function var_0_0.updateIsEmpty(arg_16_0)
	if arg_16_0:getIsHasHero() then
		gohelper.setActive(arg_16_0._goHero, true)
		gohelper.setActive(arg_16_0._goEmpty, false)
	else
		gohelper.setActive(arg_16_0._goHero, false)
		gohelper.setActive(arg_16_0._goEmpty, arg_16_0._isShowEmptyWhenNoneHero)
	end
end

function var_0_0.onDestroy(arg_17_0)
	arg_17_0._heroIcon:UnLoadImage()
	arg_17_0:isShowEmptyWhenNoneHero(true)
end

return var_0_0
