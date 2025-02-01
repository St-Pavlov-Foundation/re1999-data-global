module("modules.logic.versionactivity1_8.dungeon.controller.VersionActivity1_8StatController", package.seeall)

slot0 = class("VersionActivity1_8StatController")

function slot0.startStat(slot0)
	slot0.startTime = ServerTime.now()
end

function slot0.statSuccess(slot0)
	slot0:_statEnd(StatEnum.Result.Success)
end

function slot0.statAbort(slot0)
	slot0:_statEnd(StatEnum.Result.Abort)
end

function slot0.statReset(slot0)
	slot0:_statEnd(StatEnum.Result.Reset)
	slot0:startStat()
end

function slot0._statEnd(slot0, slot1)
	if not slot0.startTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.FactoryConnectionGame, {
		[StatEnum.EventProperties.UseTime] = ServerTime.now() - slot0.startTime,
		[StatEnum.EventProperties.PartsId] = tostring(Activity157RepairGameModel.instance:getCurComponentId()),
		[StatEnum.EventProperties.Result] = slot1
	})

	slot0.startTime = nil
end

slot0.instance = slot0.New()

return slot0
