module("modules.logic.scene.pushbox.logic.PushBoxDataMgr", package.seeall)

slot0 = class("PushBoxDataMgr", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._game_mgr = slot1
	slot0._scene = slot1._scene
	slot0._scene_root = slot1._scene_root
end

function slot0.init(slot0)
	slot0.warning = 0
end

function slot0.setWarning(slot0, slot1)
	slot0.warning = slot1
end

function slot0.getCurWarning(slot0)
	return slot0.warning
end

function slot0.changeWarning(slot0, slot1)
	slot0.warning = slot0.warning + slot1
end

function slot0.gameOver(slot0)
	return slot0.warning >= 100
end

function slot0.releaseSelf(slot0)
	slot0:__onDispose()
end

return slot0
