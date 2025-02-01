module("modules.logic.season.view1_6.Season1_6CelebrityCardGetlView", package.seeall)

slot0 = class("Season1_6CelebrityCardGetlView", BaseViewExtended)
slot0.OpenType = {
	Get = 1
}

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg2")
	slot0._simagebg3 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg3")
	slot0._simagebg4 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg4")
	slot0._simagebg5 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg5")
	slot0._goselfSelect = gohelper.findChild(slot0.viewGO, "#go_selfSelect")
	slot0._gocardget = gohelper.findChild(slot0.viewGO, "#go_cardget")
	slot0._scrollcardget = gohelper.findChildScrollRect(slot0.viewGO, "#go_cardget/mask/#scroll_cardget")
	slot0._gocardContent = gohelper.findChild(slot0.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "#go_cardget/mask/#scroll_cardget/Viewport/#go_cardContent/#go_carditem")
	slot0._btnclose = gohelper.getClick(slot0.viewGO)
	slot0._contentGrid = slot0._gocardContent:GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	slot0._contentSizeFitter = slot0._gocardContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter))

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_celebrity_get)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("full/bg_beijingzhezhao"))
	slot0._simagebg3:LoadImage(ResUrl.getSeasonIcon("bg_zs.png"))
	slot0._simagebg5:LoadImage(ResUrl.getSeasonIcon("bg_zs2.png"))
	slot0._simagebg4:LoadImage(ResUrl.getSeasonIcon("full/img_bg2.png"))
	gohelper.setActive(slot0._goselfSelect, false)
	gohelper.setActive(slot0._gocardget, true)
	slot0:_showGetCard()
	Activity104Rpc.instance:sendGetUnlockActivity104EquipIdsRequest(Activity104Model.instance:getCurSeasonId())
end

function slot0._showGetCard(slot0)
	slot0:com_loadAsset(Season1_6CelebrityCardItem.AssetPath, slot0._onCardItemLoaded)
end

function slot0._onCardItemLoaded(slot0, slot1)
	slot3 = gohelper.clone(slot1:GetResource(), gohelper.findChild(slot0._gocarditem, "go_itempos"), "root")

	transformhelper.setLocalScale(slot3.transform, 0.65, 0.65, 0.65)

	slot0._scroll_view = slot0:com_registSimpleScrollView(slot0._scrollcardget.gameObject, ScrollEnum.ScrollDirV, 4)

	slot0._scroll_view:setClass(Season1_6CelebrityCardGetScrollItem)
	slot0._scroll_view:setObjItem(slot3)

	if #slot0.viewParam.data > 4 then
		recthelper.setAnchor(slot0._scrollcardget.transform, 0, -473)

		slot0._contentGrid.enabled = false
		slot0._contentSizeFitter.enabled = false
	else
		recthelper.setAnchor(slot0._scrollcardget.transform, 0, -618)

		slot0._contentGrid.enabled = true
		slot0._contentSizeFitter.enabled = true
	end

	slot0._scroll_view:setData(slot4)
end

function slot0.isItemID(slot0)
	return slot0.viewParam.is_item_id
end

function slot0.onClose(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg3:UnLoadImage()
	slot0._simagebg4:UnLoadImage()
	slot0._simagebg5:UnLoadImage()
end

return slot0
