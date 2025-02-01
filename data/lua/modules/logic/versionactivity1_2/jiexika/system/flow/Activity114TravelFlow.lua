module("modules.logic.versionactivity1_2.jiexika.system.flow.Activity114TravelFlow", package.seeall)

slot0 = class("Activity114TravelFlow", Activity114BaseFlow)

function slot0.addSkipWork(slot0)
	if Activity114Model.instance.serverData.battleEventId > 0 then
		slot0.context.result = Activity114Enum.Result.Fail

		slot0:addWork(Activity114FightResultWork.New())
		slot0:addWork(Activity114OpenAttrViewWork.New())

		return
	end

	uv0.super.addSkipWork(slot0)
end

function slot0.addEventWork(slot0)
	slot0:addWork(Activity114CheckWork.New())
	slot0:addWork(Activity114CheckOrAnswerWork.New())
end

return slot0
