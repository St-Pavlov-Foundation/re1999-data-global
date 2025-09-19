module("modules.logic.survival.view.map.SurvivalHeroGroupFightView", package.seeall)

local var_0_0 = class("SurvivalHeroGroupFightView", HeroGroupFightView)

function var_0_0._editableInitView(arg_1_0)
	arg_1_0:checkHeroList()
	var_0_0.super._editableInitView(arg_1_0)
end

function var_0_0._refreshBtns(arg_2_0, arg_2_1)
	var_0_0.super._refreshBtns(arg_2_0, arg_2_1)
	gohelper.setActive(arg_2_0._dropherogroup, false)
	TaskDispatcher.cancelTask(arg_2_0._checkDropArrow, arg_2_0)
end

function var_0_0.checkHeroList(arg_3_0)
	local var_3_0 = 5
	local var_3_1 = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setMaxHeroCount(var_3_0, SurvivalHeroSingleGroupMO)
	HeroSingleGroupModel.instance:setSingleGroup(var_3_1)
end

function var_0_0.openHeroGroupEditView(arg_4_0)
	ViewMgr.instance:openView(ViewName.SurvivalHeroGroupEditView, arg_4_0._param)
end

function var_0_0._refreshReplay(arg_5_0)
	gohelper.setActive(arg_5_0._goReplayBtn, false)
	gohelper.setActive(arg_5_0._gomemorytimes, false)
end

function var_0_0._refreshPowerShow(arg_6_0)
	gohelper.setActive(arg_6_0._gopowercontent, false)
end

function var_0_0._onClickStart(arg_7_0)
	if SurvivalEquipRedDotHelper.instance.reddotType >= 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.SurvivalEnterFightEquipRed, MsgBoxEnum.BoxType.Yes_No, arg_7_0._realClickStart, nil, nil, arg_7_0, nil, nil)
	else
		var_0_0.super._onClickStart(arg_7_0)
	end
end

function var_0_0._realClickStart(arg_8_0)
	var_0_0.super._onClickStart(arg_8_0)
end

function var_0_0.onClose(arg_9_0)
	var_0_0.super.onClose(arg_9_0)
	HeroSingleGroupModel.instance:setMaxHeroCount()

	HeroGroupTrialModel.instance.curBattleId = nil
end

return var_0_0
