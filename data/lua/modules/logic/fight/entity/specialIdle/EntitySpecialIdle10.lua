module("modules.logic.fight.entity.specialIdle.EntitySpecialIdle10", package.seeall)

slot0 = class("EntitySpecialIdle10", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0._entity = slot1
end

function slot0.releaseSelf(slot0)
	slot0._entity = nil

	slot0:__onDispose()
end

return slot0
