module("modules.logic.weekwalk.view.WeekWalkMapElement", package.seeall)

local var_0_0 = class("WeekWalkMapElement", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._info = arg_1_1[1]
	arg_1_0._config = arg_1_0._info.config
	arg_1_0._weekwalkMap = arg_1_1[2]
	arg_1_0._curMapInfo = WeekWalkModel.instance:getCurMapInfo()
	arg_1_0._elementRes = arg_1_0._info:getRes()

	arg_1_0:_playBgm()
end

function var_0_0._playBgm(arg_2_0)
	if arg_2_0._info:getType() ~= WeekWalkEnum.ElementType.General then
		return
	end

	if arg_2_0._config.generalType ~= WeekWalkEnum.GeneralType.Bgm then
		return
	end

	arg_2_0._audioId = arg_2_0._config.param

	arg_2_0._weekwalkMap:_playBgm(arg_2_0._audioId)
end

function var_0_0._stopBgm(arg_3_0)
	if arg_3_0._info:getType() ~= WeekWalkEnum.ElementType.General then
		return
	end

	if arg_3_0._config.generalType ~= WeekWalkEnum.GeneralType.Bgm or not arg_3_0._audioId then
		return
	end

	arg_3_0._weekwalkMap:_stopBgm()

	arg_3_0._audioId = nil
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	arg_4_0._info = arg_4_1
end

function var_0_0.init(arg_5_0, arg_5_1)
	arg_5_0._go = arg_5_1
	arg_5_0._transform = arg_5_1.transform
end

function var_0_0.dispose(arg_6_0)
	gohelper.setActive(arg_6_0._itemGo, false)
	gohelper.destroy(arg_6_0._go)

	local var_6_0 = arg_6_0._config.smokeMaskOffset

	if not string.nilorempty(var_6_0) then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnRemoveSmokeMask, arg_6_0._config.id)
	end

	arg_6_0:_stopBgm()
end

function var_0_0.disappear(arg_7_0, arg_7_1)
	if string.nilorempty(arg_7_0._elementRes) then
		arg_7_1 = false
	end

	arg_7_0:_stopBgm()

	arg_7_0._isDisappear = true

	if not arg_7_1 then
		if arg_7_0._lightGo then
			arg_7_0:_lightFadeOut(arg_7_0.dispose)

			return
		end

		arg_7_0:dispose()

		return
	end

	arg_7_0:_fadeOut()
end

function var_0_0._fadeOut(arg_8_0)
	arg_8_0:_initMats()

	arg_8_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.8, arg_8_0._frameUpdate, arg_8_0._fadeOutFinish, arg_8_0)

	arg_8_0:_lightFadeOut(arg_8_0._lightFadeOutDone)
end

function var_0_0._lightFadeOut(arg_9_0, arg_9_1)
	if arg_9_0._lightGo then
		SLFramework.AnimatorPlayer.Get(arg_9_0._lightGo):Play("weekwalk_deepdream_light_blend_out", arg_9_1, arg_9_0)
	end
end

function var_0_0._lightFadeOutDone(arg_10_0)
	return
end

function var_0_0._frameUpdate(arg_11_0, arg_11_1)
	if not arg_11_0._mats then
		return
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._mats) do
		if iter_11_1:HasProperty("_MainCol") then
			local var_11_0 = iter_11_1:GetColor("_MainCol")

			var_11_0.a = arg_11_1

			iter_11_1:SetColor("_MainCol", var_11_0)
		end
	end
end

function var_0_0._fadeOutFinish(arg_12_0)
	arg_12_0:dispose()
end

function var_0_0.getResName(arg_13_0)
	return arg_13_0._elementRes
end

function var_0_0._initStarEffect(arg_14_0)
	if arg_14_0._battleInfo.index == #arg_14_0._curMapInfo.battleInfos then
		arg_14_0._starEffect = string.format("scenes/m_s09_rgmy/prefab/s09_rgmy_star_red.prefab")
	else
		arg_14_0._starEffect = string.format("scenes/m_s09_rgmy/prefab/s09_rgmy_star.prefab")
	end
