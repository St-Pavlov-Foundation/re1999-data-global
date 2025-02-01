module("modules.logic.explore.model.ExploreTaskModel", package.seeall)

slot0 = class("ExploreTaskModel", BaseModel)

function slot0.ctor(slot0)
	slot0._models = {}
end

function slot0.getTaskList(slot0, slot1)
	if not slot0._models[slot1] then
		slot0._models[slot1] = ListScrollModel.New()
	end

	return slot0._models[slot1]
end

slot0.instance = slot0.New()

return slot0
