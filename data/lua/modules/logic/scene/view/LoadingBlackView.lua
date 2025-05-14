module("modules.logic.scene.view.LoadingBlackView", package.seeall)

local var_0_0 = class("LoadingBlackView", BaseView)
local var_0_1 = 60

function var_0_0.addEvents(arg_1_0)
	arg_1_0:addEventCb(GameSceneMgr.instance, SceneEventName.AgainOpenLoading, arg_1_0._againOpenLoading, arg_1_0)
	arg_1_0:addEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, arg_1_0.closeThis, arg_1_0)
	TaskDispatcher.runDelay(arg_1_0._errorCloseLoading, arg_1_0, var_0_1)
end

function var_0_0.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(GameSceneMgr.instance, SceneEventName.AgainOpenLoading, arg_2_0._againOpenLoading, arg_2_0)
	arg_2_0:removeEventCb(GameSceneMgr.instance, SceneEventName.DelayCloseLoading, arg_2_0.closeThis, arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0._errorCloseLoading, arg_2_0)
end

function var_0_0._againOpenLoading(arg_3_0)
	logNormal("loading打开状态下，又调用了打开loading，取消计时，继续走")
	TaskDispatcher.cancelTask(arg_3_0._errorCloseLoading, arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._errorCloseLoading, arg_3_0, var_0_1)
end

function var_0_0._errorCloseLoading(arg_4_0)
	local var_4_0 = GameSceneMgr.instance:getCurSceneType()
	local var_4_1 = GameSceneMgr.instance:getCurSceneId()
	local var_4_2 = GameSceneMgr.instance:isLoading()

	logError(string.format("loading超时，关闭loading看看 sceneType_%d sceneId_%d isLoading_%s", var_4_0 or -1, var_4_1 or -1, var_4_2 and "true" or "false"))
	arg_4_0:closeThis()
end

return var_0_0
