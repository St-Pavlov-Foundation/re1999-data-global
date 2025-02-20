module("modules.logic.room.view.interact.RoomInteractCharacterItem", package.seeall)

slot0 = class("RoomInteractCharacterItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goonbirthdayicon = gohelper.findChild(slot0.viewGO, "#go_onbirthdayicon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0._view and slot0._view.viewContainer and slot0._mo then
		slot0._view.viewContainer:dispatchEvent(RoomEvent.InteractBuildingSelectHero, slot0._mo.heroId)
	end
end

function slot0._editableInitView(slot0)
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "role/heroicon")
	slot0._gobeplaced = gohelper.findChild(slot0.viewGO, "placeicon")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "go_click")
	slot0._goselect = gohelper.findChild(slot0.viewGO, "select")
	slot0._gotrust = gohelper.findChild(slot0.viewGO, "trust")
	slot0._txttrust = gohelper.findChildText(slot0.viewGO, "trust/txt_trust")
	slot0._gorole = gohelper.findChild(slot0.viewGO, "role")
	slot0._imagecareer = gohelper.findChildImage(slot0.viewGO, "role/career")
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "role/rare")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "role/name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "role/name/nameEn")
	slot0._canvasGroup = slot0._gorole:GetComponent(typeof(UnityEngine.CanvasGroup))

	gohelper.addUIClickAudio(slot0._goclick, AudioEnum.UI.UI_Common_Click)

	slot0._uiclick = SLFramework.UGUI.UIClickListener.Get(slot0._goclick)

	slot0._uiclick:AddClickListener(slot0._btnclickOnClick, slot0)
	gohelper.setActive(slot0._gotrust, false)
	gohelper.setActive(slot0._gobeplaced, false)
	gohelper.setActive(gohelper.findChild(slot0._gobeplaced, "icon"), false)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0._uiclick:RemoveClickListener()
	slot0._simageicon:UnLoadImage()
end

function slot0._refreshUI(slot0)
	slot0._simageicon:LoadImage(ResUrl.getRoomHeadIcon(slot0._mo.skinConfig.headIcon))
	gohelper.setActive(slot0._gobeplaced, slot0._mo.use)
	gohelper.setActive(slot0._goonbirthdayicon, RoomCharacterModel.instance:isOnBirthday(slot0._mo.heroConfig.id))

	if slot0._mo.use then
		slot0._canvasGroup.alpha = 0.7
	else
		slot0._canvasGroup.alpha = 1
	end

	gohelper.addUIClickAudio(slot0._goclick, slot0._mo.use and AudioEnum.UI.UI_Common_Click or AudioEnum.UI.Play_UI_Copies)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareer, "lssx_" .. slot0._mo.heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagerare, "bgequip" .. CharacterEnum.Color[slot0._mo.heroConfig.rare])

	slot0._txtname.text = slot0._mo.heroConfig.name
	slot0._txtnameen.text = slot0._mo.heroConfig.nameEng
end

slot0.prefabUrl = "ui/viewres/room/roomcharacterplaceitem.prefab"

return slot0
