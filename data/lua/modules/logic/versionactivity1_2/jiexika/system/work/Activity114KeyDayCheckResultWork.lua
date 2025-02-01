module("modules.logic.versionactivity1_2.jiexika.system.work.Activity114KeyDayCheckResultWork", package.seeall)

slot0 = class("Activity114KeyDayCheckResultWork", Activity114BaseWork)

function slot0.onStart(slot0, slot1)
	slot0:getFlow():addWork(Activity114StopStoryWork.New())
	slot0:getFlow():addWork(Activity114OpenAttrViewWork.New())

	slot3 = false

	if not Activity114Config.instance:getKeyDayCo(Activity114Model.instance.id, slot0.context.nowDay) then
		slot4, slot5, slot6, slot7 = Activity114Helper.getWeekEndScore()
		slot3 = slot7 < Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId.ScoreC)

		slot0:getFlow():addWork(Activity114WeekEndWork.New())
	end

	slot0.context.storyId = nil
	slot4 = slot0.context.eventCo

	if slot0.context.result == Activity114Enum.Result.None then
		-- Nothing
	elseif slot2 and slot0.context.result == Activity114Enum.Result.Success or not slot2 and not slot3 then
		slot0:getFlow():addWork(Activity114StoryWork.New(slot4.config.successStoryId, Activity114Enum.StoryType.Result))
	elseif slot2 and slot0.context.result == Activity114Enum.Result.Fail or not slot2 and slot3 then
		slot0:getFlow():addWork(Activity114StoryWork.New(slot4.config.failureStoryId, Activity114Enum.StoryType.Result))
	else
		logError("error :" .. tostring(slot3) .. " +++ " .. tostring(slot0.context.nowDay))
	end

	slot0:getFlow():addWork(Activity114StopStoryWork.New())
	slot0:startFlow()
end

return slot0
