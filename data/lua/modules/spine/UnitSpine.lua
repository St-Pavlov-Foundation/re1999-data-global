module("modules.spine.UnitSpine", package.seeall)

slot0 = class("UnitSpine", LuaCompBase)
slot0.TypeSkeletonAnimtion = typeof(Spine.Unity.SkeletonAnimation)
slot0.TypeSpineAnimationEvent = typeof(ZProj.SpineAnimationEvent)
slot0.Evt_OnLoaded = 100001

function slot0.Create(slot0)
	return MonoHelper.addNoUpdateLuaComOnceToGo(slot0, uv0)
end

function slot0.ctor(slot0, slot1)
	slot0.unitSpawn = slot1

	LuaEventSystem.addEventMechanism(slot0)
end

function slot0.init(slot0, slot1)
	slot0._gameObj = slot1
	slot0._gameTr = slot1.transform
	slot0._resLoader = nil
	slot0._resPath = nil
	slot0._skeletonAnim = nil
	slot0._spineRenderer = nil
	slot0._ppEffectMask = nil
	slot0._spineGo = nil
	slot0._spineTr = nil
	slot0._curAnimState = nil
	slot0._defaultAnimState = SpineAnimState.idle1
	slot0._isLoop = false
	slot0._lookDir = SpineLookDir.Left
	slot0._timeScale = 1
	slot0._bFreeze = false
	slot0._layer = UnityLayer.Unit
	slot0._actionCbList = {}
	slot0._resLoadedCb = nil
	slot0._resLoadedCbObj = nil
end

