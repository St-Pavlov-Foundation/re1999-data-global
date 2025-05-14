module("modules.logic.versionactivity1_4.act130.view.Activity130MapElement", package.seeall)

local var_0_0 = class("Activity130MapElement", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._info = arg_1_1[1]

	local var_1_0 = VersionActivity1_4Enum.ActivityId.Role37

	arg_1_0._config = Activity130Config.instance:getActivity130ElementCo(var_1_0, arg_1_0._info.elementId)
	arg_1_0._stageMap = arg_1_1[2]
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	arg_2_0._info = arg_2_1
end

function var_0_0.init(arg_3_0, arg_3_1)
	arg_3_0._go = arg_3_1
	arg_3_0._transform = arg_3_1.transform
end

function var_0_0.dispose(arg_4_0)
	if arg_4_0._lightGo then
		gohelper.destroy(arg_4_0._lightGo)
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
	arg_6_0:_lightFadeOut()
end

function var_0_0._lightFadeOut(arg_7_0)
	if arg_7_0._lightGo then
		arg_7_0._lightAnimator:Play("out", 0, 0)
		TaskDispatcher.runDelay(arg_7_0.dispose, arg_7_0, 0.37)
	end
end

function var_0_0.getResName(arg_8_0)
	return arg_8_0._config.res
end

function var_0_0._loadRes(arg_9_0)
	if arg_9_0._resLoader then
		return
	end

	arg_9_0._lightPath = "scenes/v1a4_m_s12_37jshd/prefab/v1a4_m_s12_kejiaohu_light.prefab"
	arg_9_0._resLoader = MultiAbLoader.New()

	arg_9_0._resLoader:addPath(arg_9_0._lightPath)
	arg_9_0._resLoader:startLoad(arg_9_0._onResLoaded, arg_9_0)

	return true
end

function var_0_0.isValid(arg_10_0)
	return not gohelper.isNil(arg_10_0._go) and not arg_10_0._isDisappear and arg_10_0._info:isAvailable()
end

function var_0_0.onDown(arg_11_0)
	arg_11_0:_onDown()
end

function var_0_0._onDown(arg_12_0)
	arg_12_0._stageMap:setElementDown(arg_12_0)
end

function var_0_0.onClick(arg_13_0)
	arg_13_0._info = Activity130Model.instance:getCurMapElementInfo(arg_13_0._info.elementId)

	Activity130Controller.instance:dispatchEvent(Activity130Event.OnClickElement, arg_13_0)
end

function var_0_0.setItemGo(arg_14_0, arg_14_1, arg_14_2)
	if string.nilorempty(arg_14_0._config.res) then
		arg_14_2 = false
	end

	arg_14_0._isFadeIn = arg_14_2

	gohelper.setActive(arg_14_1, true)

	arg_14_0._itemGo = arg_14_1

	if not arg_14_0:_loadRes() then
		arg_14_0:_checkFadeIn()
	end

	if not string.nilorempty(arg_14_0._config.type) then
		var_0_0.addBoxColliderListener(arg_14_0._itemGo, arg_14_0._onDown, arg_14_0)
	end
end

function var_0_0._checkFadeIn(arg_15_0)
	arg_15_0:_initMats()

	if arg_15_0._isFadeIn then
		arg_15_0:_frameUpdate(1)
	end
end

function var_0_0._frameUpdate(arg_16_0, arg_16_1)
	if not arg_16_0._mats then
		return
	end

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._mats) do
		if iter_16_1:HasProperty("_MainCol") then
			local var_16_0 = iter_16_1:GetColor("_MainCol")

			var_16_0.a = arg_16_1

			iter_16_1:SetColor("_MainCol", var_16_0)
		end
	end
end

function var_0_0._initMats(arg_17_0)
	if arg_17_0._mats then
		return
	end

	arg_17_0._mats = {}

	local var_17_0 = arg_17_0._itemGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_17_0 = 0, var_17_0.Length - 1 do
		local var_17_1 = var_17_0[iter_17_0].material

		table.insert(arg_17_0._mats, var_17_1)
	end
end

function var_0_0._onResLoaded(arg_18_0, arg_18_1)
	if arg_18_0._config.skipFinish == 1 then
		return
	end

	arg_18_0:_addLightEffect()
end

function var_0_0._addLightEffect(arg_19_0)
	if arg_19_0._lightPath then
		local var_19_0 = arg_19_0._resLoader:getAssetItem(arg_19_0._lightPath):GetResource(arg_19_0._lightPath)

		arg_19_0._lightGo = gohelper.clone(var_19_0, arg_19_0._go)

		local var_19_1, var_19_2 = transformhelper.getLocalPos(arg_19_0._itemGo.transform)

		transformhelper.setLocalPos(arg_19_0._lightGo.transform, var_19_1, var_19_2, 0)

		arg_19_0._lightAnimator = arg_19_0._lightGo:GetComponent(typeof(UnityEngine.Animator))

		arg_19_0._lightAnimator:Play("in", 0, 0)
	end
end

function var_0_0.addEventListeners(arg_20_0)
	return
end

function var_0_0.removeEventListeners(arg_21_0)
	return
end

function var_0_0.onStart(arg_22_0)
	return
end

function var_0_0.addBoxCollider2D(arg_23_0)
	local var_23_0 = ZProj.BoxColliderClickListener.Get(arg_23_0)

	var_23_0:SetIgnoreUI(true)

	local var_23_1 = arg_23_0:GetComponent(typeof(UnityEngine.Collider2D))

	if var_23_1 then
		var_23_1.enabled = false
		var_23_1.enabled = true

		return var_23_0
	end

	local var_23_2 = gohelper.onceAddComponent(arg_23_0, typeof(UnityEngine.BoxCollider2D))

	var_23_2.enabled = false
	var_23_2.enabled = true
	var_23_2.size = Vector2(1.5, 1.5)

	return var_23_0
end

function var_0_0.addBoxColliderListener(arg_24_0, arg_24_1, arg_24_2)
	var_0_0.addBoxCollider2D(arg_24_0):AddClickListener(arg_24_1, arg_24_2)
end

function var_0_0.onDestroy(arg_25_0)
	if arg_25_0._resLoader then
		arg_25_0._resLoader:dispose()

		arg_25_0._resLoader = nil
	end

	TaskDispatcher.cancelTask(arg_25_0.dispose, arg_25_0)

	if arg_25_0._mats then
		for iter_25_0, iter_25_1 in pairs(arg_25_0._mats) do
			rawset(arg_25_0._mats, iter_25_0, nil)
		end

		arg_25_0._mats = nil
	end
end

return var_0_0
