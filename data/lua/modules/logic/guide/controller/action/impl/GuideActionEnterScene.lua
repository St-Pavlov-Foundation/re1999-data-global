module("modules.logic.guide.controller.action.impl.GuideActionEnterScene", package.seeall)

local var_0_0 = class("GuideActionEnterScene", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")

	arg_1_0._sceneType = SceneType[var_1_0[1]]

	if VirtualSummonScene.instance:isOpen() and arg_1_0._sceneType ~= SceneType.Summon then
		VirtualSummonScene.instance:close(true)
	end

	if arg_1_0._sceneType == SceneType.Summon then
		SummonController.instance:enterSummonScene()
	else
		arg_1_0._sceneId = tonumber(var_1_0[2])
		arg_1_0._sceneLevel = tonumber(var_1_0[3])

		if arg_1_0._sceneLevel then
			GameSceneMgr.instance:startScene(arg_1_0._sceneType, arg_1_0._sceneId, arg_1_0._sceneLevel)
		else
			GameSceneMgr.instance:startSceneDefaultLevel(arg_1_0._sceneType, arg_1_0._sceneId)
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
