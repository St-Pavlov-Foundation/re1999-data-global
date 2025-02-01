module("modules.logic.playercard.view.PlayerCardThemeView", package.seeall)

slot0 = class("PlayerCardThemeView", BaseView)

function slot0.onInitView(slot0)
	slot0.goBottom = gohelper.findChild(slot0.viewGO, "Bottom")
	slot0.btnConfirm = gohelper.findChildButtonWithAudio(slot0.goBottom, "#btn_confirm")
	slot0.goLocked = gohelper.findChild(slot0.goBottom, "#go_locked")
	slot0.goUsing = gohelper.findChild(slot0.goBottom, "#go_using")
	slot0.goSource = gohelper.findChild(slot0.goBottom, "source")
	slot0.txtSourceTitle = gohelper.findChildTextMesh(slot0.goSource, "layout/#txt_title")
	slot0.txtSourceDesc = gohelper.findChildTextMesh(slot0.goSource, "layout/#txt_dec")
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnConfirm, slot0.onClickConfirm, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ShowTheme, slot0.refreshView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, slot0.onSwitchView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClickConfirm(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.refreshView(slot0, slot1)
	if not PlayerCardModel.instance:getCardInfo(slot1) then
		return
	end

	PlayerCardThemeListModel.instance:initTheme(slot2:getThemeId())
	slot0:onSwitchView()
	PlayerCardThemeListModel.instance:refreshList()
end

function slot0.onSwitchView(slot0)
	slot1 = PlayerCardThemeListModel.instance:getSelectTheme()
	slot3 = PlayerCardModel.instance:themeIsUnlock(slot1)
	slot4 = PlayerCardThemeListModel.instance:getUsingTheme() == slot1

	gohelper.setActive(slot0.goSource, not slot3)
	gohelper.setActive(slot0.goLocked, not slot3)
	gohelper.setActive(slot0.goUsing, slot4)
	gohelper.setActive(slot0.btnConfirm, not slot4 and slot3)
end

function slot0.onClose(slot0)
end

return slot0
