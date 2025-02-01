module("modules.logic.versionactivity1_5.aizila.view.game.AiZiLaGamePackView", package.seeall)

slot0 = class("AiZiLaGamePackView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnfullClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fullClose")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "#txt_Title")
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_Close")
	slot0._scrollItems = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_Items")
	slot0._goEmpty = gohelper.findChild(slot0.viewGO, "#go_Empty")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfullClose:AddClickListener(slot0._btnfullCloseOnClick, slot0)
	slot0._btnClose:AddClickListener(slot0._btnCloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfullClose:RemoveClickListener()
	slot0._btnClose:RemoveClickListener()
end

function slot0._btnfullCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.ExitGame, slot0.closeThis, slot0)

	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0.closeThis, slot0)
	end

	AiZiLaGamePackListModel.instance:init()
	gohelper.setActive(slot0._goEmpty, AiZiLaGamePackListModel.instance:getCount() < 1)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
