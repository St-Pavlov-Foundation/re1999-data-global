module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114MeetingFlow", package.seeall)

slot0 = class("Activity114MeetingFlow", Activity114BaseFlow)

function slot0.addEventWork(slot0)
	slot0:addWork(Activity114CheckWork.New())
	slot0:addWork(Activity114CheckOrAnswerWork.New())
end

return slot0
