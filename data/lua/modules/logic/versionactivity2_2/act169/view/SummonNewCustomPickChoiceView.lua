module("modules.logic.versionactivity2_2.act169.view.SummonNewCustomPickChoiceView", package.seeall)

slot0 = class("SummonNewCustomPickChoiceView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._simagedecbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg/#simage_decbg")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._scrollrule = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_rule")
	slot0._goexskill = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/role/#go_exskill")
	slot0._imageexskill = gohelper.findChildImage(slot0.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/role/#go_exskill/#image_exskill")
	slot0._goclick = gohelper.findChild(slot0.viewGO, "#scroll_rule/Viewport/content/selfselectsixchoiceitem/select/#go_click")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0:addEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, slot0.handleCusomPickCompleted, slot0)
	slot0:addEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0:removeEventCb(SummonNewCustomPickViewController.instance, SummonNewCustomPickEvent.OnGetReward, slot0.handleCusomPickCompleted, slot0)
	slot0:removeEventCb(SummonNewCustomPickChoiceController.instance, SummonNewCustomPickEvent.OnCustomPickListChanged, slot0.refreshUI, slot0)
end

function slot0._btnconfirmOnClick(slot0)
	SummonNewCustomPickChoiceController.instance:trySendChoice()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnconfirm.gameObject, SummonNewCustomPickChoiceListModel.instance:getSelectCount() ~= SummonNewCustomPickChoiceListModel.instance:getMaxSelectCount())
end

function slot0.onClose(slot0)
	SummonNewCustomPickChoiceListModel.instance:clearSelectIds()
end

function slot0.handleCusomPickCompleted(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
end

return slot0
