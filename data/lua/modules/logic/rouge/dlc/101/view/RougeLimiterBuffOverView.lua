module("modules.logic.rouge.dlc.101.view.RougeLimiterBuffOverView", package.seeall)

slot0 = class("RougeLimiterBuffOverView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollviews = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_views")
	slot0._gobuffitem = gohelper.findChild(slot0.viewGO, "#scroll_views/Viewport/Content/#go_buffitem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gobuffcontainer = gohelper.findChild(slot0.viewGO, "#scroll_views/Viewport/Content")
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:initBuffList()
end

function slot0.initBuffList(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.buffIds or {}

	table.sort(slot1, slot0._buffMoSortFunc)
	gohelper.CreateObjList(slot0, slot0._refreshBuffItem, slot1, slot0._gobuffcontainer, slot0._gobuffitem)
end

function slot0._buffMoSortFunc(slot0, slot1)
	slot3 = RougeDLCConfig101.instance:getLimiterBuffCo(slot1)

	if (RougeDLCConfig101.instance:getLimiterBuffCo(slot0) and slot2.buffType or 0) ~= (slot3 and slot3.buffType or 0) then
		return slot4 < slot5
	end

	return slot0 < slot1
end

function slot0._refreshBuffItem(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "#txt_dec").text = RougeDLCConfig101.instance:getLimiterBuffCo(slot2) and slot4.desc
	gohelper.findChildText(slot1, "#txt_name").text = slot4 and slot4.title

	UISpriteSetMgr.instance:setRouge4Sprite(gohelper.findChildImage(slot1, "#image_bufficon"), slot4.icon)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
