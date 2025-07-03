module("modules.logic.fight.entity.comp.skill.FightTimelineTrackItem", package.seeall)

local var_0_0 = class("FightTimelineTrackItem", FightBaseClass)

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.id = arg_1_1
	arg_1_0.type = arg_1_2
	arg_1_0.binder = arg_1_3
	arg_1_0.timelineItem = arg_1_4
end

function var_0_0.onTrackStart(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	return
end

function var_0_0.onTrackEnd(arg_3_0)
	return
end

function var_0_0.addWork2TimelineFinishWork(arg_4_0, arg_4_1)
	arg_4_0.timelineItem:addWork2FinishWork(arg_4_1)
end

function var_0_0.onDestructor(arg_5_0)
	return
end

return var_0_0
