module("modules.logic.summon.pool.SummonEffectWrap", package.seeall)

slot0 = class("SummonEffectWrap", LuaCompBase)

function slot0.ctor(slot0)
	slot0.uniqueId = nil
	slot0.path = nil
	slot0.containerGO = nil
	slot0.containerTr = nil
	slot0.effectGO = nil
	slot0.hangPointGO = nil
	slot0._canDestroy = false
	slot0._animator = nil
	slot0._animationName = nil
	slot0._headLoader = nil
	slot0._frameLoader = nil
	slot0._active = true
end

function slot0.init(slot0, slot1)
	slot0.containerGO = slot1
	slot0.containerTr = slot1.transform
end

function slot0.setAnimationName(slot0, slot1)
	slot0._animationName = slot1
end

function slot0.play(slot0)
	if slot0.effectGO then
		slot0:setActive(true)
	end

	if slot0._animator and not string.nilorempty(slot0._animationName) then
		slot0._animator.enabled = true

		slot0._animator:Play(slot0._animationName, 0, 0)
		slot0._animator:Update(0)

		slot0._animator.speed = 1
	end
end

function slot0.stop(slot0)
	if slot0._animator and not string.nilorempty(slot0._animationName) then
		slot0._animator.enabled = true

		slot0._animator:Play(slot0._animationName, 0, 0)
		slot0._animator:Update(0)

		slot0._animator.speed = 0
	end

	if slot0.effectGO then
		slot0:setActive(false)
	end
end

function slot0.setUniqueId(slot0, slot1)
	slot0.uniqueId = slot1
end

function slot0.setPath(slot0, slot1)
	slot0.path = slot1
end

function slot0.setEffectGO(slot0, slot1)
	slot0.effectGO = slot1
	slot0._animator = slot1:GetComponentInChildren(typeof(UnityEngine.Animator))
	slot0._timeScaleComp = nil
	slot0._particleList = nil
end

