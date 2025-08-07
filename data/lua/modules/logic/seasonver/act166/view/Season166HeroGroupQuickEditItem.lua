module("modules.logic.seasonver.act166.view.Season166HeroGroupQuickEditItem", package.seeall)

local var_0_0 = class("Season166HeroGroupQuickEditItem", Season166HeroGroupEditItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._txtorder = gohelper.findChildText(arg_1_1, "#go_orderbg/#txt_order")
	arg_1_0._goorderbg = gohelper.findChild(arg_1_1, "#go_orderbg")

	arg_1_0:enableDeselect(false)
	arg_1_0._heroItem:setNewShow(false)
	gohelper.setActive(arg_1_0._goorderbg, false)

	arg_1_0._itemAnim.speed = 1
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1

	arg_2_0._heroItem:onUpdateMO(arg_2_1)
	arg_2_0._heroItem:setNewShow(false)

	if not arg_2_1:isTrial() then
		local var_2_0 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_2_1.heroId)

		if var_2_0 > arg_2_1.level then
			arg_2_0._heroItem:setBalanceLv(var_2_0)
		end
	end

	arg_2_0:updateTrialTag()
	arg_2_0:updateTrialRepeat()

	local var_2_1 = Season166HeroGroupQuickEditModel.instance:getHeroTeamPos(arg_2_0._mo.uid)

	arg_2_0._team_pos_index = var_2_1

	if var_2_1 ~= 0 then
		if not arg_2_0._open_ani_finish then
			TaskDispatcher.runDelay(arg_2_0._show_goorderbg, arg_2_0, 0.3)
		else
			arg_2_0:_show_goorderbg()
		end
	else
		gohelper.setActive(arg_2_0._goorderbg, false)
	end

	arg_2_0._open_ani_finish = true

	arg_2_0:refreshSelectState()
end

function var_0_0._show_goorderbg(arg_3_0)
	gohelper.setActive(arg_3_0._goorderbg, true)

	arg_3_0._txtorder.text = arg_3_0._team_pos_index
end

function var_0_0.updateTrialRepeat(arg_4_0, arg_4_1)
	if arg_4_1 and (arg_4_1.heroId ~= arg_4_0._mo.heroId or arg_4_1 == arg_4_0._mo) then
		return
	end

	arg_4_0.isRepeat = Season166HeroGroupQuickEditModel.instance:isRepeatHero(arg_4_0._mo.heroId, arg_4_0._mo.uid)

	arg_4_0._heroItem:setTrialRepeat(arg_4_0.isRepeat)
end

function var_0_0.refreshSelectState(arg_5_0)
	gohelper.setActive(arg_5_0._goMainSelect, false)
	gohelper.setActive(arg_5_0._goHelpSelect, false)
end

function var_0_0._onItemClick(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_6_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if arg_6_0._mo and arg_6_0._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_6_0._mo:isTrial() and not Season166HeroGroupQuickEditModel.instance:isInTeamHero(arg_6_0._mo.uid) and Season166HeroGroupQuickEditModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_6_0._mo and not Season166HeroGroupQuickEditModel.instance:selectHero(arg_6_0._mo.uid) then
		return
	end

	if arg_6_0._isSelect and arg_6_0._enableDeselect then
		arg_6_0._view:selectCell(arg_6_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_6_0._view:selectCell(arg_6_0._index, true)
	end
end

function var_0_0.onSelect(arg_7_0, arg_7_1)
	arg_7_0._isSelect = arg_7_1

	if arg_7_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_7_0._mo)
	end
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._show_goorderbg, arg_8_0)
	var_0_0.super.onDestroy(arg_8_0)
end

return var_0_0
