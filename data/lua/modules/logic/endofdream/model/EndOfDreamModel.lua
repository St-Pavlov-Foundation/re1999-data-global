module("modules.logic.endofdream.model.EndOfDreamModel", package.seeall)

slot0 = class("EndOfDreamModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
	slot0:clear()
end

function slot0.clear(slot0)
	uv0.super.clear()
end

function slot0.isLevelUnlocked(slot0, slot1)
	return true
end

slot0.instance = slot0.New()

return slot0
