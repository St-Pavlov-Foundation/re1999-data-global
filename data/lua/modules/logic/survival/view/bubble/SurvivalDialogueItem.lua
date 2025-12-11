module("modules.logic.survival.view.bubble.SurvivalDialogueItem", package.seeall)

local var_0_0 = class("SurvivalDialogueItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.textContent = gohelper.findChildTextMesh(arg_1_1, "root/#textContent")
	arg_1_0.uiFollower = arg_1_1:GetComponent(gohelper.Type_UIFollower)
	arg_1_0.mainCamera = CameraMgr.instance:getMainCamera()
	arg_1_0.uiCamera = CameraMgr.instance:getUICamera()
end

function var_0_0.setData(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_1
	arg_2_0.survivalBubble = arg_2_2
	arg_2_0.container = arg_2_3
	arg_2_0.survivalBubbleParam = arg_2_2.survivalBubbleParam
	arg_2_0.tarTransform = arg_2_2.transform
	arg_2_0.textContent.text = arg_2_0.survivalBubbleParam.content

	arg_2_0.uiFollower:Set(arg_2_0.mainCamera, arg_2_0.uiCamera, arg_2_0.container.transform, arg_2_0.tarTransform, 0, 1, 0, 0, 0)
	arg_2_0.uiFollower:SetEnable(true)
end

return var_0_0
