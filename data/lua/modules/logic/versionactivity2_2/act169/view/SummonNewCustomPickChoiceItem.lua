module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceItem", package.seeall)

slot0 = class("SummonNewCustomPickChoiceItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._goclick = gohelper.findChild(slot0._go, "go_click")
	slot0._btnClick = gohelper.findChildClickWithAudio(slot0._go, "go_click", AudioEnum.UI.UI_vertical_first_tabs_click)
	slot0._goSelected = gohelper.findChild(slot0._go, "select")
	slot0._btnLongPress = SLFramework.UGUI.UILongPressListener.Get(slot0._goclick)

	slot0._btnLongPress:SetLongPressTime({
		0.5,
		99999
	})

	slot0._imagerare = gohelper.findChildImage(slot0._go, "role/rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0._go, "role/heroicon")
	slot0._imagecareer = gohelper.findChildImage(slot0._go, "role/career")
	slot0._txtname = gohelper.findChildText(slot0._go, "role/name")
	slot0._goexskill = gohelper.findChild(slot1, "role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot1, "role/#go_exskill/#image_exskill")
	slot0._goRank = gohelper.findChild(slot1, "role/Rank")

	gohelper.setActive(slot0._goRank, false)
	slot0:addEvents()
end

function slot0.setClickCallBack(slot0, slot1)
	slot0._callBack = slot1
end

slot0.exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function slot0.addEvents(slot0)
	slot0._btnClick:AddClickListener(slot0.onClickSelf, slot0)
	slot0._btnLongPress:AddLongPressListener(slot0._onLongClickItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClick:RemoveClickListener()
	slot0._btnLongPress:RemoveLongPressListener()

	slot0._callBack = nil
end

function slot0._onLongClickItem(slot0)
	if not slot0._mo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_action_explore)
	ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
		heroId = slot0._mo.id
	})
end

function slot0.onClickSelf(slot0)
	logNormal("onClickChoice id = " .. tostring(slot0._mo.id))

	if slot0._callBack then
		slot0._callBack(slot0._mo.id)
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
	slot0:refreshSelect()
end

function slot0.refreshUI(slot0)
	if not HeroConfig.instance:getHeroCO(slot0._mo.id) then
		logError("SummonNewCustomPickChoiceItem.onUpdateMO error, heroConfig is nil, id:" .. tostring(slot0._mo.id))

		return
	end

	slot0:refreshBaseInfo(slot1)
	slot0:refreshExSkill()
end

function slot0.refreshBaseInfo(slot0, slot1)
	if not SkinConfig.instance:getSkinCo(slot1.skinId) then
		logError("SummonNewCustomPickChoiceItem.onUpdateMO error, skinCfg is nil, id:" .. tostring(slot1.skinId))

		return
	end

	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot2.headIcon))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot1.career)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. tostring(CharacterEnum.Color[slot1.rare]))

	slot0._txtname.text = slot1.name
end

function slot0.refreshExSkill(slot0)
	if not slot0._mo:hasHero() or slot0._mo:getSkillLevel() <= 0 then
		gohelper.setActive(slot0._goexskill, false)

		return
	end

	gohelper.setActive(slot0._goexskill, true)

	slot0._imageexskill.fillAmount = slot0.exSkillFillAmount[slot0._mo:getSkillLevel()] or 1
end

function slot0.refreshSelect(slot0)
	gohelper.setActive(slot0._goSelected, SummonNewCustomPickChoiceListModel.instance:isHeroIdSelected(slot0._mo.id))
end

function slot0.onDestroy(slot0)
	if not slot0._isDisposed then
		slot0._simageicon:UnLoadImage()
		slot0:removeEvents()

		slot0._callBack = nil
		slot0._isDisposed = true
	end
end

return slot0
