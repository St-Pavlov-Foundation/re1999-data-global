module("modules.logic.activity.view.ActivityTipView", package.seeall)

slot0 = class("ActivityTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnbgclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_bgclick")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0._btnmask = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_tip/#btn_mask")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#go_tip/#txt_desc")
	slot0._scrollruledesc = gohelper.findChildScrollRect(slot0.viewGO, "#go_tip/#scroll_ruledesc")
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "#go_tip/#scroll_ruledesc/Viewport/Content/#txt_tip")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbgclick:AddClickListener(slot0._btnbgclickOnClick, slot0)
	slot0._btnmask:AddClickListener(slot0._btnmaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbgclick:RemoveClickListener()
	slot0._btnmask:RemoveClickListener()
end

function slot0._btnbgclickOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._viewName = nil
end

function slot0._btnmaskOnClick(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refresh()
end

function slot0.onClose(slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._refresh(slot0)
	gohelper.addChild(slot0.viewParam.rootGo, slot0.viewGO)
	transformhelper.setLocalPosXY(slot0._gotip.transform, recthelper.getWidth(slot0.viewParam.rootGo.transform), 0)

	slot0._txtdesc.text = slot0.viewParam.title
	slot0._txttip.text = slot0.viewParam.desc
end

function slot0.onDestroyView(slot0)
end

return slot0
