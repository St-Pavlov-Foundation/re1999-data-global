module("modules.logic.login.controller.work.LoginParseMonsterConfigWork", package.seeall)

local var_0_0 = class("LoginParseMonsterConfigWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._skillMonsterIdDict = arg_1_1
	arg_1_0._skillCurrCardLvDict = arg_1_2
end

function var_0_0._timeOut(arg_2_0)
	logError("解析战斗Monster配置出错了")

	return arg_2_0:onDone(false)
end

function var_0_0.onStart(arg_3_0)
	TaskDispatcher.runDelay(arg_3_0._timeOut, arg_3_0, 10)

	arg_3_0.curIndex = 0

	TaskDispatcher.runRepeat(arg_3_0.parseMonsterCo, arg_3_0, 0.0001)
end

var_0_0.Interval = 160

function var_0_0.parseMonsterCo(arg_4_0)
	local var_4_0 = lua_monster.configList

	for iter_4_0 = 1, var_0_0.Interval do
		arg_4_0.curIndex = arg_4_0.curIndex + 1

		local var_4_1 = var_4_0[arg_4_0.curIndex]

		if not var_4_1 then
			TaskDispatcher.cancelTask(arg_4_0.parseMonsterCo, arg_4_0)

			return arg_4_0:onDone(true)
		end

		local var_4_2 = var_4_1.id
		local var_4_3 = FightStrUtil.instance:getSplitString2Cache(var_4_1.activeSkill, true, "|", "#")

		if var_4_3 then
			for iter_4_1, iter_4_2 in ipairs(var_4_3) do
				local var_4_4 = 1

				for iter_4_3, iter_4_4 in ipairs(iter_4_2) do
					if lua_skill.configDict[iter_4_4] then
						arg_4_0._skillMonsterIdDict[iter_4_4] = var_4_2
						arg_4_0._skillCurrCardLvDict[iter_4_4] = var_4_4
						var_4_4 = var_4_4 + 1
					end
				end
			end
		end

		local var_4_5 = var_4_1.uniqueSkill

		if var_4_5 and #var_4_5 > 0 then
			for iter_4_5, iter_4_6 in ipairs(var_4_5) do
				arg_4_0._skillMonsterIdDict[iter_4_6] = var_4_2
			end
		end
	end
end

function var_0_0.clearWork(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._timeOut, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.parseMonsterCo, arg_5_0)
end

return var_0_0
