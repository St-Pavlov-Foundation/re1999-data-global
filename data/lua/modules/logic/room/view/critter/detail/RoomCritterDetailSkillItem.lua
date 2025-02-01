module("modules.logic.room.view.critter.detail.RoomCritterDetailSkillItem", package.seeall)

slot0 = class("RoomCritterDetailSkillItem", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._txtskillname = gohelper.findChildText(slot0.viewGO, "title/#txt_skillname")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "title/#txt_skillname/#image_icon")
	slot0._txtskilldec = gohelper.findChildText(slot0.viewGO, "#txt_skilldec")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.onRefreshMo(slot0, slot1)
	slot0._txtskillname.text = slot1 and slot1.name
	slot0._txtskilldec.text = slot1 and slot1.desc

	if slot0._imageicon and not string.nilorempty(slot1.skillIcon) then
		UISpriteSetMgr.instance:setCritterSprite(slot0._imageicon, slot1.skillIcon)
	end
end

return slot0
