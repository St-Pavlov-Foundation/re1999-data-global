module("modules.logic.guide.controller.action.impl.GuideActionFindGO", package.seeall)

local var_0_0 = class("GuideActionFindGO", BaseGuideAction)

var_0_0.FindGameObjectSeconds = 5

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0._goPath = arg_1_3
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)

	local var_2_0 = arg_2_0:_findGO(arg_2_0._goPath)

	if var_2_0 then
		arg_2_1.targetGO = var_2_0

		arg_2_0:_setGlobalTouchGO()
		arg_2_0:onDone(true)
	else
		if GuideConfig.instance:getStepCO(arg_2_0.guideId, arg_2_0.stepId).notForce == 0 then
			arg_2_0:_startBlock()
		end

		TaskDispatcher.runRepeat(arg_2_0._findGOToStartGuide, arg_2_0, 0.1)

		arg_2_0._startTime = Time.time
		arg_2_0._realStartTime = Time.realtimeSinceStartup
	end
end

function var_0_0.onDestroy(arg_3_0)
	var_0_0.super.onDestroy(arg_3_0)
	arg_3_0:_endBlock()
end

function var_0_0._setGlobalTouchGO(arg_4_0)
	local var_4_0 = GuideConfig.instance:getStepCO(arg_4_0.guideId, arg_4_0.stepId)

	if not string.nilorempty(var_4_0.touchGOPath) then
		local var_4_1 = gohelper.find(var_4_0.touchGOPath)

		arg_4_0.context.touchGO = var_4_1 and var_4_1:GetComponent("TouchEventMgr") or nil
	end
end

function var_0_0._findGOToStartGuide(arg_5_0)
	local var_5_0 = BaseViewContainer.openViewAnimStartTime

	if var_5_0 and var_5_0 < Time.time and Time.time - var_5_0 <= BaseViewContainer.openViewAnimLength then
		return
	end

	local var_5_1 = arg_5_0:_findGO(arg_5_0._goPath)

	if not gohelper.isNil(var_5_1) and var_5_1.activeInHierarchy then
		arg_5_0:_endBlock()

		arg_5_0.context.targetGO = var_5_1

		arg_5_0:_setGlobalTouchGO()
		arg_5_0:onDone(true)
	else
		local var_5_2 = Time.time - arg_5_0._startTime
		local var_5_3 = Time.realtimeSinceStartup - arg_5_0._realStartTime
		local var_5_4 = GuideConfig.instance:getStepCO(arg_5_0.guideId, arg_5_0.stepId)
		local var_5_5 = var_0_0.FindGameObjectSeconds

		if var_5_4.notForce == 0 and var_5_5 < var_5_2 and var_5_5 < var_5_3 then
			if UIBlockMgr.instance:isKeyBlock(UIBlockKey.ViewOpening) then
				if not arg_5_0._loadingWaitingFlag then
					arg_5_0._loadingWaitingFlag = true

					logError("Guide findGO time out, is loading view, waiting!!")
				end

				return
			end

			arg_5_0:_endBlock()
			GuideStepController.instance:clearFlow(arg_5_0.guideId)
			GuideModel.instance:clearFlagByGuideId(arg_5_0.guideId)

			local var_5_6 = #ConnectAliveMgr.instance:getUnresponsiveMsgList()
			local var_5_7 = GuideModel.instance:getById(arg_5_0.guideId)

			if var_5_7 and var_5_6 == 0 then
				var_5_7:exceptionFinishGuide()
			end

			var_0_0._exceptionFindLog(arg_5_0.guideId, arg_5_0.stepId, arg_5_0._goPath, "[ActionFind]")
		end
	end
end

function var_0_0._exceptionFindLog(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = #ConnectAliveMgr.instance:getUnresponsiveMsgList()
	local var_6_1 = "找不到" .. tostring(arg_6_2)
	local var_6_2 = "msgCount_" .. tostring(var_6_0)
	local var_6_3 = GuideModel.instance:getStepExecStr()
	local var_6_4 = "scene_" .. tostring(GameSceneMgr.instance:getCurSceneType())
	local var_6_5 = ViewMgr.instance:getOpenViewNameList()
	local var_6_6 = "views:" .. tostring(table.concat(var_6_5, ","))
	local var_6_7 = GuideConfig.instance:getGuideCO(arg_6_0)
	local var_6_8 = GuideConfig.instance:getStepCO(arg_6_0, arg_6_1)

	logError(string.format("%s%s guide_%d_%d, %s-%s %s %s %s %s", arg_6_3 or "", var_6_1, arg_6_0, arg_6_1, var_6_7.desc, var_6_8.desc, var_6_2, var_6_4, var_6_6, var_6_3))
end

function var_0_0._startBlock(arg_7_0)
	UIBlockMgr.instance:startBlock(UIBlockKey.GuideActionFindGO)
end

function var_0_0._endBlock(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._findGOToStartGuide, arg_8_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.GuideActionFindGO)
end

function var_0_0._findGO(arg_9_0, arg_9_1)
	local var_9_0 = string.split(arg_9_1, "###")

	for iter_9_0 = 1, #var_9_0 do
		local var_9_1 = gohelper.find(var_9_0[iter_9_0])

		if GuideUtil.isGOShowInScreen(var_9_1) then
			return var_9_1
		end
	end
end

return var_0_0
