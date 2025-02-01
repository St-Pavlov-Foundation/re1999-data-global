module("modules.logic.advance.model.testtask.TestTaskModel", package.seeall)

slot0 = class("TestTaskModel", BaseModel)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.getTaskData(slot0, slot1)
	return TaskModel.instance:getTaskById(slot1)
end

slot0.instance = slot0.New()

return slot0
