slot0 = pureTable("Activity104EpisodeMo")

function slot0.ctor(slot0)
	slot0.layer = 0
	slot0.state = 0
	slot0.readAfterStory = false
end

function slot0.init(slot0, slot1)
	slot0.layer = slot1.layer
	slot0.state = slot1.state
	slot0.readAfterStory = slot1.readAfterStory
end

function slot0.reset(slot0, slot1)
	slot0.layer = slot1.layer
	slot0.state = slot1.state
	slot0.readAfterStory = slot1.readAfterStory
end

function slot0.markStory(slot0, slot1)
	slot0.readAfterStory = slot1
end

return slot0
