module("modules.logic.guide.controller.action.impl.GuideActionFindGO", package.seeall)

slot0 = class("GuideActionFindGO", BaseGuideAction)
slot0.FindGameObjectSeconds = 5

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1, slot2, slot3)

	slot0._goPath = slot3
end

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	if slot0:_findGO(slot0._goPath) then
		slot1.targetGO = slot2

		slot0:_setGlobalTouchGO()
		slot0:onDone(true)
	else
		if GuideConfig.instance:getStepCO(slot0.guideId, slot0.stepId).notForce == 0 then
			slot0:_startBlock()
		end

		TaskDispatcher.runRepeat(slot0._findGOToStartGuide, slot0, 0.1)

		slot0._startTime = Time.time
		slot0._realStartTime = Time.realtimeSinceStartup
	end
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	slot0:_endBlock()
end

function slot0._setGlobalTouchGO(slot0)
	if not string.nilorempty(GuideConfig.instance:getStepCO(slot0.guideId, slot0.stepId).touchGOPath) then
		slot0.context.touchGO = gohelper.find(slot1.touchGOPath) and slot2:GetComponent("TouchEventMgr") or nil
	end
end

function slot0._findGOToStartGuide(slot0)
	if BaseViewContainer.openViewAnimStartTime and slot1 < Time.time and Time.time - slot1 <= BaseViewContainer.openViewAnimLength then
		return
	end

	if not gohelper.isNil(slot0:_findGO(slot0._goPath)) and slot2.activeInHierarchy then
		slot0:_endBlock()

		slot0.context.targetGO = slot2

		slot0:_setGlobalTouchGO()
		slot0:onDone(true)
	else
		slot6 = uv0.FindGameObjectSeconds

		if GuideConfig.instance:getStepCO(slot0.guideId, slot0.stepId).notForce == 0 and slot6 < Time.time - slot0._startTime and slot6 < Time.realtimeSinceStartup - slot0._realStartTime then
			if UIBlockMgr.instance:isKeyBlock(UIBlockKey.ViewOpening) then
				if not slot0._loadingWaitingFlag then
					slot0._loadingWaitingFlag = true

					logError("Guide findGO time out, is loading view, waiting!!")
				end

				return
			end

			slot0:_endBlock()
			GuideStepController.instance:clearFlow(slot0.guideId)
			GuideModel.instance:clearFlagByGuideId(slot0.guideId)

			if GuideModel.instance:getById(slot0.guideId) and #ConnectAliveMgr.instance:getUnresponsiveMsgList() == 0 then
				slot9:exceptionFinishGuide()
			end

			uv0._exceptionFindLog(slot0.guideId, slot0.stepId, slot0._goPath, "[ActionFind]")
		end
	end
end

function slot0._exceptionFindLog(slot0, slot1, slot2, slot3)
	logError(string.format("%s%s guide_%d_%d, %s-%s %s %s %s %s", slot3 or "", "找不到" .. tostring(slot2), slot0, slot1, GuideConfig.instance:getGuideCO(slot0).desc, GuideConfig.instance:getStepCO(slot0, slot1).desc, "msgCount_" .. tostring(#ConnectAliveMgr.instance:getUnresponsiveMsgList()), "scene_" .. tostring(GameSceneMgr.instance:getCurSceneType()), "views:" .. tostring(table.concat(ViewMgr.instance:getOpenViewNameList(), ",")), GuideModel.instance:getStepExecStr()))
end

function slot0._startBlock(slot0)
	UIBlockMgr.instance:startBlock(UIBlockKey.GuideActionFindGO)
end

function slot0._endBlock(slot0)
	TaskDispatcher.cancelTask(slot0._findGOToStartGuide, slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.GuideActionFindGO)
end

function slot0._findGO(slot0, slot1)
	for slot6 = 1, #string.split(slot1, "###") do
		if GuideUtil.isGOShowInScreen(gohelper.find(slot2[slot6])) then
			return slot7
		end
	end
end

return slot0
