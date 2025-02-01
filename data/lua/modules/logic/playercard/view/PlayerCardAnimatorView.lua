module("modules.logic.playercard.view.PlayerCardAnimatorView", package.seeall)

slot0 = class("PlayerCardAnimatorView", BaseView)

function slot0.onInitView(slot0)
	slot0.animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0.goBottom = gohelper.findChild(slot0.viewGO, "Bottom")
	slot0.goBg = gohelper.findChild(slot0.goBottom, "bg")
end

function slot0.addEvents(slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.CloseLayout, slot0.onCloseLayout, slot0)
	slot0:addEventCb(PlayerCardController.instance, PlayerCardEvent.ShowTheme, slot0.onShowTheme, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0.onOpenView, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onShowTheme(slot0)
	slot0.animator:Play("switch1", 0, 0)

	slot0._inThemeView = true

	gohelper.setActive(slot0.goBottom, true)
end

function slot0.closeThemeView(slot0)
	slot0.animator:Play("switch2", 0, 0)

	slot0._inThemeView = false

	gohelper.setActive(slot0.goBottom, false)
end

function slot0.onOpenView(slot0, slot1)
	if slot1 == ViewName.PlayerCardLayoutView then
		slot0.animator:Play("layout1", 0, 0)
	end
end

function slot0.onCloseLayout(slot0)
	slot0.animator:Play("layout2", 0, 0)
end

function slot0.isInThemeView(slot0)
	return slot0._inThemeView
end

function slot0.onClose(slot0)
end

return slot0
