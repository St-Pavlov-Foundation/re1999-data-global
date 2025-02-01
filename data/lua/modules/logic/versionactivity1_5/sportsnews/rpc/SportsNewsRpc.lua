module("modules.logic.versionactivity1_5.sportsnews.rpc.SportsNewsRpc", package.seeall)

slot0 = class("SportsNewsRpc", BaseRpc)

function slot0.sendFinishReadTaskRequest(slot0, slot1, slot2)
	slot3 = TaskModule_pb.FinishReadTaskRequest()
	slot3.taskId = slot2

	slot0:sendMsg(slot3)
end

slot0.instance = slot0.New()

return slot0
