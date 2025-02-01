module("modules.logic.scene.view.LoadingBlackView", package.seeall)

slot0 = class("LoadingBlackView", BaseView)
slot1 = 60

function slot0.addEvents(slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.AgainOpenLoading, slot0._againOpenLoading, slot0)
	slot0:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, slot0.closeThis, slot0)
	TaskDispatcher.runDelay(slot0._errorCloseLoading, slot0, uv0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.AgainOpenLoading, slot0._againOpenLoading, slot0)
	slot0:removeEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, slot0.closeThis, slot0)
	TaskDispatcher.cancelTask(slot0._errorCloseLoading, slot0)
end

function slot0._againOpenLoading(slot0)
	logNormal("loading打开状态下，又调用了打开loading，取消计时，继续走")
	TaskDispatcher.cancelTask(slot0._errorCloseLoading, slot0)
	TaskDispatcher.runDelay(slot0._errorCloseLoading, slot0, uv0)
end

function slot0._errorCloseLoading(slot0)
	logError(string.format("loading超时，关闭loading看看 sceneType_%d sceneId_%d isLoading_%s", GameSceneMgr.instance:getCurSceneType() or -1, GameSceneMgr.instance:getCurSceneId() or -1, GameSceneMgr.instance:isLoading() and "true" or "false"))
	slot0:closeThis()
end

return slot0
