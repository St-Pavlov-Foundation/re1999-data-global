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
	TaskDispatcher.cancelTask(arg_2_0._followBg, arg_2_0)

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

	if arg_3_0._effectCo.orderType == StoryEnum.EffectOrderType.ContinuityUnscale or arg_3_0._effectCo.orderType == StoryEnum.EffectOrderType.SingleUnscale or arg_3_0._effectCo.orderType == StoryEnum.EffectOrderType.NoSettingUnScale then
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

	local var_4_0 = arg_4_0._effectCo.inTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]

	if var_4_0 > 0.1 and arg_4_0._effectCo.orderType ~= StoryEnum.EffectOrderType.NoSettingUnScale and arg_4_0._effectCo.orderType ~= StoryEnum.EffectOrderType.NoSetting then
		local var_4_1 = arg_4_0._effectCo.orderType == StoryEnum.EffectOrderType.Continuity or arg_4_0._effectCo.orderType == StoryEnum.EffectOrderType.ContinuityUnscale

		arg_4_0._fadeHelper:setEffectLoop(var_4_1)
		arg_4_0:_doEffectFade(0, 1, var_4_0)
	end

	if arg_4_0._effectCo.orderType == StoryEnum.EffectOrderType.FollowBg then
		arg_4_0:_playFollowBg()
	end

	arg_4_0._effectOrderContainer = gohelper.onceAddComponent(arg_4_0._effectGo, typeof(ZProj.EffectOrderContainer))

	arg_4_0._effectOrderContainer:SetBaseOrder(arg_4_0._effOrder)
end

function var_0_0._playFollowBg(arg_5_0)
	arg_5_0._bgGo = StoryViewMgr.instance:getStoryFrontBgGo()
	arg_5_0._bgFrontGo = gohelper.findChild(arg_5_0._bgGo, "#simage_bgimg")

	local var_5_0, var_5_1 = transformhelper.getLocalPos(arg_5_0._bgFrontGo.transform)

	arg_5_0._initFrontPos = {
		var_5_0,
		var_5_1
	}

	local var_5_2, var_5_3 = transformhelper.getLocalPos(arg_5_0._uieffectGo.transform)

	arg_5_0._deltaPos = {
		var_5_2,
		var_5_3
	}

	TaskDispatcher.runRepeat(arg_5_0._followBg, arg_5_0, 0.02)
end

function var_0_0._followBg(arg_6_0)
	local var_6_0, var_6_1 = transformhelper.getLocalScale(arg_6_0._bgGo.transform)
	local var_6_2, var_6_3 = transformhelper.getLocalPos(arg_6_0._bgFrontGo.transform)
	local var_6_4 = var_6_0 * (arg_6_0._deltaPos[1] + var_6_2 - arg_6_0._initFrontPos[1])
	local var_6_5 = var_6_1 * (arg_6_0._deltaPos[2] + var_6_3 - arg_6_0._initFrontPos[2])

	transformhelper.setLocalPosXY(arg_6_0._uieffectGo.transform, var_6_4, var_6_5)
	transformhelper.setLocalScale(arg_6_0._uieffectGo.transform, var_6_1, var_6_1, 1)
end

function var_0_0._doEffectFade(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	TaskDispatcher.cancelTask(arg_7_0._effFinished, arg_7_0)

	local var_7_0 = arg_7_2 == 1

	if arg_7_0:fadeByAnimator(var_7_0) then
		arg_7_0._needDestroy = arg_7_4

		TaskDispatcher.runDelay(arg_7_0._effFinished, arg_7_0, arg_7_3)

		return
	end

	if arg_7_3 < 0.1 then
		arg_7_0:_effUpdate(arg_7_2)

		if arg_7_4 then
			arg_7_0:onDestroy()
		end
	else
		arg_7_0._needDestroy = arg_7_4

		if arg_7_0._effTweenId then
			ZProj.TweenHelper.KillById(arg_7_0._effTweenId)

			arg_7_0._effTweenId = nil
		end

		arg_7_0._effTweenId = ZProj.TweenHelper.DOTweenFloat(arg_7_1, arg_7_2, arg_7_3, arg_7_0._effUpdate, arg_7_0._effFinished, arg_7_0, nil, EaseType.Linear)
	end
end

function var_0_0.fadeByAnimator(arg_8_0, arg_8_1)
	if not arg_8_0._effectAnim then
		return
	end

	if arg_8_1 then
		arg_8_0._effectAnim:Play("open", 0, 0)
	else
		arg_8_0._effectAnim:Play("close", 0, 0)
	end

	return true
end

function var_0_0._effUpdate(arg_9_0, arg_9_1)
	if not ViewMgr.instance:isOpen(ViewName.StoryHeroView) or not arg_9_0._fadeHelper then
		if arg_9_0._effTweenId then
			ZProj.TweenHelper.KillById(arg_9_0._effTweenId)

			arg_9_0._effTweenId = nil
		end

		return
	end

	if arg_9_0._canvas then
		arg_9_0._canvas.alpha = arg_9_1

		if arg_9_0._fadeHelper then
			arg_9_0._fadeHelper:setTransparency(arg_9_1)
		end
	elseif arg_9_0._effTweenId then
		ZProj.TweenHelper.KillById(arg_9_0._effTweenId)

		arg_9_0._effTweenId = nil
	end
end

function var_0_0._effFinished(arg_10_0)
	if not arg_10_0._needDestroy then
		return
	end

	arg_10_0:onDestroy()
end

function var_0_0.destroyEffect(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 then
		arg_11_0._effectCo = arg_11_1
	end

	arg_11_0._destroyParam = arg_11_2

	TaskDispatcher.cancelTask(arg_11_0._buildNormalEffect, arg_11_0)

	if arg_11_0._effectCo.outType == StoryEnum.EffectOutType.Hard then
		arg_11_0:onDestroy()
	else
		arg_11_0:_doEffectFade(1, 0, arg_11_0._effectCo.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()], true)
	end
end

function var_0_0.onDestroy(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._effFinished, arg_12_0)

	if arg_12_0._destroyParam then
		arg_12_0._destroyParam.callback(arg_12_0._destroyParam.callbackObj, arg_12_0._effectPath)
	end

	TaskDispatcher.cancelTask(arg_12_0._buildNormalEffect, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._followBg, arg_12_0)

	if arg_12_0._fadeHelper then
		arg_12_0._fadeHelper:destroy()

		arg_12_0._fadeHelper = nil
	end

	arg_12_0._canvas = nil

	if arg_12_0._effTweenId then
		ZProj.TweenHelper.KillById(arg_12_0._effTweenId)

		arg_12_0._effTweenId = nil
	end

	if arg_12_0._effectLoader then
		arg_12_0._effectLoader:dispose()

		arg_12_0._effectLoader = nil
	end

	if arg_12_0._effectGo then
		gohelper.destroy(arg_12_0._effectGo)

		arg_12_0._effectGo = nil
	end

	if arg_12_0._uieffectGo then
		gohelper.destroy(arg_12_0._uieffectGo)

		arg_12_0._uieffectGo = nil
	end
end

return var_0_0
