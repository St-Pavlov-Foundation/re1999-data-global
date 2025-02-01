module("modules.logic.teach.view.TeachNoteDescItem", package.seeall)

slot0 = class("TeachNoteDescItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.go = slot1
	slot0.index = slot2
	slot0.id = slot3
	slot0._txtdesccn = gohelper.findChildText(slot1, "desccn")
	slot0._txtdescen = gohelper.findChildText(slot1, "descen")

	slot0:_refreshItem()
end

function slot0._refreshItem(slot0)
	slot0._txtdesccn.text = string.gsub(string.split(TeachNoteConfig.instance:getInstructionLevelCO(slot0.id).desc, "#")[slot0.index], "<i>(.-)</i>", "<i><size=24>%1</size></i>")
	slot0._txtdescen.text = string.split(TeachNoteConfig.instance:getInstructionLevelCO(slot0.id).desc_en, "#")[slot0.index]
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0.go)
end

return slot0
