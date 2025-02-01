module("modules.logic.versionactivity1_4.dailyallowance.DailyAllowanceView", package.seeall)

slot0 = class("DailyAllowanceView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._simagePresent = gohelper.findChildSingleImage(slot0.viewGO, "#simage_Present")
	slot0._txtLimitTime = gohelper.findChildText(slot0.viewGO, "LimitTime/#txt_LimitTime")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "#txt_Descr")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._simageFullBG:LoadImage(ResUrl.getV1Aa4DailyAllowanceIcon("v1a4_gold_fullbg"))
	slot0._simagePresent:LoadImage(ResUrl.getV1Aa4DailyAllowanceIcon("v1a4_gold_present"))
end

function slot0.onUpdateParam(slot0)
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0._actId = slot0.viewParam.actId

	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)
	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot2 = ActivityModel.instance:getActivityInfo()[slot0._actId]:getRealEndTimeStamp() - ServerTime.now()
	slot0._txtLimitTime.text = string.format(luaLang("remain"), Mathf.Floor(slot2 / TimeUtil.OneDaySecond) .. luaLang("time_day") .. Mathf.Floor(slot2 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond) .. luaLang("time_hour2"))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simagePresent:UnLoadImage()
end

return slot0
