module("modules.logic.fight.system.work.FightWorkAct114RoundEndStory", package.seeall)

slot0 = class("FightWorkAct114RoundEndStory", BaseWork)

function slot0.onStart(slot0)
	if not FightModel.instance:getFightParam() or slot1.episodeId ~= Activity114Enum.episodeId then
		slot0:onDone(true)

		return
	end

	if Activity114Model.instance:isEnd() then
		Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, slot0.onProcessEnd, slot0)
		Activity114Controller.instance:alertActivityEndMsgBox()

		return
	end

	if not FightModel.instance:getRecordMO() then
		slot0:onDone(true)

		return
	end

	Activity114Controller.instance:registerCallback(Activity114Event.OnEventProcessEnd, slot0.onProcessEnd, slot0)
	Activity114Controller.instance:dispatchEvent(Activity114Event.OnFightResult, slot2.fightResult == FightEnum.FightResult.Succ and Activity114Enum.Result.FightSucess or Activity114Enum.Result.Fail)
end

function slot0.onProcessEnd(slot0)
	slot0:onDone(true)
end

function slot0.onDestroy(slot0)
	Activity114Controller.instance:unregisterCallback(Activity114Event.OnEventProcessEnd, slot0.onProcessEnd, slot0)
end

return slot0
