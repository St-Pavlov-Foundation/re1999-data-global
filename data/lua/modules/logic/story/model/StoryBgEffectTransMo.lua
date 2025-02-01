module("modules.logic.story.model.StoryBgEffectTransMo", package.seeall)

slot0 = pureTable("StoryBgEffectTransMo")

function slot0.ctor(slot0)
	slot0.type = 0
	slot0.name = ""
	slot0.mat = ""
	slot0.prefab = ""
	slot0.aniName = ""
	slot0.transTime = 0
	slot0.extraParam = ""
end

function slot0.init(slot0, slot1)
	slot0.type = slot1[1]
	slot0.name = slot1[2]
	slot0.mat = slot1[3]
	slot0.prefab = string.split(slot1[4], ".")[1]
	slot0.aniName = slot1[5]
	slot0.transTime = slot1[6]
	slot0.extraParam = slot1[7]
end

return slot0