end

function var_0_0._loadRes(arg_15_0)
	if arg_15_0._resLoader then
		return
	end

	local var_15_0 = arg_15_0._curMapInfo

	if var_15_0.isFinish > 0 and arg_15_0._info:getType() == WeekWalkEnum.ElementType.Battle then
		local var_15_1 = arg_15_0._info:getBattleId()
		local var_15_2 = var_15_0:getBattleInfo(var_15_1)

		if var_15_2 and var_15_2.star > 0 then
			arg_15_0._battleInfo = var_15_2

			arg_15_0:_initStarEffect()
		end
	end

	if not string.nilorempty(arg_15_0._config.disappearEffect) then
		arg_15_0._disappearEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", arg_15_0._config.disappearEffect)
	end

	if not string.nilorempty(arg_15_0._config.lightOffsetPos) then
		if WeekWalkModel.isShallowMap(var_15_0.id) then
			arg_15_0._lightPath = "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_light_blend.prefab"
		else
			arg_15_0._lightPath = "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_light.prefab"
		end
	end

	local var_15_3 = arg_15_0._config.smokeMaskOffset

	if not string.nilorempty(var_15_3) then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnAddSmokeMask, arg_15_0._config.id, var_15_3)
	end

	if arg_15_0._elementRes == "s09_rgmy_c03_wuqi_a" or arg_15_0._elementRes == "s09_rgmy_c04_wuqi_b" or arg_15_0._elementRes == "s09_rgmy_c05_wuqi_c" then
		arg_15_0._sceneEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", arg_15_0._elementRes)
	end

	if string.nilorempty(arg_15_0._config.effect) and not arg_15_0._disappearEffectPath and not arg_15_0._starEffect and not arg_15_0._lightPath and not arg_15_0._sceneEffectPath then
		return
	end

	arg_15_0._resLoader = MultiAbLoader.New()

	if not string.nilorempty(arg_15_0._config.effect) then
		arg_15_0._resLoader:addPath(arg_15_0._config.effect)
	end

	if arg_15_0._disappearEffectPath then
		arg_15_0._resLoader:addPath(arg_15_0._disappearEffectPath)
	end

	if arg_15_0._starEffect then
		arg_15_0._resLoader:addPath(arg_15_0._starEffect)
	end

	if arg_15_0._lightPath then
		arg_15_0._resLoader:addPath(arg_15_0._lightPath)
	end

	if arg_15_0._sceneEffectPath then
		arg_15_0._resLoader:addPath(arg_15_0._sceneEffectPath)
	end

	arg_15_0._resLoader:startLoad(arg_15_0._onResLoaded, arg_15_0)

	return true
end

function var_0_0.isValid(arg_16_0)
	return not gohelper.isNil(arg_16_0._go) and not arg_16_0._isDisappear and arg_16_0._info:isAvailable()
end

function var_0_0.setWenHaoVisible(arg_17_0, arg_17_1)
	if not arg_17_0._wenhaoGo then
		return
	end

	if not arg_17_0._wenhaoAnimator then
		arg_17_0._wenhaoAnimator = arg_17_0._wenhaoGo:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_17_1 then
		arg_17_0._wenhaoAnimator:Play("wenhao_a_001_in")
	else
		arg_17_0._wenhaoAnimator:Play("wenhao_a_001_out")
	end
end

function var_0_0.onDown(arg_18_0)
	arg_18_0:_onDown()
end

function var_0_0._onDown(arg_19_0)
	arg_19_0._weekwalkMap:setElementDown(arg_19_0)
end

function var_0_0.onClick(arg_20_0)
	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnClickElement, arg_20_0)
end

function var_0_0.hasEffect(arg_21_0)
	return arg_21_0._wenhaoGo
end

