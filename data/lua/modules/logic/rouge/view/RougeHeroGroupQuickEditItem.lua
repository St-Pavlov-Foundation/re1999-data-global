module("modules.logic.rouge.view.RougeHeroGroupQuickEditItem", package.seeall)

local var_0_0 = class("RougeHeroGroupQuickEditItem", RougeHeroGroupEditItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._goframe = gohelper.findChild(arg_1_1, "frame")
	arg_1_0._goframehp = gohelper.findChild(arg_1_1, "frame_hp")
	arg_1_0._imageorder = gohelper.findChildImage(arg_1_1, "#go_orderbg/#image_order")
	arg_1_0._goorderbg = gohelper.findChild(arg_1_1, "#go_orderbg")

	arg_1_0:enableDeselect(false)
	arg_1_0._heroItem:setNewShow(false)
	gohelper.setActive(arg_1_0._goorderbg, false)
	gohelper.setActive(arg_1_0._goframe, false)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._edityType = RougeHeroGroupEditListModel.instance:getHeroGroupEditType()
	arg_2_0._isSelectHeroType = arg_2_0._edityType == RougeEnum.HeroGroupEditType.SelectHero
	arg_2_0._isInitType = arg_2_0._edityType == RougeEnum.HeroGroupEditType.Init
	arg_2_0._mo = arg_2_1

	arg_2_0._heroItem:onUpdateMO(arg_2_1)
	arg_2_0._heroItem:setNewShow(false)
	arg_2_0:_updateCapacity(arg_2_1)
	arg_2_0:_updateHp()

	if not arg_2_1:isTrial() then
		local var_2_0 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(arg_2_1.heroId)

		if var_2_0 > arg_2_1.level then
			arg_2_0._heroItem:setBalanceLv(var_2_0)
		end
	end

	arg_2_0:updateTrialTag()
	arg_2_0:updateTrialRepeat()
	arg_2_0._heroItem:setRepeatAnimFinish()

	local var_2_1 = RougeHeroGroupQuickEditListModel.instance:getHeroTeamPos(arg_2_0._mo.uid)

	if arg_2_0._edityType == RougeEnum.HeroGroupEditType.FightAssit then
		local var_2_2 = RougeHeroGroupQuickEditListModel.instance:getAssitPosIndex(arg_2_0._mo.uid)
		local var_2_3 = var_2_1 == 0 and var_2_2

		if var_2_3 then
			local var_2_4 = var_2_2 - RougeEnum.FightTeamNormalHeroNum

			var_2_3 = RougeHeroGroupQuickEditListModel.instance:getHeroUidByPos(var_2_4) ~= "0"
		end

		gohelper.setActive(arg_2_0._goassit, var_2_3)
	else
		gohelper.setActive(arg_2_0._goassit, false)
	end

	arg_2_0._team_pos_index = var_2_1

	if var_2_1 ~= 0 then
		if not arg_2_0._open_ani_finish then
			TaskDispatcher.runDelay(arg_2_0._show_goorderbg, arg_2_0, 0.3)
		else
			arg_2_0:_show_goorderbg()
		end
	else
		gohelper.setActive(arg_2_0._goorderbg, false)
		gohelper.setActive(arg_2_0._goframehp, false)
		gohelper.setActive(arg_2_0._goframe, false)
	end

	arg_2_0._open_ani_finish = true

	arg_2_0:tickUpdateDLCs(arg_2_1)
end

function var_0_0.updateTrialRepeat(arg_3_0, arg_3_1)
	if arg_3_1 and (arg_3_1.heroId ~= arg_3_0._mo.heroId or arg_3_1 == arg_3_0._mo) then
		return
	end

	local var_3_0 = RougeHeroGroupQuickEditListModel.instance:isRepeatHero(arg_3_0._mo.heroId, arg_3_0._mo.uid)

	arg_3_0._heroItem:setTrialRepeat(var_3_0)
end

function var_0_0._show_goorderbg(arg_4_0)
	local var_4_0 = arg_4_0:_isHideHp()

	gohelper.setActive(arg_4_0._goorderbg, true)
	gohelper.setActive(arg_4_0._goframehp, not var_4_0)
	gohelper.setActive(arg_4_0._goframe, var_4_0)

	local var_4_1 = not arg_4_0._isSelectHeroType and not arg_4_0._isInitType

	gohelper.setActive(arg_4_0._goorderbg, var_4_1)

	if not var_4_1 then
		return
	end

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_4_0._imageorder, "biandui_shuzi_" .. arg_4_0._team_pos_index)
end

function var_0_0._onItemClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_5_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if arg_5_0._mo and arg_5_0._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_5_0._mo and RougeHeroSingleGroupModel.instance:isAidConflict(arg_5_0._mo.heroId) then
		GameFacade.showToast(ToastEnum.HeroIsAidConflict)

		return
	end

	local var_5_0 = RougeModel.instance:getTeamInfo():getHeroHp(arg_5_0._mo.heroId)

	if var_5_0 and var_5_0.life <= 0 then
		GameFacade.showToast(ToastEnum.V1a6CachotToast04)

		return
	end

	if HeroGroupModel.instance:isRestrict(arg_5_0._mo.uid) then
		local var_5_1 = HeroGroupModel.instance:getCurrentBattleConfig()
		local var_5_2 = var_5_1 and var_5_1.restrictReason

		if not string.nilorempty(var_5_2) then
			ToastController.instance:showToastWithString(var_5_2)
		end

		return
	end

	if arg_5_0._mo:isTrial() and not RougeHeroGroupQuickEditListModel.instance:inInTeam(arg_5_0._mo.uid) and RougeHeroGroupQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_5_0._mo and not arg_5_0._mo.isPosLock and not RougeHeroGroupQuickEditListModel.instance:selectHero(arg_5_0._mo.uid) then
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
