module("modules.logic.fight.entity.comp.skill.FightTLEventDisableSpineRotate", package.seeall)

local var_0_0 = class("FightTLEventDisableSpineRotate", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0:_disable()
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_enable()
end

function var_0_0._enable(arg_3_0)
	arg_3_0:_do(true)
end

function var_0_0._disable(arg_4_0)
	arg_4_0:_do(false)
end

function var_0_0._do(arg_5_0, arg_5_1)
	GameSceneMgr.instance:getCurScene().entityMgr.enableSpineRotate = arg_5_1
end

return var_0_0
