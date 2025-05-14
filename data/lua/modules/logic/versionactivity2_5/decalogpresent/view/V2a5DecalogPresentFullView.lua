module("modules.logic.versionactivity2_5.decalogpresent.view.V2a5DecalogPresentFullView", package.seeall)

local var_0_0 = class("V2a5DecalogPresentFullView", V1a9DecalogPresentFullView)

function var_0_0.refreshRemainTime(arg_1_0)
	local var_1_0 = DecalogPresentModel.instance:getDecalogPresentActId()
	local var_1_1 = ActivityModel.instance:getActMO(var_1_0):getRemainTimeStr3(false, true)

	arg_1_0._txtremainTime.text = var_1_1
end

function var_0_0.onOpen(arg_2_0)
	local var_2_0 = arg_2_0.viewParam.parent

	gohelper.addChild(var_2_0, arg_2_0.viewGO)
	arg_2_0:refresh()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_qiyuan_unlock_2)
end

return var_0_0
