module("modules.logic.season.view1_4.Season1_4MarketShowLevelItem", package.seeall)

slot0 = class("Season1_4MarketShowLevelItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2, slot3, slot4)
	slot0.go = slot1
	slot0.index = slot2
	slot0.targetIndex = slot3
	slot0.maxIndex = slot4
	slot0._goselected = gohelper.findChild(slot1, "#go_selected")
	slot0._txtselectindex = gohelper.findChildText(slot1, "#go_selected/#txt_selectindex")
	slot0._gounselect = gohelper.findChild(slot1, "#go_unselected")
	slot0._txtunselectindex = gohelper.findChildText(slot1, "#go_unselected/#txt_selectindex")

	gohelper.setActive(slot0.go, true)
	gohelper.setActive(slot0._goselected, false)
	gohelper.setActive(slot0._gounselect, false)
end

function slot0.show(slot0)
	gohelper.setActive(slot0._goselected, slot0.targetIndex == slot0.index)
	gohelper.setActive(slot0._gounselect, slot0.targetIndex ~= slot0.index)

	slot0._txtselectindex.text = string.format("%02d", slot0.index)
	slot0._txtunselectindex.text = string.format("%02d", slot0.index)
end

function slot0.destroy(slot0)
end

return slot0
