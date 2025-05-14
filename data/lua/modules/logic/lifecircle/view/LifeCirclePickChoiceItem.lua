module("modules.logic.lifecircle.view.LifeCirclePickChoiceItem", package.seeall)

local var_0_0 = class("LifeCirclePickChoiceItem", RougeSimpleItemBase)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagerare = gohelper.findChildImage(arg_1_0.viewGO, "role/#image_rare")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "role/#simage_icon")
	arg_1_0._imagecareer = gohelper.findChildImage(arg_1_0.viewGO, "role/#image_career")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "role/#txt_name")
	arg_1_0._goexskill = gohelper.findChild(arg_1_0.viewGO, "role/#go_exskill")
	arg_1_0._imageexskill = gohelper.findChildImage(arg_1_0.viewGO, "role/#go_exskill/#image_exskill")
	arg_1_0._goRank = gohelper.findChild(arg_1_0.viewGO, "role/#go_Rank")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.viewGO, "#go_select")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_click")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnLongPress:AddLongPressListener(arg_2_0._onLongClickItem, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnLongPress:RemoveLongPressListener()
end

local var_0_1 = SLFramework.UGUI.UILongPressListener
local var_0_2 = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function var_0_0.ctor(arg_4_0, ...)
	arg_4_0:__onInit()
	var_0_0.super.ctor(arg_4_0, ...)
end

function var_0_0.onDestroyView(arg_5_0)
	var_0_0.super.onDestroyView(arg_5_0)
	arg_5_0:__onDispose()
end

function var_0_0._btnclickOnClick(arg_6_0)
	if arg_6_0:_isCustomSelect() then
		arg_6_0:setSelected(not arg_6_0:isSelected())
	else
		arg_6_0:_showSummonHeroDetailView()
	end
end

function var_0_0._onLongClickItem(arg_7_0)
	arg_7_0:_showSummonHeroDetailView()
end

function var_0_0._showSummonHeroDetailView(arg_8_0)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = arg_8_0:heroId()
	})
	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0._isCustomSelect(arg_9_0)
	return arg_9_0:parent():isCustomSelect()
end

function var_0_0._editableInitView(arg_10_0)
	var_0_0.super._editableInitView(arg_10_0)

	arg_10_0._btnLongPress = var_0_1.Get(arg_10_0._btnclick.gameObject)

	arg_10_0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	arg_10_0._goranks = arg_10_0:getUserDataTb_()

	for iter_10_0 = 1, 3 do
		arg_10_0._goranks[iter_10_0] = gohelper.findChild(arg_10_0._goRank, "rank" .. iter_10_0)
	end

	arg_10_0:setSelected(false)
end

function var_0_0.setSelected(arg_11_0, arg_11_1)
	if arg_11_0:isSelected() == arg_11_1 then
		return
	end

	arg_11_0._staticData.isSelected = arg_11_1

	arg_11_0:onSelect(arg_11_1)
end

function var_0_0.onSelect(arg_12_0, arg_12_1)
	arg_12_0:_setActive_goselect(arg_12_1)
	arg_12_0:parent():onItemSelected(arg_12_0, arg_12_1)
end

function var_0_0.setData(arg_13_0, arg_13_1)
	var_0_0.super.setData(arg_13_0, arg_13_1)
	arg_13_0:_refreshHero()
	arg_13_0:_refreshSkin()
	arg_13_0:_refreshRank()
	arg_13_0:_refreshExSkill()
end

function var_0_0._refreshHero(arg_14_0)
	local var_14_0 = arg_14_0:_heroCO()

	UISpriteSetMgr.instance:setCommonSprite(arg_14_0._imagecareer, "lssx_" .. var_14_0.career)
	UISpriteSetMgr.instance:setCommonSprite(arg_14_0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[var_14_0.rare]))

	arg_14_0._txtname.text = var_14_0.name
end

function var_0_0._refreshSkin(arg_15_0)
	local var_15_0 = arg_15_0:_skinCO()

	GameUtil.loadSImage(arg_15_0._simageicon, ResUrl.getRoomHeadIcon(var_15_0.headIcon))
end

function var_0_0._refreshExSkill(arg_16_0)
	if not arg_16_0._mo:hasHero() or arg_16_0._mo:getSkillLevel() <= 0 then
		gohelper.setActive(arg_16_0._goexskill, false)

		return
	end

	gohelper.setActive(arg_16_0._goexskill, true)

	arg_16_0._imageexskill.fillAmount = var_0_2[arg_16_0._mo:getSkillLevel()] or 1
end

function var_0_0._refreshRank(arg_17_0)
	local var_17_0 = arg_17_0._mo.rank - 1
	local var_17_1 = false

	for iter_17_0 = 1, 3 do
		local var_17_2 = iter_17_0 == var_17_0

		gohelper.setActive(arg_17_0._goranks[iter_17_0], var_17_2)

		var_17_1 = var_17_1 or var_17_2
	end

	gohelper.setActive(arg_17_0._goRank, var_17_1)
end

function var_0_0._heroCO(arg_18_0)
	return HeroConfig.instance:getHeroCO(arg_18_0:heroId())
end

function var_0_0._skinCO(arg_19_0)
	local var_19_0 = arg_19_0:_heroCO()

	return SkinConfig.instance:getSkinCo(var_19_0.skinId)
end

function var_0_0._setActive_goselect(arg_20_0, arg_20_1)
	gohelper.setActive(arg_20_0._goselect, arg_20_1)
end

function var_0_0.heroId(arg_21_0)
	return arg_21_0._mo.id
end

return var_0_0
