module("modules.logic.gift.view.GiftInsightHeroChoiceListItem", package.seeall)

slot0 = class("GiftInsightHeroChoiceListItem")

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._gorole = gohelper.findChild(slot1, "role")
	slot0._imageRare = gohelper.findChildImage(slot1, "role/rare")
	slot0._simageIcon = gohelper.findChildSingleImage(slot1, "role/heroicon")
	slot0._imageCareer = gohelper.findChildImage(slot1, "role/career")
	slot0._txtname = gohelper.findChildText(slot1, "role/name")
	slot0._goexskill = gohelper.findChild(slot1, "role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot1, "role/#go_exskill/#image_exskill")
	slot5 = "role/Rank"
	slot0._gorank = gohelper.findChild(slot1, slot5)
	slot0._rankGos = {}

	for slot5 = 1, 3 do
		slot0._rankGos[slot5] = gohelper.findChild(slot0._gorank, "rank" .. slot5)
	end

	slot0._goselect = gohelper.findChild(slot1, "select")
	slot0._goclick = gohelper.findChild(slot1, "go_click")
	slot0._clickitem = gohelper.getClick(slot0._goclick)
	slot0._showUp = true

	slot0:_addEvents()
end

function slot0._addEvents(slot0)
	slot0._clickitem:AddClickListener(slot0._onClickItem, slot0)
	GiftController.instance:registerCallback(GiftEvent.InsightHeroChoose, slot0._refresh, slot0)
end

function slot0._removeEvents(slot0)
	slot0._clickitem:RemoveClickListener()
	GiftController.instance:unregisterCallback(GiftEvent.InsightHeroChoose, slot0._refresh, slot0)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._go, false)
end

function slot0.refreshItem(slot0, slot1)
	gohelper.setActive(slot0._go, true)

	slot0._heroMO = slot1

	slot0:_refresh()
end

function slot0._onClickItem(slot0)
	if not slot0._showUp then
		return
	end

	GiftInsightHeroChoiceModel.instance:setCurHeroId(slot0._heroMO.heroId)
	GiftController.instance:dispatchEvent(GiftEvent.InsightHeroChoose)
end

function slot0._refresh(slot0)
	gohelper.setActive(slot0._goselect, GiftInsightHeroChoiceModel.instance:getCurHeroId() == slot0._heroMO.heroId)

	slot2 = slot0._heroMO and slot0._heroMO.skin

	slot0._simageIcon:LoadImage(ResUrl.getRoomHeadIcon((slot2 and lua_skin.configDict[slot2]).headIcon))

	slot0._txtname.text = slot0._heroMO.config.name

	UISpriteSetMgr.instance:setCommonSprite(slot0._imageCareer, "lssx_" .. tostring(slot0._heroMO.config.career))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imageRare, "equipbar" .. slot0._heroMO.config.rare + 1)
	gohelper.setActive(slot0._gorank, slot0._heroMO.rank > 1)

	for slot8 = 1, 3 do
		gohelper.setActive(slot0._rankGos[slot8], slot8 == slot0._heroMO.rank - 1)
	end

	slot0._imageexskill.fillAmount = 0.2 * slot0._heroMO.exSkillLevel
end

function slot0.showUp(slot0, slot1)
	slot0._showUp = slot1

	gohelper.setActive(slot0._goneed, slot1)
end

function slot0.destroy(slot0)
	slot0._simageIcon:UnLoadImage()
	slot0:_removeEvents()
end

return slot0
