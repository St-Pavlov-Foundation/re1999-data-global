module("modules.logic.handbook.model.HandbookCGTripleMO", package.seeall)

slot0 = pureTable("HandbookCGTripleMO")

function slot0.init(slot0, slot1)
	if slot1.isTitle then
		slot0.storyChapterId = slot1.storyChapterId
		slot0.isTitle = true
	else
		slot0.cgList = slot1.cgList
		slot0.cgType = slot1.cgType
		slot0.isTitle = false
	end
end

return slot0