function slot0.setResPath(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	if slot0.resPath == slot1 then
		return
	end

	slot0:_clear()

	slot0._resPath = slot1
	slot0._resLoadedCb = slot2
	slot0._resLoadedCbObj = slot3

	if FightSpinePool.getSpine(slot0._resPath) then
		if gohelper.isNil(slot0._gameObj) then
			logError("try move spine, but parent is nil, spine name : " .. tostring(slot4.name))
		end

		gohelper.addChild(slot0._gameObj, slot4)
		transformhelper.setLocalPos(slot4.transform, 0, 0, 0)
		slot0:_initSpine(slot4)
	else
		slot0._resLoader = MultiAbLoader.New()

		slot0._resLoader:addPath(slot0._resPath)
		slot0._resLoader:startLoad(slot0._onResLoaded, slot0)
	end
end

function slot0.setFreeze(slot0, slot1)
	slot0._bFreeze = slot1

	if slot0._skeletonAnim then
		slot0._skeletonAnim.freeze = slot0._bFreeze
	end
end

function slot0.setTimeScale(slot0, slot1)
	slot0._timeScale = slot1

	if slot0._skeletonAnim then
		slot0._skeletonAnim.timeScale = slot0._timeScale
	end
end

function slot0._clear(slot0)
	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	if slot0._csSpineEvt then
		slot0._csSpineEvt:RemoveAnimEventCallback()
	end

	slot0._skeletonAnim = nil
	slot0._resPath = nil
	slot0._spineGo = nil
	slot0._spineTr = nil
	slot0._bFreeze = false
	slot0._isActive = true
	slot0._renderOrder = nil
end

function slot0._onResLoaded(slot0, slot1)
	if gohelper.isNil(slot0._gameObj) then
		return
	end

	if slot1:getFirstAssetItem() then
		slot0:_initSpine(gohelper.clone(slot2:GetResource(), slot0._gameObj))
	end
end

function slot0._initSpine(slot0, slot1)
	slot0._spineGo = slot1
	slot0._spineTr = slot0._spineGo.transform

	slot0:setLayer(slot0._layer, true)

	slot0._skeletonAnim = slot0._spineGo:GetComponent(uv0.TypeSkeletonAnimtion)

	if slot0._lookDir == SpineLookDir.Right then
		slot0._skeletonAnim.initialFlipX = true

		slot0._skeletonAnim:Initialize(true)
	else
		slot0._skeletonAnim:Initialize(false)
	end

	slot0._skeletonAnim.freeze = slot0._bFreeze
	slot0._skeletonAnim.timeScale = slot0._timeScale
	slot0._spineRenderer = slot0._spineGo:GetComponent(typeof(UnityEngine.MeshRenderer))
	slot0._ppEffectMask = slot0._spineGo:GetComponent(typeof(UrpCustom.PPEffectMask))
	slot0._csSpineEvt = gohelper.onceAddComponent(slot0._spineGo, uv0.TypeSpineAnimationEvent)

	slot0._csSpineEvt:SetAnimEventCallback(slot0._onAnimCallback, slot0)
	slot0:setActive(slot0._isActive)

	if slot0._curAnimState then
		slot0._curAnimState = nil

		slot0:play(slot0._curAnimState, slot0._isLoop)
	elseif slot0._defaultAnimState and slot0._skeletonAnim:HasAnimation(slot0._defaultAnimState) then
		slot0._isLoop = true

		slot0:play(slot0._defaultAnimState, slot0._isLoop, true)
	end

	slot0:setRenderOrder(slot0._renderOrder, true)

	if slot0._resLoadedCb and slot0._resLoadedCbObj then
		slot0._resLoadedCb(slot0._resLoadedCbObj, slot0)
	end

	slot0._resLoadedCb = nil
	slot0._resLoadedCbObj = nil

	slot0:dispatchEvent(uv0.Evt_OnLoaded)
end

function slot0.setLayer(slot0, slot1, slot2)
	slot0._layer = slot1

	if not gohelper.isNil(slot0._spineGo) then
		gohelper.setLayer(slot0._spineGo, slot0._layer, slot2)
	end
end

function slot0.getSpineGO(slot0)
	return slot0._spineGo
end

function slot0.getSpineTr(slot0)
	return slot0._spineTr
end

function slot0.getSkeletonAnim(slot0)
	return slot0._skeletonAnim
end

function slot0.getAnimState(slot0)
	return slot0._curAnimState or slot0._defaultAnimState
end

function slot0.getPPEffectMask(slot0)
	return slot0._ppEffectMask
end

function slot0.setRenderOrder(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0._renderOrder = slot1

	if not slot2 and slot1 == slot0._renderOrder then
		return
	end

	if not gohelper.isNil(slot0._spineRenderer) then
		slot0._spineRenderer.sortingOrder = slot1
	end
end

function slot0.changeLookDir(slot0, slot1)
	if slot1 == slot0._lookDir then
		return
	end

	slot0._lookDir = slot1

	slot0:_changeLookDir()
end

function slot0._changeLookDir(slot0)
	if slot0._skeletonAnim then
		slot0._skeletonAnim:SetScaleX(slot0._lookDir)
	end
end

function slot0.getLookDir(slot0)
	return slot0._lookDir
end

function slot0.setActive(slot0, slot1)
	if slot0._spineGo then
		gohelper.setActive(slot0._spineGo, slot1)
	else
		slot0._isActive = slot1
	end
end

function slot0.play(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	slot0._curAnimState = slot1
	slot0._isLoop = slot2 or false

	if slot0._skeletonAnim and (slot3 or slot1 ~= slot0._curAnimState or slot2 ~= slot0._isLoop) then
		if slot0._skeletonAnim:HasAnimation(slot1) then
			slot0:playAnim(slot1, slot0._isLoop, slot3 or false)
		else
			if isDebugBuild then
				slot5 = not gohelper.isNil(slot0._spineGo) and slot0._spineGo.name or "spine_nil"

				logError(string.format("%s 缺少动作: %s", string.find(slot5, "(Clone)", 1) and string.sub(slot5, 1, slot6 - 2) or slot5, slot1))
			end

			slot0:playAnim(SpineAnimState.idle1, true, true)
		end
	end
end

function slot0.hasAnimation(slot0, slot1)
	if slot0._skeletonAnim then
		return slot0._skeletonAnim:HasAnimation(slot1)
	end

	return false
end

function slot0.playAnim(slot0, slot1, slot2, slot3)
	slot0._skeletonAnim:PlayAnim(slot1, slot2, slot3)
end

function slot0.setAnimation(slot0, slot1, slot2, slot3)
	if slot0._skeletonAnim then
		slot0._curAnimState = slot1
		slot0._isLoop = slot2 or false

		slot0._skeletonAnim:SetAnimation(0, slot1, slot2, slot3 or 0)
	end
end

function slot0.addAnimEventCallback(slot0, slot1, slot2, slot3)
	if not slot1 then
		return
	end

	for slot7, slot8 in ipairs(slot0._actionCbList) do
		if slot8[1] == slot1 and slot8[2] == slot2 then
			slot8[3] = slot3

			return
		end
	end

	table.insert(slot0._actionCbList, {
		slot1,
		slot2,
		slot3
	})
end

function slot0.removeAnimEventCallback(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._actionCbList) do
		if slot7[1] == slot1 and slot7[2] == slot2 then
			table.remove(slot0._actionCbList, slot6)

			break
		end
	end
end

function slot0.removeAllAnimEventCallback(slot0)
	slot0._actionCbList = {}
end

function slot0._onAnimCallback(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot0._actionCbList) do
		if slot8[2] then
			slot8[1](slot10, slot1, slot2, slot3, slot8[3])
		else
			slot9(slot1, slot2, slot3, slot11)
		end
	end
end

function slot0.logNilGameObj(slot0)
end

function slot0.onDestroy(slot0)
	slot0:_clear()

	slot0._resLoader = nil
	slot0._csSpineEvt = nil
end

return slot0
