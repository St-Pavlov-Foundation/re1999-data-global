module("modules.logic.rouge.map.view.map.RougeMapInputView", package.seeall)

slot0 = class("RougeMapInputView", BaseView)

function slot0.onInitView(slot0)
	slot0.goFullScreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.click = gohelper.getClickWithDefaultAudio(slot0.goFullScreen)

	slot0.click:AddClickListener(slot0.onClickMap, slot0)

	slot0.trFullScreen = slot0.goFullScreen:GetComponent(gohelper.Type_RectTransform)
	slot0.mapComp = RougeMapController.instance:getMapComp()

	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onLoadMapDone, slot0.onLoadMapDone, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onBeforeChangeMapInfo, slot0.onBeforeChangeMapInfo, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0.onCloseView, slot0)
end

function slot0.onBeforeChangeMapInfo(slot0)
	slot0.mapComp = nil
end

function slot0.onLoadMapDone(slot0)
	slot0.mapComp = RougeMapController.instance:getMapComp()
end

function slot0.onClickMap(slot0, slot1, slot2)
	if not slot0.mapComp then
		return
	end

	slot3, slot4 = recthelper.screenPosToAnchorPos2(slot2, slot0.trFullScreen)

	for slot8, slot9 in ipairs(slot0.mapComp:getMapItemList()) do
		if slot9:checkInClickArea(slot3, slot4, slot0.trFullScreen) then
			slot9:onClick()

			return
		end
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
end

function slot0.onCloseView(slot0, slot1)
	if slot1 == ViewName.RougeMapChoiceView then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onSelectNode, nil)
	end
end

function slot0.onClose(slot0)
	slot0.click:RemoveClickListener()

	slot0.click = nil
end

return slot0
