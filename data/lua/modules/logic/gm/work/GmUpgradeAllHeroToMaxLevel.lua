module("modules.logic.gm.work.GmUpgradeAllHeroToMaxLevel", package.seeall)

local var_0_0 = class("GmUpgradeAllHeroToMaxLevel", BaseWork)

var_0_0.BlockKey = "send max level msg ing"

function var_0_0.onStart(arg_1_0)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)

	arg_1_0.heroList = HeroModel.instance:getList()
	arg_1_0.curIndex = 0
	arg_1_0.maxCount = #arg_1_0.heroList

	local var_1_0 = 50

	TaskDispatcher.runRepeat(arg_1_0.senMsg, arg_1_0, 1 / var_1_0)
end

function var_0_0.senMsg(arg_2_0)
	arg_2_0.curIndex = arg_2_0.curIndex + 1

	local var_2_0 = arg_2_0.heroList[arg_2_0.curIndex]

	if not var_2_0 then
		return arg_2_0:senMsgDone()
	end

	local var_2_1 = GMController.instance:getHeroMaxLevel(var_2_0.heroId)
	local var_2_2 = string.format("add heroAttr %d#%d#%d#%d#%d", var_2_0.heroId, var_2_1, 0, var_2_0.talent, var_2_0.exSkillLevel)

	GMRpc.instance:sendGMRequest(var_2_2)
	GameFacade.showToastString(string.format("设置最大等级进度  %s / %s", arg_2_0.curIndex, arg_2_0.maxCount))
end

function var_0_0.senMsgDone(arg_3_0)
	arg_3_0:clearWork()
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.senMsg, arg_4_0)
	UIBlockMgr.instance:endBlock(var_0_0.BlockKey)
end

return var_0_0
