module("modules.logic.fight.entity.comp.buff.FightBuffPlayAnimation", package.seeall)

local var_0_0 = class("FightBuffPlayAnimation", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:__onInit()

	arg_1_0._entity = arg_1_1
	arg_1_0._buff_mo = arg_1_2
	arg_1_0._url = arg_1_3

	arg_1_0:_beforePlayAni()

	arg_1_0._loader = MultiAbLoader.New()

	arg_1_0._loader:addPath(FightHelper.getEntityAniPath(arg_1_3))
	arg_1_0._loader:startLoad(arg_1_0._onEntityAnimLoaded, arg_1_0)
end

function var_0_0._beforePlayAni(arg_2_0)
	return
end

function var_0_0._onEntityAnimLoaded(arg_3_0)
	local var_3_0 = arg_3_0._loader:getFirstAssetItem():GetResource(ResUrl.getEntityAnim(arg_3_0._url))

	var_3_0.legacy = true

	local var_3_1 = gohelper.onceAddComponent(arg_3_0._entity.spine:getSpineGO(), typeof(UnityEngine.Animation))

	arg_3_0._animStateName = var_3_0.name
	arg_3_0._animComp = var_3_1
	var_3_1.enabled = true
	var_3_1.clip = var_3_0

	var_3_1:AddClip(var_3_0, var_3_0.name)

	local var_3_2 = var_3_1.this:get(var_3_0.name)

	if var_3_2 then
		var_3_2.speed = FightModel.instance:getSpeed()
	end

	var_3_1:Play()
	TaskDispatcher.runDelay(arg_3_0._animDone, arg_3_0, var_3_0.length / FightModel.instance:getSpeed())
	FightController.instance:registerCallback(FightEvent.OnUpdateSpeed, arg_3_0._onUpdateSpeed, arg_3_0)
end

function var_0_0._animDone(arg_4_0)
	if not gohelper.isNil(arg_4_0._animComp) then
		local var_4_0 = arg_4_0._animStateName

		if arg_4_0._animComp:GetClip(var_4_0) then
			arg_4_0._animComp:RemoveClip(var_4_0)
		end

		if arg_4_0._animComp.clip and arg_4_0._animComp.clip.name == var_4_0 then
			arg_4_0._animComp.clip = nil
		end

		arg_4_0._animComp.enabled = false
	end

	ZProj.CharacterSetVariantHelper.Disable(arg_4_0._entity.spine:getSpineGO())
end

function var_0_0._onUpdateSpeed(arg_5_0)
	if not gohelper.isNil(arg_5_0._animComp) then
		local var_5_0 = arg_5_0._animComp.this:get(arg_5_0._animStateName)

		if var_5_0 then
			var_5_0.speed = FightModel.instance:getSpeed()
		end
	end
end

function var_0_0.releaseSelf(arg_6_0)
	arg_6_0:_animDone()
	TaskDispatcher.cancelTask(arg_6_0._animDone, arg_6_0)
	FightController.instance:unregisterCallback(FightEvent.OnUpdateSpeed, arg_6_0._onUpdateSpeed, arg_6_0)

	if arg_6_0._loader then
		arg_6_0._loader:dispose()

		arg_6_0._loader = nil
	end

	arg_6_0._entity = nil
	arg_6_0._buff_mo = nil
	arg_6_0._url = nil

	arg_6_0:__onDispose()
end

return var_0_0
