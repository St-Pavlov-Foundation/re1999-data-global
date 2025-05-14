module("modules.logic.scene.fight.comp.FightSceneMgrComp", package.seeall)

local var_0_0 = class("FightSceneMgrComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.mgr = FightPerformanceMgr.New()
end

function var_0_0.onScenePrepared(arg_2_0, arg_2_1, arg_2_2)
	return
end

function var_0_0.onSceneClose(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.mgr then
		arg_3_0.mgr:disposeSelf()

		arg_3_0.mgr = nil
	end
end

function var_0_0.getASFDMgr(arg_4_0)
	if arg_4_0.mgr then
		return arg_4_0.mgr:getASFDMgr()
	end
end

return var_0_0
