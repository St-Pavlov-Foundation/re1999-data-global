module("modules.logic.versionactivity1_4.act130.controller.StatActivity130Controller", package.seeall)

slot0 = class("StatActivity130Controller", BaseController)

function slot0.statStart(slot0)
	slot0.startTime = Time.realtimeSinceStartup
end

function slot0.statSuccess(slot0)
	slot0:statEnd(StatEnum.Result.Success)
end

function slot0.statFail(slot0)
	slot0:statEnd(StatEnum.Result.Fail)
end

function slot0.statAbort(slot0)
	slot0:statEnd(StatEnum.Result.Abort)
end

function slot0.statReset(slot0)
	slot0:statEnd(StatEnum.Result.Reset)
	slot0:statStart()
end

function slot0.statEnd(slot0, slot1)
	if not slot0.startTime then
		return
	end

	slot2 = Time.realtimeSinceStartup - slot0.startTime
	slot4 = Activity130Model.instance:getGameChallengeNum(Activity130Model.instance:getCurEpisodeId())
	slot5 = PuzzleRecordListModel.instance:getCount()
	slot6 = Role37PuzzleModel.instance:getResult() and 1 or 0
	slot7 = 0

	if Activity130Model.instance:getInfo(slot3).getFinishElementCount then
		slot7 = slot8:getFinishElementCount()
	end

	slot9 = ""

	if slot1 == StatEnum.Result.Fail then
		slot9 = "超出回合数"
	end

	StatController.instance:track(StatEnum.EventName.Exit37Game, {
		[StatEnum.EventProperties.UseTime] = slot2,
		[StatEnum.EventProperties.EpisodeId] = tostring(slot3),
		[StatEnum.EventProperties.ChallengesNum] = slot4,
		[StatEnum.EventProperties.RoundNum] = slot5,
		[StatEnum.EventProperties.GoalNum] = slot6,
		[StatEnum.EventProperties.ElementNum] = slot7,
		[StatEnum.EventProperties.Result] = slot1,
		[StatEnum.EventProperties.FailReason] = slot9
	})

	slot0.startTime = nil
end

slot0.instance = slot0.New()

return slot0
