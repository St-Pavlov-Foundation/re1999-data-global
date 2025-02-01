module("modules.logic.room.entity.RoomFakeBlockEntity", package.seeall)

slot0 = class("RoomFakeBlockEntity", RoomBaseBlockEntity)

function slot0.getTag(slot0)
	return SceneTag.RoomFakeBlock
end

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)
end

function slot0.initComponents(slot0)
	uv0.super.initComponents(slot0)
end

function slot0.refreshLand(slot0)
	uv0.super.refreshLand(slot0)
	slot0.effect:changeParams({
		landGO = {
			shadow = false,
			batch = false,
			layer = UnityLayer.SceneOrthogonalOpaque
		}
	})
	slot0.effect:refreshEffect()
end

function slot0.getMO(slot0)
	return RoomInventoryBlockModel.instance:getFakeBlockMOById(slot0.id)
end

return slot0
