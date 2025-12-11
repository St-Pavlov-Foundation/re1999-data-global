module("modules.logic.survival.view.map.comp.SurvivalInitHeroSelectQuickEditItem", package.seeall)

local var_0_0 = class("SurvivalInitHeroSelectQuickEditItem", SurvivalInitHeroSelectEditItem)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._goframe = gohelper.findChild(arg_1_1, "frame")
	arg_1_0._txtorder = gohelper.findChildTextMesh(arg_1_1, "go_order/txt_order")
	arg_1_0._goorderbg = gohelper.findChild(arg_1_1, "go_order")

	arg_1_0:enableDeselect(false)
	arg_1_0._heroItem:setNewShow(false)
	arg_1_0._heroItem:_setTxtPos("_nameCnTxt", 0.55, 68.9)
	arg_1_0._heroItem:_setTxtPos("_nameEnTxt", 0.55, 36.1)
	arg_1_0._heroItem:_setTxtPos("_lvObj", 1.7, 96.8)
	arg_1_0._heroItem:_setTxtPos("_rankObj", 1.7, -107.7)
	arg_1_0._heroItem:_setTranScale("_nameCnTxt", 1.25, 1.25)
	arg_1_0._heroItem:_setTranScale("_nameEnTxt", 1.25, 1.25)
	arg_1_0._heroItem:_setTranScale("_lvObj", 1.25, 1.25)
	arg_1_0._heroItem:_setTranScale("_rankObj", 0.22, 0.22)
	arg_1_0._heroItem:setStyle_SurvivalHeroGroupEdit()
	gohelper.setActive(arg_1_0._goorderbg, false)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._mo = arg_2_1

	arg_2_0._heroItem:onUpdateMO(arg_2_1)
	arg_2_0._heroItem:setNewShow(false)

	if not arg_2_1:isTrial() then
		local var_2_0 = SurvivalBalanceHelper.getHeroBalanceLv(arg_2_1.heroId)

		if var_2_0 > arg_2_1.level then
			arg_2_0._heroItem:setBalanceLv(var_2_0)
		end
	end

	arg_2_0:updateLimitStatus()
	arg_2_0:updateTrialTag()
	arg_2_0:updateTrialRepeat()
	arg_2_0._heroItem:setRepeatAnimFinish()

	local var_2_1 = arg_2_0:getGroupModel():getMoIndex(arg_2_1)

	arg_2_0._team_pos_index = var_2_1

	gohelper.setActive(arg_2_0._goorderbg, var_2_1 > 0)
	gohelper.setActive(arg_2_0._goframe, var_2_1 > 0)

	if var_2_1 > 0 then
		arg_2_0._txtorder.text = var_2_1
	end

	arg_2_0._open_ani_finish = true

	arg_2_0._healthPart:setHeroId(arg_2_1.heroId)
end

function var_0_0.updateTrialRepeat(arg_3_0, arg_3_1)
	if arg_3_1 and (arg_3_1.heroId ~= arg_3_0._mo.heroId or arg_3_1 == arg_3_0._mo) then
		return
	end

	arg_3_0._heroItem:setTrialRepeat(false)
end

function var_0_0._onItemClick(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if SurvivalShelterModel.instance:getWeekInfo():getHeroMo(arg_4_0._mo.heroId).health == 0 then
		GameFacade.showToast(ToastEnum.SurvivalHeroDead)

		return
	end

	local var_4_0 = arg_4_0:getGroupModel():getMoIndex(arg_4_0._mo)

	if var_4_0 > 0 then
		arg_4_0:getGroupModel().allSelectHeroMos[var_4_0] = nil

		gohelper.setActive(arg_4_0._goorderbg, false)
		gohelper.setActive(arg_4_0._goframe, false)
	else
		local var_4_1 = arg_4_0:getGroupModel():tryAddHeroMo(arg_4_0._mo)

		if var_4_1 then
			arg_4_0._view:selectCell(arg_4_0._index, true)
			gohelper.setActive(arg_4_0._goorderbg, true)
			gohelper.setActive(arg_4_0._goframe, true)

			arg_4_0._txtorder.text = var_4_1
		else
			GameFacade.showToast(ToastEnum.SurvivalInitHeroLimit)
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHeroEditItemSelectChange, arg_4_0._mo)
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	arg_5_0._isSelect = arg_5_1

	if arg_5_1 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroEditItem, arg_5_0._mo)
	end
end

function var_0_0.getGroupModel(arg_6_0)
	return SurvivalMapModel.instance:getInitGroup()
end

return var_0_0
