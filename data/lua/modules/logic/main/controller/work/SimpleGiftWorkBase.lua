module("modules.logic.main.controller.work.SimpleGiftWorkBase", package.seeall)

local var_0_0 = class("SimpleGiftWorkBase", BaseWork)
local var_0_1 = 0

local function var_0_2(arg_1_0)
	if not arg_1_0._viewNames then
		arg_1_0._viewNames = assert(arg_1_0:onGetViewNames())
	end
end

local function var_0_3(arg_2_0)
	if not arg_2_0._actIds then
		arg_2_0._actIds = assert(arg_2_0:onGetActIds())
	end
end

local var_0_4 = _G.class("SimpleGiftWorkBase_WorkContext")

function var_0_4.ctor(arg_3_0)
	arg_3_0.bAutoWorkNext = true
end

function var_0_0.ctor(arg_4_0, arg_4_1)
	arg_4_0._patFaceId = arg_4_1
	arg_4_0._patViewName = PatFaceConfig.instance:getPatFaceViewName(arg_4_0._patFaceId)
	arg_4_0._patStoryId = PatFaceConfig.instance:getPatFaceStoryId(arg_4_0._patFaceId)
end

function var_0_0.onStart(arg_5_0)
	var_0_2(arg_5_0)
	var_0_3(arg_5_0)

	var_0_1 = 0

	if arg_5_0:_isExistGuide() then
		arg_5_0:_endBlock()
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_5_0._work, arg_5_0)
	else
		arg_5_0:_work()
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_5_0._onOpenViewFinish, arg_5_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_5_0._onCloseViewFinish, arg_5_0)
end

function var_0_0._onOpenViewFinish(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0._viewName then
		return
	end

	arg_6_0:_endBlock()
end

function var_0_0._onCloseViewFinish(arg_7_0, arg_7_1)
	if arg_7_1 ~= arg_7_0._viewName then
		return
	end

	if ViewMgr.instance:isOpen(arg_7_0._viewName) then
		return
	end

	arg_7_0:_work()
end

function var_0_0.clearWork(arg_8_0)
	arg_8_0:_endBlock()
	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_8_0._work, arg_8_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_8_0._onCloseViewFinish, arg_8_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_8_0._onOpenViewFinish, arg_8_0)

	arg_8_0._actId = nil
	arg_8_0._viewName = nil
end

function var_0_0._pop(arg_9_0)
	var_0_1 = var_0_1 + 1

	local var_9_0 = arg_9_0._viewNames[var_0_1]

	return arg_9_0._actIds[var_0_1], var_9_0
end

function var_0_0._work(arg_10_0)
	arg_10_0:_startBlock()

	arg_10_0._actId, arg_10_0._viewName = arg_10_0:_pop()

	if not arg_10_0._actId then
		arg_10_0:onDone(true)

		return
	end

	local var_10_0 = var_0_4.New()

	arg_10_0:onWork(var_10_0)

	if var_10_0.bAutoWorkNext then
		arg_10_0:_work()
	end
end

function var_0_0._isExistGuide(arg_11_0)
	if GuideModel.instance:isDoingClickGuide() and not GuideController.instance:isForbidGuides() then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end

	return false
end

function var_0_0._endBlock(arg_12_0)
	if not arg_12_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:endBlock()
end

function var_0_0._startBlock(arg_13_0)
	if arg_13_0:_isBlock() then
		return
	end

	UIBlockMgr.instance:startBlock()
end

function var_0_0._isBlock(arg_14_0)
	return UIBlockMgr.instance:isBlock() and true or false
end

function var_0_0.onGetViewNames(arg_15_0)
	assert(false, "please override this function, and return a table")
end

function var_0_0.onGetActIds(arg_16_0)
	assert(false, "please override this function, and return a table")
end

function var_0_0.onWork(arg_17_0, arg_17_1)
	assert(false, "please override this function")
end

return var_0_0
