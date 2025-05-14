module("modules.logic.scene.fight.comp.FightSceneCtrl02", package.seeall)

local var_0_0 = class("FightSceneCtrl02", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0:getCurScene().level:registerCallback(CommonSceneLevelComp.OnLevelLoaded, arg_1_0._onLevelLoaded, arg_1_0)
end

function var_0_0._onLevelLoaded(arg_2_0, arg_2_1)
	arg_2_0._sceneCtrl02Comp = nil

	local var_2_0 = arg_2_0:getCurScene():getSceneContainerGO():GetComponentsInChildren(typeof(ZProj.SceneCtrl02))

	if var_2_0.Length > 0 then
		arg_2_0._sceneCtrl02Comp = var_2_0[0]
		arg_2_0._deadIdDict = {}

		FightController.instance:registerCallback(FightEvent.BeforePlayUniqueSkill, arg_2_0._beforePlayUniqueSkill, arg_2_0)
		FightController.instance:registerCallback(FightEvent.AfterPlayUniqueSkill, arg_2_0._afterPlayUniqueSkill, arg_2_0)
		FightController.instance:registerCallback(FightEvent.BeforeDeadEffect, arg_2_0._beforeDeadEffect, arg_2_0)
		FightController.instance:registerCallback(FightEvent.OnSpineMaterialChange, arg_2_0._onSpineMaterialChange, arg_2_0)
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, arg_2_0._onSpineLoaded, arg_2_0)
		FightController.instance:registerCallback(FightEvent.BeforeEntityDestroy, arg_2_0._beforeEntityDestroy, arg_2_0)
		FightController.instance:registerCallback(FightEvent.PushEndFight, arg_2_0._onEndFight, arg_2_0)
		arg_2_0:_setAllSpineMat()
	else
		FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, arg_2_0._beforePlayUniqueSkill, arg_2_0)
		FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, arg_2_0._afterPlayUniqueSkill, arg_2_0)
		FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_2_0._beforeDeadEffect, arg_2_0)
		FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, arg_2_0._onSpineMaterialChange, arg_2_0)
		FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_2_0._onSpineLoaded, arg_2_0)
		FightController.instance:unregisterCallback(FightEvent.BeforeEntityDestroy, arg_2_0._beforeEntityDestroy, arg_2_0)
		FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_2_0._onEndFight, arg_2_0)
	end
end

function var_0_0._setAllSpineMat(arg_3_0)
	if arg_3_0._sceneCtrl02Comp then
		local var_3_0 = FightHelper.getAllEntitysContainUnitNpc()

		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if iter_3_1.spineRenderer then
				local var_3_1 = iter_3_1.spineRenderer:getReplaceMat()

				arg_3_0._sceneCtrl02Comp:SetSpineMat(tostring(iter_3_1.id), var_3_1)
			end
		end
	end
end

function var_0_0._onSpineLoaded(arg_4_0, arg_4_1)
	if arg_4_0._sceneCtrl02Comp then
		local var_4_0 = arg_4_1.unitSpawn
		local var_4_1 = var_4_0.id

		if var_4_0.spineRenderer then
			local var_4_2 = var_4_0.spineRenderer:getReplaceMat()

			arg_4_0._sceneCtrl02Comp:SetSpineMat(tostring(var_4_1), var_4_2)
		end
	end
end

function var_0_0._beforeEntityDestroy(arg_5_0, arg_5_1)
	if arg_5_0._sceneCtrl02Comp and arg_5_1 and arg_5_1.spineRenderer then
		arg_5_0._sceneCtrl02Comp:SetSpineMat(tostring(arg_5_1.id), nil)
	end
end

function var_0_0._onSpineMaterialChange(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._sceneCtrl02Comp and not arg_6_0._deadIdDict[arg_6_1] then
		arg_6_0._sceneCtrl02Comp:SetSpineMat(tostring(arg_6_1), arg_6_2)
	end
end

function var_0_0._beforeDeadEffect(arg_7_0, arg_7_1)
	arg_7_0._deadIdDict[arg_7_1] = true

	arg_7_0._sceneCtrl02Comp:SetSpineMat(tostring(arg_7_1), nil)
end

function var_0_0._beforePlayUniqueSkill(arg_8_0, arg_8_1)
	if arg_8_0._sceneCtrl02Comp then
		arg_8_0._sceneCtrl02Comp.enabled = false
	end
end

function var_0_0._afterPlayUniqueSkill(arg_9_0, arg_9_1)
	if arg_9_0._sceneCtrl02Comp then
		arg_9_0._sceneCtrl02Comp.enabled = true
	end
end

function var_0_0._onEndFight(arg_10_0)
	if arg_10_0._sceneCtrl02Comp then
		arg_10_0._sceneCtrl02Comp.enabled = false
	end
end

function var_0_0.onSceneClose(arg_11_0)
	arg_11_0._sceneCtrl02Comp = nil

	FightController.instance:unregisterCallback(FightEvent.BeforePlayUniqueSkill, arg_11_0._beforePlayUniqueSkill, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.AfterPlayUniqueSkill, arg_11_0._afterPlayUniqueSkill, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeDeadEffect, arg_11_0._beforeDeadEffect, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineMaterialChange, arg_11_0._onSpineMaterialChange, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, arg_11_0._onSpineLoaded, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.BeforeEntityDestroy, arg_11_0._beforeEntityDestroy, arg_11_0)
	FightController.instance:unregisterCallback(FightEvent.PushEndFight, arg_11_0._onEndFight, arg_11_0)
end

return var_0_0
