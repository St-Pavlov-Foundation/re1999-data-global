module("modules.logic.versionactivity1_4.dailyallowance.DailyAllowanceView", package.seeall)

local var_0_0 = class("DailyAllowanceView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simagePresent = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Present")
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LimitTime/#txt_LimitTime")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "#txt_Descr")

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

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simageFullBG:LoadImage(ResUrl.getV1Aa4DailyAllowanceIcon("v1a4_gold_fullbg"))
	arg_4_0._simagePresent:LoadImage(ResUrl.getV1Aa4DailyAllowanceIcon("v1a4_gold_present"))
end

function var_0_0.onUpdateParam(arg_5_0)
	arg_5_0:_refreshUI()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._actId = arg_6_0.viewParam.actId

	local var_6_0 = arg_6_0.viewParam.parent

	gohelper.addChild(var_6_0, arg_6_0.viewGO)
	arg_6_0:_refreshUI()
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = ActivityModel.instance:getActivityInfo()[arg_7_0._actId]:getRealEndTimeStamp() - ServerTime.now()
	local var_7_1 = Mathf.Floor(var_7_0 / TimeUtil.OneDaySecond)
	local var_7_2 = var_7_0 % TimeUtil.OneDaySecond
	local var_7_3 = Mathf.Floor(var_7_2 / TimeUtil.OneHourSecond)
	local var_7_4 = var_7_1 .. luaLang("time_day") .. var_7_3 .. luaLang("time_hour2")

	arg_7_0._txtLimitTime.text = string.format(luaLang("remain"), var_7_4)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0._simageFullBG:UnLoadImage()
	arg_9_0._simagePresent:UnLoadImage()
end

return var_0_0
