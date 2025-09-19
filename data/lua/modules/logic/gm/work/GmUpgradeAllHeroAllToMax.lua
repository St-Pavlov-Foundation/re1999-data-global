module("modules.logic.gm.work.GmUpgradeAllHeroAllToMax", package.seeall)

local var_0_0 = class("GmUpgradeAllHeroAllToMax", BaseWork)

var_0_0.BlockKey = "send all to max msg ing"

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

	local var_2_1 = HeroResonanceConfig.instance:getHeroMaxTalentLv(var_2_0.heroId)
	local var_2_2 = GMController.instance:getHeroMaxLevel(var_2_0.heroId)
	local var_2_3 = string.format("add heroAttr %d#%d#%d#%d#%d", var_2_0.heroId, var_2_2, 0, var_2_1, 5)

	GMRpc.instance:sendGMRequest(var_2_3)
	GameFacade.showToastString(string.format("全部拉满进度  %s / %s", arg_2_0.curIndex, arg_2_0.maxCount))
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
