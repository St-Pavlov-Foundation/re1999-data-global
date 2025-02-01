module("modules.logic.gm.view.GMSubViewOldView", package.seeall)

slot0 = Color.New(0.88, 0.84, 0.5, 1)
slot1 = Color.New(0.75, 0.75, 0.75, 0.75)
slot2 = class("GMSubViewOldView", GMSubViewBase)

function slot2.onOpen(slot0)
	slot0:addSubViewGo("ALL")
end

function slot2._onToggleValueChanged(slot0, slot1, slot2)
	if slot2 then
		if not slot0._subViewContent then
			slot0:initViewContent()
		end

		slot0.viewContainer:selectToggle(slot0._toggleWrap)
	end

	gohelper.setActive(slot0._mainViewBg, slot2)
	gohelper.setActive(slot0._mainViewPort, slot2)

	slot0._toggleImage.color = slot2 and uv0 or uv1
end

return slot2
