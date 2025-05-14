module("modules.logic.explore.map.unit.ExploreBonusUnit", package.seeall)

local var_0_0 = class("ExploreBonusUnit", ExploreBaseMoveUnit)

function var_0_0.canTrigger(arg_1_0)
	if arg_1_0.mo:isInteractActiveState() then
		return false
	end

	return var_0_0.super.canTrigger(arg_1_0)
end

function var_0_0.playAnim(arg_2_0, arg_2_1)
	var_0_0.super.playAnim(arg_2_0, arg_2_1)

	if arg_2_1 == ExploreAnimEnum.AnimName.nToA then
		PopupController.instance:setPause("ExploreBonusUnit_EXIT", true)

		local var_2_0 = ExploreController.instance:getMap():getHero()

		var_2_0:onCheckDir(var_2_0.nodePos, arg_2_0.nodePos)
		var_2_0:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.OpenChest, true, true)
		arg_2_0.animComp:setShowEffect(false)
	end
end

function var_0_0.onAnimEnd(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == ExploreAnimEnum.AnimName.nToA then
		AudioMgr.instance:trigger(AudioEnum.Summon.stop_ui_callfor_cordage02)
		PopupController.instance:setPause("ExploreBonusUnit_EXIT", false)

		if arg_3_0:checkHavePopup() then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_3_0.checkHavePopup, arg_3_0)
		end
	end

	var_0_0.super.onAnimEnd(arg_3_0, arg_3_1, arg_3_2)
end

function var_0_0.checkHavePopup(arg_4_0)
	if PopupController.instance:getPopupCount() > 0 or ViewMgr.instance:isOpen(ViewName.ExploreGetItemView) or ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return true
	else
		arg_4_0:onPopupEnd()
	end
end

function var_0_0.onPopupEnd(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_5_0.checkHavePopup, arg_5_0)
	arg_5_0.animComp:setShowEffect(true)
	arg_5_0.animComp:_setCurAnimName(ExploreAnimEnum.AnimName.active)
end

function var_0_0.onDestroy(arg_6_0, ...)
	PopupController.instance:setPause("ExploreBonusUnit_EXIT", false)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_6_0.checkHavePopup, arg_6_0)
	var_0_0.super.onDestroy(arg_6_0, ...)
end

return var_0_0
