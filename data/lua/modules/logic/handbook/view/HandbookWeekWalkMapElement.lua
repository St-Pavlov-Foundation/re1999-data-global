module("modules.logic.handbook.view.HandbookWeekWalkMapElement", package.seeall)

slot0 = class("HandbookWeekWalkMapElement", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.parentView = slot1.parentView
	slot0.diffuseGo = slot1.diffuseGo
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.transform = slot1.transform
end

function slot0.updateInfo(slot0, slot1)
	slot0.elementId = slot1

	slot0:updateConfig(WeekWalkConfig.instance:getElementConfig(slot1))
end

function slot0.updateConfig(slot0, slot1)
	slot0.config = slot1
end

function slot0.dispose(slot0)
	gohelper.setActive(slot0._itemGo, false)
	gohelper.destroy(slot0.go)
end

function slot0.fadeOut(slot0)
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.8, slot0._frameUpdate, slot0._fadeOutFinish, slot0)
end

function slot0.fadeIn(slot0)
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.8, slot0._frameUpdate, slot0._fadeInFinish, slot0)
end

function slot0._fadeInFinish(slot0)
	slot0:_frameUpdate(1)
end

function slot0._fadeOutFinish(slot0)
	slot0:dispose()
end

function slot0._frameUpdate(slot0, slot1)
	if not slot0._color then
		return
	end

	slot0._color.a = slot1

	for slot5, slot6 in ipairs(slot0._mats) do
		slot6:SetColor("_MainCol", slot0._color)
	end
end

function slot0.getResName(slot0)
	return slot0._config.res
end

function slot0.refresh(slot0)
	if string.nilorempty(slot0:getResName()) then
		return
	end

	if not gohelper.findChild(slot0.diffuseGo, slot1) then
		logError(tostring(slot0.elementId) .. " no resGo:" .. tostring(slot1))
	end

	slot0.resItemGo = gohelper.clone(slot2, slot0.go, slot1)

	slot0:_loadEffectRes()

	slot0._mats = {}

	for slot7 = 0, slot0._itemGo:GetComponentsInChildren(typeof(UnityEngine.Renderer)).Length - 1 do
		table.insert(slot0._mats, slot3[slot7].material)

		if not slot0._color then
			slot0._color = slot8:GetColor("_MainCol")
		end
	end

	slot0:fadeIn()
end

function slot0._loadEffectRes(slot0)
	if slot0._resLoader then
		return
	end

	if not string.nilorempty(slot0._config.disappearEffect) then
		slot0._disappearEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", slot0._config.disappearEffect)
	end

	if string.nilorempty(slot0._config.effect) and not slot0._disappearEffectPath then
		return
	end

	slot0._resLoader = MultiAbLoader.New()

	if not string.nilorempty(slot0._config.effect) then
		slot0._resLoader:addPath(slot0._config.effect)
	end

	if slot0._disappearEffectPath then
		slot0._resLoader:addPath(slot0._disappearEffectPath)
	end

	slot0._resLoader:startLoad(slot0._onResLoaded, slot0)
end

function slot0._onResLoaded(slot0, slot1)
	if not string.nilorempty(slot0._config.effect) then
		slot0._offsetX = string.splitToNumber(slot0._config.tipOffsetPos, "#")[1] or 0
		slot0._offsetY = slot2[2] or 0
		slot0._wenhaoGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._config.effect):GetResource(slot0._config.effect), slot0._go)
		slot5, slot6 = transformhelper.getLocalPos(slot0.resItemGo.transform)

		transformhelper.setLocalPos(slot0._wenhaoGo.transform, slot5 + slot0._offsetX, slot6 + slot0._offsetY, -2)
	end
end

function slot0.setWenHaoVisible(slot0, slot1)
	if not slot0._wenhaoGo then
		return
	end

	if not slot0._wenhaoAnimator then
		slot0._wenhaoAnimator = slot0._wenhaoGo:GetComponent(typeof(UnityEngine.Animator))
	end

	if slot1 then
		slot0._wenhaoAnimator:Play("wenhao_a_001_in")
	else
		slot0._wenhaoAnimator:Play("wenhao_a_001_out")
	end
end

function slot0.hasEffect(slot0)
	return slot0._wenhaoGo
end

function slot0.onDestroy(slot0)
	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	slot0._mats = nil
	slot0._color = nil
end

return slot0
