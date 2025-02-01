module("modules.logic.dungeon.view.level.DungeonLevelTicketView", package.seeall)

slot0 = class("DungeonLevelTicketView", BaseChildView)

function slot0.onInitView(slot0)
	slot0._goticketinfo = gohelper.findChild(slot0.viewGO, "#go_ticketinfo")
	slot0._simageticket = gohelper.findChildSingleImage(slot0.viewGO, "#go_ticketinfo/#simage_ticket")
	slot0._txtticket = gohelper.findChildText(slot0.viewGO, "#go_ticketinfo/#txt_ticket")
	slot0._gonoticket = gohelper.findChild(slot0.viewGO, "#go_noticket")
	slot0._txtnoticket1 = gohelper.findChildText(slot0.viewGO, "#go_noticket/#txt_noticket1")
	slot0._txtnoticket2 = gohelper.findChildText(slot0.viewGO, "#go_noticket/#txt_noticket2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:onUpdateParam()
end

function slot0.onUpdateParam(slot0)
	slot0._goticketinfo:SetActive(slot0.viewParam ~= 0)
	slot0._gonoticket:SetActive(slot1 == 0)

	if slot1 ~= 0 then
		slot0._simageticket:LoadImage(ResUrl.getPropItemIcon(ItemConfig.instance:getItemIconById(slot1)))

		slot0._txtticket.text = ItemModel.instance:getItemCount(slot1)
	else
		slot0._txtnoticket1.gameObject:SetActive(slot0._click ~= nil)
		slot0._txtnoticket2.gameObject:SetActive(not slot0._click)
	end
end

function slot0._onClick(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSelectTicket, slot0.viewParam)
end

function slot0.addClick(slot0)
	if slot0._click then
		return
	end

	slot0._canvasGroup = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.CanvasGroup))
	slot0._canvasGroup.blocksRaycasts = true
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0.viewGO)

	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	if slot0._click then
		slot0._click:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simageticket:UnLoadImage()
end

return slot0
