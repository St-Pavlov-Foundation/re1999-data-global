module("modules.logic.rouge.dlc.101.view.RougeLimiterGroupItem", package.seeall)

slot0 = class("RougeLimiterGroupItem", LuaCompBase)
slot1 = {
	Locked2UnLocked = "tounlock",
	Locked = "locked",
	UnLocked = "unlock",
	MaxLevel = "tohighest"
}

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gounlock = gohelper.findChild(slot0.go, "#go_unlock")
	slot0._imagebufficon = gohelper.findChildImage(slot0.go, "#go_unlock/#image_bufficon")
	slot0._txtbufflevel = gohelper.findChildText(slot0.go, "#go_unlock/#txt_bufflevel")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.go, "#btn_cancel")
	slot0._golocked = gohelper.findChild(slot0.go, "#go_locked")
	slot0._btnclick = gohelper.findChildButton(slot0.go, "#btn_click")
	slot0._gofulleffect = gohelper.findChild(slot0.go, "debuff3_light")
	slot0._goaddeffect = gohelper.findChild(slot0.go, "click")
	slot0._animator = gohelper.onceAddComponent(slot0.go, gohelper.Type_Animator)

	slot0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, slot0._updateLimiterGroup, slot0)
end

function slot0.addEventListeners(slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelkOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btncancel:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot2 = RougeDLCModel101.instance:getCurLimiterGroupState(slot0._mo.id) == RougeDLCEnum101.LimitState.Locked
	slot0._curLimitGroupLv = RougeDLCModel101.instance:getCurLimiterGroupLv(slot0._mo.id)
	slot0._maxLimitGroupLv = RougeDLCConfig101.instance:getLimiterGroupMaxLevel(slot0._mo.id)
	slot0._isCurMaxGroupLv = slot0._maxLimitGroupLv <= slot0._curLimitGroupLv

	gohelper.setActive(slot0._golocked, slot2)
	gohelper.setActive(slot0._gounlock, not slot2)
	gohelper.setActive(slot0._btncancel.gameObject, not slot2 and slot0._curLimitGroupLv > 0)
	gohelper.setActive(slot0._txtbufflevel.gameObject, not slot2 and slot0._curLimitGroupLv <= slot0._maxLimitGroupLv)

	if not slot2 then
		slot0._txtbufflevel.text = GameUtil.getRomanNums(slot0._curLimitGroupLv)

		UISpriteSetMgr.instance:setRouge4Sprite(slot0._imagebufficon, slot0._mo.icon)
	end

	slot3 = uv0.Locked

	if not slot2 then
		slot3 = (not slot0._isCurMaxGroupLv or uv0.MaxLevel) and (RougeDLCModel101.instance:isLimiterGroupNewUnlocked(slot0._mo.id) and uv0.Locked2UnLocked or uv0.UnLocked)
	end

	gohelper.setActive(slot0._gofulleffect, slot0._isCurMaxGroupLv)
	slot0._animator:Play(slot3, 0, 0)
end

function slot0._btncancelkOnClick(slot0)
	RougeDLCModel101.instance:removeLimiterGroupLv(slot0._mo.id)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips, slot0._mo.id)
end

function slot0._btnclickOnClick(slot0)
	if RougeDLCModel101.instance:getCurLimiterGroupState(slot0._mo.id) == RougeDLCEnum101.LimitState.Locked then
		RougeDLCController101.instance:openRougeLimiterLockedTipsView({
			limiterGroupId = slot0._mo.id
		})

		return
	end

	if not slot0._isCurMaxGroupLv then
		gohelper.setActive(slot0._goaddeffect, false)
		gohelper.setActive(slot0._goaddeffect, true)

		if slot0._curLimitGroupLv + 1 == slot0._maxLimitGroupLv then
			AudioMgr.instance:trigger(AudioEnum.UI.ClickLimiter2MaxLevel)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.AddLimiterLevel)
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.MaxLevelLimiter)
	end

	RougeDLCModel101.instance:addLimiterGroupLv(slot0._mo.id)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips, slot0._mo.id)
end

function slot0._updateLimiterGroup(slot0, slot1)
	if slot0._mo and slot0._mo.id == slot1 then
		slot0:refreshUI()
	end
end

function slot0.onDestroy(slot0)
end

return slot0
