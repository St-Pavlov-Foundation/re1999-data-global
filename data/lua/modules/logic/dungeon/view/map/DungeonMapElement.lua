module("modules.logic.dungeon.view.map.DungeonMapElement", package.seeall)

slot0 = class("DungeonMapElement", LuaCompBase)
slot0.InAnimName = "wenhao_a_001_in"

function slot0.ctor(slot0, slot1)
	slot0._config = slot1[1]
	slot0._mapScene = slot1[2]
	slot0._sceneElements = slot1[3]
end

function slot0.getElementId(slot0)
	return slot0._config.id
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._transform = slot1.transform

	transformhelper.setLocalPos(slot0._transform, string.splitToNumber(slot0._config.pos, "#")[1] or 0, slot2[2] or 0, slot2[3] or 0)

	if slot0._resLoader then
		return
	end

	slot0._resLoader = MultiAbLoader.New()

	if not string.nilorempty(slot0._config.res) then
		slot0._resLoader:addPath(slot0._config.res)
	end

	slot0._effectPath = slot0._config.effect

	if not string.nilorempty(slot0._effectPath) then
		slot0._resLoader:addPath(slot0._effectPath)
	end

	slot0._exEffectPath = DungeonEnum.ElementExEffectPath[slot0:getElementId()]

	if slot0._exEffectPath then
		slot0._resLoader:addPath(slot0._exEffectPath)
	end

	slot0._resLoader:startLoad(slot0._onResLoaded, slot0)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0._go, false)
end

function slot0.show(slot0)
	gohelper.setActive(slot0._go, true)
end

function slot0.getVisible(slot0)
	return not gohelper.isNil(slot0._go) and slot0._go.activeSelf
end

function slot0.hasEffect(slot0)
	return slot0._effectPath
end

function slot0.showArrow(slot0)
	return slot0._config.showArrow == 1
end

function slot0.isValid(slot0)
	return not gohelper.isNil(slot0._go)
end

function slot0.setWenHaoGoVisible(slot0, slot1)
	slot0._wenhaoVisible = slot1

	gohelper.setActive(slot0._wenhaoGo, slot1)
end

function slot0.setWenHaoVisible(slot0, slot1)
	if slot0._config.type == DungeonEnum.ElementType.ToughBattle then
		return
	end

	slot0._itemGoVisible = slot1

	if slot1 then
		slot0:setWenHaoAnim(uv0.InAnimName)
	else
		gohelper.setActive(slot0._itemGo, slot0._itemGoVisible)
		slot0:setWenHaoAnim("wenhao_a_001_out")
	end
end

function slot0.setWenHaoAnim(slot0, slot1)
	slot0._wenhaoAnimName = slot1

	if gohelper.isNil(slot0._wenhaoGo) then
		return
	end

	if not slot0._wenhaoGo.activeInHierarchy then
		slot0:_wenHaoAnimDone()

		return
	end

	if slot0._wenhaoAnimator == nil then
		if slot0._wenhaoGo:GetComponent(typeof(UnityEngine.Animator)) then
			slot0._wenhaoAnimator = SLFramework.AnimatorPlayer.Get(slot0._wenhaoGo)
		else
			slot0._wenhaoAnimator = false
		end
	end

	if slot0._wenhaoAnimator and slot0._wenhaoAnimator.animator:HasState(0, UnityEngine.Animator.StringToHash(slot1)) then
		slot0._wenhaoAnimator:Play(slot1, slot0._wenHaoAnimDone, slot0)
	else
		slot0:_wenHaoAnimDone()
	end
end

function slot0._wenHaoAnimDone(slot0)
	if slot0._wenhaoAnimator then
		slot0._wenhaoAnimator.animator.enabled = true
	end

	if slot0._wenhaoAnimName == "finish" then
		gohelper.destroy(slot0._go)
		DungeonController.instance:dispatchEvent(DungeonMapElementEvent.OnFinishAndDisposeElement, slot0._config)
	end

	if slot0._wenhaoAnimName == uv0.InAnimName then
		gohelper.setActive(slot0._itemGo, slot0._itemGoVisible)
	end
