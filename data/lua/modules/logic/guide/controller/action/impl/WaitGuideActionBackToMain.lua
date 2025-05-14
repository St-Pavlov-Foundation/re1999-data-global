module("modules.logic.guide.controller.action.impl.WaitGuideActionBackToMain", package.seeall)

local var_0_0 = class("WaitGuideActionBackToMain", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	GameSceneMgr.instance:registerCallback(SceneType.Main, arg_1_0._onEnterMainScene, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._checkInMain, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._checkInMain, arg_1_0)

	arg_1_0._needView = arg_1_0.actionParam

	arg_1_0:_checkInMain()
end

function var_0_0._onEnterMainScene(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == 1 then
		arg_2_0:_checkInMain()
	end
end

function var_0_0._checkInMain(arg_3_0)
	if arg_3_0:checkGuideLock() then
		return
	end

	local var_3_0 = GameSceneMgr.instance:getCurSceneType() == SceneType.Main
	local var_3_1 = GameSceneMgr.instance:isLoading()
	local var_3_2 = GameSceneMgr.instance:isClosing()

	if var_3_0 and not var_3_1 and not var_3_2 then
		local var_3_3 = false
		local var_3_4 = ViewMgr.instance:getOpenViewNameList()

		for iter_3_0, iter_3_1 in ipairs(var_3_4) do
			if iter_3_1 ~= arg_3_0._needView and (ViewMgr.instance:isModal(iter_3_1) or ViewMgr.instance:isFull(iter_3_1)) then
				var_3_3 = true

				break
			end
		end

		if not var_3_3 and (string.nilorempty(arg_3_0._needView) or ViewMgr.instance:isOpen(arg_3_0._needView)) then
			arg_3_0:_removeEvents()
			arg_3_0:onDone(true)
		end
	end
end

function var_0_0._removeEvents(arg_4_0)
	GameSceneMgr.instance:unregisterCallback(SceneType.Main, arg_4_0._onEnterMainScene, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_4_0._checkInMain, arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_4_0._checkInMain, arg_4_0)
end

function var_0_0.clearWork(arg_5_0)
	arg_5_0:_removeEvents()
end

return var_0_0
