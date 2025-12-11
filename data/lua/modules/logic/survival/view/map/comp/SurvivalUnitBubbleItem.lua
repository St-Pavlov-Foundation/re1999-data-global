module("modules.logic.survival.view.map.comp.SurvivalUnitBubbleItem", package.seeall)

local var_0_0 = class("SurvivalUnitBubbleItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._params = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._anim = SLFramework.AnimatorPlayer.Get(arg_2_1)
	arg_2_0._icon = gohelper.findChildImage(arg_2_1, "icon")

	UISpriteSetMgr.instance:setSurvivalSprite(arg_2_0._icon, "survival_map_emoji_" .. arg_2_0._params.type)

	if arg_2_0._params.time > 0 then
		TaskDispatcher.runDelay(arg_2_0._delayDestroy, arg_2_0, arg_2_0._params.time)
	end

	arg_2_0._uiFollower = gohelper.onceAddComponent(arg_2_0.go, typeof(ZProj.UIFollower))

	local var_2_0 = SurvivalMapHelper.instance:getEntity(arg_2_0._params.unitId)
	local var_2_1 = CameraMgr.instance:getMainCamera()
	local var_2_2 = CameraMgr.instance:getUICamera()
	local var_2_3 = ViewMgr.instance:getUIRoot().transform

	arg_2_0._uiFollower:Set(var_2_1, var_2_2, var_2_3, var_2_0.go.transform, 0, 0.4, 0, 0, 0)
	arg_2_0._uiFollower:SetEnable(true)
end

function var_0_0.updateParam(arg_3_0, arg_3_1)
	arg_3_0._params = arg_3_1

	UISpriteSetMgr.instance:setSurvivalSprite(arg_3_0._icon, "survival_map_emoji_" .. arg_3_0._params.type)
	TaskDispatcher.cancelTask(arg_3_0._delayDestroy, arg_3_0)

	if arg_3_0._params.time > 0 then
		TaskDispatcher.runDelay(arg_3_0._delayDestroy, arg_3_0, arg_3_0._params.time)
	end
end

function var_0_0._delayDestroy(arg_4_0)
	arg_4_0._params.callback(arg_4_0._params.callobj, arg_4_0._params.unitId)
end

function var_0_0.tryDestroy(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDestroy, arg_5_0)
	arg_5_0._anim:Play("close", arg_5_0._destroySelf, arg_5_0)
end

function var_0_0._destroySelf(arg_6_0)
	gohelper.destroy(arg_6_0.go)
end

return var_0_0
