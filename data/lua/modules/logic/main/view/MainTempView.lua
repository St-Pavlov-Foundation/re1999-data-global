module("modules.logic.main.view.MainTempView", package.seeall)

slot0 = class("MainTempView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnrouge = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rouge")
end

function slot0.addEvents(slot0)
	slot0._btnrouge:AddClickListener(slot0._btnRougeOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrouge:RemoveClickListener()
end

function slot0._btnRougeOnClick(slot0)
	RougeController.instance:enterRouge()
end

function slot0.onOpen(slot0)
end

function slot0._onCloseView(slot0)
end

return slot0
