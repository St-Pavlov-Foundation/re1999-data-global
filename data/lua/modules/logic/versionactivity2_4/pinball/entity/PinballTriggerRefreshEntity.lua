module("modules.logic.versionactivity2_4.pinball.entity.PinballTriggerRefreshEntity", package.seeall)

local var_0_0 = class("PinballTriggerRefreshEntity", PinballTriggerEntity)

function var_0_0.onInit(arg_1_0)
	var_0_0.super.onInit(arg_1_0)

	arg_1_0.curHitCount = 0
	arg_1_0.totalRefresh = 0
end

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

	arg_2_0._effectAnim = gohelper.findChildAnim(arg_2_1, "vx_stonestatue")
end

function var_0_0.onHitEnter(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	local var_3_0 = PinballEntityMgr.instance:getEntity(arg_3_1)

	if not var_3_0 then
		return
	end

	if var_3_0:isMarblesType() then
		arg_3_0:incHit()
	end
end

function var_0_0.onCreateLinkEntity(arg_4_0, arg_4_1)
	arg_4_1.curHitCount = arg_4_0.curHitCount
	arg_4_1.totalRefresh = arg_4_0.totalRefresh

	arg_4_1:playEffectAnim(true)
end

function var_0_0.incHit(arg_5_0)
	if arg_5_0.isDead then
		return
	end

	arg_5_0.curHitCount = arg_5_0.curHitCount + 1

	if arg_5_0.linkEntity then
		arg_5_0.linkEntity.curHitCount = arg_5_0.linkEntity.curHitCount + 1

		arg_5_0.linkEntity:playEffectAnim()
	end

	arg_5_0:playEffectAnim()

	if arg_5_0.curHitCount >= arg_5_0.hitCount then
		arg_5_0.totalRefresh = arg_5_0.totalRefresh + 1

		arg_5_0:doRefresh()

		if arg_5_0.totalRefresh >= arg_5_0.limitNum then
			arg_5_0._waitAnim = true

			TaskDispatcher.runDelay(arg_5_0._delayDestory, arg_5_0, 1.5)
			arg_5_0:playAnim("disapper")
			arg_5_0:markDead()
		end
	end
end

function var_0_0.playEffectAnim(arg_6_0, arg_6_1)
	if not arg_6_0._effectAnim then
		return
	end

	if arg_6_0.curHitCount == 0 then
		gohelper.setActive(arg_6_0._effectAnim, false)
	else
		gohelper.setActive(arg_6_0._effectAnim, true)
		arg_6_0._effectAnim:Play(string.format("stonestatue_open_%02d", arg_6_0.curHitCount), 0, arg_6_1 and 1 or 0)
	end
end

function var_0_0.doRefresh(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio19)
	PinballController.instance:dispatchEvent(PinballEvent.GameResRefresh)
end

function var_0_0.onInitByCo(arg_8_0)
	local var_8_0 = string.splitToNumber(arg_8_0.spData, "#") or {}

	arg_8_0.hitCount = var_8_0[1] or 1
	arg_8_0.limitNum = var_8_0[2] or 1
end

function var_0_0._delayDestory(arg_9_0)
	gohelper.destroy(arg_9_0.go)
end

function var_0_0.onDestroy(arg_10_0)
	var_0_0.super.onDestroy(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0._delayDestory, arg_10_0)
end

function var_0_0.dispose(arg_11_0)
	if not arg_11_0._waitAnim then
		gohelper.destroy(arg_11_0.go)
	end
end

return var_0_0
