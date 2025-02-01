module("modules.logic.story.model.StoryHeroLibraryMo", package.seeall)

slot0 = pureTable("StoryHeroLibraryMo")

function slot0.ctor(slot0)
	slot0.index = 0
	slot0.type = 0
	slot0.tag = false
	slot0.name = ""
	slot0.nameEn = ""
	slot0.icon = ""
	slot0.leftParam = ""
	slot0.midParam = ""
	slot0.rightParam = ""
	slot0.live2dLeftParam = ""
	slot0.live2dMidParam = ""
	slot0.live2dRightParam = ""
	slot0.prefab = ""
	slot0.live2dPrefab = ""
	slot0.hideNodes = ""
end

function slot0.init(slot0, slot1)
	slot0.index = slot1[1]
	slot0.type = slot1[2]
	slot0.tag = slot1[3]
	slot0.name = slot1[4]
	slot0.nameEn = slot1[5]
	slot0.icon = slot1[6]
	slot0.leftParam = slot1[7]
	slot0.midParam = slot1[8]
	slot0.rightParam = slot1[9]
	slot0.live2dLeftParam = slot1[10]
	slot0.live2dMidParam = slot1[11]
	slot0.live2dRightParam = slot1[12]
	slot0.prefab = slot1[13]
	slot0.live2dPrefab = slot1[14]
	slot0.hideNodes = slot1[15]
end

return slot0
