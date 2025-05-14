module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractEnemyStatus", package.seeall)

local var_0_0 = class("YaXianInteractEnemyStatus", YaXianInteractStatusBase)

function var_0_0.updateStatus(arg_1_0)
	arg_1_0.statusDict = {}
	arg_1_0.hadInVisibleEffect = YaXianGameModel.instance:hasInVisibleEffect()

	if arg_1_0.interactItem:isFighting() then
		arg_1_0:addStatus(YaXianGameEnum.IconStatus.Fight)
	end

	arg_1_0.playerCanWalkPos2Direction = YaXianGameModel.instance:getCanWalkPos2Direction()

	arg_1_0:handleInteractPos()
	arg_1_0:handleInteractAlertArea()
	arg_1_0:handleInteractMoving()
end

function var_0_0.handleInteractPos(arg_2_0)
	local var_2_0 = arg_2_0.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(arg_2_0.interactMo.posX, arg_2_0.interactMo.posY)]

	if not var_2_0 then
		return
	end

	if arg_2_0.interactItem:isFighting() then
		arg_2_0:addStatus(YaXianGameEnum.IconStatus.Fight, YaXianGameEnum.OppositeDirection[var_2_0])
	elseif arg_2_0.hadInVisibleEffect then
		arg_2_0:addStatus(YaXianGameEnum.IconStatus.Assassinate)
	elseif YaXianGameEnum.OppositeDirection[var_2_0] ~= arg_2_0.interactMo.direction then
		arg_2_0:addStatus(YaXianGameEnum.IconStatus.Assassinate)
	end
end

function var_0_0.handleInteractAlertArea(arg_3_0)
	if not arg_3_0.interactItem:isFighting() then
		return
	end

	local var_3_0 = arg_3_0.interactMo.alertPosList

	if var_3_0 and #var_3_0 > 0 then
		for iter_3_0, iter_3_1 in ipairs(var_3_0) do
			if arg_3_0.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(iter_3_1.posX, iter_3_1.posY)] then
				arg_3_0:addStatus(YaXianGameEnum.IconStatus.Fight)

				break
			end
		end
	end
end

function var_0_0.handleInteractMoving(arg_4_0)
	local var_4_0 = arg_4_0.interactItem.interactMo
	local var_4_1 = arg_4_0.interactItem.interactMo.nextPos

	if not var_4_1 then
		return
	end

	if not arg_4_0.hadInVisibleEffect then
		return
	end

	for iter_4_0, iter_4_1 in YaXianGameHelper.getPassPosGenerator(var_4_0.posX, var_4_0.posY, var_4_1.posX, var_4_1.posY) do
		if arg_4_0.playerCanWalkPos2Direction[YaXianGameHelper.getPosHashKey(iter_4_0, iter_4_1)] then
			arg_4_0:addStatus(YaXianGameEnum.IconStatus.Assassinate)

			break
		end
	end
end

return var_0_0
