module("modules.logic.gm.work.GmUpgradeEquipAllToMax", package.seeall)

local var_0_0 = class("GmUpgradeEquipAllToMax", BaseWork)

var_0_0.BlockKey = "send equip all to max msg ing"

function var_0_0.onStart(arg_1_0)
	UIBlockMgr.instance:startBlock(var_0_0.BlockKey)

	arg_1_0.equipList = EquipModel.instance:getEquips()
	arg_1_0.curIndex = 0
	arg_1_0.maxCount = #arg_1_0.equipList

	local var_1_0 = 50

	TaskDispatcher.runRepeat(arg_1_0.senMsg, arg_1_0, 1 / var_1_0)
end

function var_0_0.senMsg(arg_2_0)
	arg_2_0.curIndex = arg_2_0.curIndex + 1

	local var_2_0 = arg_2_0.equipList[arg_2_0.curIndex]

	if not var_2_0 then
		return arg_2_0:senMsgDone()
	end

	if not EquipHelper.isNormalEquip(var_2_0.config) then
		return
	end

	local var_2_1 = EquipConfig.instance:getEquipRefineLvMax()
	local var_2_2 = 60
	local var_2_3 = string.format("add equip %d#%d#%d", var_2_0.equipId, var_2_2, var_2_1)

	GMRpc.instance:sendGMRequest(var_2_3)
	GameFacade.showToastString(string.format("心相全部拉满进度  %s / %s", arg_2_0.curIndex, arg_2_0.maxCount))
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
