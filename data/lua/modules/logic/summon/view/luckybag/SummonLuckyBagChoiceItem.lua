module("modules.logic.summon.view.luckybag.SummonLuckyBagChoiceItem", package.seeall)

local var_0_0 = class("SummonLuckyBagChoiceItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1
	arg_1_0._goclick = gohelper.findChild(arg_1_0._go, "go_click")
	arg_1_0._btnClick = gohelper.findChildClickWithAudio(arg_1_0._go, "go_click", AudioEnum.UI.UI_vertical_first_tabs_click)
	arg_1_0._goSelected = gohelper.findChild(arg_1_0._go, "select")
	arg_1_0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(arg_1_0._goclick)

	arg_1_0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0._go, "role/rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0._go, "role/heroicon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0._go, "role/career")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0._go, "role/name")
	arg_1_0._goexskill = gohelper.findChild(arg_1_1, "role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_1, "role/#go_exskill/#image_exskill")
	arg_1_0._goRank = gohelper.findChild(arg_1_1, "role/Rank")

	gohelper.setActive(arg_1_0._goRank, false)
	arg_1_0:addEvents()
end

var_0_0.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClick:AddClickListener(arg_2_0.onClickSelf, arg_2_0)
	arg_2_0._btnLongPress:AddLongPressListener(arg_2_0._onLongClickItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClick:RemoveClickListener()
	arg_3_0._btnLongPress:RemoveLongPressListener()
end

function var_0_0._onLongClickItem(arg_4_0)
	if not arg_4_0._mo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		showHome = false,
		heroId = arg_4_0._mo.id
	})
end

function var_0_0.onClickSelf(arg_5_0)
	logNormal("onClickChoice id = " .. tostring(arg_5_0._mo.id))

	if SummonLuckyBagChoiceController.instance:isLuckyBagOpened() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagAlreadyReceive)

		return
	end

	SummonLuckyBagChoiceController.instance:setSelect(arg_5_0._mo.id)
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	arg_6_0:refreshUI()
	arg_6_0:refreshSelect()
end

function var_0_0.refreshUI(arg_7_0)
	local var_7_0 = HeroConfig.instance:getHeroCO(arg_7_0._mo.id)

	if not var_7_0 then
		logError("SummonLuckyBagChoiceItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(arg_7_0._mo.id))

		return
	end

	arg_7_0:refreshBaseInfo(var_7_0)
	arg_7_0:refreshExSkill()
end

function var_0_0.refreshBaseInfo(arg_8_0, arg_8_1)
	local var_8_0 = SkinConfig.instance:getSkinCo(arg_8_1.skinId)

	if not var_8_0 then
		logError("SummonLuckyBagChoiceItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(arg_8_1.skinId))

		return
	end

	arg_8_0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(var_8_0.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagecareer, "lssx_" .. arg_8_1.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_8_0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[arg_8_1.rare]))

	arg_8_0._txtname.text = arg_8_1.name
end

function var_0_0.refreshExSkill(arg_9_0)
	if not arg_9_0._mo:hasHero() or arg_9_0._mo:getSkillLevel() <= 0 then
		gohelper.setActive(arg_9_0._goexskill, false)

		return
	end

	gohelper.setActive(arg_9_0._goexskill, true)

	arg_9_0._imageexskill.fillAmount = var_0_0.exSkillFillAmount[arg_9_0._mo:getSkillLevel()] or 1
end

function var_0_0.refreshSelect(arg_10_0)
	local var_10_0 = arg_10_0._mo.id == SummonLuckyBagChoiceListModel.instance:getSelectId()

	gohelper.setActive(arg_10_0._goSelected, var_10_0)
end

function var_0_0.onDestroy(arg_11_0)
	if not arg_11_0._isDisposed then
		arg_11_0._simageicon:UnLoadImage()
		arg_11_0:removeEvents()

		arg_11_0._isDisposed = true
	end
end

return var_0_0
