module("modules.logic.versionactivity1_2.yaxian.controller.game.status.YaXianInteractPlayerStatus", package.seeall)

local var_0_0 = class("YaXianInteractPlayerStatus", YaXianInteractStatusBase)

function var_0_0.updateStatus(arg_1_0)
	arg_1_0.statusDict = {}
	arg_1_0.hadInVisibleEffect = YaXianGameModel.instance:hasInVisibleEffect()
	arg_1_0.hadThroughWallEffect = YaXianGameModel.instance:hasThroughWallEffect()
	arg_1_0.canWalkDirection2Pos = YaXianGameModel.instance:getCanWalkTargetPosDict()
	arg_1_0.canWalkPos2Direction = YaXianGameModel.instance:getCanWalkPos2Direction()

	arg_1_0:addVisibleStatus()
	arg_1_0:addThroughWallStatus()
	arg_1_0:addAssassinateOrFightStatus()
end

function var_0_0.addVisibleStatus(arg_2_0)
	if arg_2_0.hadInVisibleEffect then
		arg_2_0:addStatus(YaXianGameEnum.IconStatus.InVisible)
	end
end

function var_0_0.addThroughWallStatus(arg_3_0)
	if arg_3_0.hadThroughWallEffect then
		arg_3_0:addStatus(YaXianGameEnum.IconStatus.ThroughWall)
	end
end

function var_0_0.addAssassinateOrFightStatus(arg_4_0)
	local var_4_0 = YaXianGameController.instance:getInteractItemList()

	if var_4_0 and #var_4_0 > 0 then
		for iter_4_0, iter_4_1 in ipairs(var_4_0) do
			if iter_4_1 and iter_4_1:isEnemy() and not iter_4_1:isDelete() then
				arg_4_0:handleInteractPos(iter_4_1)
				arg_4_0:handleInteractAlertArea(iter_4_1)
				arg_4_0:handleInteractMoving(iter_4_1)
			end
		end
	end
end

function var_0_0.handleInteractPos(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.canWalkDirection2Pos) do
		local var_5_0 = arg_5_1.interactMo

		if var_5_0.posX == iter_5_1.x and var_5_0.posY == iter_5_1.y then
			if arg_5_1:isFighting() then
				arg_5_0:addStatus(YaXianGameEnum.IconStatus.Fight, iter_5_0)
			elseif not arg_5_0.hadInVisibleEffect and var_5_0.direction == YaXianGameEnum.OppositeDirection[iter_5_0] then
				arg_5_0:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, iter_5_0)
			end
		end
	end
end

function var_0_0.handleInteractAlertArea(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.interactMo.alertPosList

	if var_6_0 and #var_6_0 > 0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			local var_6_1 = arg_6_0.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(iter_6_1.posX, iter_6_1.posY)]

			if var_6_1 then
				if arg_6_1:isFighting() then
					arg_6_0:addStatus(YaXianGameEnum.IconStatus.Fight, var_6_1)
				elseif not arg_6_0.hadInVisibleEffect then
					arg_6_0:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, var_6_1)
				end
			end
		end
	end
end

function var_0_0.handleInteractMoving(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.interactMo
	local var_7_1 = arg_7_1.interactMo.nextPos

	if not var_7_1 then
		return
	end

	for iter_7_0, iter_7_1 in YaXianGameHelper.getPassPosGenerator(var_7_0.posX, var_7_0.posY, var_7_1.posX, var_7_1.posY) do
		local var_7_2 = arg_7_0.canWalkPos2Direction[YaXianGameHelper.getPosHashKey(iter_7_0, iter_7_1)]

		if var_7_2 then
			if arg_7_1:isFighting() then
				arg_7_0:addStatus(YaXianGameEnum.IconStatus.Fight, var_7_2)
			elseif not arg_7_0.hadInVisibleEffect then
				arg_7_0:addStatus(YaXianGameEnum.IconStatus.PlayerAssassinate, var_7_2)
			end
		end
	end
end

return var_0_0
