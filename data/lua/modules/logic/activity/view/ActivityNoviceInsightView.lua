module("modules.logic.activity.view.ActivityNoviceInsightView", package.seeall)

local var_0_0 = class("ActivityNoviceInsightView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "name/title/#txt_namecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "name/title/#txt_nameen")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "time")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "time/#txt_time")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "#txt_desc")
	arg_1_0._btnjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_jump")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnjump:AddClickListener(arg_2_0._btnjumpOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnjump:RemoveClickListener()
end

function var_0_0._btnjumpOnClick(arg_4_0)
	arg_4_0:closeThis()

	if ViewMgr.instance:isOpen(ViewName.ActivityBeginnerView) then
		ViewMgr.instance:closeView(ViewName.ActivityBeginnerView)
	end

	GameFacade.jump(53)
end

function var_0_0._editableInitView(arg_5_0)
	gohelper.addUIClickAudio(arg_5_0._btnjump.gameObject, AudioEnum.UI.play_ui_activity_jump)
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.parent

	gohelper.addChild(var_7_0, arg_7_0.viewGO)

	local var_7_1 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NoviceInsight)

	arg_7_0._txtnamecn.text = var_7_1.name
	arg_7_0._txtnameen.text = var_7_1.nameEn

	local var_7_2 = ActivityModel.instance:getActStartTime(ActivityEnum.Activity.NoviceInsight)
	local var_7_3 = ActivityModel.instance:getActEndTime(ActivityEnum.Activity.NoviceInsight)

	if type(var_7_1.endTime) == "number" then
		gohelper.setActive(arg_7_0._gotime, true)

		local var_7_4 = type(var_7_2) == "number" and TimeUtil.timestampToString1(var_7_2 / 1000) or "   "
		local var_7_5 = {
			var_7_4,
			TimeUtil.timestampToString1(var_7_3 / 1000)
		}

		arg_7_0._txttime.text = GameUtil.getSubPlaceholderLuaLang(luaLang("activitynoviceinsightview_time"), var_7_5)
	else
		gohelper.setActive(arg_7_0._gotime, false)
	end

	arg_7_0._txtdesc.text = var_7_1.actTip
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
