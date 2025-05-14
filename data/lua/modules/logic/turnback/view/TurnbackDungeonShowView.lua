module("modules.logic.turnback.view.TurnbackDungeonShowView", package.seeall)

local var_0_0 = class("TurnbackDungeonShowView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "tipspanel/#txt_time")
	arg_1_0._txtrule = gohelper.findChildText(arg_1_0.viewGO, "tipspanel/#txt_rule")
	arg_1_0._txttipdesc = gohelper.findChildText(arg_1_0.viewGO, "tipspanel/tipsbg/#txt_tipdec")
	arg_1_0._btngoto = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_goto")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngoto:AddClickListener(arg_2_0._btngotoOnClick, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_2_0._refreshRemainTime, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0._refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngoto:RemoveClickListener()
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshRemainTime, arg_3_0._refreshRemainTime, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_3_0._refreshUI, arg_3_0)
end

function var_0_0._btngotoOnClick(arg_4_0)
	if arg_4_0.config.jumpId ~= 0 then
		GameFacade.jump(arg_4_0.config.jumpId)
	end
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getTurnbackIcon("turnback_fullbg"))
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)

	arg_6_0.endTime = arg_6_0:_getEndTime()

	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0.config = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_7_0.viewParam.actId)

	local var_7_0 = string.split(arg_7_0.config.actDesc, "|")

	arg_7_0._txtrule.text = var_7_0[1]

	local var_7_1, var_7_2 = TurnbackModel.instance:getAdditionCountInfo()
	local var_7_3 = var_7_1 == 0 and "#d97373" or "#FFFFFF"

	arg_7_0._txttipdesc.text = string.format("%s (<color=%s>%s</color>/%s)", var_7_0[2], var_7_3, var_7_1, var_7_2)

	arg_7_0:_refreshRemainTime()
end

function var_0_0._refreshRemainTime(arg_8_0)
	arg_8_0._txttime.text = TurnbackController.instance:refreshRemainTime(arg_8_0.endTime)
end

function var_0_0._getEndTime(arg_9_0)
	local var_9_0 = TurnbackModel.instance:getCurTurnbackId()
	local var_9_1 = TurnbackConfig.instance:getAdditionDurationDays(var_9_0)

	return TurnbackModel.instance:getCurTurnbackMo().startTime + var_9_1 * TimeUtil.OneDaySecond
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simagebg:UnLoadImage()
end

return var_0_0
