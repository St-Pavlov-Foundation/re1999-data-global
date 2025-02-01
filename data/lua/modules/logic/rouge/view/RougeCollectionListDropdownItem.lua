module("modules.logic.rouge.view.RougeCollectionListDropdownItem", package.seeall)

slot0 = class("RougeCollectionListDropdownItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simageruanpan = gohelper.findChildSingleImage(slot0.viewGO, "simage_ruanpan")
	slot0._imageruanpan = gohelper.findChildImage(slot0.viewGO, "simage_ruanpan")
	slot0._color = slot0._imageruanpan.color
end

function slot0.addEvents(slot0)
	slot0._click = gohelper.getClickWithDefaultAudio(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._onClick(slot0)
	RougeController.instance:dispatchEvent(RougeEvent.OnClickCollectionDropItem, slot0._mo)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._simageruanpan:LoadImage(RougeCollectionHelper.getCollectionIconUrl(slot0._mo.id), slot0._onLoadImage, slot0)
	slot0:_onLoadImage()
end

function slot0._onLoadImage(slot0)
	slot0._color.a = RougeFavoriteModel.instance:collectionIsUnlock(slot0._mo.id) and 1 or 0.8
	slot0._imageruanpan.color = slot0._color
end

return slot0
