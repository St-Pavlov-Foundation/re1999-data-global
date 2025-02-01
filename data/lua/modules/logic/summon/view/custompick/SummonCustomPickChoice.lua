module("modules.logic.summon.view.custompick.SummonCustomPickChoice", package.seeall)

slot0 = class("SummonCustomPickChoice", BaseView)

function slot0.onInitView(slot0)
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_cancel")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Tips2/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnok:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
end

function slot0._editableInitView(slot0)
end

function slot0.onDestroyView(slot0)
	SummonCustomPickChoiceController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	logNormal("SummonCustomPickChoice onOpen")
	slot0:addEventCb(SummonController.instance, SummonEvent.onCustomPicked, slot0.handleCusomPickCompleted, slot0)
	slot0:addEventCb(SummonCustomPickChoiceController.instance, SummonEvent.onCustomPickListChanged, slot0.refreshUI, slot0)
	SummonCustomPickChoiceController.instance:onOpenView(slot0.viewParam.poolId)
end

function slot0.onClose(slot0)
end

function slot0._btnokOnClick(slot0)
	SummonCustomPickChoiceController.instance:trySendChoice()
end

function slot0._btncancelOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnbgOnClick(slot0)
	slot0:closeThis()
end

function slot0.refreshUI(slot0)
	slot1 = SummonCustomPickChoiceListModel.instance:getSelectCount()
	slot2 = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()
	slot0._txtnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_custompick_selectnum"), {
		slot1,
		slot2
	})

	ZProj.UGUIHelper.SetGrayscale(slot0._btnok.gameObject, slot1 ~= slot2)
end

function slot0.handleCusomPickCompleted(slot0)
	slot0:closeThis()
end

return slot0