end

function slot0._destroyGo(slot0)
	gohelper.destroy(slot0._go)
end

function slot0._destroyItemGo(slot0)
	gohelper.destroy(slot0._itemGo)
end

function slot0.getItemGo(slot0)
	return slot0._itemGo
end

function slot0.setFinish(slot0)
	if not slot0._wenhaoGo or slot0._config and slot0._config.type == DungeonEnum.ElementType.ToughBattle then
		slot0:_destroyGo()

		return
	end

	slot0:setWenHaoAnim("finish")
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)
	TaskDispatcher.runDelay(slot0._destroyItemGo, slot0, 0.77)
	TaskDispatcher.runDelay(slot0._destroyGo, slot0, 1.6)
end

function slot0.setFinishAndDotDestroy(slot0)
	if not slot0._wenhaoGo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementdisappear)

	if slot0.finishGo then
		gohelper.setActive(slot0.finishGo, true)

		slot0.animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.finishGo)

		slot0.animatorPlayer:Play(UIAnimationName.Open, slot0.setFinishAndDotDestroyAnimationDone, slot0)
	else
		slot0:dispose()
	end
end

function slot0.setFinishAndDotDestroyAnimationDone(slot0)
	slot0.animatorPlayer:Play(UIAnimationName.Idle, function ()
	end, slot0)
	slot0:dispose()
end

function slot0.onDown(slot0)
	slot0:_onDown()
end

function slot0._onDown(slot0)
	slot0._sceneElements:setElementDown(slot0)
end

function slot0.onClick(slot0)
	slot0._sceneElements:clickElement(slot0._config.id)
end

function slot0._onResLoaded(slot0)
	DungeonController.instance:registerCallback(DungeonEvent.OnSetEpisodeListVisible, slot0._onSetEpisodeListVisible, slot0)

	if not string.nilorempty(slot0._config.res) then
		slot0._itemGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._config.res):GetResource(slot0._config.res), slot0._go)

		if slot0._config.resScale and slot3 ~= 0 then
			transformhelper.setLocalScale(slot0._itemGo.transform, slot3, slot3, 1)
		end

		gohelper.setLayer(slot0._itemGo, UnityLayer.Scene, true)
		uv0.addBoxColliderListener(slot0._itemGo, slot0._onDown, slot0)
		transformhelper.setLocalPos(slot0._itemGo.transform, 0, 0, -1)
	end

	if not string.nilorempty(slot0._effectPath) then
		slot0._offsetX = string.splitToNumber(slot0._config.tipOffsetPos, "#")[1] or 0
		slot0._offsetY = slot1[2] or 0
		slot0._offsetZ = slot1[3] or -3
		slot0._wenhaoGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._effectPath):GetResource(slot0._effectPath), slot0._go)

		if slot0._wenhaoVisible == false then
			slot0:setWenHaoGoVisible(false)
		end

		uv0.addBoxColliderListener(slot0._wenhaoGo, slot0._onDown, slot0)
		transformhelper.setLocalPos(slot0._wenhaoGo.transform, slot0._offsetX, slot0._offsetY, slot0._offsetZ)

		slot0.finishGo = gohelper.findChild(slot0._wenhaoGo, "ani/yuanjian_new_07/gou")

		gohelper.setActive(slot0.finishGo, false)

		if slot0._mapScene:showInteractiveItem() then
			slot0:setWenHaoVisible(false)
		elseif slot0._wenhaoAnimName then
			slot0:setWenHaoAnim(slot0._wenhaoAnimName)
		end

		if string.find(slot0._effectPath, "hddt_front_lubiao_a_002") then
			slot6 = gohelper.findChild(slot0._wenhaoGo, "ani/plane"):GetComponent(typeof(UnityEngine.Renderer)).material
			slot7 = slot6:GetVector("_Frame")
			slot7.w = DungeonEnum.ElementTypeIconIndex[string.format("%s0", slot0._config.type)]

			slot6:SetVector("_Frame", slot7)
		end
	end

	if slot0._exEffectPath then
		slot0._exEffectGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._exEffectPath):GetResource(slot0._exEffectPath), slot0._go)

		transformhelper.setLocalPos(slot0._exEffectGo.transform, 0, 0, 0)
	end

	if slot0._config.param == tostring(DungeonMapModel.instance.lastElementBattleId) then
		DungeonMapModel.instance.lastElementBattleId = nil

		slot0:_clickDirect()
	end