function var_0_0.setItemGo(arg_22_0, arg_22_1, arg_22_2)
	if string.nilorempty(arg_22_0._elementRes) then
		arg_22_2 = false
	end

	arg_22_0._isFadeIn = arg_22_2

	gohelper.setActive(arg_22_1, true)

	arg_22_0._itemGo = arg_22_1

	if not arg_22_0:_loadRes() then
		arg_22_0:_checkFadeIn()
	end

	if not string.nilorempty(arg_22_0._config.type) then
		var_0_0.addBoxColliderListener(arg_22_0._itemGo, arg_22_0._onDown, arg_22_0)
	end
end

function var_0_0._checkFadeIn(arg_23_0)
	arg_23_0:_initMats()

	if arg_23_0._isFadeIn then
		arg_23_0:_frameUpdate(0)
		arg_23_0:_fadeIn()
	end
end

function var_0_0._initMats(arg_24_0)
	if arg_24_0._mats then
		return
	end

	arg_24_0._mats = {}

	local var_24_0 = arg_24_0._itemGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_24_0 = 0, var_24_0.Length - 1 do
		local var_24_1 = var_24_0[iter_24_0].material

		table.insert(arg_24_0._mats, var_24_1)
	end
end

function var_0_0._fadeIn(arg_25_0)
	arg_25_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.8, arg_25_0._frameUpdate, arg_25_0._fadeInFinish, arg_25_0)
end

function var_0_0._fadeInFinish(arg_26_0)
	arg_26_0:_frameUpdate(1)
end

function var_0_0._onResLoaded(arg_27_0, arg_27_1)
	if not string.nilorempty(arg_27_0._config.effect) then
		local var_27_0 = string.splitToNumber(arg_27_0._config.tipOffsetPos, "#")
		local var_27_1 = var_27_0[1] or 0
		local var_27_2 = var_27_0[2] or 0
		local var_27_3 = arg_27_0._resLoader:getAssetItem(arg_27_0._config.effect):GetResource(arg_27_0._config.effect)

		arg_27_0._wenhaoGo = gohelper.clone(var_27_3, arg_27_0._go)

		local var_27_4, var_27_5 = transformhelper.getLocalPos(arg_27_0._itemGo.transform)

		transformhelper.setLocalPos(arg_27_0._wenhaoGo.transform, var_27_4 + var_27_1, var_27_5 + var_27_2, -2)
	end

	if not arg_27_0:noRemainStars() then
		arg_27_0:_addStarEffect()
	end

	arg_27_0:_addLightEffect()
	arg_27_0:_addSceneEffect()
end

function var_0_0.noRemainStars(arg_28_0)
	local var_28_0 = arg_28_0._curMapInfo

	if not var_28_0 or var_28_0.isFinish <= 0 then
		return
	end

	local var_28_1, var_28_2 = var_28_0:getCurStarInfo()

	return var_28_1 == var_28_2
end

function var_0_0._addStarEffect(arg_29_0)
	if arg_29_0._starEffect then
		local var_29_0 = string.splitToNumber(arg_29_0._config.starOffsetPos, "#")
		local var_29_1 = var_29_0[1] or 0
		local var_29_2 = var_29_0[2] or 0
		local var_29_3 = arg_29_0._resLoader:getAssetItem(arg_29_0._starEffect):GetResource(arg_29_0._starEffect)

		arg_29_0._starGo = gohelper.clone(var_29_3, arg_29_0._go)

		local var_29_4 = gohelper.findChildComponent(arg_29_0._starGo, "text_number", typeof(TMPro.TextMeshPro))

		if var_29_4 then
			var_29_4.text = "0" .. arg_29_0._battleInfo.index
		end

		local var_29_5 = arg_29_0._curMapInfo:getStarNumConfig()
		local var_29_6 = gohelper.findChild(arg_29_0._starGo, "star2")
		local var_29_7 = gohelper.findChild(arg_29_0._starGo, "star3")
		local var_29_8 = var_29_5 == 2

		gohelper.setActive(var_29_6, var_29_8)
		gohelper.setActive(var_29_7, not var_29_8)

		local var_29_9 = var_29_8 and var_29_6 or var_29_7

		for iter_29_0 = 1, var_29_5 do
			gohelper.setActive(gohelper.findChild(var_29_9, "star_highlight/star_highlight0" .. iter_29_0), iter_29_0 <= arg_29_0._battleInfo.star)
		end

		if var_29_1 ~= 0 or var_29_2 ~= 0 then
			transformhelper.setLocalPos(arg_29_0._starGo.transform, var_29_1, var_29_2, 0)
		else
			local var_29_10, var_29_11 = transformhelper.getLocalPos(arg_29_0._itemGo.transform)

			transformhelper.setLocalPos(arg_29_0._starGo.transform, var_29_10 + var_29_1, var_29_11 + var_29_2, 0)
		end
	end
