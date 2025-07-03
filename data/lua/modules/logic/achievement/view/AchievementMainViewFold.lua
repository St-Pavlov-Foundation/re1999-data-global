module("modules.logic.achievement.view.AchievementMainViewFold", package.seeall)

local var_0_0 = class("AchievementMainViewFold", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._modlInst = AchievementMainTileModel.instance

	arg_4_0:addEventCb(AchievementMainController.instance, AchievementEvent.OnClickGroupFoldBtn, arg_4_0.onClickGroupFoldBtn, arg_4_0)
end

function var_0_0.onDestroyView(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:removeEventCb(AchievementMainController.instance, AchievementEvent.OnClickGroupFoldBtn, arg_7_0.onClickGroupFoldBtn, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onEndPlayGroupFadeAnim, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onPreEndPlayGroupFadeAnim, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onDispatchAchievementFadeAnimationEvent, arg_7_0)

	arg_7_0._modifyMap = nil

	arg_7_0:onEndPlayGroupFadeAnim()
end

function var_0_0.onClickGroupFoldBtn(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:onStartPlayGroupFadeAnim()
	arg_8_0:doAchievementFadeAnimation(arg_8_1, arg_8_2)
end

function var_0_0.onStartPlayGroupFadeAnim(arg_9_0)
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock("AchievementMainViewFold_BeginPlayGroupFadeAnim")
end

function var_0_0.onEndPlayGroupFadeAnim(arg_10_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	UIBlockMgr.instance:endBlock("AchievementMainViewFold_BeginPlayGroupFadeAnim")
end

local var_0_1 = 0.001
local var_0_2 = 0.0003
local var_0_3 = 0
local var_0_4 = 0.35

function var_0_0.doAchievementFadeAnimation(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()
	local var_11_1 = AchievementMainCommonModel.instance:getCurrentFilterType()
	local var_11_2 = var_11_0:getCurGroupMoList(arg_11_1)
	local var_11_3 = var_11_2 and var_11_2[1]
	local var_11_4 = var_11_0:getIndex(var_11_3)

	arg_11_0._isFold = arg_11_2
	arg_11_0._modifyGroupId = arg_11_1

	local var_11_5
	local var_11_6 = 0

	arg_11_0._modifyMap = arg_11_0:getUserDataTb_()

	local var_11_7 = arg_11_0:getCurRenderCellCount(arg_11_1, var_11_2, arg_11_2)
	local var_11_8 = arg_11_2 and var_11_7 or 1
	local var_11_9 = arg_11_2 and 1 or var_11_7
	local var_11_10 = arg_11_2 and -1 or 1

	for iter_11_0 = var_11_8, var_11_9, var_11_10 do
		local var_11_11 = var_11_2[iter_11_0]

		arg_11_0._modifyMap[var_11_11] = true

		var_11_11:clearOverrideLineHeight()

		if not arg_11_2 and not var_11_11.isGroupTop then
			local var_11_12 = var_11_4 + iter_11_0 - 1

			var_11_0:addAt(var_11_11, var_11_12)
		end

		local var_11_13 = arg_11_0:getEffectParams(var_11_1, arg_11_2, var_11_11, var_11_5)

		if not arg_11_2 and not var_11_11.isGroupTop then
			var_11_11:overrideLineHeight(0)
		end

		TaskDispatcher.runDelay(arg_11_0.onDispatchAchievementFadeAnimationEvent, var_11_13, var_11_6)

		var_11_6 = var_11_6 + var_11_13.duration
		var_11_5 = var_11_11
	end

	if arg_11_2 then
		arg_11_0:onBeginFoldIn(arg_11_0._modifyGroupId, arg_11_0._isFold)
	end

	TaskDispatcher.cancelTask(arg_11_0.onPreEndPlayGroupFadeAnim, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0.onPreEndPlayGroupFadeAnim, arg_11_0, var_11_6)
	TaskDispatcher.cancelTask(arg_11_0.onEndPlayGroupFadeAnim, arg_11_0)
	TaskDispatcher.runDelay(arg_11_0.onEndPlayGroupFadeAnim, arg_11_0, var_11_6)
end

function var_0_0.onBeginFoldIn(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()
	local var_12_1 = var_12_0:getCurGroupMoList(arg_12_1)

	if var_12_1 then
		for iter_12_0 = 1, #var_12_1 do
			local var_12_2 = var_12_1[iter_12_0]

			if not arg_12_0._modifyMap[var_12_2] then
				var_12_2:setIsFold(arg_12_2)
				var_12_2:clearOverrideLineHeight()
				var_12_0:remove(var_12_2)
			end
		end

		var_12_0:onModelUpdate()
	end
end

function var_0_0.onPreEndPlayGroupFadeAnim(arg_13_0)
	local var_13_0 = AchievementMainCommonModel.instance:getCurViewExcuteModelInstance()
	local var_13_1 = var_13_0:getCurGroupMoList(arg_13_0._modifyGroupId)

	if var_13_1 then
		local var_13_2 = var_13_1 and var_13_1[1]
		local var_13_3 = var_13_0:getIndex(var_13_2)

		for iter_13_0 = 1, #var_13_1 do
			local var_13_4 = var_13_1[iter_13_0]

			var_13_4:setIsFold(arg_13_0._isFold)
			var_13_4:clearOverrideLineHeight()

			if not arg_13_0._isFold and not arg_13_0._modifyMap[var_13_4] then
				local var_13_5 = var_13_3 + iter_13_0 - 1

				var_13_0:addAt(var_13_4, var_13_5)
			end
		end

		var_13_0:onModelUpdate()
	end
end

function var_0_0.getEffectParams(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = arg_14_3:getLineHeight(arg_14_1, not arg_14_2)
	local var_14_1 = arg_14_3:getLineHeight(arg_14_1, arg_14_2)
	local var_14_2 = arg_14_2 and var_0_2 or var_0_1
	local var_14_3 = math.abs(var_14_1 - var_14_0) * var_14_2
	local var_14_4 = Mathf.Clamp(var_14_3, var_0_3, var_0_4)

	return {
		mo = arg_14_3,
		isFold = arg_14_2,
		orginLineHeight = var_14_0,
		targetLineHeight = var_14_1,
		duration = var_14_4,
		lastModifyMO = arg_14_4
	}
end

function var_0_0.onDispatchAchievementFadeAnimationEvent(arg_15_0)
	local var_15_0 = arg_15_0.isFold
	local var_15_1 = arg_15_0.lastModifyMO

	if var_15_0 and var_15_1 and not var_15_1.isGroupTop then
		AchievementMainCommonModel.instance:getCurViewExcuteModelInstance():remove(var_15_1)
	end

	AchievementMainController.instance:dispatchEvent(AchievementEvent.OnPlayGroupFadeAnim, arg_15_0)
end

local var_0_5 = 3

function var_0_0.getCurRenderCellCount(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = AchievementMainCommonModel.instance:getCurrentScrollType()
	local var_16_1 = arg_16_0.viewContainer:getScrollView(var_16_0)
	local var_16_2 = var_16_1:getCsScroll()
	local var_16_3 = 0

	if not arg_16_3 then
		var_16_3 = arg_16_0:getCurRenderCellCountWhileFoldIn(arg_16_1, arg_16_2, var_16_2)
	else
		var_16_3 = arg_16_0:getCurRenderCellCountWhileFoldOut(arg_16_1, arg_16_2, var_16_1, var_16_2)
	end

	return (Mathf.Clamp(var_16_3, 1, var_0_5))
end

function var_0_0.getCurRenderCellCountWhileFoldIn(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = AchievementMainCommonModel.instance:getCurrentFilterType()
	local var_17_1 = 0
	local var_17_2 = 0
	local var_17_3 = arg_17_3.VerticalScrollPixel
	local var_17_4 = recthelper.getHeight(arg_17_3.transform)
	local var_17_5 = Mathf.Clamp(var_17_4 - var_17_3, 0, var_17_4)

	for iter_17_0 = 1, #arg_17_2 do
		var_17_5 = var_17_5 - arg_17_2[iter_17_0]:getLineHeight(var_17_0, false)

		if var_17_5 > 0 then
			var_17_2 = var_17_2 + 1
		else
			break
		end
	end

	return var_17_2
end

function var_0_0.getCurRenderCellCountWhileFoldOut(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	local var_18_0 = arg_18_3._cellCompDict
	local var_18_1 = {}
	local var_18_2 = 0

	for iter_18_0, iter_18_1 in pairs(var_18_0) do
		if iter_18_0._mo.groupId == arg_18_1 then
			var_18_1[iter_18_0._mo.id] = iter_18_0
		end
	end

	for iter_18_2 = 1, #arg_18_2 do
		local var_18_3 = var_18_1[arg_18_2[iter_18_2].id]
		local var_18_4 = var_18_3 and var_18_3._index - 1 or -1

		if not var_18_3 then
			break
		end

		if not arg_18_4:IsVisual(var_18_4) then
			break
		end

		var_18_2 = var_18_2 + 1
	end

	return var_18_2
end

return var_0_0
