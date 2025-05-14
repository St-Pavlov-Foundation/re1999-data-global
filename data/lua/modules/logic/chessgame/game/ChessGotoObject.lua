module("modules.logic.chessgame.game.ChessGotoObject", package.seeall)

local var_0_0 = class("ChessGotoObject")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0._srcList = nil
	arg_1_0._itemTrackMark = false
end

function var_0_0.init(arg_2_0)
	return
end

function var_0_0.initAttract(arg_3_0)
	arg_3_0._attractEnemyMap = {}

	if arg_3_0._target.config and arg_3_0._target.config.interactType == ChessGameEnum.InteractType.Item and not string.nilorempty(arg_3_0._target.config.showParam) then
		local var_3_0 = string.splitToNumber(arg_3_0._target.config.showParam, "#")

		for iter_3_0, iter_3_1 in pairs(var_3_0) do
			logNormal("ChessGotoObject initAttract : " .. tostring(iter_3_1))

			arg_3_0._attractEnemyMap[iter_3_1] = true
		end
	end
end

function var_0_0.updateGoToObject(arg_4_0)
	local var_4_0
	local var_4_1 = arg_4_0._target.originData.data

	if var_4_1 then
		var_4_0 = var_4_1.goToObject
	end

	if arg_4_0._goToObjectId == var_4_0 then
		return
	end

	arg_4_0:deleteRelation()

	arg_4_0._goToObjectId = var_4_0

	local var_4_2 = arg_4_0._target.originData.id
	local var_4_3 = ChessGameController.instance.interacts:get(var_4_0)

	if var_4_3 ~= nil then
		var_4_3.goToObject:addSource(var_4_2)
	end

	arg_4_0:refreshTarget()
end

function var_0_0.deleteRelation(arg_5_0)
	return
end

function var_0_0.refreshSource(arg_6_0)
	if arg_6_0._target.avatar and arg_6_0._target.avatar.goTracked then
		if arg_6_0._srcList then
			gohelper.setActive(arg_6_0._target.avatar.goTracked, #arg_6_0._srcList > 0)
		else
			gohelper.setActive(arg_6_0._target.avatar.goTracked, false)
		end
	end
end

function var_0_0.refreshTarget(arg_7_0)
	if arg_7_0._target.avatar then
		local var_7_0 = false
		local var_7_1 = false

		if arg_7_0._goToObjectId ~= nil and arg_7_0._goToObjectId ~= 0 then
			local var_7_2
			local var_7_3 = ChessGameController.instance.interacts:get(arg_7_0._goToObjectId)

			if var_7_3 ~= nil then
				var_7_2 = var_7_3.objType
			end

			if var_7_2 == ChessGameEnum.InteractType.Item or var_7_2 == ChessGameEnum.InteractType.NoEffectItem then
				var_7_1 = true
			else
				var_7_0 = true
			end
		end

		local var_7_4 = arg_7_0._target.originData.data

		if var_7_4 and var_7_4.lostTarget == true then
			gohelper.setActive(arg_7_0._target.avatar.goTrackItem, false)
			gohelper.setActive(arg_7_0._target.avatar.goTrack, false)

			return
		end

		gohelper.setActive(arg_7_0._target.avatar.goTrackItem, var_7_1 or arg_7_0._itemTrackMark)
		gohelper.setActive(arg_7_0._target.avatar.goTrack, var_7_0)
	end
end

function var_0_0.addSource(arg_8_0, arg_8_1)
	arg_8_0._srcList = arg_8_0._srcList or {}

	table.insert(arg_8_0._srcList, arg_8_1)
	arg_8_0:refreshSource()
end

function var_0_0.removeSource(arg_9_0, arg_9_1)
	if arg_9_0._srcList then
		tabletool.removeValue(arg_9_0._srcList, arg_9_1)
	end

	arg_9_0:refreshSource()
end

function var_0_0.setItemTrackMark(arg_10_0, arg_10_1)
	arg_10_0._itemTrackMark = arg_10_1
end

function var_0_0.setMarkAttract(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._attractEnemyMap) do
		local var_11_0 = ChessGameController.instance.interacts:get(iter_11_0)

		if var_11_0 ~= nil then
			var_11_0.goToObject:setItemTrackMark(arg_11_1)
			var_11_0.goToObject:refreshTarget()
		end
	end
end

function var_0_0.onAvatarLoaded(arg_12_0)
	local var_12_0 = arg_12_0._target.avatar.loader

	if not var_12_0 then
		return
	end

	arg_12_0._target.avatar.goTracked = gohelper.findChild(var_12_0:getInstGO(), "piecea/vx_tracked")
	arg_12_0._target.avatar.goTrack = gohelper.findChild(var_12_0:getInstGO(), "piecea/vx_track")
	arg_12_0._target.avatar.goTrackItem = gohelper.findChild(var_12_0:getInstGO(), "piecea/vx_wenao")

	arg_12_0:refreshSource()
	arg_12_0:refreshTarget()
end

function var_0_0.dispose(arg_13_0)
	arg_13_0:deleteRelation()
end

return var_0_0
