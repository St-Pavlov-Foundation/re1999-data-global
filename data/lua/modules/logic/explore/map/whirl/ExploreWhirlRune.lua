module("modules.logic.explore.map.whirl.ExploreWhirlRune", package.seeall)

local var_0_0 = class("ExploreWhirlRune", ExploreWhirlBase)
local var_0_1 = -0.1
local var_0_2 = 0.47
local var_0_3 = 0.03
local var_0_4 = var_0_2 + var_0_3
local var_0_5 = 0.03
local var_0_6 = 0.47
local var_0_7 = var_0_5 + var_0_6
local var_0_8 = 1
local var_0_9 = 1
local var_0_10 = 1
local var_0_11 = 0.4
local var_0_12 = var_0_11 + 0.6
local var_0_13 = 0.5

function var_0_0.onInit(arg_1_0)
	arg_1_0._resPath = "explore/zj_01/jiaohu/prefabs/zj_01_jh_mfdj_01.prefab"

	arg_1_0.trans:SetParent(ExploreController.instance:getMap():getHero().trans, false)
end

function var_0_0.initComponents(arg_2_0)
	return
end

function var_0_0.flyToPos(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if not arg_3_0._runeTrans then
		arg_3_2(arg_3_3)

		return
	end

	local var_3_0 = ExploreController.instance:getMap():getHero()

	arg_3_0._toDir = var_3_0.dir
	arg_3_0._isHigh = arg_3_1
	arg_3_0._tweenEndCallBack = arg_3_2
	arg_3_0._tweenEndCallObj = arg_3_3

	local var_3_1 = arg_3_0._runeTrans.position
	local var_3_2 = arg_3_0._runeTrans.eulerAngles
	local var_3_3 = var_3_0:getPos():Clone()

	arg_3_0._anim:Play("active", 0, var_0_13)
	arg_3_0._anim:Update(0)

	arg_3_0._prePos = arg_3_0._runeTrans.position
	arg_3_0._preEulerAngles = arg_3_0._runeTrans.eulerAngles

	arg_3_0._anim:Play(arg_3_0:getFlyAnimName(), 0, 0)
	arg_3_0._anim:Update(0)

	local var_3_4 = arg_3_0._runeTrans.eulerAngles

	var_3_3.y = arg_3_0._runeTrans.position.y
	arg_3_0._anim.enabled = false
	arg_3_0._runeTrans.eulerAngles = var_3_2
	arg_3_0._runeTrans.position = var_3_1

	local var_3_5 = (arg_3_0._prePos + var_3_3) / 2

	var_3_5.y = var_3_3.y + var_0_1

	ZProj.TweenHelper.DOMove(arg_3_0._runeTrans, var_3_5.x, var_3_5.y, var_3_5.z, var_0_2, arg_3_0.onTweenPos, arg_3_0, var_3_3, EaseType.Linear)

	arg_3_0._tweenId2 = ZProj.TweenHelper.DORotate(arg_3_0._runeTrans, var_3_4.x, var_3_4.y, var_3_4.z, var_0_4, arg_3_0.onTweenEnd, arg_3_0, nil, EaseType.Linear)
end

function var_0_0.onTweenPos(arg_4_0, arg_4_1)
	ZProj.TweenHelper.DOMove(arg_4_0._runeTrans, arg_4_1.x, arg_4_1.y, arg_4_1.z, var_0_3, nil, nil, nil, EaseType.Linear)
end

function var_0_0.onTweenEnd(arg_5_0)
	arg_5_0._tweenId = nil
	arg_5_0._tweenId2 = nil
	arg_5_0._anim.enabled = true

	arg_5_0._anim:Play(arg_5_0:getFlyAnimName(), 0, 0)
	TaskDispatcher.runDelay(arg_5_0.onAnimEnd, arg_5_0, var_0_8)
end

function var_0_0.getFlyAnimName(arg_6_0)
	return arg_6_0:getDirStr()
end

function var_0_0.getDirStr(arg_7_0)
	if arg_7_0._toDir == 0 then
		return "up"
	elseif arg_7_0._toDir == 90 then
		return "right"
	elseif arg_7_0._toDir == 180 then
		return "down"
	else
		return "left"
	end
end

function var_0_0.onAnimEnd(arg_8_0)
	if arg_8_0._isHigh then
		arg_8_0._tweenEndCallBack(arg_8_0._tweenEndCallObj)

		arg_8_0._tweenEndCallBack = nil
		arg_8_0._tweenEndCallObj = nil
	else
		gohelper.setActive(arg_8_0._effect2, false)
		gohelper.setActive(arg_8_0._effect2, true)
		TaskDispatcher.runDelay(arg_8_0._delayPlayRuneUnitAnim, arg_8_0, var_0_11)
		TaskDispatcher.runDelay(arg_8_0.flyBack, arg_8_0, var_0_12)
	end
end

function var_0_0._delayPlayRuneUnitAnim(arg_9_0)
	arg_9_0._tweenEndCallBack(arg_9_0._tweenEndCallObj)

	arg_9_0._tweenEndCallBack = nil
	arg_9_0._tweenEndCallObj = nil
end

function var_0_0.flyBack(arg_10_0)
	gohelper.setActive(arg_10_0._activeRoot, true)

	if arg_10_0._isHigh then
		gohelper.setActive(arg_10_0._effect1, false)
		gohelper.setActive(arg_10_0._effect1, true)
		AudioMgr.instance:trigger(AudioEnum.Explore.ActiveRune)
		TaskDispatcher.runDelay(arg_10_0._delayShowActiveEffect, arg_10_0, var_0_10)
	else
		arg_10_0:_delayShowActiveEffect()
	end
end

function var_0_0._delayShowActiveEffect(arg_11_0)
	gohelper.setActive(arg_11_0._activeRoot2, true)
	gohelper.setActive(arg_11_0._normalRoot, false)

	arg_11_0._anim.enabled = true

	arg_11_0._anim:Play(string.format("back_%s", arg_11_0:getDirStr()), 0, 0)
	TaskDispatcher.runDelay(arg_11_0.onBackAnimEnd, arg_11_0, var_0_9)
end

function var_0_0.onBackAnimEnd(arg_12_0)
	arg_12_0._anim.enabled = false

	if not arg_12_0._prePos then
		arg_12_0:onTweenEnd2()

		return
	end

	local var_12_0 = arg_12_0._runeTrans.position
	local var_12_1 = (arg_12_0._prePos + var_12_0) / 2

	var_12_1.y = var_12_0.y + var_0_1

	ZProj.TweenHelper.DOMove(arg_12_0._runeTrans, var_12_1.x, var_12_1.y, var_12_1.z, var_0_5, arg_12_0.onTweenPos2, arg_12_0, arg_12_0._prePos, EaseType.Linear)

	arg_12_0._tweenId2 = ZProj.TweenHelper.DORotate(arg_12_0._runeTrans, arg_12_0._preEulerAngles.x, arg_12_0._preEulerAngles.y, arg_12_0._preEulerAngles.z, var_0_7, arg_12_0.onTweenEnd2, arg_12_0, nil, EaseType.Linear)
	arg_12_0._prePos = nil
end

function var_0_0.onTweenPos2(arg_13_0, arg_13_1)
	ZProj.TweenHelper.DOMove(arg_13_0._runeTrans, arg_13_1.x, arg_13_1.y, arg_13_1.z, var_0_6, nil, nil, nil, EaseType.Linear)
end

function var_0_0.onTweenEnd2(arg_14_0)
	arg_14_0._anim.enabled = true
	arg_14_0._tweenId = nil
	arg_14_0._tweenId2 = nil

	arg_14_0._anim:Play("active", 0, var_0_13)
	ExploreModel.instance:setStepPause(false)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Rune)
