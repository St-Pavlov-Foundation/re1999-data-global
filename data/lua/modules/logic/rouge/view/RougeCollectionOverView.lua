module("modules.logic.rouge.view.RougeCollectionOverView", package.seeall)

slot0 = class("RougeCollectionOverView", RougeBaseDLCViewComp)

function slot0.onInitView(slot0)
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.SwitchCollectionInfoType, slot0._onSwitchCollectionInfoType, slot0)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)
	RougeCollectionOverListModel.instance:onInitData()
	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_dungeon_1_6_store_open)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goempty, RougeCollectionOverListModel.instance:getCount() <= 0)
	gohelper.setActive(slot0._scrollview.gameObject, slot1 > 0)
end

function slot0._onSwitchCollectionInfoType(slot0)
	RougeCollectionOverListModel.instance:onModelUpdate()
end

function slot0.onClose(slot0)
	ViewMgr.instance:closeView(ViewName.CommonBuffTipView)
	ViewMgr.instance:closeView(ViewName.RougeCollectionTipView)
end

return slot0
