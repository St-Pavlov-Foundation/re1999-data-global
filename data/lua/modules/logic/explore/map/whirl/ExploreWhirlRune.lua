module("modules.logic.explore.map.whirl.ExploreWhirlRune", package.seeall)

slot0 = class("ExploreWhirlRune", ExploreWhirlBase)
slot1 = -0.1
slot4 = 0.47 + 0.03
slot7 = 0.03 + 0.47
slot8 = 1
slot9 = 1
slot10 = 1
slot12 = 0.4 + 0.6
slot13 = 0.5

function slot0.onInit(slot0)
	slot0._resPath = "explore/zj_01/jiaohu/prefabs/zj_01_jh_mfdj_01.prefab"

	slot0.trans:SetParent(ExploreController.instance:getMap():getHero().trans, false)
end

function slot0.initComponents(slot0)
end

function slot0.flyToPos(slot0, slot1, slot2, slot3)
	if not slot0._runeTrans then
		slot2(slot3)

		return
	end

	slot4 = ExploreController.instance:getMap():getHero()
	slot0._toDir = slot4.dir
	slot0._isHigh = slot1
	slot0._tweenEndCallBack = slot2
	slot0._tweenEndCallObj = slot3
	slot7 = slot4:getPos():Clone()

	slot0._anim:Play("active", 0, uv0)
	slot0._anim:Update(0)

	slot0._prePos = slot0._runeTrans.position
	slot0._preEulerAngles = slot0._runeTrans.eulerAngles

	slot0._anim:Play(slot0:getFlyAnimName(), 0, 0)
	slot0._anim:Update(0)

	slot8 = slot0._runeTrans.eulerAngles
	slot7.y = slot0._runeTrans.position.y
	slot0._anim.enabled = false
	slot0._runeTrans.eulerAngles = slot0._runeTrans.eulerAngles
	slot0._runeTrans.position = slot0._runeTrans.position
	slot9 = (slot0._prePos + slot7) / 2
	slot9.y = slot7.y + uv1

	ZProj.TweenHelper.DOMove(slot0._runeTrans, slot9.x, slot9.y, slot9.z, uv2, slot0.onTweenPos, slot0, slot7, EaseType.Linear)

	slot0._tweenId2 = ZProj.TweenHelper.DORotate(slot0._runeTrans, slot8.x, slot8.y, slot8.z, uv3, slot0.onTweenEnd, slot0, nil, EaseType.Linear)
end

function slot0.onTweenPos(slot0, slot1)
	ZProj.TweenHelper.DOMove(slot0._runeTrans, slot1.x, slot1.y, slot1.z, uv0, nil, , , EaseType.Linear)
end

function slot0.onTweenEnd(slot0)
	slot0._tweenId = nil
	slot0._tweenId2 = nil
	slot0._anim.enabled = true

	slot0._anim:Play(slot0:getFlyAnimName(), 0, 0)
	TaskDispatcher.runDelay(slot0.onAnimEnd, slot0, uv0)
end

function slot0.getFlyAnimName(slot0)
	return slot0:getDirStr()
end

function slot0.getDirStr(slot0)
	if slot0._toDir == 0 then
		return "up"
	elseif slot0._toDir == 90 then
		return "right"
	elseif slot0._toDir == 180 then
		return "down"
	else
		return "left"
	end
end

function slot0.onAnimEnd(slot0)
	if slot0._isHigh then
		slot0._tweenEndCallBack(slot0._tweenEndCallObj)

		slot0._tweenEndCallBack = nil
		slot0._tweenEndCallObj = nil
	else
		gohelper.setActive(slot0._effect2, false)
		gohelper.setActive(slot0._effect2, true)
		TaskDispatcher.runDelay(slot0._delayPlayRuneUnitAnim, slot0, uv0)
		TaskDispatcher.runDelay(slot0.flyBack, slot0, uv1)
	end
end

function slot0._delayPlayRuneUnitAnim(slot0)
	slot0._tweenEndCallBack(slot0._tweenEndCallObj)

	slot0._tweenEndCallBack = nil
	slot0._tweenEndCallObj = nil
end

