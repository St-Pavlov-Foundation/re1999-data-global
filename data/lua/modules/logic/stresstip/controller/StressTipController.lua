module("modules.logic.stresstip.controller.StressTipController", package.seeall)

slot0 = class("StressTipController", BaseController)

function slot0.openMonsterStressTip(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.StressTipView, {
		openEnum = StressTipView.OpenEnum.Monster,
		co = slot1,
		clickPosition = slot2 or UnityEngine.Input.mousePosition
	})
end

function slot0.openHeroStressTip(slot0, slot1, slot2)
	ViewMgr.instance:openView(ViewName.StressTipView, {
		openEnum = StressTipView.OpenEnum.Hero,
		co = slot1,
		clickPosition = slot2 or UnityEngine.Input.mousePosition
	})
end

slot0.instance = slot0.New()

return slot0