function slot0.setHangPointGO(slot0, slot1)
	if slot0.hangPointGO ~= slot1 then
		slot0.hangPointGO = slot1

		slot0.containerGO.transform:SetParent(slot0.hangPointGO.transform, true)
		transformhelper.setLocalPos(slot0.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalRotation(slot0.containerGO.transform, 0, 0, 0)
		transformhelper.setLocalScale(slot0.containerGO.transform, 1, 1, 1)
	end
end

function slot0.setActive(slot0, slot1)
	slot0._active = slot1

	if slot0.containerGO then
		gohelper.setActive(slot0.containerGO, slot1)
	else
		logError("Effect container is nil, setActive fail: " .. slot0.path)
	end
end

function slot0.loadHeroIcon(slot0, slot1)
	if not SummonEnum.UIMaterialPath[slot0.path] or #slot2 <= 0 then
		return
	end

	if not (HeroConfig.instance:getHeroCO(slot1).skinId and SkinConfig.instance:getSkinCo(slot4)) then
		return
	end

	slot0:loadHeadTex(ResUrl.getHeadIconSmall(slot5.headIcon))
end

function slot0.loadEquipIcon(slot0, slot1)
	if not EquipConfig.instance:getEquipCo(slot1) then
		return
	end

	slot0:loadHeadTex(ResUrl.getEquipIconSmall(slot2.icon))
end

function slot0.setEquipFrame(slot0, slot1)
	slot0:_loadFrameTex(slot1 and SummonEnum.EquipFloatIconFrameOpened or SummonEnum.EquipFloatIconFrameBeforeOpen)
end

function slot0.loadEquipWaitingClick(slot0)
	slot0:loadHeadTex(SummonEnum.EquipDefaultIconPath)
end

function slot0.loadHeadTex(slot0, slot1)
	if slot0._headLoader then
		slot0._headLoader:dispose()

		slot0._headLoader = nil
		slot0._urlHead = nil
	end

	slot0._urlHead = slot1
	slot0._headLoader = MultiAbLoader.New()

	slot0._headLoader:addPath(slot1)
	slot0._headLoader:startLoad(slot0._onHeadIconLoaded, slot0)
end

function slot0._onHeadIconLoaded(slot0, slot1)
	if not slot0._headLoader:getAssetItem(slot0._urlHead) then
		return
	end

	for slot8, slot9 in ipairs(SummonEnum.UIMaterialPath[slot0.path]) do
		if gohelper.findChild(slot0.effectGO, slot9) and slot10:GetComponent(typeof(UnityEngine.MeshRenderer)) then
			slot11.material:SetTexture("_MainTex", slot2:GetResource(slot0._urlHead))
		end
	end
end

function slot0._loadFrameTex(slot0, slot1)
	if slot0._frameLoader then
		slot0._frameLoader:dispose()

		slot0._frameLoader = nil
		slot0._urlFrame = nil
	end

	slot0._urlFrame = slot1
	slot0._frameLoader = MultiAbLoader.New()

	slot0._frameLoader:addPath(slot1)
	slot0._frameLoader:startLoad(slot0._onFrameTexLoaded, slot0)
end

function slot0._onFrameTexLoaded(slot0, slot1)
	if not slot0._frameLoader:getAssetItem(slot0._urlFrame) then
		return
	end

	if gohelper.findChild(slot0.effectGO, SummonEnum.EquipFloatIconFrameNode) and slot5:GetComponent(typeof(UnityEngine.MeshRenderer)) then
		slot6.material:SetTexture("_MainTex", slot2:GetResource(slot0._urlFrame))
	end
end

function slot0.unloadIcon(slot0)
	if slot0._headLoader then
		slot0._headLoader:dispose()

		slot0._headLoader = nil
	end

	if not SummonEnum.UIMaterialPath[slot0.path] or #slot1 <= 0 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if gohelper.findChild(slot0.effectGO, slot6) and slot7:GetComponent(typeof(UnityEngine.MeshRenderer)) then
			slot8.material:SetTexture("_MainTex", nil)
		end
	end
end

function slot0.setSpeed(slot0, slot1)
	slot0:checkInitSpeedComponents()
	slot0._timeScaleComp:SetTimeScale(slot1)
end

function slot0.checkInitSpeedComponents(slot0)
	if gohelper.isNil(slot0._timeScaleComp) then
		slot0._timeScaleComp = gohelper.onceAddComponent(slot0.effectGO, typeof(ZProj.EffectTimeScale))
	end
end

function slot0.markCanDestroy(slot0)
	slot0._canDestroy = true
end

function slot0.getIsActive(slot0)
	return slot0._active == true
end

function slot0.startParticle(slot0)
	slot0:checkInitParticle()

	for slot4, slot5 in ipairs(slot0._particleList) do
		slot5:Play()
	end
end

function slot0.stopParticle(slot0)
	slot0:checkInitParticle()

	for slot4, slot5 in ipairs(slot0._particleList) do
		slot5:Stop()
	end
end

function slot0.checkInitParticle(slot0)
	if not slot0._particleList then
		slot0._particleList = slot0:getUserDataTb_()

		if not gohelper.isNil(slot0.effectGO) then
			slot2 = slot0.effectGO:GetComponentsInChildren(typeof(UnityEngine.ParticleSystem), true):GetEnumerator()

			while slot2:MoveNext() do
				table.insert(slot0._particleList, slot2.Current)
			end
		end
	end
end

function slot0.onDestroy(slot0)
	if not slot0._canDestroy then
		logError("Effect destroy unexpected: " .. slot0.path)
	end

	slot0.containerGO = nil
	slot0.effectGO = nil
	slot0.hangPointGO = nil
	slot0._particleList = nil

	if slot0._headLoader then
		slot0._headLoader:dispose()

		slot0._headLoader = nil
	end

	if slot0._frameLoader then
		slot0._frameLoader:dispose()

		slot0._frameLoader = nil
	end
end

return slot0
