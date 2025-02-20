module("modules.logic.act189.view.ShortenAct_FullView", package.seeall)

slot0 = class("ShortenAct_FullView", ShortenActView_impl)

function slot0.onInitView(slot0)
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "root/right/limittimebg/#txt_time")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "root/right/#simage_title")
	slot0._scrolltasklist = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#scroll_tasklist")
	slot0._go28days = gohelper.findChild(slot0.viewGO, "root/#go_28days")
	slot0._go35days = gohelper.findChild(slot0.viewGO, "root/#go_35days")

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
	Activity189Controller.instance:sendGetAct189InfoRequest(slot0:actId())
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	uv0.super.onOpen(slot0)
end

return slot0
