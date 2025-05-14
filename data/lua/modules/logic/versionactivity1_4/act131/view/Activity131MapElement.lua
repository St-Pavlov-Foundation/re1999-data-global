module("modules.logic.versionactivity1_4.act131.view.Activity131MapElement", package.seeall)

local var_0_0 = class("Activity131MapElement", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._info = arg_1_1[1]

	local var_1_0 = VersionActivity1_4Enum.ActivityId.Role6

	arg_1_0._config = Activity131Config.instance:getActivity131ElementCo(var_1_0, arg_1_0._info.elementId)
	arg_1_0._stageMap = arg_1_1[2]
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0._info = arg_2_1
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._go = arg_3_1
	arg_3_0._transform = arg_3_1.transform
end

function var_0_0.dispose(arg_4_0, arg_4_1)
	if arg_4_0._lightGo then
		gohelper.destroy(arg_4_0._lightGo)
	end

	if arg_4_1 and arg_4_0._itemGo then
		gohelper.destroy(arg_4_0._itemGo)

		return
	end

	if arg_4_0._itemGo then
		local var_4_0 = arg_4_0._itemGo:GetComponent(typeof(UnityEngine.BoxCollider2D))

		if var_4_0 then
			var_4_0.enabled = false
		end
	end
end

function var_0_0.disappear(arg_5_0, arg_5_1)
	if string.nilorempty(arg_5_0._config.res) then
		arg_5_1 = false
	end

	arg_5_0._isDisappear = true

	if not arg_5_1 then
		if arg_5_0._lightGo then
			arg_5_0:_lightFadeOut(arg_5_0.dispose)

			return
		end

		arg_5_0:dispose()

		return
	end

	arg_5_0:_fadeOut()
end

function var_0_0._fadeOut(arg_6_0)
	arg_6_0:_initMats()

	arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.8, arg_6_0._frameUpdate, arg_6_0._fadeOutFinish, arg_6_0)

	arg_6_0:_lightFadeOut()
end

function var_0_0._fadeOutFinish(arg_7_0)
	arg_7_0:dispose()
end

function var_0_0._lightFadeOut(arg_8_0)
	if arg_8_0._lightGo then
		arg_8_0._lightAnimator:Play("out", 0, 0)
		TaskDispatcher.runDelay(arg_8_0.dispose, arg_8_0, 0.37)
	end
end

function var_0_0.getResName(arg_9_0)
	return arg_9_0._config.res
end

function var_0_0._loadRes(arg_10_0)
	if arg_10_0._resLoader then
		return
	end

	arg_10_0._lightPath = "scenes/v1a4_m_s12_37jshd/prefab/v1a4_m_s12_kejiaohu_light.prefab"
	arg_10_0._resLoader = MultiAbLoader.New()

	arg_10_0._resLoader:addPath(arg_10_0._lightPath)
	arg_10_0._resLoader:startLoad(arg_10_0._onResLoaded, arg_10_0)

	return true
end

function var_0_0.isValid(arg_11_0)
	return not gohelper.isNil(arg_11_0._go) and not arg_11_0._isDisappear and arg_11_0._info:isAvailable()
end

function var_0_0.onDown(arg_12_0)
	arg_12_0:_onDown()
end

function var_0_0._onDown(arg_13_0)
	arg_13_0._stageMap:setElementDown(arg_13_0)
end

function var_0_0.onClick(arg_14_0)
	arg_14_0._info = Activity131Model.instance:getCurMapElementInfo(arg_14_0._info.elementId)

	Activity131Controller.instance:dispatchEvent(Activity131Event.OnClickElement, arg_14_0)
end

function var_0_0.setItemGo(arg_15_0, arg_15_1, arg_15_2)
	if string.nilorempty(arg_15_0._config.res) then
		arg_15_2 = false
	end

	arg_15_0._isFadeIn = arg_15_2

	gohelper.setActive(arg_15_1, true)

	arg_15_0._itemGo = arg_15_1

	if not arg_15_0:_loadRes() then
		arg_15_0:_checkFadeIn()
	end

	if not string.nilorempty(arg_15_0._config.type) then
		var_0_0.addBoxColliderListener(arg_15_0._itemGo, arg_15_0._onDown, arg_15_0)
	end
