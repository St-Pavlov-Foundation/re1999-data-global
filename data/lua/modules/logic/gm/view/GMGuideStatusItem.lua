module("modules.logic.gm.view.GMGuideStatusItem", package.seeall)

local var_0_0 = class("GMGuideStatusItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._guideCO = nil
	arg_1_0._txtGuideId = gohelper.findChildText(arg_1_1, "txtGuideId")
	arg_1_0._txtClientStep = gohelper.findChildText(arg_1_1, "txtClientStep")
	arg_1_0._txtServerStep = gohelper.findChildText(arg_1_1, "txtServerStep")
	arg_1_0._txtExecStep = gohelper.findChildText(arg_1_1, "txtExecStep")
	arg_1_0._txtStatus = gohelper.findChildText(arg_1_1, "txtStatus")
	arg_1_0._btnRestart = gohelper.findChildButtonWithAudio(arg_1_1, "btnRestart")
	arg_1_0._btnFinish = gohelper.findChildButtonWithAudio(arg_1_1, "btnFinish")
	arg_1_0._btnDel = gohelper.findChildButtonWithAudio(arg_1_1, "btnDel")
	arg_1_0._clickGuideId = gohelper.getClick(arg_1_0._txtGuideId.gameObject)

	arg_1_0._btnRestart:AddClickListener(arg_1_0._onClickRestart, arg_1_0)
	arg_1_0._btnFinish:AddClickListener(arg_1_0._onClickFinish, arg_1_0)
	arg_1_0._btnDel:AddClickListener(arg_1_0._onClickDel, arg_1_0)
	arg_1_0._clickGuideId:AddClickListener(arg_1_0._onClickGuideId, arg_1_0)
end

function var_0_0.onUpdateMO(arg_2_0, arg_2_1)
	arg_2_0._guideId = arg_2_1.id
	arg_2_0._guideCO = arg_2_1

	local var_2_0 = GuideModel.instance:getById(arg_2_0._guideCO.id)

	arg_2_0._txtGuideId.text = arg_2_0._guideCO.id

	if var_2_0 then
		arg_2_0._txtClientStep.text = var_2_0.clientStepId
		arg_2_0._txtServerStep.text = var_2_0.serverStepId

		if var_2_0.currGuideId == -1 or var_2_0.currGuideId == arg_2_0._guideCO then
			arg_2_0._txtExecStep.text = var_2_0.currStepId
		else
			arg_2_0._txtExecStep.text = var_2_0.currGuideId .. "_" .. var_2_0.currStepId
		end

		if var_2_0.serverStepId == -1 then
			if var_2_0.isExceptionFinish then
				arg_2_0._txtStatus.text = "<color=#FF0000>异常终止</color>"
			elseif var_2_0.clientStepId == -1 then
				arg_2_0._txtStatus.text = "<color=#00DD00>已完成</color>"
			else
				arg_2_0._txtStatus.text = "<color=#00DD00>前端收尾ing</color>"
			end
		elseif var_2_0.currGuideId == arg_2_0._guideCO.id then
			if ViewMgr.instance:isOpen(ViewName.GuideView) then
				if GuideViewMgr.instance.guideId == var_2_0.currGuideId and GuideViewMgr.instance.stepId == var_2_0.currrStepId then
					arg_2_0._txtStatus.text = "<color=#EA00B3>指引点击ing</color>"
				else
					arg_2_0._txtStatus.text = "<color=#EA00B3>执行ing</color>"
				end
			else
				arg_2_0._txtStatus.text = "<color=#EA00B3>执行ing</color>"
			end
		else
			arg_2_0._txtStatus.text = "<color=#EA00B3>中断重来ing</color>"
		end
	else
		arg_2_0._txtClientStep.text = ""
		arg_2_0._txtServerStep.text = ""
		arg_2_0._txtExecStep.text = ""
		arg_2_0._txtStatus.text = "<color=#444444>未接取</color>"
	end

	gohelper.setActive(arg_2_0._btnRestart.gameObject, GMGuideStatusModel.instance.showOpBtn)
	gohelper.setActive(arg_2_0._btnFinish.gameObject, GMGuideStatusModel.instance.showOpBtn)
	gohelper.setActive(arg_2_0._btnDel.gameObject, GMGuideStatusModel.instance.showOpBtn)
end

function var_0_0._onClickDel(arg_3_0)
	local var_3_0 = arg_3_0._guideCO.id

	if not GuideModel.instance:getById(var_3_0) then
		return
	end

	GMRpc.instance:sendGMRequest("delete guide " .. var_3_0)
	GuideStepController.instance:clearFlow(var_3_0)
	GuideModel.instance:remove(GuideModel.instance:getById(var_3_0))
end

function var_0_0._onClickFinish(arg_4_0)
	local var_4_0 = arg_4_0._guideCO.id
	local var_4_1 = GuideModel.instance:getById(var_4_0)

	if not var_4_1 then
		return
	end

	local var_4_2 = GuideConfig.instance:getStepList(var_4_0)

	for iter_4_0 = #var_4_2, 1, -1 do
		local var_4_3 = var_4_2[iter_4_0]

		if var_4_3.keyStep == 1 then
			GuideRpc.instance:sendFinishGuideRequest(var_4_0, var_4_3.stepId)

			break
		end
	end

	var_4_1.isJumpPass = true

	GuideStepController.instance:clearFlow(var_4_0)
end

function var_0_0._onClickRestart(arg_5_0)
	local var_5_0 = arg_5_0._guideCO.id
	local var_5_1 = 0
	local var_5_2 = GuideModel.instance:getById(var_5_0)

	GuideModel.instance:gmStartGuide(var_5_0, var_5_1)

	if var_5_2 then
		GuideStepController.instance:clearFlow(var_5_0)

		var_5_2.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. var_5_0)
		GuideRpc.instance:sendFinishGuideRequest(var_5_0, var_5_1)
	elseif var_5_0 then
		GuideController.instance:startGudie(var_5_0)
	end
end

function var_0_0._onClickGuideId(arg_6_0)
	GameFacade.showToast(ToastEnum.IconId, arg_6_0._guideCO.desc)
	logNormal(arg_6_0._guideCO.id .. ":" .. arg_6_0._guideCO.desc)
end

function var_0_0.onDestroy(arg_7_0)
	arg_7_0._btnRestart:RemoveClickListener()
	arg_7_0._btnFinish:RemoveClickListener()
	arg_7_0._btnDel:RemoveClickListener()
	arg_7_0._clickGuideId:RemoveClickListener()
end

return var_0_0
