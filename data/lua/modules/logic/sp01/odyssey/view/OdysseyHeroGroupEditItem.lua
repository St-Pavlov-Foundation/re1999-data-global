module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupEditItem", package.seeall)

local var_0_0 = class("OdysseyHeroGroupEditItem", HeroGroupEditItem)

function var_0_0._onItemClick(arg_1_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if arg_1_0._heroItem:getIsRepeat() then
		GameFacade.showToast(ToastEnum.TrialIsJoin)

		return
	end

	local var_1_0 = HeroSingleGroupModel.instance:getById(arg_1_0._view.viewContainer.viewParam.singleGroupMOId)

	if arg_1_0._mo:isTrial() and not HeroSingleGroupModel.instance:isInGroup(arg_1_0._mo.uid) and (var_1_0:isEmpty() or not var_1_0.trial) and HeroGroupEditListModel.instance:isTrialLimit() then
		GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

		return
	end

	if arg_1_0._mo.isPosLock or not var_1_0:isEmpty() and var_1_0.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	local var_1_1 = arg_1_0._mo.heroId

	if var_1_0.trial and var_1_0.trial ~= 0 then
		local var_1_2 = lua_hero_trial.configDict[var_1_0.trial][var_1_0.trialTemplate]

		if var_1_2 == nil then
			logError("奥德赛下半活动 不存在的试用角色id：" .. var_1_0.trial)

			return
		end

		if arg_1_0._isSelect and var_1_1 == var_1_2.heroId then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		elseif arg_1_0._isSelect == false and var_1_1 ~= var_1_2.heroId then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end
	elseif var_1_0.heroUid ~= nil and var_1_0.heroUid ~= "0" then
		local var_1_3 = HeroModel.instance:getById(var_1_0.heroUid)

		if var_1_3 == nil then
			logError("奥德赛下半活动 不存在的角色 uid：" .. var_1_0.heroUid)

			return
		end

		local var_1_4 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
		local var_1_5 = tonumber(var_1_4.value)
		local var_1_6 = lua_hero_trial.configDict[var_1_5][0]

		if var_1_3.heroId == var_1_6.heroId then
			if arg_1_0._isSelect and var_1_1 == var_1_6.heroId then
				GameFacade.showToast(ToastEnum.TrialCantTakeOff)

				return
			elseif arg_1_0._isSelect == false and var_1_1 ~= var_1_6.heroId then
				GameFacade.showToast(ToastEnum.TrialCantTakeOff)

				return
			end
		end
	end

	if HeroGroupModel.instance:isRestrict(arg_1_0._mo.uid) then
		local var_1_7 = HeroGroupModel.instance:getCurrentBattleConfig()
		local var_1_8 = var_1_7 and var_1_7.restrictReason

		if not string.nilorempty(var_1_8) then
			ToastController.instance:showToastWithString(var_1_8)
		end

		return
	end

	if arg_1_0._isSelect and arg_1_0._enableDeselect and not arg_1_0._mo.isPosLock then
		arg_1_0._view:selectCell(arg_1_0._index, false)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem)
	else
		arg_1_0._view:selectCell(arg_1_0._index, true)
	end
end

return var_0_0
