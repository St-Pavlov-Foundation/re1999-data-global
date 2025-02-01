module("modules.logic.scene.summon.comp.SummonSceneDirector", package.seeall)

slot0 = class("SummonSceneDirector", BaseSceneComp)

function slot0.onSceneStart(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._hasSummonView = false
	slot0._allStepReady = false

	slot0._scene.selector:registerCallback(SummonSceneEvent.OnSceneGOInited, slot0._onSelectorGOInited, slot0)

	slot0._hasCharPreload = VirtualSummonScene.instance:isABLoaded(true)

	if not slot0._hasEquipPreload or not slot0._hasCharPreload then
		VirtualSummonScene.instance:registerCallback(SummonSceneEvent.OnPreloadFinish, slot0._onPreloadFinish, slot0)
	end

	if slot0._scene.selector:isSceneGOInited(true) then
		slot0:_onSelectorGOInited(true)
	end

	if VirtualSummonScene.instance:isOpenImmediately() then
		VirtualSummonScene.instance:checkNeedLoad(true, true)
	end

	slot0._scene.view:registerCallback(SummonSceneEvent.OnViewFinish, slot0._onViewReady, slot0)
	slot0._scene.view:openView()
end

function slot0.onScenePrepared(slot0)
	slot0:dispatchEvent(SummonSceneEvent.OnEnterScene)
end

function slot0._onPreloadFinish(slot0, slot1)
	if slot1 then
		slot0._hasCharPreload = true
	else
		slot0._hasEquipPreload = true
	end

	slot0:_checkAllResPrepared()
	VirtualSummonScene.instance:dispatchEvent(SummonSceneEvent.OnPreloadFinishAtScene, slot1)
end

function slot0._onSelectorGOInited(slot0, slot1)
	if slot1 then
		slot2 = slot0._scene.selector:getCharSceneGo()
		slot0._drawCompChar = MonoHelper.addLuaComOnceToGo(slot2, SummonDrawComp, slot2)

		if gohelper.findChild(slot2, "anim") then
			if SummonController.instance:isInSummonGuide() then
				slot3:GetComponent(typeof(UnityEngine.Animator)):Play(SummonEnum.SummonFogAnimationName, 0, 0)
			else
				slot4:Play(SummonEnum.InitialStateAnimationName, 0, 0)
			end

			slot4.speed = 0
		end
	else
		slot2 = slot0._scene.selector:getEquipSceneGo()
		slot0._drawCompEquip = MonoHelper.addLuaComOnceToGo(slot2, SummonDrawEquipComp, slot2)

		if gohelper.findChild(slot2, "anim") then
			slot4 = slot3:GetComponent(typeof(UnityEngine.Animator))

			slot4:Play(SummonEnum.InitialStateEquipAnimationName, 0, 0)

			slot4.speed = 0
		end
	end

	SummonController.instance:prepareSummon()
end

function slot0._onViewReady(slot0)
	slot0._scene.view:unregisterCallback(SummonSceneEvent.OnViewFinish, slot0._onViewReady, slot0)

	slot0._hasSummonView = true

	slot0:_checkAllResPrepared()
end

function slot0._checkAllResPrepared(slot0)
	if VirtualSummonScene.instance:isOpenImmediately() then
		if slot0._hasCharPreload then
			slot0._scene.selector:initSceneGO(true)

			if slot0._hasSummonView then
				slot0._allStepReady = true

				slot0._scene:onPrepared()
			end
		end
	elseif slot0._hasSummonView then
		slot0._allStepReady = true

		slot0._scene:onPrepared()
	end
end

function slot0.isPreloadReady(slot0, slot1)
	if slot1 then
		return slot0._hasCharPreload
	else
		return slot0._hasEquipPreload
	end

	return false
end

function slot0.isReady(slot0)
	return slot0._allStepReady
end

function slot0.getDrawComp(slot0, slot1)
	if slot1 == SummonEnum.ResultType.Equip then
		return slot0._drawCompEquip
	else
		return slot0._drawCompChar
	end
end

function slot0.onSceneClose(slot0)
	slot0._scene.selector:unregisterCallback(SummonSceneEvent.OnSceneGOInited, slot0._onSelectorGOInited, slot0)
	slot0._scene.view:unregisterCallback(SummonSceneEvent.OnViewFinish, slot0._onViewReady, slot0)
	VirtualSummonScene.instance:unregisterCallback(SummonSceneEvent.OnPreloadFinish, slot0._onPreloadFinish, slot0)

	slot0._drawCompChar = nil
	slot0._drawCompEquip = nil
	slot0._allStepReady = false
	slot0._hasCharPreload = false
	slot0._hasEquipPreload = false
end

function slot0.onSceneHide(slot0)
	slot0:onSceneClose()
end

return slot0
