module("modules.logic.fight.view.FightTopRightView", package.seeall)

local var_0_0 = class("FightTopRightView", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.topRightBtnRoot = gohelper.findChild(arg_1_0.viewGO, "root/btns")
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:checkAddSurvivalBtn()
	arg_4_0:com_openSubView(FightAutoBtnView, gohelper.findChild(arg_4_0.topRightBtnRoot, "btnAuto"))
end

function var_0_0.checkAddSurvivalBtn(arg_5_0)
	if not (FightDataHelper.fieldMgr:isShelter() or FightDataHelper.fieldMgr:isSurvival()) then
		return
	end

	local var_5_0 = "ui/viewres/fight/fightsurvivalbagbtnview.prefab"

	arg_5_0.survivalBtnLoader = PrefabInstantiate.Create(arg_5_0.topRightBtnRoot)

	arg_5_0.survivalBtnLoader:startLoad(var_5_0, arg_5_0.onSurvivalBtnLoaded, arg_5_0)
end

function var_0_0.onSurvivalBtnLoaded(arg_6_0)
	local var_6_0 = arg_6_0.survivalBtnLoader:getInstGO()

	gohelper.setAsFirstSibling(var_6_0)

	arg_6_0.survivalClick = gohelper.getClickWithDefaultAudio(var_6_0)

	arg_6_0.survivalClick:AddClickListener(arg_6_0.onClickCollection, arg_6_0)
end

function var_0_0.onClickCollection(arg_7_0)
	ViewMgr.instance:openView(ViewName.SurvivalEquipOverView)
end

function var_0_0.onClose(arg_8_0)
	if arg_8_0.survivalBtnLoader then
		arg_8_0.survivalBtnLoader:dispose()

		arg_8_0.survivalBtnLoader = nil
	end

	if arg_8_0.survivalClick then
		arg_8_0.survivalClick:RemoveClickListener()

		arg_8_0.survivalClick = nil
	end
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
