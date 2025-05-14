module("modules.logic.activity.view.ActivityNorSignView", package.seeall)

local var_0_0 = class("ActivityNorSignView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebanner = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_banner")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "title/#txt_remaintime")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_2_0._refresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshNorSignActivity, arg_3_0._refresh, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gorule, false)

	arg_4_0._actId = ActivityEnum.Activity.NorSign

	Activity101Rpc.instance:sendGet101InfosRequest(arg_4_0._actId)
	arg_4_0._simagebanner:LoadImage(ResUrl.getActivityBg("bg_qiridenglubeijing"))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0._btnhelpOnClick(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = ActivityConfig.instance:getActivityCo(arg_6_0._actId)

	var_6_0.title = luaLang("rule")
	var_6_0.desc = var_6_1.actTip
	var_6_0.rootGo = arg_6_0._btnhelp.gameObject

	ViewMgr.instance:openView(ViewName.ActivityTipView, var_6_0)
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	gohelper.addChild(var_7_0, arg_7_0.viewGO)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Task_page)
end

function var_0_0._refresh(arg_8_0)
	local var_8_0 = {}

	for iter_8_0 = 1, 7 do
		local var_8_1 = {
			data = ActivityConfig.instance:getNorSignActivityCo(arg_8_0._actId, iter_8_0)
		}

		table.insert(var_8_0, var_8_1)
	end

	ActivityNorSignItemListModel.instance:setDayList(var_8_0)

	local var_8_2, var_8_3 = ActivityModel.instance:getRemainTime(arg_8_0._actId)

	arg_8_0._txtremaintime.text = string.format(luaLang("activitynorsignview_remaintime"), var_8_2, var_8_3)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simagebanner:UnLoadImage()
end

return var_0_0
