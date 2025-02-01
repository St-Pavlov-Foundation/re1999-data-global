module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionUnlockedView", package.seeall)

slot0 = class("V1a6_CachotCollectionUnlockedView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagelevelbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_levelbg")
	slot0._simagetipsbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_tipsbg")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "#simage_title")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_info/#scroll_view")
	slot0._gounlockeditem = gohelper.findChild(slot0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem")
	slot0._simagecollection = gohelper.findChildSingleImage(slot0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#simage_collection")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#go_container")
	slot0._txtitem = gohelper.findChildText(slot0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#go_container/#txt_item")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_info/#scroll_view/Viewport/Content/#go_unlockeditem/#txt_name")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnquit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_quit")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#go_info")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnquit:AddClickListener(slot0._btnquitOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnquit:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnquitOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "#go_info/#scroll_view/Viewport/Content")
	slot0._contentGrid = gohelper.onceAddComponent(slot0._goScrollContent, typeof(UnityEngine.UI.GridLayoutGroup))
	slot0._contentGrid.enabled = false
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	V1a6_CachotCollectionUnlockController.instance:onOpenView()
	slot0:setInfoPos()
end

function slot0.setInfoPos(slot0)
	slot0._contentGrid.enabled = not (V1a6_CachotCollectionUnLockListModel.instance:getCount() > (slot0.viewContainer:getListScrollParam() and slot2.lineCount or 0))
end

function slot0.onClose(slot0)
	V1a6_CachotCollectionUnlockController.instance:onCloseView()
end

function slot0.onDestroyView(slot0)
end

return slot0
