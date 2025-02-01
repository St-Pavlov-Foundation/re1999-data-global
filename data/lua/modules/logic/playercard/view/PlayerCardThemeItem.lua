module("modules.logic.playercard.view.PlayerCardThemeItem", package.seeall)

slot0 = class("PlayerCardThemeItem", ListScrollCellExtend)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.simageBg = gohelper.findChildSingleImage(slot0.viewGO, "themeBg")
	slot0.txtName = gohelper.findChildTextMesh(slot0.viewGO, "bg/#txt_name")
	slot0.goLocked = gohelper.findChild(slot0.viewGO, "#go_locked")
	slot0.goSelect = gohelper.findChild(slot0.viewGO, "#go_select")
	slot0.goUsing = gohelper.findChild(slot0.viewGO, "#go_using")
	slot0.btnClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "click")
end

function slot0.addEvents(slot0)
	slot0.btnClick:AddClickListener(slot0._onClick, slot0)
	PlayerCardController.instance:registerCallback(PlayerCardEvent.SwitchTheme, slot0._switchTheme, slot0)
end

function slot0.removeEvents(slot0)
	PlayerCardController.instance:unregisterCallback(PlayerCardEvent.SwitchTheme, slot0._switchTheme, slot0)
	slot0.btnClick:RemoveClickListener()
end

function slot0._switchTheme(slot0, slot1)
	gohelper.setActive(slot0.goSelect, slot1 == slot0._themeId)
end

function slot0._onClick(slot0)
	PlayerCardThemeListModel.instance:selectTheme(slot0._themeId)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._themeId = slot0._mo.id
	slot0._config = slot0._mo.config

	slot0:_switchTheme(PlayerCardThemeListModel.instance:getSelectTheme())
	gohelper.setActive(slot0.goUsing, PlayerCardThemeListModel.instance:getUsingTheme() == slot0._themeId)

	slot0.txtName.text = slot0._config.name

	slot0.simageBg:LoadImage(string.format("singlebg/player/personalcardtheme/%s.png", slot0._config.cardRes))
	gohelper.setActive(slot0.goLocked, not PlayerCardModel.instance:themeIsUnlock(slot0._themeId))
end

function slot0.onDestroy(slot0)
	slot0.simageBg:UnLoadImage()
end

return slot0
