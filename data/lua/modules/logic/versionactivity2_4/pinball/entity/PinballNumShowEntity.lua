module("modules.logic.versionactivity2_4.pinball.entity.PinballNumShowEntity", package.seeall)

slot0 = class("PinballNumShowEntity", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._trans = slot1.transform
	slot0._txtnum = gohelper.findChildTextMesh(slot1, "#txt_num")

	TaskDispatcher.runDelay(slot0.dispose, slot0, 2)
end

function slot0.setType(slot0, slot1)
	slot0._txtnum.text = slot1
end

function slot0.setPos(slot0, slot1, slot2)
	recthelper.setAnchor(slot0._trans, slot1, slot2)
end

function slot0.dispose(slot0)
	gohelper.destroy(slot0.go)
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0.dispose, slot0)
end

return slot0
