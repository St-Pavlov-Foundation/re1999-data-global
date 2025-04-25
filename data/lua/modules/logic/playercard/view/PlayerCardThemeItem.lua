module("modules.logic.playercard.view.PlayerCardThemeItem", package.seeall)

slot0 = class("PlayerCardThemeItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.simageBg = gohelper.findChildSingleImage(slot0.viewGO, "themeBg")
	slot0.txtName = gohelper.findChildTextMesh(slot0.viewGO, "#txt_name")
	slot0.txtEn = gohelper.findChildTextMesh(slot0.viewGO, "#txt_en")
	slot0.goLocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0.goSelect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0.goUsing = gohelper.findChild(slot0.viewGO, "#go_using")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "click")
end

function slot0.addEvents(slot0)
	slot0.btnClick:AddClickListener(slot0._onClick, slot0)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.SwitchTheme, slot0.refreshUI, slot0)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.ChangeSkin, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.SwitchTheme, slot0.refreshUI, slot0)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.ChangeSkin, slot0.refreshUI, slot0)
	slot0.btnClick:RemoveClickListener()
end

function slot0._onClick(slot0)
	PlayerCardModel.instance:setSelectSkinMO(slot0._mo)
	PlayerCardController.instance:dispatchEvent(PlayerCardEvent.SwitchTheme, slot0._mo.id)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0.goSelect, slot0._skinId == PlayerCardModel.instance:getSelectSkinMO().id)
	gohelper.setActive(slot0.goUsing, slot0._mo:checkIsUse())
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._skinId = slot0._mo:isEmpty() and 0 or slot0._mo.id
	slot0._config = slot0._mo:getConfig()

	if slot0._mo:isEmpty() then
		slot0:refreshEmpty()
	else
		slot0:refreshItem()
	end

	gohelper.setActive(slot0.goSelect, slot0._skinId == PlayerCardModel.instance:getSelectSkinMO().id)
	gohelper.setActive(slot0.goUsing, slot0._mo:checkIsUse())
end

function slot0.refreshEmpty(slot0)
	slot0.txtName.text = luaLang("talent_style_special_tag_998")

	slot0.simageBg:LoadImage(ResUrl.getPlayerCardIcon("banner/" .. slot0._skinId))
	gohelper.setActive(slot0.goLocked, false)
end

function slot0.refreshItem(slot0)
	slot0.txtName.text = slot0._config.name
	slot0.txtEn.text = slot0._config.nameEn

	slot0.simageBg:LoadImage(ResUrl.getPlayerCardIcon("banner/" .. slot0._skinId))
	gohelper.setActive(slot0.goLocked, not slot0._mo:isUnLock())
end

function slot0.onDestroy(slot0)
	slot0.simageBg:UnLoadImage()
end

return slot0