function slot0.flyBack(slot0)
	gohelper.setActive(slot0._activeRoot, true)

	if slot0._isHigh then
		gohelper.setActive(slot0._effect1, false)
		gohelper.setActive(slot0._effect1, true)
		AudioMgr.instance:trigger(AudioEnum.Explore.ActiveRune)
		TaskDispatcher.runDelay(slot0._delayShowActiveEffect, slot0, uv0)
	else
		slot0:_delayShowActiveEffect()
	end
end

function slot0._delayShowActiveEffect(slot0)
	gohelper.setActive(slot0._activeRoot2, true)
	gohelper.setActive(slot0._normalRoot, false)

	slot0._anim.enabled = true

	slot0._anim:Play(string.format("back_%s", slot0:getDirStr()), 0, 0)
	TaskDispatcher.runDelay(slot0.onBackAnimEnd, slot0, uv0)
end

function slot0.onBackAnimEnd(slot0)
	slot0._anim.enabled = false

	if not slot0._prePos then
		slot0:onTweenEnd2()

		return
	end

	slot1 = slot0._runeTrans.position
	slot2 = (slot0._prePos + slot1) / 2
	slot2.y = slot1.y + uv0

	ZProj.TweenHelper.DOMove(slot0._runeTrans, slot2.x, slot2.y, slot2.z, uv1, slot0.onTweenPos2, slot0, slot0._prePos, EaseType.Linear)

	slot0._tweenId2 = ZProj.TweenHelper.DORotate(slot0._runeTrans, slot0._preEulerAngles.x, slot0._preEulerAngles.y, slot0._preEulerAngles.z, uv2, slot0.onTweenEnd2, slot0, nil, EaseType.Linear)
	slot0._prePos = nil
end

function slot0.onTweenPos2(slot0, slot1)
	ZProj.TweenHelper.DOMove(slot0._runeTrans, slot1.x, slot1.y, slot1.z, uv0, nil, , , EaseType.Linear)
end

function slot0.onTweenEnd2(slot0)
	slot0._anim.enabled = true
	slot0._tweenId = nil
	slot0._tweenId2 = nil

	slot0._anim:Play("active", 0, uv0)
	ExploreModel.instance:setStepPause(false)
	ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.Rune)
end

function slot0.onResLoaded(slot0)
	slot0._anim = gohelper.findChildComponent(slot0._displayGo, "zj_01_jh_mfdj_01/root", typeof(UnityEngine.Animator))
	slot0._runeTrans = gohelper.findChild(slot0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan").transform
	slot0._normalRoot = gohelper.findChild(slot0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/normal")
	slot0._activeRoot = gohelper.findChild(slot0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect")
	slot0._activeRoot2 = gohelper.findChild(slot0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/emissive")
	slot0._effect1 = gohelper.findChild(slot0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect_jihuo")
	slot0._effect2 = gohelper.findChild(slot0._displayGo, "zj_01_jh_mfdj_01/root/zongxuanzhuan/zizhuan/effect_fanjihuo")

	gohelper.setActive(slot0._effect1, false)
	gohelper.setActive(slot0._effect2, false)
	slot0:checkActive()
end

function slot0.checkActive(slot0)
	if not ExploreBackpackModel.instance:getItemMoByEffect(ExploreEnum.ItemEffect.Active) then
		return
	end

	slot3 = ExploreEnum.RuneStatus.Active == slot1.status

	gohelper.setActive(slot0._activeRoot, slot3)
	gohelper.setActive(slot0._activeRoot2, slot3)
	gohelper.setActive(slot0._normalRoot, not slot3)
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0.onAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0.onBackAnimEnd, slot0)
	TaskDispatcher.cancelTask(slot0._delayShowActiveEffect, slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayRuneUnitAnim, slot0)
	TaskDispatcher.cancelTask(slot0.flyBack, slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	if slot0._tweenId2 then
		ZProj.TweenHelper.KillById(slot0._tweenId2)

		slot0._tweenId2 = nil
	end

	if slot0._runeTrans then
		ZProj.TweenHelper.KillByObj(slot0._runeTrans)

		slot0._runeTrans = nil
	end

	slot0._tweenEndCallBack = nil
	slot0._tweenEndCallObj = nil
	slot0._anim = nil
	slot0._activeRoot = nil
	slot0._activeRoot2 = nil

	ExploreModel.instance:setStepPause(false)
	uv0.super.destroy(slot0)
end

return slot0
