module("modules.logic.seasonver.act166.view.information.Season166InformationAnalyTipsItem", package.seeall)

slot0 = class("Season166InformationAnalyTipsItem", Season166InformationAnalyDetailItemBase)

function slot0.onInit(slot0)
	slot0.goCanReveal = gohelper.findChild(slot0.go, "#go_CanReveal")
	slot0.goNoReveal = gohelper.findChild(slot0.go, "#go_NoReveal")
	slot0.goLine = gohelper.findChild(slot0.go, "image_Line")
end

function slot0.onUpdate(slot0)
	slot3 = slot0.data.config.stage == slot0.data.info.stage + 1

	gohelper.setActive(slot0.goCanReveal, slot3)
	gohelper.setActive(slot0.goNoReveal, not slot3)
end

return slot0
