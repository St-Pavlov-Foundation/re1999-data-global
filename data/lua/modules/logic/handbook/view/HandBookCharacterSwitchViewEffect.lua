module("modules.logic.handbook.view.HandBookCharacterSwitchViewEffect", package.seeall)

slot0 = class("HandBookCharacterSwitchViewEffect", BaseView)

function slot0.onInitView(slot0)
	slot0._simagecoverbg1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_coverbg1")
	slot0._simagepeper55bg = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg")
	slot0._simagepeper55left = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg/#simge_peper55left")
	slot0._simagepeper55right = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/#simage_peper55bg/#simge_peper55right")
	slot0._gocorvercharacter4 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter4")
	slot0._gocorvercharacter5 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter5")
	slot0._gocorvercharacter6 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter6")
	slot0._gocorvercharacter7 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_corvercharacter7")
	slot0._gofrpos4 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos4")
	slot0._gofrpos5 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos5")
	slot0._gofrpos6 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos6")
	slot0._gofrpos7 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/right/#go_coverrightpage/#go_frpos7")
	slot0._gocharacter1 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character1")
	slot0._gocharacter2 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character2")
	slot0._gocharacter3 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_character3")
	slot0._gocharacter4 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character4")
	slot0._gocharacter5 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character5")
	slot0._gocharacter6 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character6")
	slot0._gocharacter7 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_character7")
	slot0._gosepos1 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos1")
	slot0._gosepos2 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos2")
	slot0._gosepos3 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/#go_sepos3")
	slot0._gosepos4 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos4")
	slot0._gosepos5 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos5")
	slot0._gosepos6 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos6")
	slot0._gosepos7 = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/#go_sepos7")
	slot0._goupleft = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_upleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simagepeperleft01 = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/peper_left01")
	slot0._simagepeperright01 = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/peper_right01")
	slot0._simagepeperleft = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/#go_leftpage/peper_left")
	slot0._simagepagebgright = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/#go_rightpage/peper_right")
	slot0._simagepagebgleft = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/#simage_pagebg/peper_left")
	slot0._simagepeperright = gohelper.findChildSingleImage(slot0.viewGO, "#go_center/handbookcharacterview/#simage_pagebg/peper_right")
	slot0._gocoverleft = gohelper.findChild(slot0.viewGO, "#go_center/handbookcharacterview/#go_cover/left")
	slot0._prefabPosList = {}
	slot0._allTypePosList = {}
	slot0._goTrsList = slot0:getUserDataTb_()
	slot2 = {
		slot0._gosepos1,
		slot0._gosepos2,
		slot0._gosepos3,
		slot0._gosepos4,
		slot0._gosepos5,
		slot0._gosepos6,
		slot0._gosepos7,
		slot0._gofrpos4,
		slot0._gofrpos5,
		slot0._gofrpos6,
		slot0._gofrpos7
	}

	for slot6, slot7 in ipairs({
		slot0._gocharacter1,
		slot0._gocharacter2,
		slot0._gocharacter3,
		slot0._gocharacter4,
		slot0._gocharacter5,
		slot0._gocharacter6,
		slot0._gocharacter7,
		slot0._gocorvercharacter4,
		slot0._gocorvercharacter5,
		slot0._gocorvercharacter6,
		slot0._gocorvercharacter7
	}) do
		slot8 = slot7.transform
		slot9, slot10, slot11 = transformhelper.getLocalPos(slot8)

		table.insert(slot0._prefabPosList, {
			x = slot9,
			y = slot10,
			z = slot11
		})
		table.insert(slot0._goTrsList, slot8)
	end

	for slot6, slot7 in ipairs(slot2) do
		slot8, slot9, slot10 = transformhelper.getLocalPos(slot7.transform)

		table.insert(slot0._allTypePosList, {
			x = slot8,
			y = slot9,
			z = slot10
		})
		gohelper.setActive(slot7, false)
	end
end

function slot0.reallyOpenView(slot0, slot1)
	slot0.heroType = slot1

	slot0:_refresh()
end

function slot0._refresh(slot0)
	if slot0._isLastAllHeroType == slot0:_isAllHeroType() then
		return
	end

	slot0._isLastAllHeroType = slot1

	for slot6, slot7 in ipairs(slot0._goTrsList) do
		slot8 = (slot1 and slot0._allTypePosList or slot0._prefabPosList)[slot6]

		transformhelper.setLocalPos(slot7, slot8.x, slot8.y, slot8.z)
	end

	slot3 = slot0:_getBGParam()
	slot4 = ResUrl.getHandbookCharacterIcon(slot3.left)
	slot5 = ResUrl.getHandbookCharacterIcon(slot3.right)

	slot0._simagepeper55left:LoadImage(slot4)
	slot0._simagepeperleft01:LoadImage(slot4)
	slot0._simagepeperleft:LoadImage(slot4)
	slot0._simagepagebgleft:LoadImage(slot4)
	slot0._simagepeper55right:LoadImage(slot5)
	slot0._simagepeperright01:LoadImage(slot5)
	slot0._simagepeperright:LoadImage(slot5)
	slot0._simagepagebgright:LoadImage(slot5)
	gohelper.setActive(slot0._simagecoverbg1, not slot1)
	gohelper.setActive(slot0._gocoverleft, not slot1)
	gohelper.setActive(slot0._simagepeper55bg, slot1)
	gohelper.setActive(slot0._goupleft, slot1)
end

function slot0._isAllHeroType(slot0)
	return slot0.heroType == HandbookEnum.HeroType.AllHero
end

function slot0._getBGParam(slot0)
	return HandbookEnum.BookBGRes[slot0.heroType] or HandbookEnum.BookBGRes[HandbookEnum.HeroType.Common]
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, slot0.reallyOpenView, slot0)
	slot0:_refresh()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, slot0.reallyOpenView, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagepeper55left:UnLoadImage()
	slot0._simagepeperleft01:UnLoadImage()
	slot0._simagepeperleft:UnLoadImage()
	slot0._simagepagebgleft:UnLoadImage()
	slot0._simagepeper55right:UnLoadImage()
	slot0._simagepeperright01:UnLoadImage()
	slot0._simagepeperright:UnLoadImage()
	slot0._simagepagebgright:UnLoadImage()
end

return slot0
