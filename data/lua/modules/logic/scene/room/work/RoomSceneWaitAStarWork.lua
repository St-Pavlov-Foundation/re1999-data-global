module("modules.logic.scene.room.work.RoomSceneWaitAStarWork", package.seeall)

slot0 = class("RoomSceneWaitAStarWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._scene = slot1
end

function slot0.onStart(slot0)
	slot0._isLoadingFinish = false

	TaskDispatcher.runDelay(slot0._overtime, slot0, 30)
	TaskDispatcher.runRepeat(slot0._onUpdate, slot0, 0)
	slot0:_logState()
end

function slot0._onUpdate(slot0)
	slot0:_logState()

	if not slot0._scene.loader:isLoaderInProgress() and (not RoomEnum.UseAStarPath or not ZProj.AStarPathBridge.IsAStarInProgress()) then
		slot0:_finish()
	else
		logNormal("RoomSceneWaitAStarWork: waiting")
	end
end

function slot0._logState(slot0)
	RoomHelper.logElapse(string.format("loading = %s, scaning = %s", slot0._scene.loader:isLoaderInProgress() and "true" or "false", ZProj.AStarPathBridge.IsAStarInProgress() and "true" or "false"))
end

function slot0._overtime(slot0)
	logError("RoomSceneWaitAStarWork: 超时, 直接进场景")
	GameFacade.showMessageBox(MessageBoxIdDefine.RoomEnterLoadingTimeOut, MsgBoxEnum.BoxType.Yes, function ()
		if not uv0._isLoadingFinish then
			TaskDispatcher.runDelay(uv0._overtime, uv0, 30)
		end
	end)
end

function slot0._finish(slot0)
	logNormal("RoomSceneWaitAStarWork: finish")

	slot0._isLoadingFinish = true

	TaskDispatcher.cancelTask(slot0._overtime, slot0)
	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)

	slot0._scene = nil

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._overtime, slot0)
	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)

	slot0._scene = nil
end

return slot0
