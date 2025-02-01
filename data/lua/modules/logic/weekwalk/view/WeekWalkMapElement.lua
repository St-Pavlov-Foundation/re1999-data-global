module("modules.logic.weekwalk.view.WeekWalkMapElement", package.seeall)

slot0 = class("WeekWalkMapElement", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._info = slot1[1]
	slot0._config = slot0._info.config
	slot0._weekwalkMap = slot1[2]
	slot0._curMapInfo = WeekWalkModel.instance:getCurMapInfo()
	slot0._elementRes = slot0._info:getRes()

	slot0:_playBgm()
end

function slot0._playBgm(slot0)
	if slot0._info:getType() ~= WeekWalkEnum.ElementType.General then
		return
	end

	if slot0._config.generalType ~= WeekWalkEnum.GeneralType.Bgm then
		return
	end

	slot0._audioId = slot0._config.param

	slot0._weekwalkMap:_playBgm(slot0._audioId)
end

function slot0._stopBgm(slot0)
	if slot0._info:getType() ~= WeekWalkEnum.ElementType.General then
		return
	end

	if slot0._config.generalType ~= WeekWalkEnum.GeneralType.Bgm or not slot0._audioId then
		return
	end

	slot0._weekwalkMap:_stopBgm()

	slot0._audioId = nil
end

function slot0.updateInfo(slot0, slot1)
	slot0._info = slot1
end

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._transform = slot1.transform
end

function slot0.dispose(slot0)
	gohelper.setActive(slot0._itemGo, false)
	gohelper.destroy(slot0._go)

	if not string.nilorempty(slot0._config.smokeMaskOffset) then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnRemoveSmokeMask, slot0._config.id)
	end

	slot0:_stopBgm()
end

function slot0.disappear(slot0, slot1)
	if string.nilorempty(slot0._elementRes) then
		slot1 = false
	end

	slot0:_stopBgm()

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

	slot0:_lightFadeOut(slot0._lightFadeOutDone)
end

function slot0._lightFadeOut(slot0, slot1)
	if slot0._lightGo then
		SLFramework.AnimatorPlayer.Get(slot0._lightGo):Play("weekwalk_deepdream_light_blend_out", slot1, slot0)
	end
end

function slot0._lightFadeOutDone(slot0)
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

function slot0._fadeOutFinish(slot0)
	slot0:dispose()
end

function slot0.getResName(slot0)
	return slot0._elementRes
end

function slot0._initStarEffect(slot0)
	if slot0._battleInfo.index == #slot0._curMapInfo.battleInfos then
		slot0._starEffect = string.format("scenes/m_s09_rgmy/prefab/s09_rgmy_star_red.prefab")
	else
		slot0._starEffect = string.format("scenes/m_s09_rgmy/prefab/s09_rgmy_star.prefab")
	end
end

function slot0._loadRes(slot0)
	if slot0._resLoader then
		return
	end

	if slot0._curMapInfo.isFinish > 0 and slot0._info:getType() == WeekWalkEnum.ElementType.Battle and slot1:getBattleInfo(slot0._info:getBattleId()) and slot3.star > 0 then
		slot0._battleInfo = slot3

		slot0:_initStarEffect()
	end

	if not string.nilorempty(slot0._config.disappearEffect) then
		slot0._disappearEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", slot0._config.disappearEffect)
	end

	if not string.nilorempty(slot0._config.lightOffsetPos) then
		if WeekWalkModel.isShallowMap(slot1.id) then
			slot0._lightPath = "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_light_blend.prefab"
		else
			slot0._lightPath = "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_light.prefab"
		end
	end

	if not string.nilorempty(slot0._config.smokeMaskOffset) then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnAddSmokeMask, slot0._config.id, slot2)
	end

	if slot0._elementRes == "s09_rgmy_c03_wuqi_a" or slot0._elementRes == "s09_rgmy_c04_wuqi_b" or slot0._elementRes == "s09_rgmy_c05_wuqi_c" then
		slot0._sceneEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", slot0._elementRes)
	end

	if string.nilorempty(slot0._config.effect) and not slot0._disappearEffectPath and not slot0._starEffect and not slot0._lightPath and not slot0._sceneEffectPath then
		return
	end

	slot0._resLoader = MultiAbLoader.New()

	if not string.nilorempty(slot0._config.effect) then
		slot0._resLoader:addPath(slot0._config.effect)
	end

	if slot0._disappearEffectPath then
		slot0._resLoader:addPath(slot0._disappearEffectPath)
	end

	if slot0._starEffect then
		slot0._resLoader:addPath(slot0._starEffect)
	end

	if slot0._lightPath then
		slot0._resLoader:addPath(slot0._lightPath)
	end

	if slot0._sceneEffectPath then
		slot0._resLoader:addPath(slot0._sceneEffectPath)
	end

	slot0._resLoader:startLoad(slot0._onResLoaded, slot0)

	return true
