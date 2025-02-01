module("modules.logic.custompickchoice.view.CustomPickChoiceItem", package.seeall)

slot0 = class("CustomPickChoiceItem", LuaCompBase)
slot1 = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goclick = gohelper.findChild(slot0._go, "go_click")
	slot0._btnClick = gohelper.getClickWithAudio(slot0._goclick, AudioEnum.UI.UI_vertical_first_tabs_click)
	slot0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(slot0._goclick)

	slot0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	slot0._goSelected = gohelper.findChild(slot0._go, "select")
	slot0._imagerare = gohelper.findChildImage(slot0._go, "role/rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0._go, "role/heroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0._go, "role/career")
	slot0._txtname = gohelper.findChildText(slot0._go, "role/name")
	slot0._goexskill = gohelper.findChild(slot1, "role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot1, "role/#go_exskill/#image_exskill")
	slot0._goRankBg = gohelper.findChild(slot1, "role/Rank")
	slot0._goranks = slot0:getUserDataTb_()

	for slot5 = 1, 3 do
		slot0._goranks[slot5] = gohelper.findChild(slot1, "role/Rank/rank" .. slot5)
	end

	slot0:addEvents()
end

function slot0.addEvents(slot0)
	slot0._btnClick:AddClickListener(slot0.onClickSelf, slot0)
	slot0._btnLongPress:AddLongPressListener(slot0._onLongClickItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClick:RemoveClickListener()
	slot0._btnLongPress:RemoveLongPressListener()
end

function slot0.onClickSelf(slot0)
	logNormal("CustomPickChoiceItem onClickChoice id = " .. tostring(slot0._mo.id))
	CustomPickChoiceController.instance:setSelect(slot0._mo.id)
end

function slot0._onLongClickItem(slot0)
	if not slot0._mo then
		return
	end

	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = slot0._mo.id
	})
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
	slot0:refreshSelect()
end

function slot0.refreshUI(slot0)
	if not HeroConfig.instance:getHeroCO(slot0._mo.id) then
		logError("CustomPickChoiceItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(slot0._mo.id))

		return
	end

	slot0:refreshBaseInfo(slot1)
	slot0:refreshExSkill()
end

function slot0.refreshBaseInfo(slot0, slot1)
	if not SkinConfig.instance:getSkinCo(slot1.skinId) then
		logError("CustomPickChoiceItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(slot1.skinId))

		return
	end

	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot2.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot1.career)

	slot9 = slot1.rare

	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[slot9]))

	slot0._txtname.text = slot1.name

	for slot9 = 1, 3 do
		slot10 = slot9 == slot0._mo.rank - 1

		gohelper.setActive(slot0._goranks[slot9], slot10)

		slot5 = false or slot10
	end

	gohelper.setActive(slot0._goRankBg, slot5)
end

function slot0.refreshExSkill(slot0)
	if not slot0._mo:hasHero() or slot0._mo:getSkillLevel() <= 0 then
		gohelper.setActive(slot0._goexskill, false)

		return
	end

	gohelper.setActive(slot0._goexskill, true)

	slot0._imageexskill.fillAmount = uv0[slot0._mo:getSkillLevel()] or 1
end

function slot0.refreshSelect(slot0)
	gohelper.setActive(slot0._goSelected, CustomPickChoiceListModel.instance:isHeroIdSelected(slot0._mo.id))
end

function slot0.onDestroy(slot0)
	if not slot0._isDisposed then
		slot0._simageicon:UnLoadImage()
		slot0:removeEvents()

		slot0._isDisposed = true
	end
end

return slot0
