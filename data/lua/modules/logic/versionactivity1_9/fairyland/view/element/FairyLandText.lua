module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandText", package.seeall)

slot0 = class("FairyLandText", FairyLandElementBase)

function slot0.onInitView(slot0)
	slot0.itemGO = gohelper.findChild(slot0._go, "item")
	slot0.wordComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.itemGO, FairyLandWordComp, {
		co = slot0._config.config,
		res1 = slot0._elements.wordRes1,
		res2 = slot0._elements.wordRes2
	})
end

function slot0.onRefresh(slot0)
end

function slot0.updatePos(slot0)
	slot5 = slot0:getPos()

	recthelper.setAnchor(slot0._transform, -100 + slot5 * 244, -120 - slot5 * 73)
end

function slot0.onDestroyElement(slot0)
end

return slot0
