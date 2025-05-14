module("modules.logic.fight.system.work.FightWorkDouQuQuClear", package.seeall)

local var_0_0 = class("FightWorkDouQuQuClear", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = GameSceneMgr.instance:getCurScene()

	var_1_0.specialIdleMgr:_releaseAllEntity()
	var_1_0.magicCircle:releaseAllEffect()
	var_1_0.specialEffectMgr:clearAllEffect()
	var_1_0.entityMgr:removeAllUnits()
	FightTLEventPool.dispose()
	FightSkillBehaviorMgr.instance:dispose()
	FightRenderOrderMgr.instance:dispose()
	FightNameMgr.instance:dispose()
	FightFloatMgr.instance:dispose()
	FightAudioMgr.instance:dispose()
	FightVideoMgr.instance:dispose()
	FightSkillMgr.instance:dispose()
	FightResultModel.instance:clear()
	FightStrUtil.instance:dispose()
	FightPreloadController.instance:dispose()
	FightRoundPreloadController.instance:dispose()
	arg_1_0:com_registTimer(arg_1_0._delayGC, 1)
	arg_1_0:cancelFightWorkSafeTimer()
end

function var_0_0._delayGC(arg_2_0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
	FightStrUtil.instance:init()
	FightSkillBehaviorMgr.instance:init()
	FightRenderOrderMgr.instance:init()
	FightNameMgr.instance:init()
	FightFloatMgr.instance:init()
	FightAudioMgr.instance:init()
	FightVideoMgr.instance:init()
	FightSkillMgr.instance:init()
	arg_2_0:onDone(true)
end

return var_0_0
