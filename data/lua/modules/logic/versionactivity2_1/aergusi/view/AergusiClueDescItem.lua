module("modules.logic.versionactivity2_1.aergusi.view.AergusiClueDescItem", package.seeall)

slot0 = class("AergusiClueDescItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._txtDesc = gohelper.findChildText(slot1, "txt_desc")
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.refreshItem(slot0, slot1)
	gohelper.setActive(slot0.go, true)

	slot0._txtDesc.text = slot1
end

function slot0.destroy(slot0)
	gohelper.destroy(slot0.go)
end

return slot0
