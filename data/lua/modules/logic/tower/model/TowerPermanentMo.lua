module("modules.logic.tower.model.TowerPermanentMo", package.seeall)

local var_0_0 = pureTable("TowerPermanentMo")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.ItemType = 1
	arg_1_0.stage = arg_1_1
	arg_1_0.configList = arg_1_2
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getIsUnFold(arg_3_0)
	return arg_3_0.isUnFold
end

function var_0_0.setIsUnFold(arg_4_0, arg_4_1)
	arg_4_0.isUnFold = arg_4_1
end

function var_0_0.getAltitudeHeight(arg_5_0, arg_5_1)
	local var_5_0 = tabletool.len(arg_5_0.configList)

	if arg_5_1 then
		return var_5_0 * TowerEnum.PermanentUI.SingleItemH + (var_5_0 - 1) * TowerEnum.PermanentUI.ItemSpaceH
	end

	return 0
end

function var_0_0.getStageHeight(arg_6_0, arg_6_1)
	if arg_6_0.curUnFoldingH then
		return TowerEnum.PermanentUI.StageTitleH + arg_6_0.curUnFoldingH
	end

	if tabletool.len(arg_6_0.configList) == 0 then
		return TowerEnum.PermanentUI.LockTipH
	end

	return TowerEnum.PermanentUI.StageTitleH + arg_6_0:getAltitudeHeight(arg_6_1)
end

function var_0_0.overrideStageHeight(arg_7_0, arg_7_1)
	arg_7_0.curUnFoldingH = arg_7_1
end

function var_0_0.cleanCurUnFoldingH(arg_8_0)
	arg_8_0.curUnFoldingH = nil
end

function var_0_0.checkIsOnline(arg_9_0)
	return TowerPermanentModel.instance:checkStageIsOnline(arg_9_0.stage)
end

return var_0_0
