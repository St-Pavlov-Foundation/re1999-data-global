module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomGuide", package.seeall)

local var_0_0 = class("V1a6_CachotRoomGuide", BaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.CheckGuideEnterLayerRoom, arg_2_0._checkGuideEnterLayerRoom, arg_2_0)
	arg_2_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.CheckPlayStory, arg_2_0._onRoomViewOpenAnimEnd, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0)
	arg_2_0:addEventCb(V1a6_CachotController.instance, V1a6_CachotEvent.GuideMoveCollection, arg_2_0._onGuideMoveCollection, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_2_0._onFinishGuide, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._heartNum = V1a6_CachotController.instance.heartNum
	V1a6_CachotController.instance.heartNum = nil
end

function var_0_0.onClose(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._guideEnterLayerRoom, arg_5_0)
end

function var_0_0._onFinishGuide(arg_6_0, arg_6_1)
	if arg_6_1 == 16508 then
		arg_6_0:_guideEnterLayerRoom()
	end
end

function var_0_0._onGuideMoveCollection(arg_7_0)
	V1a6_CachotCollectionBagController.instance.guideMoveCollection = true
end

function var_0_0._checkGuideEnterLayerRoom(arg_8_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	TaskDispatcher.cancelTask(arg_8_0._guideEnterLayerRoom, arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._guideEnterLayerRoom, arg_8_0, 0.5)
end

function var_0_0._guideEnterLayerRoom(arg_9_0)
	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	arg_9_0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not arg_9_0._rogueInfo then
		return
	end

	local var_9_0 = arg_9_0._rogueInfo.layer
	local var_9_1, var_9_2 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(arg_9_0._rogueInfo.room)
	local var_9_3 = arg_9_0._rogueInfo.heart
	local var_9_4 = arg_9_0._heartNum

	arg_9_0._heartNum = var_9_3

	if var_9_0 ~= 1 or var_9_1 >= 3 then
		if var_9_4 and var_9_4 ~= var_9_3 then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideHeartChange)
		end

		if V1a6_CachotCollectionHelper.isCollectionBagCanEnchant() then
			V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideCanEnchant)
		end
	end

	if var_9_0 == 3 and var_9_1 == 3 then
		local var_9_5 = arg_9_0._rogueInfo.collectionCfgMap
		local var_9_6 = var_9_5 and var_9_5[V1a6_CachotEnum.SpecialCollection]
		local var_9_7 = var_9_6 and #var_9_6 > 0

		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideEnterLayerRoom, string.format("%s_%s_%s", var_9_0, var_9_1, var_9_7 and 1 or 0))

		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.GuideEnterLayerRoom, string.format("%s_%s", var_9_0, var_9_1))
end

function var_0_0._onRoomViewOpenAnimEnd(arg_10_0)
	arg_10_0:_guideEnterLayerRoom()
end

function var_0_0._onCloseViewFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.StoryBackgroundView or string.find(arg_11_1, "V1a6_CachotCollection") then
		arg_11_0:_guideEnterLayerRoom()
	end
end

return var_0_0
