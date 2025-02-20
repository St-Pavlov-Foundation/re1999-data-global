module("modules.logic.act189.view.ShortenAct_PanelView", package.seeall)

slot0 = class("ShortenAct_PanelView", ShortenActView_impl)

function slot0.onInitView(slot0)
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "root/right/limittimebg/#txt_time")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "root/right/#simage_title")
	slot0._scrolltasklist = gohelper.findChildScrollRect(slot0.viewGO, "root/right/#scroll_tasklist")
	slot0._go28days = gohelper.findChild(slot0.viewGO, "root/#go_28days")
	slot0._go35days = gohelper.findChild(slot0.viewGO, "root/#go_35days")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_Close")
	slot0._btnemptyTop = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyTop")
	slot0._btnemptyBottom = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyBottom")
	slot0._btnemptyLeft = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyLeft")
	slot0._btnemptyRight = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_emptyRight")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._btnemptyTop:AddClickListener(slot0._btnemptyTopOnClick, slot0)
	slot0._btnemptyBottom:AddClickListener(slot0._btnemptyBottomOnClick, slot0)
	slot0._btnemptyLeft:AddClickListener(slot0._btnemptyLeftOnClick, slot0)
	slot0._btnemptyRight:AddClickListener(slot0._btnemptyRightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnemptyTop:RemoveClickListener()
	slot0._btnemptyBottom:RemoveClickListener()
	slot0._btnemptyLeft:RemoveClickListener()
	slot0._btnemptyRight:RemoveClickListener()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyTopOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyBottomOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyLeftOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnemptyRightOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
end

return slot0
