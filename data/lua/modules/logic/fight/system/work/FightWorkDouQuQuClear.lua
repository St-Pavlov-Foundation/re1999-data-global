module("modules.logic.fight.system.work.FightWorkDouQuQuClear", package.seeall)

slot0 = class("FightWorkDouQuQuClear", FightWorkItem)

function slot0.onStart(slot0)
	slot1 = GameSceneMgr.instance:getCurScene()

	slot1.specialIdleMgr:_releaseAllEntity()
	slot1.magicCircle:releaseAllEffect()
	slot1.specialEffectMgr:clearAllEffect()
	slot1.entityMgr:removeAllUnits()
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
	slot0:com_registTimer(slot0._delayGC, 1)
	slot0:cancelFightWorkSafeTimer()
end

function slot0._delayGC(slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.FullGC)
	FightStrUtil.instance:init()
	FightSkillBehaviorMgr.instance:init()
	FightRenderOrderMgr.instance:init()
	FightNameMgr.instance:init()
	FightFloatMgr.instance:init()
	FightAudioMgr.instance:init()
	FightVideoMgr.instance:init()
	FightSkillMgr.instance:init()
	slot0:onDone(true)
end

return slot0
