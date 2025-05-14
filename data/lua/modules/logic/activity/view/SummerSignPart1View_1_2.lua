module("modules.logic.activity.view.SummerSignPart1View_1_2", package.seeall)

local var_0_0 = class("SummerSignPart1View_1_2", ActivityNorSignViewBase_1_2)

function var_0_0._editableInitView(arg_1_0)
	gohelper.setActive(arg_1_0._gorule, false)

	arg_1_0._actId = ActivityEnum.Activity.SummerSignPart1_1_2

	Activity101Rpc.instance:sendGet101InfosRequest(arg_1_0._actId)
	arg_1_0._titleicon:LoadImage(ResUrl.getActivityLangIcon("qiandao_biaoti_shang"))
	arg_1_0._simagebanner:LoadImage(ResUrl.getActivityFullBg("qiandao_bg_shang"))
end

return var_0_0
