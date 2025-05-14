module("modules.logic.rouge.dlc.101.view.RougeLimiterGroupItem", package.seeall)

local var_0_0 = class("RougeLimiterGroupItem", LuaCompBase)
local var_0_1 = {
	Locked2UnLocked = "tounlock",
	Locked = "locked",
	UnLocked = "unlock",
	MaxLevel = "tohighest"
}

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.go, "#go_unlock")
	arg_1_0._imagebufficon = gohelper.findChildImage(arg_1_0.go, "#go_unlock/#image_bufficon")
	arg_1_0._txtbufflevel = gohelper.findChildText(arg_1_0.go, "#go_unlock/#txt_bufflevel")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.go, "#btn_cancel")
	arg_1_0._golocked = gohelper.findChild(arg_1_0.go, "#go_locked")
	arg_1_0._btnclick = gohelper.findChildButton(arg_1_0.go, "#btn_click")
	arg_1_0._gofulleffect = gohelper.findChild(arg_1_0.go, "debuff3_light")
	arg_1_0._goaddeffect = gohelper.findChild(arg_1_0.go, "click")
	arg_1_0._animator = gohelper.onceAddComponent(arg_1_0.go, gohelper.Type_Animator)

	arg_1_0:addEventCb(RougeDLCController101.instance, RougeDLCEvent101.UpdateLimitGroup, arg_1_0._updateLimiterGroup, arg_1_0)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelkOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	arg_4_0:refreshUI()
end

function var_0_0.refreshUI(arg_5_0)
	local var_5_0 = RougeDLCModel101.instance:getCurLimiterGroupState(arg_5_0._mo.id) == RougeDLCEnum101.LimitState.Locked

	arg_5_0._curLimitGroupLv = RougeDLCModel101.instance:getCurLimiterGroupLv(arg_5_0._mo.id)
	arg_5_0._maxLimitGroupLv = RougeDLCConfig101.instance:getLimiterGroupMaxLevel(arg_5_0._mo.id)
	arg_5_0._isCurMaxGroupLv = arg_5_0._curLimitGroupLv >= arg_5_0._maxLimitGroupLv

	gohelper.setActive(arg_5_0._golocked, var_5_0)
	gohelper.setActive(arg_5_0._gounlock, not var_5_0)
	gohelper.setActive(arg_5_0._btncancel.gameObject, not var_5_0 and arg_5_0._curLimitGroupLv > 0)
	gohelper.setActive(arg_5_0._txtbufflevel.gameObject, not var_5_0 and arg_5_0._curLimitGroupLv <= arg_5_0._maxLimitGroupLv)

	if not var_5_0 then
		arg_5_0._txtbufflevel.text = GameUtil.getRomanNums(arg_5_0._curLimitGroupLv)

		UISpriteSetMgr.instance:setRouge4Sprite(arg_5_0._imagebufficon, arg_5_0._mo.icon)
	end

	local var_5_1 = var_0_1.Locked

	if not var_5_0 then
		if arg_5_0._isCurMaxGroupLv then
			var_5_1 = var_0_1.MaxLevel
		else
			var_5_1 = RougeDLCModel101.instance:isLimiterGroupNewUnlocked(arg_5_0._mo.id) and var_0_1.Locked2UnLocked or var_0_1.UnLocked
		end
	end

	gohelper.setActive(arg_5_0._gofulleffect, arg_5_0._isCurMaxGroupLv)
	arg_5_0._animator:Play(var_5_1, 0, 0)
end

function var_0_0._btncancelkOnClick(arg_6_0)
	RougeDLCModel101.instance:removeLimiterGroupLv(arg_6_0._mo.id)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips, arg_6_0._mo.id)
end

function var_0_0._btnclickOnClick(arg_7_0)
	if RougeDLCModel101.instance:getCurLimiterGroupState(arg_7_0._mo.id) == RougeDLCEnum101.LimitState.Locked then
		RougeDLCController101.instance:openRougeLimiterLockedTipsView({
			limiterGroupId = arg_7_0._mo.id
		})

		return
	end

	if not arg_7_0._isCurMaxGroupLv then
		gohelper.setActive(arg_7_0._goaddeffect, false)
		gohelper.setActive(arg_7_0._goaddeffect, true)

		if arg_7_0._curLimitGroupLv + 1 == arg_7_0._maxLimitGroupLv then
			AudioMgr.instance:trigger(AudioEnum.UI.ClickLimiter2MaxLevel)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.AddLimiterLevel)
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.MaxLevelLimiter)
	end

	RougeDLCModel101.instance:addLimiterGroupLv(arg_7_0._mo.id)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips, arg_7_0._mo.id)
end

function var_0_0._updateLimiterGroup(arg_8_0, arg_8_1)
	if arg_8_0._mo and arg_8_0._mo.id == arg_8_1 then
		arg_8_0:refreshUI()
	end
end

function var_0_0.onDestroy(arg_9_0)
	return
end

return var_0_0
