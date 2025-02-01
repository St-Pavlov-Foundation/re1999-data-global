module("modules.logic.rouge.map.view.tip.RougeMapTipView", package.seeall)

slot0 = class("RougeMapTipView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.goTip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0.txtTip = gohelper.findChildText(slot0.viewGO, "#go_tip/#txt_Tips")

	gohelper.setActive(slot0.goTip, false)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onShowTip, slot0.onShowTip, slot0)
	slot0:addEventCb(RougeMapController.instance, RougeMapEvent.onHideTip, slot0.onHideTip, slot0)

	slot0.animator = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	slot0.animator:Play("close", 0, 1)
end

function slot0.onShowTip(slot0, slot1)
	slot0.txtTip.text = slot1

	slot0.animator:Play("open", 0, 0)
end

function slot0.onHideTip(slot0)
	slot0.animator:Play("close", 0, 0)
end

return slot0
