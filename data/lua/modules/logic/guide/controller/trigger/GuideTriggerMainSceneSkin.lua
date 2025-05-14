module("modules.logic.guide.controller.trigger.GuideTriggerMainSceneSkin", package.seeall)

local var_0_0 = class("GuideTriggerMainSceneSkin", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0._onViewChange, arg_1_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0._onViewChange, arg_1_0)
	GameSceneMgr.instance:registerCallback(SceneType.Main, arg_1_0._onMainScene, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	return arg_2_0:_isHasSkinItem() and arg_2_0:_checkInMain()
end

function var_0_0._isHasSkinItem(arg_3_0)
	local var_3_0 = MainSceneSwitchConfig.instance:getItemLockList()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if ItemModel.instance:getItemCount(iter_3_1) > 0 then
			return true
		end
	end
end

function var_0_0._onMainScene(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 1 then
		arg_4_0:checkStartGuide()
	end
end

function var_0_0._onViewChange(arg_5_0)
	arg_5_0:checkStartGuide()
end

function var_0_0._checkInMain(arg_6_0)
	local var_6_0 = ViewName.MainView
	local var_6_1 = GameSceneMgr.instance:getCurSceneType() == SceneType.Main
	local var_6_2 = GameSceneMgr.instance:isLoading()
	local var_6_3 = GameSceneMgr.instance:isClosing()

	if var_6_1 and not var_6_2 and not var_6_3 then
		local var_6_4 = false
		local var_6_5 = ViewMgr.instance:getOpenViewNameList()

		for iter_6_0, iter_6_1 in ipairs(var_6_5) do
			if iter_6_1 ~= var_6_0 and (ViewMgr.instance:isModal(iter_6_1) or ViewMgr.instance:isFull(iter_6_1)) then
				var_6_4 = true

				break
			end
		end

		if not var_6_4 and (string.nilorempty(var_6_0) or ViewMgr.instance:isOpen(var_6_0)) then
			return true
		end
	end
end

function var_0_0._checkStartGuide(arg_7_0)
	arg_7_0:checkStartGuide()
end

return var_0_0
