module("modules.logic.versionactivity1_4.act131.view.Activity131MapElement", package.seeall)

slot0 = class("Activity131MapElement", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._info = slot1[1]
	slot0._config = Activity131Config.instance:getActivity131ElementCo(VersionActivity1_4Enum.ActivityId.Role6, slot0._info.elementId)
	slot0._stageMap = slot1[2]
end

function slot0.updateInfo(slot0, slot1)
	slot0._info = slot1
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._transform = slot1.transform
end

function slot0.dispose(slot0, slot1)
	if slot0._lightGo then
		gohelper.destroy(slot0._lightGo)
	end

	if slot1 and slot0._itemGo then
		gohelper.destroy(slot0._itemGo)

		return
	end

	if slot0._itemGo and slot0._itemGo:GetComponent(typeof(UnityEngine.BoxCollider2D)) then
		slot2.enabled = false
	end
end

function slot0.disappear(slot0, slot1)
	if string.nilorempty(slot0._config.res) then
		slot1 = false
	end

	slot0._isDisappear = true

	if not slot1 then
		if slot0._lightGo then
			slot0:_lightFadeOut(slot0.dispose)

			return
		end

		slot0:dispose()

		return
	end

	slot0:_fadeOut()
end

function slot0._fadeOut(slot0)
	slot0:_initMats()

	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.8, slot0._frameUpdate, slot0._fadeOutFinish, slot0)

	slot0:_lightFadeOut()
end

function slot0._fadeOutFinish(slot0)
	slot0:dispose()
end

function slot0._lightFadeOut(slot0)
	if slot0._lightGo then
		slot0._lightAnimator:Play("out", 0, 0)
		TaskDispatcher.runDelay(slot0.dispose, slot0, 0.37)
	end
end

function slot0.getResName(slot0)
	return slot0._config.res
end

function slot0._loadRes(slot0)
	if slot0._resLoader then
		return
	end

	slot0._lightPath = "scenes/v1a4_m_s12_37jshd/prefab/v1a4_m_s12_kejiaohu_light.prefab"
	slot0._resLoader = MultiAbLoader.New()

	slot0._resLoader:addPath(slot0._lightPath)
	slot0._resLoader:startLoad(slot0._onResLoaded, slot0)

	return true
end

function slot0.isValid(slot0)
	return not gohelper.isNil(slot0._go) and not slot0._isDisappear and slot0._info:isAvailable()
end

function slot0.onDown(slot0)
	slot0:_onDown()
end

function slot0._onDown(slot0)
	slot0._stageMap:setElementDown(slot0)
end

function slot0.onClick(slot0)
	slot0._info = Activity131Model.instance:getCurMapElementInfo(slot0._info.elementId)

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnClickElement, slot0)
end

function slot0.setItemGo(slot0, slot1, slot2)
	if string.nilorempty(slot0._config.res) then
		slot2 = false
	end

	slot0._isFadeIn = slot2

	gohelper.setActive(slot1, true)

	slot0._itemGo = slot1

	if not slot0:_loadRes() then
		slot0:_checkFadeIn()
	end

	if not string.nilorempty(slot0._config.type) then
		uv0.addBoxColliderListener(slot0._itemGo, slot0._onDown, slot0)
	end
end

function slot0._checkFadeIn(slot0)
	slot0:_initMats()

	if slot0._isFadeIn then
		slot0:_frameUpdate(1)
	end
end

function slot0._frameUpdate(slot0, slot1)
	if not slot0._mats then
		return
	end

	for slot5, slot6 in ipairs(slot0._mats) do
		if slot6:HasProperty("_MainCol") then
			slot7 = slot6:GetColor("_MainCol")
			slot7.a = slot1

			slot6:SetColor("_MainCol", slot7)
		end
	end
end

function slot0._initMats(slot0)
	if slot0._mats then
		return
	end

	slot0._mats = {}

	for slot5 = 0, slot0._itemGo:GetComponentsInChildren(typeof(UnityEngine.Renderer)).Length - 1 do
		table.insert(slot0._mats, slot1[slot5].material)
	end
end

function slot0._onResLoaded(slot0, slot1)
	if slot0._config.skipFinish == 1 then
		return
	end

	slot0:_addLightEffect()
end

function slot0._addLightEffect(slot0)
	if slot0._lightPath then
		slot0._lightGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._lightPath):GetResource(slot0._lightPath), slot0._go)
		slot3, slot4 = transformhelper.getLocalPos(slot0._itemGo.transform)

		transformhelper.setLocalPos(slot0._lightGo.transform, slot3, slot4, 0)

		slot0._lightAnimator = slot0._lightGo:GetComponent(typeof(UnityEngine.Animator))

		slot0._lightAnimator:Play("in", 0, 0)
	end
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onStart(slot0)
end

function slot0.addBoxCollider2D(slot0)
	ZProj.BoxColliderClickListener.Get(slot0):SetIgnoreUI(true)

	if slot0:GetComponent(typeof(UnityEngine.Collider2D)) then
		slot2.enabled = false
		slot2.enabled = true

		return slot1
	end

	slot3 = gohelper.onceAddComponent(slot0, typeof(UnityEngine.BoxCollider2D))
	slot3.enabled = false
	slot3.enabled = true
	slot3.size = Vector2(1.5, 1.5)

	return slot1
end

function slot0.addBoxColliderListener(slot0, slot1, slot2)
	uv0.addBoxCollider2D(slot0):AddClickListener(slot1, slot2)
end

function slot0.refreshClick(slot0)
	if slot0._itemGo:GetComponent(typeof(UnityEngine.BoxCollider2D)) then
		slot1.enabled = false
		slot1.enabled = true
	end
end

function slot0.onDestroy(slot0)
	if slot0._resLoader then
		slot0._resLoader:dispose()

		slot0._resLoader = nil
	end

	TaskDispatcher.cancelTask(slot0.dispose, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._mats then
		for slot4, slot5 in pairs(slot0._mats) do
			rawset(slot0._mats, slot4, nil)
		end

		slot0._mats = nil
	end
end

return slot0
