module("modules.logic.seasonver.act166.view.Season166FightQuitTipView", package.seeall)

local var_0_0 = class("Season166FightQuitTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntargetShow = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_quitshowview/center/layout/passtarget/#go_conditionitem/passtargetTip/tip/#btn_targetShow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntargetShow:AddClickListener(arg_2_0._btntargetShowOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntargetShow:RemoveClickListener()
end

function var_0_0._btntargetShowOnClick(arg_4_0)
	Season166Controller.instance:openSeason166TargetView()
end

function var_0_0._editableInitView(arg_5_0)
	return
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = Season166Model.instance:getCurSeasonId()

	if not arg_7_0.actId then
		gohelper.setActive(arg_7_0._btntargetShow, false)

		return
	end

	local var_7_0 = Season166Model.instance:getBattleContext(true)
	local var_7_1 = var_7_0 and var_7_0.baseId and var_7_0.baseId > 0

	gohelper.setActive(arg_7_0._btntargetShow, var_7_1)
end

function var_0_0.refreshUI(arg_8_0)
	return
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	return
end

return var_0_0
