module("modules.logic.room.view.RoomInitBuildingDegreeItem", package.seeall)

slot0 = class("RoomInitBuildingDegreeItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._go = slot0.viewGO
	slot0._goline = gohelper.findChild(slot0.viewGO, "line")
	slot0._txtdegree = gohelper.findChildText(slot0.viewGO, "txt_degree")
	slot0._goicon = gohelper.findChild(slot0.viewGO, "icon")
	slot0._goblockicon = gohelper.findChild(slot0.viewGO, "block_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "txt_name")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "txt_count")
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._showDegreeMO = slot1

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	if not slot0._showDegreeMO then
		return
	end

	if slot0._lastIsBlock ~= (slot1.degreeType == 1) then
		slot0._lastIsBlock = slot2

		gohelper.setActive(slot0._goline, slot2)
		gohelper.setActive(slot0._goblockicon, slot2)
		gohelper.setActive(slot0._goicon, not slot2)
	end

	slot0._txtcount.text = luaLang("multiple") .. slot1.count
	slot0._txtname.text = slot2 and luaLang("p_roominitbuilding_plane") or slot1.name
	slot0._txtdegree.text = slot1.degree
end

function slot0.onDestroy(slot0)
end

return slot0