end

function slot0._onAddAnimDone(slot0)
	if slot0._config.type == DungeonEnum.ElementType.ToughBattle then
		if (tonumber(slot0._config.param) or 0) == 0 then
			if ToughBattleModel.instance:getStoryInfo() then
				slot0:_checkToughBattleIsFinish()
			else
				slot0._waitId = SiegeBattleRpc.instance:sendGetSiegeBattleInfoRequest(slot0._checkToughBattleIsFinish, slot0)
			end
		elseif ToughBattleModel.instance:getIsJumpActElement() then
			slot0:_delayClick(1)
		end
	end
end

function slot0._checkToughBattleIsFinish(slot0)
	slot0._waitId = nil

	if ToughBattleModel.instance:isStoryFinish() then
		slot0:_delayClick(0.5)
	end
end

function slot0._delayClick(slot0, slot1)
	UIBlockHelper.instance:startBlock("DungeonMapElementDelayClick", slot1, ViewName.DungeonMapView)
	TaskDispatcher.runDelay(slot0._clickDirect, slot0, slot1)
end

function slot0._clickDirect(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.SkipClickElement) then
		return
	end

	DungeonMapModel.instance.directFocusElement = true

	slot0:onClick()

	DungeonMapModel.instance.directFocusElement = false
end

function slot0._onSetEpisodeListVisible(slot0, slot1)
	slot0:setWenHaoVisible(slot1)
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnSetEpisodeListVisible, slot0._onSetEpisodeListVisible, slot0)
end

function slot0.onStart(slot0)
end

function slot0.addBoxCollider2D(slot0)
	slot1 = ZProj.BoxColliderClickListener.Get(slot0)

	if not slot0:GetComponent(typeof(UnityEngine.BoxCollider2D)) then
		gohelper.onceAddComponent(slot0, typeof(UnityEngine.BoxCollider2D)).size = Vector2(1.5, 1.5)
	end

	slot2.enabled = true

	slot1:SetIgnoreUI(true)

	return slot1
end

function slot0.addBoxColliderListener(slot0, slot1, slot2)
	uv0.addBoxCollider2D(slot0):AddClickListener(slot1, slot2)
end

function slot0.getTransform(slot0)
	return slot0._transform
end

function slot0.dispose(slot0)
	slot0._itemGo = nil
	slot0._wenhaoGo = nil
	slot0._go = nil
	slot0.animatorPlayer = nil

	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	TaskDispatcher.cancelTask(slot0._destroyItemGo, slot0)
	TaskDispatcher.cancelTask(slot0._destroyGo, slot0)
end

function slot0.onDestroy(slot0)
	if slot0._itemGo then
		gohelper.destroy(slot0._itemGo)

		slot0._itemGo = nil
	end

	if slot0._wenhaoGo then
		gohelper.destroy(slot0._wenhaoGo)

		slot0._wenhaoGo = nil
	end

	if slot0._go then
		gohelper.destroy(slot0._go)

		slot0._go = nil
	end

	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	if slot0.animatorPlayer then
		slot0.animatorPlayer = nil
	end

	if slot0._waitId then
		SiegeBattleRpc.instance:removeCallbackById(slot0._waitId)

		slot0._waitId = nil
	end

	TaskDispatcher.cancelTask(slot0._clickDirect, slot0)
	TaskDispatcher.cancelTask(slot0._destroyItemGo, slot0)
	TaskDispatcher.cancelTask(slot0._destroyGo, slot0)
end

return slot0
