module("modules.logic.fight.system.flow.FightRestartSequence", package.seeall)

slot0 = class("FightRestartSequence", BaseFightSequence)
slot0.RestartType2Type = {
	[21.0] = 1,
	[121.0] = 1,
	[123.0] = 1,
	[14.0] = 1,
	[122.0] = 1,
	[191.0] = 1,
	[201.0] = 1,
	[202.0] = 1,
	[24.0] = 23,
	[143.0] = 1,
	[31.0] = 166,
	[34.0] = 34,
	[161.0] = 1,
	[183.0] = 1,
	[32.0] = 166,
	[36.0] = 34,
	[181.0] = 1,
	[19.0] = 1,
	[124.0] = 1,
	[151.0] = 1,
	[35.0] = 34,
	[135.0] = 131,
	[134.0] = 131,
	[133.0] = 131,
	[132.0] = 131
}

function slot0.buildFlow(slot0)
	uv0.super.buildFlow(slot0)

	slot1 = FightModel.instance:getFightParam()

	slot0:addWork(FightWorkRestartAbandon.New(slot1))
	slot0:addWork(FunctionWork.New(slot0.startRestartGame, slot0))
	slot0:addWork(FightWorkRestartBefore.New(slot1))
	slot0:addWork(FightWorkRestartRequest.New(slot1))
end

function slot0.startRestartGame(slot0)
	FightMsgMgr.sendMsg(FightMsgId.RestartGame)
end

return slot0
