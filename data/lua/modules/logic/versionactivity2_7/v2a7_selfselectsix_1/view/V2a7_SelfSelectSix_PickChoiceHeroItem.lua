module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.view.V2a7_SelfSelectSix_PickChoiceHeroItem", package.seeall)

local var_0_0 = class("V2a7_SelfSelectSix_PickChoiceHeroItem", LuaCompBase)
local var_0_1 = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goclick = gohelper.findChild(arg_1_0._go, "go_click")
	arg_1_0._btnClick = gohelper.getClickWithAudio(arg_1_0._goclick, AudioEnum.UI.UI_vertical_first_tabs_click)
	arg_1_0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._goclick)

	arg_1_0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	arg_1_0._goSelected = gohelper.findChild(arg_1_0._go, "select")
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0._go, "role/rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0._go, "role/heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0._go, "role/career")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0._go, "role/name")
	arg_1_0._goexskill = gohelper.findChild(arg_1_1, "role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_1, "role/#go_exskill/#image_exskill")
	arg_1_0._goRankBg = gohelper.findChild(arg_1_1, "role/Rank")
	arg_1_0._goranks = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, 3 do
		arg_1_0._goranks[iter_1_0] = gohelper.findChild(arg_1_1, "role/Rank/rank" .. iter_1_0)
	end

	arg_1_0:addEvents()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
	arg_2_0._btnLongPress:AddLongPressListener(arg_2_0._onLongClickItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	arg_3_0._btnLongPress:RemoveLongPressListener()
end

function var_0_0.onClickSelf(arg_4_0)
	logNormal("V2a7_SelfSelectSix_PickChoiceHeroItem onClickChoice id = " .. tostring(arg_4_0._mo.id))
	V2a7_SelfSelectSix_PickChoiceController.instance:setSelect(arg_4_0._mo.id)
end

function var_0_0._onLongClickItem(arg_5_0)
	if not arg_5_0._mo then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = arg_5_0._mo.id
	})
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
	arg_6_0:refreshSelect()
end

function var_0_0.setLock(arg_7_0)
	arg_7_0._btnClick:RemoveClickListener()
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = HeroConfig.instance:getHeroCO(arg_8_0._mo.id)

	if not var_8_0 then
		logError("V2a7_SelfSelectSix_PickChoiceHeroItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(arg_8_0._mo.id))

		return
	end

	arg_8_0:refreshBaseInfo(var_8_0)
	arg_8_0:refreshExSkill()
end

function var_0_0.refreshBaseInfo(arg_9_0, arg_9_1)
	local var_9_0 = SkinConfig.instance:getSkinCo(arg_9_1.skinId)

	if not var_9_0 then
		logError("V2a7_SelfSelectSix_PickChoiceHeroItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(arg_9_1.skinId))

		return
	end

	arg_9_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(var_9_0.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_9_0._imagecareer, "lssx_" .. arg_9_1.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_9_0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[arg_9_1.rare]))

	arg_9_0._txtname.text = arg_9_1.name

	local var_9_1 = arg_9_0._mo.rank - 1
	local var_9_2 = false

	for iter_9_0 = 1, 3 do
		local var_9_3 = iter_9_0 == var_9_1

		gohelper.setActive(arg_9_0._goranks[iter_9_0], var_9_3)

		var_9_2 = var_9_2 or var_9_3
	end

	gohelper.setActive(arg_9_0._goRankBg, var_9_2)
end

function var_0_0.refreshExSkill(arg_10_0)
	if not arg_10_0._mo:hasHero() or arg_10_0._mo:getSkillLevel() <= 0 then
		gohelper.setActive(arg_10_0._goexskill, false)

		return
	end

	gohelper.setActive(arg_10_0._goexskill, true)

	arg_10_0._imageexskill.fillAmount = var_0_1[arg_10_0._mo:getSkillLevel()] or 1
end

function var_0_0.refreshSelect(arg_11_0)
	local var_11_0 = V2a7_SelfSelectSix_PickChoiceListModel.instance:isHeroIdSelected(arg_11_0._mo.id)

	gohelper.setActive(arg_11_0._goSelected, var_11_0)
end

function var_0_0.onDestroy(arg_12_0)
	if not arg_12_0._isDisposed then
		arg_12_0._simageicon:UnLoadImage()
		arg_12_0:removeEvents()

		arg_12_0._isDisposed = true
	end
end

return var_0_0
