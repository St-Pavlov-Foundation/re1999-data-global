module("modules.logic.room.view.critter.RoomCritterAttrScrollCell", package.seeall)

slot0 = class("RoomCritterAttrScrollCell", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#txt_name/#image_icon")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#txt_num")
	slot0._txtratio = gohelper.findChildText(slot0.viewGO, "#txt_ratio")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.getDataMO(slot0)
	return slot0._critterAttributeInfoMO
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._critterAttributeInfoMO = slot1

	slot0:refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0.refreshUI(slot0)
	if not slot0._critterAttributeInfoMO then
		return
	end

	slot0._txtnum.text = slot1.value
	slot0._txtratio.text = math.floor(slot1.rate * 0.01) * 0.01 .. luaLang("multiple")

	if slot0._txtname then
		slot0._txtname.text = slot1:getName()
	end

	if slot0._imageicon and not string.nilorempty(slot1:getIcon()) then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imageicon, slot1:getIcon())
	end

	gohelper.setActive(slot0._goArrow, slot1:getIsAddition())
end

return slot0