end

function slot0.isValid(slot0)
	return not gohelper.isNil(slot0._go) and not slot0._isDisappear and slot0._info:isAvailable()
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

function slot0.onDown(slot0)
	slot0:_onDown()
end

function slot0._onDown(slot0)
	slot0._weekwalkMap:setElementDown(slot0)
end

function slot0.onClick(slot0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickElement, slot0)
end

function slot0.hasEffect(slot0)
	return slot0._wenhaoGo
end

function slot0.setItemGo(slot0, slot1, slot2)
	if string.nilorempty(slot0._elementRes) then
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
		slot0:_frameUpdate(0)
		slot0:_fadeIn()
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

function slot0._fadeIn(slot0)
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.8, slot0._frameUpdate, slot0._fadeInFinish, slot0)
end

function slot0._fadeInFinish(slot0)
	slot0:_frameUpdate(1)
end

function slot0._onResLoaded(slot0, slot1)
	if not string.nilorempty(slot0._config.effect) then
		slot0._wenhaoGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._config.effect):GetResource(slot0._config.effect), slot0._go)
		slot7, slot8 = transformhelper.getLocalPos(slot0._itemGo.transform)

		transformhelper.setLocalPos(slot0._wenhaoGo.transform, slot7 + (string.splitToNumber(slot0._config.tipOffsetPos, "#")[1] or 0), slot8 + (slot2[2] or 0), -2)
	end

	if not slot0:noRemainStars() then
		slot0:_addStarEffect()
	end

	slot0:_addLightEffect()
	slot0:_addSceneEffect()
end

function slot0.noRemainStars(slot0)
	if not slot0._curMapInfo or slot1.isFinish <= 0 then
		return
	end

	slot2, slot3 = slot1:getCurStarInfo()

	return slot2 == slot3
end

function slot0._addStarEffect(slot0)
	if slot0._starEffect then
		slot2 = string.splitToNumber(slot0._config.starOffsetPos, "#")[1] or 0
		slot3 = slot1[2] or 0
		slot0._starGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._starEffect):GetResource(slot0._starEffect), slot0._go)

		if gohelper.findChildComponent(slot0._starGo, "text_number", typeof(TMPro.TextMeshPro)) then
			slot6.text = "0" .. slot0._battleInfo.index
		end

		slot8 = gohelper.findChild(slot0._starGo, "star2")
		slot9 = gohelper.findChild(slot0._starGo, "star3")
		slot10 = slot0._curMapInfo:getStarNumConfig() == 2

		gohelper.setActive(slot8, slot10)
		gohelper.setActive(slot9, not slot10)

		for slot15 = 1, slot7 do
			gohelper.setActive(gohelper.findChild(slot10 and slot8 or slot9, "star_highlight/star_highlight0" .. slot15), slot15 <= slot0._battleInfo.star)
		end

		if slot2 ~= 0 or slot3 ~= 0 then
			transformhelper.setLocalPos(slot0._starGo.transform, slot2, slot3, 0)
		else
			slot12, slot13 = transformhelper.getLocalPos(slot0._itemGo.transform)

			transformhelper.setLocalPos(slot0._starGo.transform, slot12 + slot2, slot13 + slot3, 0)
		end
	end
end

function slot0._addLightEffect(slot0)
	if slot0._lightPath then
		slot3 = slot1[2] or 0
		slot0._lightGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._lightPath):GetResource(slot0._lightPath), slot0._go)

		if (string.splitToNumber(slot0._config.lightOffsetPos, "#")[1] or 0) ~= 0 or slot3 ~= 0 then
			transformhelper.setLocalPos(slot0._lightGo.transform, slot2, slot3, 0)
		else
			slot6, slot7 = transformhelper.getLocalPos(slot0._itemGo.transform)

			transformhelper.setLocalPos(slot0._lightGo.transform, slot6 + slot2, slot7 + slot3, 0)
		end
	end
end

function slot0._addSceneEffect(slot0)
	if slot0._sceneEffectPath then
		slot0._sceneEffectGo = gohelper.clone(slot0._resLoader:getAssetItem(slot0._sceneEffectPath):GetResource(slot0._sceneEffectPath), gohelper.findChild(slot0._go, slot0._elementRes))
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
		slot2.enabled = true

		return slot1
	end

	slot3 = gohelper.onceAddComponent(slot0, typeof(UnityEngine.BoxCollider2D))
	slot3.enabled = true
	slot3.size = Vector2(1.5, 1.5)

	return slot1
end

function slot0.addBoxColliderListener(slot0, slot1, slot2)
	uv0.addBoxCollider2D(slot0):AddClickListener(slot1, slot2)
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
