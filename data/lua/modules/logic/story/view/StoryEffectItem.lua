module("modules.logic.story.view.StoryEffectItem", package.seeall)

local var_0_0 = class("StoryEffectItem")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._effectPath = arg_1_2
	arg_1_0._effectGo = nil
	arg_1_0._uieffectGo = nil
	arg_1_0._effectCo = arg_1_3
	arg_1_0._fadeHelper = nil
	arg_1_0._effOrder = arg_1_4

	if arg_1_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0 then
		TaskDispatcher.runDelay(arg_1_0._buildNormalEffect, arg_1_0, arg_1_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		arg_1_0:_buildNormalEffect()
	end
end

function var_0_0.reset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	TaskDispatcher.cancelTask(arg_2_0._buildNormalEffect, arg_2_0)

	if not arg_2_0._effectGo then
		return
	end

	arg_2_0.viewGO = arg_2_1
	arg_2_0._effectCo = arg_2_2
	arg_2_0._effOrder = arg_2_3

	arg_2_0._effectGo.transform:SetParent(arg_2_0._uieffectGo.transform, false)
	arg_2_0._effectOrderContainer:SetBaseOrder(arg_2_0._effOrder)
end

function var_0_0._buildNormalEffect(arg_3_0)
	arg_3_0._uieffectGo = gohelper.create2d(arg_3_0.viewGO, "effect")
	arg_3_0._canvas = gohelper.onceAddComponent(arg_3_0._uieffectGo, typeof(UnityEngine.CanvasGroup))

	local var_3_0 = UnityEngine.Screen.width
	local var_3_1 = UnityEngine.Screen.height
	local var_3_2 = var_3_0 / var_3_1 > 1.7777777777777777 and 1080 * var_3_0 / (1920 * var_3_1) or 1
	local var_3_3 = var_3_0 / var_3_1 < 2 and 1 or 1080 * var_3_0 / (1920 * var_3_1 * var_3_2)

	if arg_3_0._effectCo.orderType ~= StoryEnum.EffectOrderType.Continuity and arg_3_0._effectCo.orderType ~= StoryEnum.EffectOrderType.Single then
		var_3_2 = 1
		var_3_3 = 1
	end

	transformhelper.setLocalPosXY(arg_3_0._uieffectGo.transform, arg_3_0._effectCo.pos[1], arg_3_0._effectCo.pos[2])
	transformhelper.setLocalScale(arg_3_0._uieffectGo.transform, var_3_2, var_3_3, 1)

	arg_3_0._effectLoader = PrefabInstantiate.Create(arg_3_0._uieffectGo)

	arg_3_0._effectLoader:startLoad(arg_3_0._effectPath, arg_3_0._onNormalEffectLoaded, arg_3_0)
end

function var_0_0._onNormalEffectLoaded(arg_4_0)
	arg_4_0._effectGo = arg_4_0._effectLoader:getInstGO()
	arg_4_0._effectAnim = arg_4_0._effectGo:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._fadeHelper = StoryEffectFadeHelper.New()

	arg_4_0._fadeHelper:init(arg_4_0._effectGo)

	if arg_4_0._effectCo.layer < 4 then
		gohelper.setLayer(arg_4_0._effectGo, UnityLayer.UI, true)
	elseif arg_4_0._effectCo.layer < 10 then
		gohelper.setLayer(arg_4_0._effectGo, UnityLayer.UISecond, true)
	else
		gohelper.setLayer(arg_4_0._effectGo, UnityLayer.UITop, true)
	end

	if arg_4_0._effectCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] > 0.1 then
		local var_4_0 = arg_4_0._effectCo.orderType == StoryEnum.EffectOrderType.Continuity or arg_4_0._effectCo.orderType == StoryEnum.EffectOrderType.ContinuityUnscale

		arg_4_0._fadeHelper:setEffectLoop(var_4_0)
		arg_4_0:_doEffectFade(0, 1, arg_4_0._effectCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end

	arg_4_0._effectOrderContainer = gohelper.onceAddComponent(arg_4_0._effectGo, typeof(ZProj.EffectOrderContainer))

	arg_4_0._effectOrderContainer:SetBaseOrder(arg_4_0._effOrder)
end

function var_0_0._doEffectFade(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	TaskDispatcher.cancelTask(arg_5_0._effFinished, arg_5_0)

	local var_5_0 = arg_5_2 == 1

	if arg_5_0:fadeByAnimator(var_5_0) then
		arg_5_0._needDestroy = arg_5_4

		TaskDispatcher.runDelay(arg_5_0._effFinished, arg_5_0, arg_5_3)

		return
	end

	if arg_5_3 < 0.1 then
		arg_5_0:_effUpdate(arg_5_2)

		if arg_5_4 then
			arg_5_0:onDestroy()
		end
	else
		arg_5_0._needDestroy = arg_5_4

		if arg_5_0._effTweenId then
			ZProj.TweenHelper.KillById(arg_5_0._effTweenId)

			arg_5_0._effTweenId = nil
		end

		arg_5_0._effTweenId = ZProj.TweenHelper.DOTweenFloat(arg_5_1, arg_5_2, arg_5_3, arg_5_0._effUpdate, arg_5_0._effFinished, arg_5_0, nil, EaseType.Linear)
	end
end

function var_0_0.fadeByAnimator(arg_6_0, arg_6_1)
	if not arg_6_0._effectAnim then
		return
	end

	if arg_6_1 then
		arg_6_0._effectAnim:Play("open", 0, 0)
	else
		arg_6_0._effectAnim:Play("close", 0, 0)
	end

	return true
end

function var_0_0._effUpdate(arg_7_0, arg_7_1)
	if not ViewMgr.instance:isOpen(ViewName.StoryHeroView) or not arg_7_0._fadeHelper then
		if arg_7_0._effTweenId then
			ZProj.TweenHelper.KillById(arg_7_0._effTweenId)

			arg_7_0._effTweenId = nil
		end

		return
	end

	if arg_7_0._canvas then
		arg_7_0._canvas.alpha = arg_7_1

		if arg_7_0._fadeHelper then
			arg_7_0._fadeHelper:setTransparency(arg_7_1)
		end
	elseif arg_7_0._effTweenId then
		ZProj.TweenHelper.KillById(arg_7_0._effTweenId)

		arg_7_0._effTweenId = nil
	end
end

function var_0_0._effFinished(arg_8_0)
	if not arg_8_0._needDestroy then
		return
	end

	arg_8_0:onDestroy()
end

function var_0_0.destroyEffect(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 then
		arg_9_0._effectCo = arg_9_1
	end

	arg_9_0._destroyParam = arg_9_2

	TaskDispatcher.cancelTask(arg_9_0._buildNormalEffect, arg_9_0)

	if arg_9_0._effectCo.outType == StoryEnum.EffectOutType.Hard then
		arg_9_0:onDestroy()
	else
		arg_9_0:_doEffectFade(1, 0, arg_9_0._effectCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], true)
	end
end

function var_0_0.onDestroy(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._effFinished, arg_10_0)

	if arg_10_0._destroyParam then
		arg_10_0._destroyParam.callback(arg_10_0._destroyParam.callbackObj, arg_10_0._effectPath)
	end

	TaskDispatcher.cancelTask(arg_10_0._buildNormalEffect, arg_10_0)

	if arg_10_0._fadeHelper then
		arg_10_0._fadeHelper:destroy()

		arg_10_0._fadeHelper = nil
	end

	arg_10_0._canvas = nil

	if arg_10_0._effTweenId then
		ZProj.TweenHelper.KillById(arg_10_0._effTweenId)

		arg_10_0._effTweenId = nil
	end

	if arg_10_0._effectLoader then
		arg_10_0._effectLoader:dispose()

		arg_10_0._effectLoader = nil
	end

	if arg_10_0._effectGo then
		gohelper.destroy(arg_10_0._effectGo)

		arg_10_0._effectGo = nil
	end

	if arg_10_0._uieffectGo then
		gohelper.destroy(arg_10_0._uieffectGo)

		arg_10_0._uieffectGo = nil
	end
end

return var_0_0
