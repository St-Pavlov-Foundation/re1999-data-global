module("modules.logic.handbook.view.HandbookWeekWalkMapElement", package.seeall)

local var_0_0 = class("HandbookWeekWalkMapElement", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.parentView = arg_1_1.parentView
	arg_1_0.diffuseGo = arg_1_1.diffuseGo
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.transform = arg_2_1.transform
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	arg_3_0.elementId = arg_3_1

	arg_3_0:updateConfig(WeekWalkConfig.instance:getElementConfig(arg_3_1))
end

function var_0_0.updateConfig(arg_4_0, arg_4_1)
	arg_4_0.config = arg_4_1
end

function var_0_0.dispose(arg_5_0)
	gohelper.setActive(arg_5_0._itemGo, false)
	gohelper.destroy(arg_5_0.go)
end

function var_0_0.fadeOut(arg_6_0)
	arg_6_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.8, arg_6_0._frameUpdate, arg_6_0._fadeOutFinish, arg_6_0)
end

function var_0_0.fadeIn(arg_7_0)
	arg_7_0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.8, arg_7_0._frameUpdate, arg_7_0._fadeInFinish, arg_7_0)
end

function var_0_0._fadeInFinish(arg_8_0)
	arg_8_0:_frameUpdate(1)
end

function var_0_0._fadeOutFinish(arg_9_0)
	arg_9_0:dispose()
end

function var_0_0._frameUpdate(arg_10_0, arg_10_1)
	if not arg_10_0._color then
		return
	end

	arg_10_0._color.a = arg_10_1

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._mats) do
		iter_10_1:SetColor("_MainCol", arg_10_0._color)
	end
end

function var_0_0.getResName(arg_11_0)
	return arg_11_0._config.res
end

function var_0_0.refresh(arg_12_0)
	local var_12_0 = arg_12_0:getResName()

	if string.nilorempty(var_12_0) then
		return
	end

	local var_12_1 = gohelper.findChild(arg_12_0.diffuseGo, var_12_0)

	if not var_12_1 then
		logError(tostring(arg_12_0.elementId) .. " no resGo:" .. tostring(var_12_0))
	end

	arg_12_0.resItemGo = gohelper.clone(var_12_1, arg_12_0.go, var_12_0)

	arg_12_0:_loadEffectRes()

	arg_12_0._mats = {}

	local var_12_2 = arg_12_0._itemGo:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_12_0 = 0, var_12_2.Length - 1 do
		local var_12_3 = var_12_2[iter_12_0].material

		table.insert(arg_12_0._mats, var_12_3)

		if not arg_12_0._color then
			arg_12_0._color = var_12_3:GetColor("_MainCol")
		end
	end

	arg_12_0:fadeIn()
end

function var_0_0._loadEffectRes(arg_13_0)
	if arg_13_0._resLoader then
		return
	end

	if not string.nilorempty(arg_13_0._config.disappearEffect) then
		arg_13_0._disappearEffectPath = string.format("scenes/m_s09_rgmy/prefab/%s.prefab", arg_13_0._config.disappearEffect)
	end

	if string.nilorempty(arg_13_0._config.effect) and not arg_13_0._disappearEffectPath then
		return
	end

	arg_13_0._resLoader = MultiAbLoader.New()

	if not string.nilorempty(arg_13_0._config.effect) then
		arg_13_0._resLoader:addPath(arg_13_0._config.effect)
	end

	if arg_13_0._disappearEffectPath then
		arg_13_0._resLoader:addPath(arg_13_0._disappearEffectPath)
	end

	arg_13_0._resLoader:startLoad(arg_13_0._onResLoaded, arg_13_0)
end

function var_0_0._onResLoaded(arg_14_0, arg_14_1)
	if not string.nilorempty(arg_14_0._config.effect) then
		local var_14_0 = string.splitToNumber(arg_14_0._config.tipOffsetPos, "#")

		arg_14_0._offsetX = var_14_0[1] or 0
		arg_14_0._offsetY = var_14_0[2] or 0

		local var_14_1 = arg_14_0._resLoader:getAssetItem(arg_14_0._config.effect):GetResource(arg_14_0._config.effect)

		arg_14_0._wenhaoGo = gohelper.clone(var_14_1, arg_14_0._go)

		local var_14_2, var_14_3 = transformhelper.getLocalPos(arg_14_0.resItemGo.transform)

		transformhelper.setLocalPos(arg_14_0._wenhaoGo.transform, var_14_2 + arg_14_0._offsetX, var_14_3 + arg_14_0._offsetY, -2)
	end
end

function var_0_0.setWenHaoVisible(arg_15_0, arg_15_1)
	if not arg_15_0._wenhaoGo then
		return
	end

	if not arg_15_0._wenhaoAnimator then
		arg_15_0._wenhaoAnimator = arg_15_0._wenhaoGo:GetComponent(typeof(UnityEngine.Animator))
	end

	if arg_15_1 then
		arg_15_0._wenhaoAnimator:Play("wenhao_a_001_in")
	else
		arg_15_0._wenhaoAnimator:Play("wenhao_a_001_out")
	end
end

function var_0_0.hasEffect(arg_16_0)
	return arg_16_0._wenhaoGo
end

function var_0_0.onDestroy(arg_17_0)
	if arg_17_0._resLoader then
		arg_17_0._resLoader:dispose()

		arg_17_0._resLoader = nil
	end

	if arg_17_0._tweenId then
		ZProj.TweenHelper.KillById(arg_17_0._tweenId)

		arg_17_0._tweenId = nil
	end

	arg_17_0._mats = nil
	arg_17_0._color = nil
end

return var_0_0