end

function var_0_0._checkFadeIn(arg_16_0)
	arg_16_0:_initMats()

	if arg_16_0._isFadeIn then
		arg_16_0:_frameUpdate(1)
	end
end

function var_0_0._frameUpdate(arg_17_0, arg_17_1)
	if not arg_17_0._mats then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._mats) do
		if iter_17_1:HasProperty("_MainCol") then
			local var_17_0 = iter_17_1:GetColor("_MainCol")

			var_17_0.a = arg_17_1

			iter_17_1:SetColor("_MainCol", var_17_0)
		end
	end
end

function var_0_0._initMats(arg_18_0)
	if arg_18_0._mats then
		return
	end

	arg_18_0._mats = {}

	local var_18_0 = arg_18_0._itemGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_18_0 = 0, var_18_0.Length - 1 do
		local var_18_1 = var_18_0[iter_18_0].material

		table.insert(arg_18_0._mats, var_18_1)
	end
end

function var_0_0._onResLoaded(arg_19_0, arg_19_1)
	if arg_19_0._config.skipFinish == 1 then
		return
	end

	arg_19_0:_addLightEffect()
end

function var_0_0._addLightEffect(arg_20_0)
	if arg_20_0._lightPath then
		local var_20_0 = arg_20_0._resLoader:getAssetItem(arg_20_0._lightPath):GetResource(arg_20_0._lightPath)

		arg_20_0._lightGo = gohelper.clone(var_20_0, arg_20_0._go)

		local var_20_1, var_20_2 = transformhelper.getLocalPos(arg_20_0._itemGo.transform)

		transformhelper.setLocalPos(arg_20_0._lightGo.transform, var_20_1, var_20_2, 0)

		arg_20_0._lightAnimator = arg_20_0._lightGo:GetComponent(typeof(UnityEngine.Animator))

		arg_20_0._lightAnimator:Play("in", 0, 0)
	end
end

function var_0_0.addEventListeners(arg_21_0)
	return
end

function var_0_0.removeEventListeners(arg_22_0)
	return
end

function var_0_0.onStart(arg_23_0)
	return
end

function var_0_0.addBoxCollider2D(arg_24_0)
	local var_24_0 = ZProj.BoxColliderClickListener.Get(arg_24_0)

	var_24_0:SetIgnoreUI(true)

	local var_24_1 = arg_24_0:GetComponent(typeof(UnityEngine.Collider2D))

	if var_24_1 then
		var_24_1.enabled = false
		var_24_1.enabled = true

		return var_24_0
	end

	local var_24_2 = gohelper.onceAddComponent(arg_24_0, typeof(UnityEngine.BoxCollider2D))

	var_24_2.enabled = false
	var_24_2.enabled = true
	var_24_2.size = Vector2(1.5, 1.5)

	return var_24_0
end

function var_0_0.addBoxColliderListener(arg_25_0, arg_25_1, arg_25_2)
	var_0_0.addBoxCollider2D(arg_25_0):AddClickListener(arg_25_1, arg_25_2)
end

function var_0_0.refreshClick(arg_26_0)
	local var_26_0 = arg_26_0._itemGo:GetComponent(typeof(UnityEngine.BoxCollider2D))

	if var_26_0 then
		var_26_0.enabled = false
		var_26_0.enabled = true
	end
end

function var_0_0.onDestroy(arg_27_0)
	if arg_27_0._resLoader then
		arg_27_0._resLoader:dispose()

		arg_27_0._resLoader = nil
	end

	TaskDispatcher.cancelTask(arg_27_0.dispose, arg_27_0)

	if arg_27_0._tweenId then
		ZProj.TweenHelper.KillById(arg_27_0._tweenId)

		arg_27_0._tweenId = nil
	end

	if arg_27_0._mats then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._mats) do
			rawset(arg_27_0._mats, iter_27_0, nil)
		end

		arg_27_0._mats = nil
	end
end

return var_0_0
