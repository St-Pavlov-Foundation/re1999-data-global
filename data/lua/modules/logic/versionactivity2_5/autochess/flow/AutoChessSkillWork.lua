module("modules.logic.versionactivity2_5.autochess.flow.AutoChessSkillWork", package.seeall)

local var_0_0 = class("AutoChessSkillWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.step = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = AutoChessEntityMgr.instance
	local var_2_1 = var_2_0:tryGetEntity(arg_2_0.step.fromId) or var_2_0:getLeaderEntity(arg_2_0.step.fromId)

	if not var_2_1 then
		arg_2_0:finishWork()

		return
	end

	local var_2_2
	local var_2_3 = 0
	local var_2_4 = 0

	if var_2_1.warZone then
		var_2_2 = lua_auto_chess_skill.configDict[tonumber(arg_2_0.step.reasonId)]
	else
		var_2_2 = lua_auto_chess_master_skill.configDict[tonumber(arg_2_0.step.reasonId)]
	end

	if var_2_2 then
		if not string.nilorempty(var_2_2.skillaction) then
			var_2_3 = var_2_1:skillAnim(var_2_2.skillaction)
		end

		if var_2_2.useeffect ~= 0 then
			local var_2_5 = lua_auto_chess_effect.configDict[var_2_2.useeffect]

			var_2_4 = var_2_5.duration

			var_2_1.effectComp:playEffect(var_2_5.id)
		end
	end

	if math.max(var_2_3, var_2_4) == 0 then
		arg_2_0:finishWork()
	else
		TaskDispatcher.runDelay(arg_2_0.finishWork, arg_2_0, var_2_3)
	end
end

function var_0_0.onStop(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0.finishWork, arg_3_0)
end

function var_0_0.onResume(arg_4_0)
	arg_4_0:finishWork()
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.finishWork, arg_5_0)

	arg_5_0.effect = nil
end

function var_0_0.finishWork(arg_6_0)
	arg_6_0:onDone(true)
end

return var_0_0
