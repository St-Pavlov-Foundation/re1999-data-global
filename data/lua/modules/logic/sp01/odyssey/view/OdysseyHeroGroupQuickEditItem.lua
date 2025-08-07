module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupQuickEditItem", package.seeall)

local var_0_0 = class("OdysseyHeroGroupQuickEditItem", HeroGroupQuickEditItem)

function var_0_0._onItemClick(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_1_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	if arg_1_0._mo and arg_1_0._mo.isPosLock then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_1_0._mo and HeroSingleGroupModel.instance:isAidConflict(arg_1_0._mo.heroId) then
		GameFacade.showToast(ToastEnum.HeroIsAidConflict)

		return
	end

	if HeroGroupModel.instance:isRestrict(arg_1_0._mo.uid) then
		local var_1_0 = HeroGroupModel.instance:getCurrentBattleConfig()
		local var_1_1 = var_1_0 and var_1_0.restrictReason

		if not string.nilorempty(var_1_1) then
			ToastController.instance:showToastWithString(var_1_1)
		end

		return
	end

	if arg_1_0._mo:isTrial() and not HeroGroupQuickEditListModel.instance:inInTeam(arg_1_0._mo.uid) and HeroGroupQuickEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	local var_1_2 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local var_1_3 = tonumber(var_1_2.value)
	local var_1_4 = lua_hero_trial.configDict[var_1_3][0]

	if arg_1_0._mo.heroId == var_1_4.heroId then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_1_0._mo and not arg_1_0._mo.isPosLock and not HeroGroupQuickEditListModel.instance:selectHero(arg_1_0._mo.uid) then
		return
	end

	if arg_1_0._isSelect and arg_1_0._enableDeselect and not arg_1_0._mo.isPosLock then
		arg_1_0._view:selectCell(arg_1_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_1_0._view:selectCell(arg_1_0._index, true)
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, arg_1_0._mo)
end

return var_0_0
