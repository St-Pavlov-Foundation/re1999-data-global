module("modules.logic.playercard.view.PlayerCardThemeView", package.seeall)

slot0 = class("PlayerCardThemeView", BaseView)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.onInitView(slot0)
	slot0.goBottom = gohelper.findChild(slot0.viewGO, "bottom")
	slot0.btnConfirm = gohelper.findChildButtonWithAudio(slot0.goBottom, "#btn_confirm")
	slot0.goLocked = gohelper.findChild(slot0.goBottom, "#go_locked")
	slot0.goUsing = gohelper.findChild(slot0.goBottom, "#go_using")
	slot0.goSource = gohelper.findChild(slot0.goBottom, "source")
	slot0.txtSourceTitle = gohelper.findChildTextMesh(slot0.goSource, "layout/#txt_title")
	slot0.txtSourceDesc = gohelper.findChildTextMesh(slot0.goSource, "layout/#txt_dec")
	slot0.goSourceLock = gohelper.findChild(slot0.goSource, "locked")
end

function slot0.canOpen(slot0)
	slot0:addEvents()
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnConfirm, slot0.onClickConfirm, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ShowTheme, slot0.refreshView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.SwitchTheme, slot0.onSwitchView, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ChangeSkin, slot0.onSwitchView, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeClickCb(slot0.btnConfirm, slot0.onClickConfirm, slot0)
end

function slot0.onClickConfirm(slot0)
	PlayerCardRpc.instance:sendSetPlayerCardThemeRequest(PlayerCardModel.instance:getSelectSkinMO().id)
end

function slot0.onUpdateParam(slot0)
end

function slot0.refreshView(slot0, slot1)
	if not PlayerCardModel.instance:getCardInfo(slot1) then
		return
	end

	PlayerCardThemeListModel.instance:init()
	slot0:onSwitchView()
end

function slot0.onSwitchView(slot0)
	slot1 = PlayerCardModel.instance:getSelectSkinMO()
	slot2 = slot1:isUnLock()

	gohelper.setActive(slot0.goLocked, not slot2)
	gohelper.setActive(slot0.goSourceLock, not slot2)

	slot3 = slot1:checkIsUse()

	gohelper.setActive(slot0.goUsing, slot3)
	gohelper.setActive(slot0.btnConfirm, not slot3 and slot2)

	if slot1:isEmpty() then
		slot0.txtSourceTitle.text = luaLang("talent_style_special_tag_998")
		slot0.txtSourceDesc.text = luaLang("playercard_skin_default")
	else
		slot4 = slot1:getConfig()
		slot0.txtSourceTitle.text = slot4.name
		slot0.txtSourceDesc.text = slot4.desc
	end
end

function slot0.onDestroy(slot0)
end

return slot0