end

function var_0_0.onResLoaded(arg_15_0)
	arg_15_0._anim = gohelper.findChildComponent(arg_15_0._displayGo, "zj_01_jh_mfdj_01/root", typeof(UnityEngine.Animator))
	arg_15_0._runeTrans = gohelper.findChild(arg_15_0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan").transform
	arg_15_0._normalRoot = gohelper.findChild(arg_15_0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/normal")
	arg_15_0._activeRoot = gohelper.findChild(arg_15_0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect")
	arg_15_0._activeRoot2 = gohelper.findChild(arg_15_0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/emissive")
	arg_15_0._effect1 = gohelper.findChild(arg_15_0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect_jihuo")
	arg_15_0._effect2 = gohelper.findChild(arg_15_0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect_fanjihuo")

	gohelper.setActive(arg_15_0._effect1, false)
	gohelper.setActive(arg_15_0._effect2, false)
	arg_15_0:checkActive()
end

function var_0_0.checkActive(arg_16_0)
	local var_16_0 = ExploreBackpackModel.instance:getItemMoByEffect(ExploreEnum.ItemEffect.Active)

	if not var_16_0 then
		return
	end

	local var_16_1 = var_16_0.status
	local var_16_2 = ExploreEnum.RuneStatus.Active == var_16_1

	gohelper.setActive(arg_16_0._activeRoot, var_16_2)
	gohelper.setActive(arg_16_0._activeRoot2, var_16_2)
	gohelper.setActive(arg_16_0._normalRoot, not var_16_2)
end

function var_0_0.destroy(arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.onAnimEnd, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.onBackAnimEnd, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._delayShowActiveEffect, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0._delayPlayRuneUnitAnim, arg_17_0)
	TaskDispatcher.cancelTask(arg_17_0.flyBack, arg_17_0)

	if arg_17_0._tweenId then
		ZProj.TweenHelper.KillById(arg_17_0._tweenId)

		arg_17_0._tweenId = nil
	end

	if arg_17_0._tweenId2 then
		ZProj.TweenHelper.KillById(arg_17_0._tweenId2)

		arg_17_0._tweenId2 = nil
	end

	if arg_17_0._runeTrans then
		ZProj.TweenHelper.KillByObj(arg_17_0._runeTrans)

		arg_17_0._runeTrans = nil
	end

	arg_17_0._tweenEndCallBack = nil
	arg_17_0._tweenEndCallObj = nil
	arg_17_0._anim = nil
	arg_17_0._activeRoot = nil
	arg_17_0._activeRoot2 = nil

	ExploreModel.instance:setStepPause(false)
	var_0_0.super.destroy(arg_17_0)
end

return var_0_0
