module("modules.logic.versionactivity1_2.jiexika.view.Activity114TransitionView", package.seeall)

local var_0_0 = class("Activity114TransitionView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._txtdes = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_des")
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")
	arg_1_0._anim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0.onOpen(arg_4_0)
	local var_4_0 = ""
	local var_4_1

	if arg_4_0.viewParam.transitionId then
		local var_4_2

		var_4_2, var_4_0 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, arg_4_0.viewParam.transitionId)
		arg_4_0.viewParam.transitionId = nil
	elseif arg_4_0.viewParam.type == Activity114Enum.EventType.Rest then
		local var_4_3

		var_4_3, var_4_0 = Activity114Config.instance:getConstValue(Activity114Model.instance.id, Activity114Enum.ConstId["Rest" .. arg_4_0.viewParam.result])
	else
		if not arg_4_0.viewParam.answerIds then
			arg_4_0.viewParam.answerIds = Activity114Model.instance.serverData.testIds
		end

		local var_4_4

		var_4_4, var_4_0 = Activity114Config.instance:getAnswerResult(Activity114Model.instance.id, arg_4_0.viewParam.answerIds[1] or 1, arg_4_0.viewParam.totalScore)
	end

	arg_4_0._openDt = UnityEngine.Time.realtimeSinceStartup

	local var_4_5 = string.gsub(var_4_0, "▩(%d+)%%s", function(arg_5_0)
		if arg_5_0 == "1" then
			return Activity114Helper.getNextKeyDayDesc(Activity114Model.instance.serverData.day)
		elseif arg_5_0 == "2" then
			return Activity114Helper.getNextKeyDayLeft(Activity114Model.instance.serverData.day)
		end

		return ""
	end)

	arg_4_0._simagebg:LoadImage(ResUrl.getAct114Icon("transbg"))

	arg_4_0._txtdes.text = var_4_5

	TaskDispatcher.runDelay(arg_4_0.closeThis, arg_4_0, 4)
end

function var_0_0._onClickClose(arg_6_0)
	if not arg_6_0._openDt or UnityEngine.Time.realtimeSinceStartup - arg_6_0._openDt < 1 then
		return
	end

	arg_6_0._anim.enabled = false

	arg_6_0:closeThis()
end

function var_0_0.onClose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.closeThis, arg_7_0)
end

function var_0_0.onDestroyView(arg_8_0)
	arg_8_0._simagebg:UnLoadImage()
end

return var_0_0
