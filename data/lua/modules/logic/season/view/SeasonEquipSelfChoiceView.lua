module("modules.logic.season.view.SeasonEquipSelfChoiceView", package.seeall)

slot0 = class("SeasonEquipSelfChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close1")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg1")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "root/bg/#simage_bg2")
	slot0._scrollitem = gohelper.findChildScrollRect(slot0.viewGO, "root/mask/#scroll_item")
	slot0._gocarditem = gohelper.findChild(slot0.viewGO, "root/mask/#scroll_item/viewport/itemcontent/#go_carditem")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_ok")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose1:AddClickListener(slot0._btnclose1OnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose1:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnclose1OnClick(slot0)
end

function slot0._btnokOnClick(slot0)
	Activity104EquipSelfChoiceController.instance:sendSelectCard(slot0.handleSendChoice, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	Activity104EquipSelfChoiceController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	if not Activity104EquipSelfChoiceController:checkOpenParam(slot0.viewParam.actId, slot0.viewParam.costItemUid) then
		slot0:delayClose()

		return
	end

	Activity104EquipSelfChoiceController.instance:onOpenView(slot1, slot2)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
end

function slot0.delayClose(slot0)
	TaskDispatcher.runDelay(slot0.closeThis, slot0, 0.001)
end

function slot0.handleSendChoice(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	slot0:closeThis()

	if slot0.viewParam.successCall then
		slot0.viewParam.successCall(slot0.viewParam.successCallObj)
	end
end

return slot0
