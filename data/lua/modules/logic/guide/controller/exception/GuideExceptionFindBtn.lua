module("modules.logic.guide.controller.exception.GuideExceptionFindBtn", package.seeall)

slot0 = class("GuideExceptionFindBtn")

function slot0.ctor(slot0)
	slot0.guideId = nil
	slot0.stepId = nil
	slot0.repeatCount = nil
	slot0.handlerFuncs = nil
	slot0.handlerParams = nil
	slot0.goPath = nil
	slot0.elapseCount = 0
end

function slot0.startCheck(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.guideId = slot1
	slot0.stepId = slot2
	slot0.handlerFuncs = slot4
	slot0.handlerParams = slot5
	slot6 = string.split(slot3, "_")
	slot0.repeatCount = slot6[2] and tonumber(slot6[2]) or 1
	slot0._ignoreLog = slot6[3] and tonumber(slot6[3]) == 1
	slot0.goPath = GuideModel.instance:getStepGOPath(slot1, slot2)

	TaskDispatcher.runRepeat(slot0._onTick, slot0, tonumber(slot6[1]))

	slot0.elapseCount = 0
end

function slot0.stopCheck(slot0)
	TaskDispatcher.cancelTask(slot0._onTick, slot0)

	slot0.guideId = nil
	slot0.stepId = nil
	slot0.handlerFuncs = nil
	slot0.handlerParams = nil
	slot0.goPath = nil
	slot0.elapseCount = 0
end

function slot0._onTick(slot0)
	if not GuideUtil.isGOShowInScreen(gohelper.find(slot0.goPath)) then
		slot2 = slot0.handlerFuncs
		slot3 = slot0.handlerParams

		if not slot0._ignoreLog then
			GuideActionFindGO._exceptionFindLog(slot0.guideId, slot0.stepId, slot0.goPath, "[ExceptionFind]")
		end

		slot4 = slot0.guideId
		slot5 = slot0.stepId

		slot0:stopCheck()

		if slot2 then
			for slot9 = 1, #slot2 do
				GuideExceptionController.instance:handle(slot4, slot5, slot2[slot9], slot3[slot9])
			end
		end

		return
	end

	if slot0.elapseCount and slot0.repeatCount then
		slot0.elapseCount = slot0.elapseCount + 1

		if slot0.repeatCount <= slot0.elapseCount then
			slot0:stopCheck()
		end
	end
end

return slot0
