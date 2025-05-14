module("modules.logic.scene.summon.comp.SummonSceneDirector", package.seeall)

local var_0_0 = class("SummonSceneDirector", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._hasSummonView = false
	arg_1_0._allStepReady = false

	arg_1_0._scene.selector:registerCallback(SummonSceneEvent.OnSceneGOInited, arg_1_0._onSelectorGOInited, arg_1_0)

	arg_1_0._hasCharPreload = VirtualSummonScene.instance:isABLoaded(true)

	if not arg_1_0._hasEquipPreload or not arg_1_0._hasCharPreload then
		VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinish, arg_1_0._onPreloadFinish, arg_1_0)
	end

	if arg_1_0._scene.selector:isSceneGOInited(true) then
		arg_1_0:_onSelectorGOInited(true)
	end

	if VirtualSummonScene.instance:isOpenImmediately() then
		VirtualSummonScene.instance:checkNeedLoad(true, true)
	end

	arg_1_0._scene.view:registerCallback(SummonSceneEvent.OnViewFinish, arg_1_0._onViewReady, arg_1_0)
	arg_1_0._scene.view:openView()
end

function var_0_0.onScenePrepared(arg_2_0)
	arg_2_0:dispatchEvent(SummonSceneEvent.OnEnterScene)
end

function var_0_0._onPreloadFinish(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0._hasCharPreload = true
	else
		arg_3_0._hasEquipPreload = true
	end

	arg_3_0:_checkAllResPrepared()
	VirtualSummonScene.instance:dispatchEvent(SummonSceneEvent.OnPreloadFinishAtScene, arg_3_1)
end

function var_0_0._onSelectorGOInited(arg_4_0, arg_4_1)
	if arg_4_1 then
		local var_4_0 = arg_4_0._scene.selector:getCharSceneGo()

		arg_4_0._drawCompChar = MonoHelper.addLuaComOnceToGo(var_4_0, SummonDrawComp, var_4_0)

		local var_4_1 = gohelper.findChild(var_4_0, "anim")

		if var_4_1 then
			local var_4_2 = var_4_1:GetComponent(typeof(UnityEngine.Animator))

			if SummonController.instance:isInSummonGuide() then
				var_4_2:Play(SummonEnum.SummonFogAnimationName, 0, 0)
			else
				var_4_2:Play(SummonEnum.InitialStateAnimationName, 0, 0)
			end

			var_4_2.speed = 0
		end
	else
		local var_4_3 = arg_4_0._scene.selector:getEquipSceneGo()

		arg_4_0._drawCompEquip = MonoHelper.addLuaComOnceToGo(var_4_3, SummonDrawEquipComp, var_4_3)

		local var_4_4 = gohelper.findChild(var_4_3, "anim")

		if var_4_4 then
			local var_4_5 = var_4_4:GetComponent(typeof(UnityEngine.Animator))

			var_4_5:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)

			var_4_5.speed = 0
		end
	end

	SummonController.instance:prepareSummon()
end

function var_0_0._onViewReady(arg_5_0)
	arg_5_0._scene.view:unregisterCallback(SummonSceneEvent.OnViewFinish, arg_5_0._onViewReady, arg_5_0)

	arg_5_0._hasSummonView = true

	arg_5_0:_checkAllResPrepared()
end

function var_0_0._checkAllResPrepared(arg_6_0)
	if VirtualSummonScene.instance:isOpenImmediately() then
		if arg_6_0._hasCharPreload then
			arg_6_0._scene.selector:initSceneGO(true)

			if arg_6_0._hasSummonView then
				arg_6_0._allStepReady = true

				arg_6_0._scene:onPrepared()
			end
		end
	elseif arg_6_0._hasSummonView then
		arg_6_0._allStepReady = true

		arg_6_0._scene:onPrepared()
	end
end

function var_0_0.isPreloadReady(arg_7_0, arg_7_1)
	if arg_7_1 then
		return arg_7_0._hasCharPreload
	else
		return arg_7_0._hasEquipPreload
	end

	return false
end

function var_0_0.isReady(arg_8_0)
	return arg_8_0._allStepReady
end

function var_0_0.getDrawComp(arg_9_0, arg_9_1)
	if arg_9_1 == SummonEnum.ResultType.Equip then
		return arg_9_0._drawCompEquip
	else
		return arg_9_0._drawCompChar
	end
end

function var_0_0.onSceneClose(arg_10_0)
	arg_10_0._scene.selector:unregisterCallback(SummonSceneEvent.OnSceneGOInited, arg_10_0._onSelectorGOInited, arg_10_0)
	arg_10_0._scene.view:unregisterCallback(SummonSceneEvent.OnViewFinish, arg_10_0._onViewReady, arg_10_0)
	VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinish, arg_10_0._onPreloadFinish, arg_10_0)

	arg_10_0._drawCompChar = nil
	arg_10_0._drawCompEquip = nil
	arg_10_0._allStepReady = false
	arg_10_0._hasCharPreload = false
	arg_10_0._hasEquipPreload = false
end

function var_0_0.onSceneHide(arg_11_0)
	arg_11_0:onSceneClose()
end

return var_0_0
