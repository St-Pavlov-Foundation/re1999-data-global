module("modules.logic.versionactivity1_2.jiexika.model.Activity114TaskMo", package.seeall)

slot0 = pureTable("Activity114TaskMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.config = nil
	slot0.progress = 0
	slot0.finishStatus = 0
end

function slot0.update(slot0, slot1)
	if slot0.id ~= slot1.taskId or not slot0.config then
		slot0.config = Activity114Config.instance:getTaskCoById(Activity114Model.instance.id, slot1.taskId)
		slot0.id = slot1.taskId
	end

	slot0.progress = slot1.progress

	if slot1.progress < slot0.config.maxProgress then
		slot0.finishStatus = Activity114Enum.TaskStatu.NoFinish
	elseif slot1.hasGetBonus then
		slot0.finishStatus = Activity114Enum.TaskStatu.GetBonus
	else
		slot0.finishStatus = Activity114Enum.TaskStatu.Finish
	end
end

return slot0
