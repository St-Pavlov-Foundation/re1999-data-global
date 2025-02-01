module("modules.logic.character.model.SkinInfoMO", package.seeall)

slot0 = pureTable("SkinInfoMO")

function slot0.init(slot0, slot1)
	slot0.skin = slot1.skin
	slot0.expireSec = slot1.expireSec
end

return slot0
