module("modules.logic.story.view.StoryEffectItem", package.seeall)

slot0 = class("StoryEffectItem")

function slot0.init(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.viewGO = slot1
	slot0._effectPath = slot2
	slot0._effectGo = nil
	slot0._uieffectGo = nil
	slot0._effectCo = slot3
	slot0._fadeHelper = nil
	slot0._effOrder = slot4

	if slot3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(slot0._buildNormalEffect, slot0, slot3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		slot0:_buildNormalEffect()
	end
end

function slot0.reset(slot0, slot1, slot2, slot3)
	TaskDispatcher.cancelTask(slot0._buildNormalEffect, slot0)

	if not slot0._effectGo then
		return
	end

	slot0.viewGO = slot1
	slot0._effectCo = slot2
	slot0._effOrder = slot3

	slot0._effectGo.transform:SetParent(slot0._uieffectGo.transform, false)
	slot0._effectOrderContainer:SetBaseOrder(slot0._effOrder)
end

function slot0._buildNormalEffect(slot0)
	slot0._uieffectGo = gohelper.create2d(slot0.viewGO, "effect")
	slot0._canvas = gohelper.onceAddComponent(slot0._uieffectGo, typeof(UnityEngine.CanvasGroup))
	slot4 = slot1 / slot2 < 2 and 1 or 1080 * slot1 / (1920 * slot2 * (UnityEngine.Screen.width / UnityEngine.Screen.height > 1.7777777777777777 and 1080 * slot1 / (1920 * slot2) or 1))

	if slot0._effectCo.orderType ~= StoryEnum.EffectOrderType.Continuity and slot0._effectCo.orderType ~= StoryEnum.EffectOrderType.Single then
		slot3 = 1
		slot4 = 1
	end

	transformhelper.setLocalPosXY(slot0._uieffectGo.transform, slot0._effectCo.pos[1], slot0._effectCo.pos[2])
	transformhelper.setLocalScale(slot0._uieffectGo.transform, slot3, slot4, 1)

	slot0._effectLoader = PrefabInstantiate.Create(slot0._uieffectGo)

	slot0._effectLoader:startLoad(slot0._effectPath, slot0._onNormalEffectLoaded, slot0)
end

function slot0._onNormalEffectLoaded(slot0)
	slot0._effectGo = slot0._effectLoader:getInstGO()
	slot0._effectAnim = slot0._effectGo:GetComponent(typeof(UnityEngine.Animator))
	slot0._fadeHelper = StoryEffectFadeHelper.New()

	slot0._fadeHelper:init(slot0._effectGo)

	if slot0._effectCo.layer < 4 then
		gohelper.setLayer(slot0._effectGo, UnityLayer.UI, true)
	elseif slot0._effectCo.layer < 10 then
		gohelper.setLayer(slot0._effectGo, UnityLayer.UISecond, true)
	else
		gohelper.setLayer(slot0._effectGo, UnityLayer.UITop, true)
	end

	if slot0._effectCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
		slot0._fadeHelper:setEffectLoop(slot0._effectCo.orderType == StoryEnum.EffectOrderType.Continuity or slot0._effectCo.orderType == StoryEnum.EffectOrderType.ContinuityUnscale)
		slot0:_doEffectFade(0, 1, slot0._effectCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	slot0._effectOrderContainer = gohelper.onceAddComponent(slot0._effectGo, typeof(ZProj.EffectOrderContainer))

	slot0._effectOrderContainer:SetBaseOrder(slot0._effOrder)
end

function slot0._doEffectFade(slot0, slot1, slot2, slot3, slot4)
	TaskDispatcher.cancelTask(slot0._effFinished, slot0)

	if slot0:fadeByAnimator(slot2 == 1) then
		slot0._needDestroy = slot4

		TaskDispatcher.runDelay(slot0._effFinished, slot0, slot3)

		return
	end

	if slot3 < 0.1 then
		slot0:_effUpdate(slot2)

		if slot4 then
			slot0:onDestroy()
		end
	else
		slot0._needDestroy = slot4

		if slot0._effTweenId then
			ZProj.TweenHelper.KillById(slot0._effTweenId)

			slot0._effTweenId = nil
		end

		slot0._effTweenId = ZProj.TweenHelper.DOTweenFloat(slot1, slot2, slot3, slot0._effUpdate, slot0._effFinished, slot0, nil, EaseType.Linear)
	end
end

function slot0.fadeByAnimator(slot0, slot1)
	if not slot0._effectAnim then
		return
	end

	if slot1 then
		slot0._effectAnim:Play("open", 0, 0)
	else
		slot0._effectAnim:Play("close", 0, 0)
	end

	return true
end

function slot0._effUpdate(slot0, slot1)
	if not slot0._fadeHelper then
		if slot0._effTweenId then
			ZProj.TweenHelper.KillById(slot0._effTweenId)

			slot0._effTweenId = nil
		end

		return
	end

	if slot0._canvas then
		slot0._canvas.alpha = slot1

		if slot0._fadeHelper then
			slot0._fadeHelper:setTransparency(slot1)
		end
	elseif slot0._effTweenId then
		ZProj.TweenHelper.KillById(slot0._effTweenId)

		slot0._effTweenId = nil
	end
end

function slot0._effFinished(slot0)
	if not slot0._needDestroy then
		return
	end

	slot0:onDestroy()
end

function slot0.destroyEffect(slot0, slot1, slot2)
	if slot1 then
		slot0._effectCo = slot1
	end

	slot0._destroyParam = slot2

	TaskDispatcher.cancelTask(slot0._buildNormalEffect, slot0)

	if slot0._effectCo.outType == StoryEnum.EffectOutType.Hard then
		slot0:onDestroy()
	else
		slot0:_doEffectFade(1, 0, slot0._effectCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], true)
	end
end

function slot0.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._effFinished, slot0)

	if slot0._destroyParam then
		slot0._destroyParam.callback(slot0._destroyParam.callbackObj, slot0._effectPath)
	end

	TaskDispatcher.cancelTask(slot0._buildNormalEffect, slot0)

	if slot0._fadeHelper then
		slot0._fadeHelper:destroy()

		slot0._fadeHelper = nil
	end

	slot0._canvas = nil

	if slot0._effTweenId then
		ZProj.TweenHelper.KillById(slot0._effTweenId)

		slot0._effTweenId = nil
	end

	if slot0._effectLoader then
		slot0._effectLoader:dispose()

		slot0._effectLoader = nil
	end

	if slot0._effectGo then
		gohelper.destroy(slot0._effectGo)

		slot0._effectGo = nil
	end

	if slot0._uieffectGo then
		gohelper.destroy(slot0._uieffectGo)

		slot0._uieffectGo = nil
	end
end

return slot0
