module("modules.logic.versionactivity2_5.challenge.view.herogroup.Act183HeroGroupQuickEditItem", package.seeall)

local var_0_0 = class("Act183HeroGroupQuickEditItem", Act183HeroGroupEditItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._goframe = gohelper.findChild(arg_1_1, "frame")
	arg_1_0._goorder = gohelper.findChild(arg_1_1, "go_order")
	arg_1_0._txtorder = gohelper.findChildText(arg_1_1, "go_order/txt_order")
	arg_1_0._gorepress = gohelper.findChild(arg_1_1, "go_repress")

	arg_1_0:enableDeselect(false)
	arg_1_0._heroItem:setNewShow(false)
	gohelper.setActive(arg_1_0._goorder, false)
	gohelper.setActive(arg_1_0._goframe, false)
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
	arg_2_0._heroItem:setRepeatAnimFinish()

	local var_2_1 = Act183HeroGroupQuickEditListModel.instance:getHeroTeamPos(arg_2_0._mo.uid)

	arg_2_0._team_pos_index = var_2_1

	if var_2_1 ~= 0 then
		if not arg_2_0._open_ani_finish then
			TaskDispatcher.runDelay(arg_2_0._show_goorderbg, arg_2_0, 0.3)
		else
			arg_2_0:_show_goorderbg()
		end
	else
		gohelper.setActive(arg_2_0._goorder, false)
		gohelper.setActive(arg_2_0._goframe, false)
	end

	arg_2_0._open_ani_finish = true

	local var_2_2 = HeroGroupModel.instance.episodeId

	arg_2_0._isRepress = Act183Model.instance:isHeroRepressInPreEpisode(var_2_2, arg_2_0._mo.heroId)

	gohelper.setActive(arg_2_0._gorepress, arg_2_0._isRepress)
	arg_2_0._heroItem._commonHeroCard:setGrayScale(arg_2_0._isRepress)
end

function var_0_0.updateTrialRepeat(arg_3_0, arg_3_1)
	if arg_3_1 and (arg_3_1.heroId ~= arg_3_0._mo.heroId or arg_3_1 == arg_3_0._mo) then
		return
	end

	local var_3_0 = Act183HeroGroupQuickEditListModel.instance:isRepeatHero(arg_3_0._mo.heroId, arg_3_0._mo.uid)

	arg_3_0._heroItem:setTrialRepeat(var_3_0)
end

function var_0_0._show_goorderbg(arg_4_0)
	gohelper.setActive(arg_4_0._goorder, true)
	gohelper.setActive(arg_4_0._goframe, true)

	arg_4_0._txtorder.text = arg_4_0._team_pos_index
end

function var_0_0._onItemClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_5_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if arg_5_0._isRepress then
		GameFacade.showToast(ToastEnum.Act183HeroRepress)

		return
	end

	if arg_5_0._mo and arg_5_0._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_5_0._mo and HeroSingleGroupModel.instance:isAidConflict(arg_5_0._mo.heroId) then
		GameFacade.showToast(ToastEnum.HeroIsAidConflict)

		return
	end

	if HeroGroupModel.instance:isRestrict(arg_5_0._mo.uid) then
		local var_5_0 = HeroGroupModel.instance:getCurrentBattleConfig()
		local var_5_1 = var_5_0 and var_5_0.restrictReason

		if not string.nilorempty(var_5_1) then
			ToastController.instance:showToastWithString(var_5_1)
		end

		return
	end

	if arg_5_0._mo:isTrial() and not Act183HeroGroupQuickEditListModel.instance:inInTeam(arg_5_0._mo.uid) and Act183HeroGroupQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_5_0._mo and not arg_5_0._mo.isPosLock and not Act183HeroGroupQuickEditListModel.instance:selectHero(arg_5_0._mo.uid) then
		return
	end

	if arg_5_0._isSelect and arg_5_0._enableDeselect and not arg_5_0._mo.isPosLock then
		arg_5_0._view:selectCell(arg_5_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_5_0._view:selectCell(arg_5_0._index, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, arg_5_0._mo)
end

function var_0_0.onSelect(arg_6_0, arg_6_1)
	arg_6_0._isSelect = arg_6_1

	if arg_6_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_6_0._mo)
	end
end

function var_0_0.onDestroy(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._show_goorderbg, arg_7_0)
	var_0_0.super.onDestroy(arg_7_0)
end

return var_0_0
