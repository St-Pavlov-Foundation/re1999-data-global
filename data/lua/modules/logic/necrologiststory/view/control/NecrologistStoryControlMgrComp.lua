module("modules.logic.necrologiststory.view.control.NecrologistStoryControlMgrComp", package.seeall)

local var_0_0 = class("NecrologistStoryControlMgrComp", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.storyView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.controlList = {}
	arg_2_0.type2Cls = {
		[NecrologistStoryEnum.StoryControlType.StoryPic] = NecrologistStoryControlStoryPic,
		[NecrologistStoryEnum.StoryControlType.Bgm] = NecrologistStoryControlBgm,
		[NecrologistStoryEnum.StoryControlType.Audio] = NecrologistStoryControlAudio,
		[NecrologistStoryEnum.StoryControlType.Effect] = NecrologistStoryControlWeather,
		[NecrologistStoryEnum.StoryControlType.Magic] = NecrologistStoryControlMagic,
		[NecrologistStoryEnum.StoryControlType.ErasePic] = NecrologistStoryControlErasePic,
		[NecrologistStoryEnum.StoryControlType.DragPic] = NecrologistStoryControlDragPic,
		[NecrologistStoryEnum.StoryControlType.StopAudio] = NecrologistStoryControlStopAudio
	}
end

function var_0_0.playControl(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_1.id
	local var_3_1 = arg_3_1.addControl

	if string.nilorempty(var_3_1) then
		return
	end

	local var_3_2 = string.splitToNumber(var_3_1, "|")
	local var_3_3 = string.split(arg_3_1.controlParam, "|")
	local var_3_4 = string.splitToNumber(arg_3_1.controlDelay, "|")

	for iter_3_0, iter_3_1 in ipairs(var_3_2) do
		arg_3_0:setControlParam(iter_3_1, var_3_0, var_3_3[iter_3_0], var_3_4[iter_3_0], arg_3_2, arg_3_3)
	end

	local var_3_5 = arg_3_0.controlList[var_3_0]

	if var_3_5 then
		for iter_3_2, iter_3_3 in ipairs(var_3_5) do
			iter_3_3:playControl()
		end
	end
end

function var_0_0.setControlParam(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5, arg_4_6)
	local var_4_0 = arg_4_0.type2Cls[arg_4_1]

	if not var_4_0 then
		return
	end

	local var_4_1 = var_4_0.New(arg_4_0)

	arg_4_0:addControl(arg_4_2, var_4_1)
	var_4_1:setParam(arg_4_3, arg_4_4, arg_4_5, arg_4_6)
end

function var_0_0.addControl(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.controlList[arg_5_1]

	if not var_5_0 then
		var_5_0 = {}
		arg_5_0.controlList[arg_5_1] = var_5_0
	end

	arg_5_2:setStoryId(arg_5_1)
	table.insert(var_5_0, arg_5_2)
end

function var_0_0.createControlItem(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5)
	return (arg_6_0.storyView:createControlItem(arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5))
end

function var_0_0.onItemFinish(arg_7_0, arg_7_1)
	if arg_7_1.fromItem then
		return
	end

	if arg_7_0:isControlFinish(arg_7_1.storyId) then
		arg_7_0.storyView:runNextStep(arg_7_1.isSkip)
	end
end

function var_0_0.isControlFinish(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.controlList[arg_8_1]

	if not var_8_0 then
		return true
	end

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if not iter_8_1:isFinish() then
			return false
		end
	end

	return true
end

function var_0_0.clearControlList(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0.controlList) do
		for iter_9_2, iter_9_3 in ipairs(iter_9_1) do
			iter_9_3:onDestory()
		end
	end
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0:clearControlList()
end

return var_0_0
