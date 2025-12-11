module("modules.logic.necrologiststory.view.item.NecrologistStoryBaseItem", package.seeall)

local var_0_0 = class("NecrologistStoryBaseItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.storyView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0.transform = arg_2_1.transform
	arg_2_0._height = 0
	arg_2_0._posY = 0

	arg_2_0:onInit()
end

function var_0_0.setCallback(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	arg_3_0.playFinishCallback = arg_3_1
	arg_3_0.playFinishCallbackObj = arg_3_2
	arg_3_0.refreshHeightCallback = arg_3_3
	arg_3_0.callbackObj = arg_3_4
end

function var_0_0.playStory(arg_4_0, arg_4_1, arg_4_2, ...)
	arg_4_0._storyConfig = arg_4_1

	arg_4_0:setCallback(...)
	arg_4_0.storyView:addControl(arg_4_1, arg_4_2, true)
	arg_4_0:onPlayStory(arg_4_2)
	arg_4_0:refreshHeight()
end

function var_0_0.onPlayFinish(arg_5_0)
	arg_5_0:refreshHeight()

	if arg_5_0._storyConfig then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryItemFinish, arg_5_0._storyConfig.id)
	end

	if arg_5_0.playFinishCallback then
		arg_5_0.playFinishCallback(arg_5_0.playFinishCallbackObj)
	end
end

function var_0_0.onClickNext(arg_6_0)
	if arg_6_0._storyConfig then
		NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.OnStoryItemClickNext, arg_6_0._storyConfig.id)
	end
end

function var_0_0.refreshHeight(arg_7_0)
	if gohelper.isNil(arg_7_0.viewGO) then
		return
	end

	local var_7_0 = arg_7_0:caleHeight()

	arg_7_0:setHeight(var_7_0)

	if arg_7_0.refreshHeightCallback then
		arg_7_0.refreshHeightCallback(arg_7_0.callbackObj, arg_7_0)
	end
end

function var_0_0.getItemType(arg_8_0)
	return arg_8_0._storyConfig.type
end

function var_0_0.getStoryConfig(arg_9_0)
	return arg_9_0._storyConfig
end

function var_0_0.getHeight(arg_10_0)
	return arg_10_0._height
end

function var_0_0.setHeight(arg_11_0, arg_11_1)
	arg_11_0._height = arg_11_1

	recthelper.setHeight(arg_11_0.transform, arg_11_1)
end

function var_0_0.getPosY(arg_12_0)
	return arg_12_0._posY
end

function var_0_0.setPosY(arg_13_0, arg_13_1)
	arg_13_0._posY = arg_13_1

	recthelper.setAnchorY(arg_13_0.transform, arg_13_1)
end

function var_0_0.onInit(arg_14_0)
	return
end

function var_0_0.onPlayStory(arg_15_0, arg_15_1)
	return
end

function var_0_0.caleHeight(arg_16_0)
	return 0
end

function var_0_0.getResPath()
	logError("need override getResPath")
end

function var_0_0.isDone(arg_18_0)
	return true
end

function var_0_0.justDone(arg_19_0)
	return
end

function var_0_0.getTextStr(arg_20_0)
	return
end

function var_0_0.destory(arg_21_0)
	if gohelper.isNil(arg_21_0.viewGO) then
		return
	end

	gohelper.destroy(arg_21_0.viewGO)

	arg_21_0.viewGO = nil
end

return var_0_0
