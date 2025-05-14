module("modules.logic.rouge.map.map.itemcomp.RougeMapBaseActorComp", package.seeall)

local var_0_0 = class("RougeMapBaseActorComp", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.map = arg_1_2
	arg_1_0.goActor = arg_1_1

	arg_1_0:initActor()
end

function var_0_0.initActor(arg_2_0)
	arg_2_0.trActor = arg_2_0.goActor.transform

	local var_2_0, var_2_1 = arg_2_0.map:getActorPos()

	transformhelper.setLocalPos(arg_2_0.trActor, var_2_0, var_2_1, RougeMapHelper.getOffsetZ(var_2_1))
end

function var_0_0.getActorWordPos(arg_3_0)
	return arg_3_0.trActor.position
end

function var_0_0.moveToMapItem(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	logNormal("base move to map item")
end

function var_0_0.moveToPieceItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	logNormal("base move to piece item")
end

function var_0_0.onMovingDone(arg_6_0)
	arg_6_0:endBlock()
	AudioMgr.instance:trigger(AudioEnum.UI.StopMoveAudio)

	arg_6_0.movingTweenId = nil

	if arg_6_0.callback then
		arg_6_0.callback(arg_6_0.callbackObj)
	end

	arg_6_0.callback = nil
	arg_6_0.callbackObj = nil

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onActorMovingDone)
end

function var_0_0.startBlock(arg_7_0)
	UIBlockMgr.instance:startBlock(RougeMapEnum.MovingBlock)
	UIBlockMgrExtend.setNeedCircleMv(false)
end

function var_0_0.endBlock(arg_8_0)
	UIBlockMgr.instance:endBlock(RougeMapEnum.MovingBlock)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.clearTween(arg_9_0)
	if arg_9_0.movingTweenId then
		ZProj.TweenHelper.KillById(arg_9_0.movingTweenId)

		arg_9_0.movingTweenId = nil
	end
end

function var_0_0.destroy(arg_10_0)
	arg_10_0:endBlock()

	arg_10_0.callback = nil
	arg_10_0.callbackObj = nil

	arg_10_0:clearTween()
	arg_10_0:__onDispose()
end

return var_0_0
