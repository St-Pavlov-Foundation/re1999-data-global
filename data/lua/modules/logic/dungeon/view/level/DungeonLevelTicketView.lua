module("modules.logic.dungeon.view.level.DungeonLevelTicketView", package.seeall)

local var_0_0 = class("DungeonLevelTicketView", BaseChildView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goticketinfo = gohelper.findChild(arg_1_0.viewGO, "#go_ticketinfo")
	arg_1_0._simageticket = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_ticketinfo/#simage_ticket")
	arg_1_0._txtticket = gohelper.findChildText(arg_1_0.viewGO, "#go_ticketinfo/#txt_ticket")
	arg_1_0._gonoticket = gohelper.findChild(arg_1_0.viewGO, "#go_noticket")
	arg_1_0._txtnoticket1 = gohelper.findChildText(arg_1_0.viewGO, "#go_noticket/#txt_noticket1")
	arg_1_0._txtnoticket2 = gohelper.findChildText(arg_1_0.viewGO, "#go_noticket/#txt_noticket2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0:onUpdateParam()
end

function var_0_0.onUpdateParam(arg_5_0)
	local var_5_0 = arg_5_0.viewParam

	arg_5_0._goticketinfo:SetActive(var_5_0 ~= 0)
	arg_5_0._gonoticket:SetActive(var_5_0 == 0)

	if var_5_0 ~= 0 then
		local var_5_1 = ItemConfig.instance:getItemIconById(var_5_0)

		arg_5_0._simageticket:LoadImage(ResUrl.getPropItemIcon(var_5_1))

		arg_5_0._txtticket.text = ItemModel.instance:getItemCount(var_5_0)
	else
		arg_5_0._txtnoticket1.gameObject:SetActive(arg_5_0._click ~= nil)
		arg_5_0._txtnoticket2.gameObject:SetActive(not arg_5_0._click)
	end
end

function var_0_0._onClick(arg_6_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSelectTicket, arg_6_0.viewParam)
end

function var_0_0.addClick(arg_7_0)
	if arg_7_0._click then
		return
	end

	arg_7_0._canvasGroup = gohelper.onceAddComponent(arg_7_0.viewGO, typeof(UnityEngine.CanvasGroup))
	arg_7_0._canvasGroup.blocksRaycasts = true
	arg_7_0._click = SLFramework.UGUI.UIClickListener.Get(arg_7_0.viewGO)

	arg_7_0._click:AddClickListener(arg_7_0._onClick, arg_7_0)
end

function var_0_0.onOpen(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	if arg_9_0._click then
		arg_9_0._click:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageticket:UnLoadImage()
end

return var_0_0
