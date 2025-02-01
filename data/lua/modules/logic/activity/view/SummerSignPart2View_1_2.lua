module("modules.logic.activity.view.SummerSignPart2View_1_2", package.seeall)

slot0 = class("SummerSignPart2View_1_2", ActivityNorSignViewBase_1_2)

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorule, false)

	slot0._actId = ActivityEnum.Activity.SummerSignPart2_1_2

	Activity101Rpc.instance:sendGet101InfosRequest(slot0._actId)
	slot0._titleicon:LoadImage(ResUrl.getActivityLangIcon("qiandao_biaoti_xia"))
	slot0._simagebanner:LoadImage(ResUrl.getActivityFullBg("qiandao_bg_xia"))
end

return slot0
