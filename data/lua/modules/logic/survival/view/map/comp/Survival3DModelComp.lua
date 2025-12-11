module("modules.logic.survival.view.map.comp.Survival3DModelComp", package.seeall)

local var_0_0 = class("Survival3DModelComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_1 = arg_1_1 or {}
	arg_1_0.width = arg_1_1.width
	arg_1_0.height = arg_1_1.height
	arg_1_0.customPos = arg_1_1.customPos
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0._image = arg_2_1:GetComponent(gohelper.Type_RawImage)

	local var_2_0 = arg_2_0.width or recthelper.getWidth(arg_2_0._image.transform)
	local var_2_1 = arg_2_0.height or recthelper.getHeight(arg_2_0._image.transform)

	arg_2_0.survivalUI3DRender = UI3DRenderController.instance:getSurvivalUI3DRender(var_2_0, var_2_1, arg_2_0.customPos)
	arg_2_0._image.texture = arg_2_0.survivalUI3DRender:getRenderTexture()
end

function var_0_0.onDestroy(arg_3_0)
	if arg_3_0.survivalUI3DRender then
		UI3DRenderController.instance:removeSurvivalUI3DRender(arg_3_0.survivalUI3DRender)

		arg_3_0.survivalUI3DRender = nil
	end
end

function var_0_0.setSurvival3DModelMO(arg_4_0, arg_4_1)
	arg_4_0.survivalUI3DRender:setSurvival3DModelMO(arg_4_1)
end

function var_0_0.playNextAnim(arg_5_0, arg_5_1)
	arg_5_0.survivalUI3DRender:playNextAnim(arg_5_1)
end

return var_0_0