end

function var_0_0._addLightEffect(arg_30_0)
	if arg_30_0._lightPath then
		local var_30_0 = string.splitToNumber(arg_30_0._config.lightOffsetPos, "#")
		local var_30_1 = var_30_0[1] or 0
		local var_30_2 = var_30_0[2] or 0
		local var_30_3 = arg_30_0._resLoader:getAssetItem(arg_30_0._lightPath):GetResource(arg_30_0._lightPath)

		arg_30_0._lightGo = gohelper.clone(var_30_3, arg_30_0._go)

		if var_30_1 ~= 0 or var_30_2 ~= 0 then
			transformhelper.setLocalPos(arg_30_0._lightGo.transform, var_30_1, var_30_2, 0)
		else
			local var_30_4, var_30_5 = transformhelper.getLocalPos(arg_30_0._itemGo.transform)

			transformhelper.setLocalPos(arg_30_0._lightGo.transform, var_30_4 + var_30_1, var_30_5 + var_30_2, 0)
		end
	end
end

function var_0_0._addSceneEffect(arg_31_0)
	if arg_31_0._sceneEffectPath then
		local var_31_0 = arg_31_0._resLoader:getAssetItem(arg_31_0._sceneEffectPath):GetResource(arg_31_0._sceneEffectPath)

		arg_31_0._sceneEffectGo = gohelper.clone(var_31_0, gohelper.findChild(arg_31_0._go, arg_31_0._elementRes))
	end
end

function var_0_0.addEventListeners(arg_32_0)
	return
end

function var_0_0.removeEventListeners(arg_33_0)
	return
end

function var_0_0.onStart(arg_34_0)
	return
end

function var_0_0.addBoxCollider2D(arg_35_0)
	local var_35_0 = ZProj.BoxColliderClickListener.Get(arg_35_0)

	var_35_0:SetIgnoreUI(true)

	local var_35_1 = arg_35_0:GetComponent(typeof(UnityEngine.Collider2D))

	if var_35_1 then
		var_35_1.enabled = true

		return var_35_0
	end

	local var_35_2 = gohelper.onceAddComponent(arg_35_0, typeof(UnityEngine.BoxCollider2D))

	var_35_2.enabled = true
	var_35_2.size = Vector2(1.5, 1.5)

	return var_35_0
end

function var_0_0.addBoxColliderListener(arg_36_0, arg_36_1, arg_36_2)
	var_0_0.addBoxCollider2D(arg_36_0):AddClickListener(arg_36_1, arg_36_2)
end

function var_0_0.onDestroy(arg_37_0)
	if arg_37_0._resLoader then
		arg_37_0._resLoader:dispose()

		arg_37_0._resLoader = nil
	end

	TaskDispatcher.cancelTask(arg_37_0.dispose, arg_37_0)

	if arg_37_0._tweenId then
		ZProj.TweenHelper.KillById(arg_37_0._tweenId)

		arg_37_0._tweenId = nil
	end

	if arg_37_0._mats then
		for iter_37_0, iter_37_1 in pairs(arg_37_0._mats) do
			rawset(arg_37_0._mats, iter_37_0, nil)
		end

		arg_37_0._mats = nil
	end
end

return var_0_0
