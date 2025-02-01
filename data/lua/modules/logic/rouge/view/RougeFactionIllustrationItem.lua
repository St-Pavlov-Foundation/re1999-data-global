module("modules.logic.rouge.view.RougeFactionIllustrationItem", package.seeall)

slot0 = class("RougeFactionIllustrationItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goLocked = gohelper.findChild(slot0.viewGO, "#go_Locked")
	slot0._goBg = gohelper.findChild(slot0.viewGO, "#go_Locked/#go_Bg")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_Locked/#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_Locked/#txt_name")
	slot0._txten = gohelper.findChildText(slot0.viewGO, "#go_Locked/#txt_name/#txt_en")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#go_Locked/#scroll_desc")
	slot0._txtscrollDesc = gohelper.findChildText(slot0.viewGO, "#go_Locked/#scroll_desc/viewport/content/#txt_scrollDesc")
	slot0._txtlocked = gohelper.findChildText(slot0.viewGO, "#go_Locked/bg/#txt_locked")
	slot0._goUnselect = gohelper.findChild(slot0.viewGO, "#go_Unselect")
	slot0._goBg2 = gohelper.findChild(slot0.viewGO, "#go_Unselect/#go_Bg2")
	slot0._gonew = gohelper.findChild(slot0.viewGO, "#go_Unselect/#go_new")
	slot0._imageicon2 = gohelper.findChildImage(slot0.viewGO, "#go_Unselect/#image_icon2")
	slot0._txtname2 = gohelper.findChildText(slot0.viewGO, "#go_Unselect/#txt_name2")
	slot0._txten2 = gohelper.findChildText(slot0.viewGO, "#go_Unselect/#txt_name2/#txt_en2")
	slot0._scrolldesc2 = gohelper.findChildScrollRect(slot0.viewGO, "#go_Unselect/#scroll_desc2")
	slot0._txtscrollDesc2 = gohelper.findChildText(slot0.viewGO, "#go_Unselect/#scroll_desc2/viewport/content/#txt_scrollDesc2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._click = gohelper.getClickWithDefaultAudio(slot0._goBg2, slot0)
	slot0._clickLocked = gohelper.getClickWithDefaultAudio(slot0._goLocked, slot0)

	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateFavoriteReddot, slot0._updateNewFlag, slot0)
end

function slot0._editableAddEvents(slot0)
	slot0._click:AddClickListener(slot0._onClickHandler, slot0)
	slot0._clickLocked:AddClickListener(slot0._onClickLockedHandler, slot0)
end

function slot0._editableRemoveEvents(slot0)
	slot0._click:RemoveClickListener()
	slot0._clickLocked:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._isUnlocked = slot1.isUnLocked
	slot0._mo = slot1.styleCO

	gohelper.setActive(slot0._goUnselect, slot0._isUnlocked)
	gohelper.setActive(slot0._goLocked, not slot0._isUnlocked)

	if not slot0._isUnlocked then
		slot0._txtlocked.text = RougeOutsideModel.instance:config():getStyleLockDesc(slot0._mo.id)

		slot0:_updateInfo(slot0._txtname, slot0._txten, slot0._txtscrollDesc, slot0._imageicon)
	else
		slot0:_updateInfo(slot0._txtname2, slot0._txten2, slot0._txtscrollDesc2, slot0._imageicon2)
		slot0:_updateNewFlag()
	end
end

function slot0._updateNewFlag(slot0)
	slot0._showNewFlag = RougeFavoriteModel.instance:getReddot(RougeEnum.FavoriteType.Faction, slot0._mo.id) ~= nil

	gohelper.setActive(slot0._gonew, slot0._showNewFlag)
end

function slot0._updateInfo(slot0, slot1, slot2, slot3, slot4)
	slot1.text = slot0._mo.name
	slot3.text = slot0._mo.desc

	UISpriteSetMgr.instance:setRouge2Sprite(slot4, string.format("%s_light", slot0._mo.icon))
	gohelper.setActive(slot2, false)
end

function slot0._onClickLockedHandler(slot0)
	GameFacade.showToast(ToastEnum.RougeFactionLockTip)
end

function slot0._onClickHandler(slot0)
	RougeController.instance:openRougeFactionIllustrationDetailView(slot0._mo)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
