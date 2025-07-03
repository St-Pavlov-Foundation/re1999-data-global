module("modules.logic.fight.entity.comp.skill.FightTLEventCameraTrace", package.seeall)

local var_0_0 = class("FightTLEventCameraTrace", FightTimelineTrackItem)
local var_0_1 = {
	Attacker = 1,
	Defender = 2,
	Reset = 0,
	PosAbsDistRelateAtk = 4,
	PosAbs = 3
}

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = GameSceneMgr.instance:getCurScene().camera

	var_1_0:setEaseTime(arg_1_2)
	var_1_0:setEaseType(EaseType.Str2Type(arg_1_3[5]))

	local var_1_1 = tonumber(arg_1_3[1]) or 0

	if var_1_1 == var_0_1.Reset then
		var_1_0:resetParam()
	else
		local var_1_2 = tonumber(arg_1_3[2]) or 0

		if var_1_2 > 0 then
			local var_1_3 = var_1_0:getCurCO()

			if var_1_1 == var_0_1.PosAbsDistRelateAtk then
				local var_1_4 = FightHelper.getEntity(arg_1_1.fromId)
				local var_1_5, var_1_6, var_1_7 = transformhelper.getPos(var_1_4.go.transform)

				var_1_0:setDistance(var_1_2 - var_1_7)
			else
				var_1_0:setDistance(var_1_2)
			end
		else
			var_1_0:resetDistance(var_1_2)
		end

		if arg_1_3[3] == "1" then
			local var_1_8 = string.split(arg_1_3[4], ",")
			local var_1_9 = tonumber(var_1_8[1]) or 0
			local var_1_10 = tonumber(var_1_8[2]) or 0
			local var_1_11 = tonumber(var_1_8[3]) or 0
			local var_1_12 = 0
			local var_1_13 = 0
			local var_1_14 = 0

			if var_1_1 == var_0_1.Attacker or var_1_1 == var_0_1.Defender then
				local var_1_15 = var_1_1 == var_0_1.Attacker and arg_1_1.fromId or arg_1_1.toId
				local var_1_16 = FightHelper.getEntity(var_1_15)

				if var_1_16 then
					var_1_12, var_1_13, var_1_14 = FightHelper.getEntityWorldCenterPos(var_1_16)

					if not var_1_16:isMySide() then
						var_1_9 = -var_1_9
					end
				end
			elseif var_1_1 == var_0_1.PosAbs or var_1_1 == var_0_1.PosAbsDistRelateAtk then
				local var_1_17 = FightHelper.getEntity(arg_1_1.fromId)

				if var_1_17 and not var_1_17:isMySide() then
					var_1_9 = -var_1_9
				end
			end

			var_1_0:setFocus(var_1_12 + var_1_9, var_1_13 + var_1_10, var_1_14 + var_1_11)
		else
			local var_1_18 = var_1_0:getCurCO()

			var_1_0:setFocus(0, var_1_18.yOffset, var_1_18.focusZ)
		end
	end
end

return var_0_0
