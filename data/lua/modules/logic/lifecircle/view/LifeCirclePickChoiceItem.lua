module("modules.logic.lifecircle.view.LifeCirclePickChoiceItem", package.seeall)

slot0 = class("LifeCirclePickChoiceItem", RougeSimpleItemBase)

function slot0.onInitView(slot0)
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "role/#image_rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "role/#simage_icon")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "role/#image_career")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "role/#txt_name")
	slot0._goexskill = gohelper.findChild(slot0.viewGO, "role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot0.viewGO, "role/#go_exskill/#image_exskill")
	slot0._goRank = gohelper.findChild(slot0.viewGO, "role/#go_Rank")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnLongPress:AddLongPressListener(slot0._onLongClickItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnLongPress:RemoveLongPressListener()
end

slot1 = SLFramework.UGUI.UILongPressListener
slot2 = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function slot0.ctor(slot0, ...)
	slot0:__onInit()
	uv0.super.ctor(slot0, ...)
end

function slot0.onDestroyView(slot0)
	uv0.super.onDestroyView(slot0)
	slot0:__onDispose()
end

function slot0._btnclickOnClick(slot0)
	if slot0:_isCustomSelect() then
		slot0:setSelected(not slot0:isSelected())
	else
		slot0:_showSummonHeroDetailView()
	end
end

function slot0._onLongClickItem(slot0)
	slot0:_showSummonHeroDetailView()
end

function slot0._showSummonHeroDetailView(slot0)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = slot0:heroId()
	})
	AudioMgr.instance:trigger(AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0._isCustomSelect(slot0)
	return slot0:parent():isCustomSelect()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._btnLongPress = uv1.Get(slot0._btnclick.gameObject)

	slot0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	slot0._goranks = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot0._goranks[slot4] = gohelper.findChild(slot0._goRank, "rank" .. slot4)
	end

	slot0:setSelected(false)
end

function slot0.setSelected(slot0, slot1)
	if slot0:isSelected() == slot1 then
		return
	end

	slot0._staticData.isSelected = slot1

	slot0:onSelect(slot1)
end

function slot0.onSelect(slot0, slot1)
	slot0:_setActive_goselect(slot1)
	slot0:parent():onItemSelected(slot0, slot1)
end

function slot0.setData(slot0, slot1)
	uv0.super.setData(slot0, slot1)
	slot0:_refreshHero()
	slot0:_refreshSkin()
	slot0:_refreshRank()
	slot0:_refreshExSkill()
end

function slot0._refreshHero(slot0)
	slot1 = slot0:_heroCO()

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot1.career)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[slot1.rare]))

	slot0._txtname.text = slot1.name
end

function slot0._refreshSkin(slot0)
	GameUtil.loadSImage(slot0._simageicon, ResUrl.getRoomHeadIcon(slot0:_skinCO().headIcon))
end

function slot0._refreshExSkill(slot0)
	if not slot0._mo:hasHero() or slot0._mo:getSkillLevel() <= 0 then
		gohelper.setActive(slot0._goexskill, false)

		return
	end

	gohelper.setActive(slot0._goexskill, true)

	slot0._imageexskill.fillAmount = uv0[slot0._mo:getSkillLevel()] or 1
end

function slot0._refreshRank(slot0)
	for slot7 = 1, 3 do
		slot8 = slot7 == slot0._mo.rank - 1

		gohelper.setActive(slot0._goranks[slot7], slot8)

		slot3 = false or slot8
	end

	gohelper.setActive(slot0._goRank, slot3)
end

function slot0._heroCO(slot0)
	return HeroConfig.instance:getHeroCO(slot0:heroId())
end

function slot0._skinCO(slot0)
	return SkinConfig.instance:getSkinCo(slot0:_heroCO().skinId)
end

function slot0._setActive_goselect(slot0, slot1)
	gohelper.setActive(slot0._goselect, slot1)
end

function slot0.heroId(slot0)
	return slot0._mo.id
end

return slot0
