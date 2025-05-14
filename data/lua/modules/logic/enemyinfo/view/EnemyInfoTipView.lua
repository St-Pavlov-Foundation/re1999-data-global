module("modules.logic.enemyinfo.view.EnemyInfoTipView", package.seeall)

local var_0_0 = class("EnemyInfoTipView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotipconatiner = gohelper.findChild(arg_1_0.viewGO, "#go_tip_container")
	arg_1_0._goruletip = gohelper.findChild(arg_1_0.viewGO, "#go_tip_container/#go_ruletip")

	gohelper.setActive(arg_1_0._goruletip, false)

	arg_1_0._gobufftip = gohelper.findChild(arg_1_0.viewGO, "#go_tip_container/#go_bufftip")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickCloseTip(arg_4_0)
	arg_4_0.showTip = nil

	arg_4_0:hideAllTip()
	EnemyInfoController.instance:dispatchEvent(EnemyInfoEvent.HideTip)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.closeTipClick = gohelper.findChildClickWithDefaultAudio(arg_5_0._gotipconatiner, "#go_tipclose")

	arg_5_0.closeTipClick:AddClickListener(arg_5_0.onClickCloseTip, arg_5_0)
	arg_5_0:addEventCb(EnemyInfoController.instance, EnemyInfoEvent.ShowTip, arg_5_0.onShowTip, arg_5_0)
end

function var_0_0.onShowTip(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0._gotipconatiner, true)

	if arg_6_0.showTip == arg_6_1 then
		return
	end

	arg_6_0.showTip = arg_6_1

	gohelper.setActive(arg_6_0._gobufftip, arg_6_0.showTip == EnemyInfoEnum.Tip.BuffTip)
end

function var_0_0.hideAllTip(arg_7_0)
	gohelper.setActive(arg_7_0._gotipconatiner, false)
	gohelper.setActive(arg_7_0._gobufftip, false)
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:hideAllTip()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0.closeTipClick:RemoveClickListener()
end

return var_0_0
