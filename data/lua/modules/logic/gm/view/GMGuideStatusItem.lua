module("modules.logic.gm.view.GMGuideStatusItem", package.seeall)

slot0 = class("GMGuideStatusItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0._guideCO = nil
	slot0._txtGuideId = gohelper.findChildText(slot1, "txtGuideId")
	slot0._txtClientStep = gohelper.findChildText(slot1, "txtClientStep")
	slot0._txtServerStep = gohelper.findChildText(slot1, "txtServerStep")
	slot0._txtExecStep = gohelper.findChildText(slot1, "txtExecStep")
	slot0._txtStatus = gohelper.findChildText(slot1, "txtStatus")
	slot0._btnRestart = gohelper.findChildButtonWithAudio(slot1, "btnRestart")
	slot0._btnFinish = gohelper.findChildButtonWithAudio(slot1, "btnFinish")
	slot0._btnDel = gohelper.findChildButtonWithAudio(slot1, "btnDel")
	slot0._clickGuideId = gohelper.getClick(slot0._txtGuideId.gameObject)

	slot0._btnRestart:AddClickListener(slot0._onClickRestart, slot0)
	slot0._btnFinish:AddClickListener(slot0._onClickFinish, slot0)
	slot0._btnDel:AddClickListener(slot0._onClickDel, slot0)
	slot0._clickGuideId:AddClickListener(slot0._onClickGuideId, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._guideId = slot1.id
	slot0._guideCO = slot1
	slot0._txtGuideId.text = slot0._guideCO.id

	if GuideModel.instance:getById(slot0._guideCO.id) then
		slot0._txtClientStep.text = slot2.clientStepId
		slot0._txtServerStep.text = slot2.serverStepId

		if slot2.currGuideId == -1 or slot2.currGuideId == slot0._guideCO then
			slot0._txtExecStep.text = slot2.currStepId
		else
			slot0._txtExecStep.text = slot2.currGuideId .. "_" .. slot2.currStepId
		end

		if slot2.serverStepId == -1 then
			if slot2.isExceptionFinish then
				slot0._txtStatus.text = "<color=#FF0000>异常终止</color>"
			elseif slot2.clientStepId == -1 then
				slot0._txtStatus.text = "<color=#00DD00>已完成</color>"
			else
				slot0._txtStatus.text = "<color=#00DD00>前端收尾ing</color>"
			end
		elseif slot2.currGuideId == slot0._guideCO.id then
			if ViewMgr.instance:isOpen(ViewName.GuideView) then
				if GuideViewMgr.instance.guideId == slot2.currGuideId and GuideViewMgr.instance.stepId == slot2.currrStepId then
					slot0._txtStatus.text = "<color=#EA00B3>指引点击ing</color>"
				else
					slot0._txtStatus.text = "<color=#EA00B3>执行ing</color>"
				end
			else
				slot0._txtStatus.text = "<color=#EA00B3>执行ing</color>"
			end
		else
			slot0._txtStatus.text = "<color=#EA00B3>中断重来ing</color>"
		end
	else
		slot0._txtClientStep.text = ""
		slot0._txtServerStep.text = ""
		slot0._txtExecStep.text = ""
		slot0._txtStatus.text = "<color=#444444>未接取</color>"
	end

	gohelper.setActive(slot0._btnRestart.gameObject, GMGuideStatusModel.instance.showOpBtn)
	gohelper.setActive(slot0._btnFinish.gameObject, GMGuideStatusModel.instance.showOpBtn)
	gohelper.setActive(slot0._btnDel.gameObject, GMGuideStatusModel.instance.showOpBtn)
end

function slot0._onClickDel(slot0)
	if not GuideModel.instance:getById(slot0._guideCO.id) then
		return
	end

	GMRpc.instance:sendGMRequest("delete guide " .. slot1)
	GuideStepController.instance:clearFlow(slot1)
	GuideModel.instance:remove(GuideModel.instance:getById(slot1))
end

function slot0._onClickFinish(slot0)
	if not GuideModel.instance:getById(slot0._guideCO.id) then
		return
	end

	for slot7 = #GuideConfig.instance:getStepList(slot1), 1, -1 do
		if slot3[slot7].keyStep == 1 then
			GuideRpc.instance:sendFinishGuideRequest(slot1, slot8.stepId)

			break
		end
	end

	slot2.isJumpPass = true

	GuideStepController.instance:clearFlow(slot1)
end

function slot0._onClickRestart(slot0)
	slot1 = slot0._guideCO.id

	GuideModel.instance:gmStartGuide(slot1, 0)

	if GuideModel.instance:getById(slot1) then
		GuideStepController.instance:clearFlow(slot1)

		slot3.isJumpPass = false

		GMRpc.instance:sendGMRequest("delete guide " .. slot1)
		GuideRpc.instance:sendFinishGuideRequest(slot1, slot2)
	elseif slot1 then
		GuideController.instance:startGudie(slot1)
	end
end

function slot0._onClickGuideId(slot0)
	GameFacade.showToast(ToastEnum.IconId, slot0._guideCO.desc)
	logNormal(slot0._guideCO.id .. ":" .. slot0._guideCO.desc)
end

function slot0.onDestroy(slot0)
	slot0._btnRestart:RemoveClickListener()
	slot0._btnFinish:RemoveClickListener()
	slot0._btnDel:RemoveClickListener()
	slot0._clickGuideId:RemoveClickListener()
end

return slot0
