module("modules.logic.versionactivity2_5.feilinshiduo.model.FeiLinShiDuoGameModel", package.seeall)

local var_0_0 = class("FeiLinShiDuoGameModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()

	arg_1_0.curGameConfig = {}
	arg_1_0.isBlindnessMode = false
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.elementMap = {}
	arg_2_0.elementList = {}
	arg_2_0.interElementList = {}
	arg_2_0.interElementMap = {}
	arg_2_0.elementShowStateMap = {}
	arg_2_0.touchElementState = {}
	arg_2_0.playerCurMoveSpeed = 0
	arg_2_0.doorOpenStateMap = {}
	arg_2_0.curColor = FeiLinShiDuoEnum.ColorType.None
	arg_2_0.isInColorChanging = false
	arg_2_0.isPlayerInIdleState = true
end

function var_0_0.initConfigData(arg_3_0, arg_3_1)
	arg_3_0:reInit()

	arg_3_0.mapConfigData = addGlobalModule("modules.configs.feilinshiduo.lua_feilinshiduo_map_" .. tostring(arg_3_1))
	arg_3_0.mapConfig = arg_3_0.mapConfigData.mapConfig

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.mapConfig) do
		local var_3_0 = arg_3_0.elementMap[iter_3_1.type]

		if not var_3_0 then
			var_3_0 = {}
			arg_3_0.elementMap[iter_3_1.type] = var_3_0
		end

		if not var_3_0[iter_3_1.id] then
			local var_3_1 = {
				id = iter_3_1.id,
				type = iter_3_1.type,
				pos = string.splitToNumber(iter_3_1.pos, "#"),
				color = iter_3_1.color,
				refId = iter_3_1.refId,
				scale = string.splitToNumber(iter_3_1.scale, "#"),
				params = iter_3_1.params,
				subGOPosList = GameUtil.splitString2(iter_3_1.subGOPosList, true),
				groupName = FeiLinShiDuoEnum.ParentName[iter_3_1.type],
				width = tonumber(iter_3_1.width),
				height = tonumber(iter_3_1.height)
			}

			var_3_0[iter_3_1.id] = var_3_1
		end

		table.insert(arg_3_0.interElementList, var_3_0[iter_3_1.id])
		table.insert(arg_3_0.elementList, var_3_0[iter_3_1.id])

		arg_3_0.elementShowStateMap[iter_3_1.id] = true
		arg_3_0.interElementMap[iter_3_1.id] = var_3_0[iter_3_1.id]
	end
end

function var_0_0.setCurMapId(arg_4_0, arg_4_1)
	arg_4_0.curMapId = arg_4_1
end

function var_0_0.getCurMapId(arg_5_0)
	return arg_5_0.curMapId
end

function var_0_0.setGameConfig(arg_6_0, arg_6_1)
	arg_6_0.curGameConfig = arg_6_1
end

function var_0_0.getCurGameConfig(arg_7_0)
	return arg_7_0.curGameConfig
end

function var_0_0.getElementList(arg_8_0)
	return arg_8_0.elementList
end

function var_0_0.getInterElementList(arg_9_0)
	return arg_9_0.interElementList
end

function var_0_0.getInterElementMap(arg_10_0)
	return arg_10_0.interElementMap
end

function var_0_0.getElementMap(arg_11_0)
	return arg_11_0.elementMap
end

function var_0_0.getMapConfigData(arg_12_0)
	return arg_12_0.mapConfigData
end

function var_0_0.setCurPlayerMoveSpeed(arg_13_0, arg_13_1)
	arg_13_0.playerCurMoveSpeed = arg_13_1
end

function var_0_0.getCurPlayerMoveSpeed(arg_14_0)
	return arg_14_0.playerCurMoveSpeed
end

function var_0_0.setBlindnessModeState(arg_15_0, arg_15_1)
	arg_15_0.isBlindnessMode = arg_15_1
end

function var_0_0.getBlindnessModeState(arg_16_0)
	return arg_16_0.isBlindnessMode
end

local var_0_1 = Vector3()
local var_0_2 = Vector3()

function var_0_0.checkTouchElement(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0 = {}
	local var_17_1 = arg_17_4 or arg_17_0.interElementList

	for iter_17_0, iter_17_1 in pairs(var_17_1) do
		var_0_1.x = iter_17_1.pos[1]
		var_0_1.y = iter_17_1.pos[2]
		var_0_2.x = var_0_1.x + iter_17_1.width
		var_0_2.y = var_0_1.y + iter_17_1.height

		local var_17_2 = true

		if arg_17_3 and #arg_17_3 > 0 then
			for iter_17_2, iter_17_3 in ipairs(arg_17_3) do
				if iter_17_1.type == iter_17_3 then
					var_17_2 = false

					break
				end
			end
		end

		if iter_17_1.type == FeiLinShiDuoEnum.ObjectType.Stairs and arg_17_5 and arg_17_1 >= var_0_1.x and arg_17_1 <= var_0_2.x and arg_17_2 > var_0_1.y and arg_17_2 < var_0_2.y - FeiLinShiDuoEnum.HalfSlotWidth / 2 then
			var_17_2 = false
		end

		if arg_17_0.elementShowStateMap[iter_17_1.id] and arg_17_1 >= var_0_1.x and arg_17_1 <= var_0_2.x and arg_17_2 >= var_0_1.y and arg_17_2 <= var_0_2.y and var_17_2 then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function var_0_0.checkItemTouchElemenet(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4, arg_18_5, arg_18_6)
	local var_18_0 = {}

	if not arg_18_0.elementShowStateMap[arg_18_3.id] then
		return var_18_0
	end

	local var_18_1 = FeiLinShiDuoEnum.touchCheckRange
	local var_18_2 = arg_18_5 or arg_18_0.interElementList

	for iter_18_0, iter_18_1 in pairs(var_18_2) do
		if arg_18_0.elementShowStateMap[iter_18_1.id] then
			local var_18_3 = false

			if arg_18_4 == FeiLinShiDuoEnum.checkDir.Left then
				if arg_18_2 < iter_18_1.pos[2] + iter_18_1.height - var_18_1 and iter_18_1.pos[2] + var_18_1 < arg_18_2 + arg_18_3.height and arg_18_1 > iter_18_1.pos[1] and Mathf.Abs(iter_18_1.pos[1] - arg_18_1) <= iter_18_1.width then
					var_18_3 = true
				end
			elseif arg_18_4 == FeiLinShiDuoEnum.checkDir.Top then
				if arg_18_1 < iter_18_1.pos[1] + iter_18_1.width - var_18_1 and iter_18_1.pos[1] + var_18_1 < arg_18_1 + arg_18_3.width and arg_18_2 < iter_18_1.pos[2] and Mathf.Abs(iter_18_1.pos[2] - arg_18_2) <= arg_18_3.height then
					var_18_3 = true
				end
			elseif arg_18_4 == FeiLinShiDuoEnum.checkDir.Right then
				if arg_18_2 < iter_18_1.pos[2] + iter_18_1.height - var_18_1 and iter_18_1.pos[2] + var_18_1 < arg_18_2 + arg_18_3.height and arg_18_1 < iter_18_1.pos[1] and Mathf.Abs(iter_18_1.pos[1] - arg_18_1) <= arg_18_3.width then
					var_18_3 = true
				end
			elseif arg_18_4 == FeiLinShiDuoEnum.checkDir.Bottom and arg_18_1 < iter_18_1.pos[1] + iter_18_1.width - var_18_1 and iter_18_1.pos[1] + var_18_1 < arg_18_1 + arg_18_3.width and arg_18_2 > iter_18_1.pos[2] and Mathf.Abs(iter_18_1.pos[2] - arg_18_2) <= iter_18_1.height then
				var_18_3 = true
			end

			if iter_18_1.type == FeiLinShiDuoEnum.ObjectType.Stairs and Mathf.Abs(arg_18_3.pos[1] + arg_18_3.width / 2 - (iter_18_1.pos[1] - iter_18_1.width / 2)) < arg_18_3.width / 2 + iter_18_1.width / 2 and arg_18_2 > iter_18_1.pos[2] and arg_18_2 <= iter_18_1.pos[2] + iter_18_1.height - FeiLinShiDuoEnum.HalfSlotWidth / 2 then
				var_18_3 = false
			end

			if arg_18_6 and #arg_18_6 > 0 then
				for iter_18_2, iter_18_3 in pairs(arg_18_6) do
					if iter_18_1.type == iter_18_3 then
						var_18_3 = false

						break
					end
				end
			end

			if var_18_3 then
				table.insert(var_18_0, iter_18_1)
			end
		end
	end

	return var_18_0
end

function var_0_0.updateBoxPos(arg_19_0, arg_19_1, arg_19_2)
	if not arg_19_0.elementMap or next(arg_19_0.elementMap) == nil then
		return
	end

	arg_19_0.elementMap[FeiLinShiDuoEnum.ObjectType.Box][arg_19_1].pos = arg_19_2
end

local var_0_3 = Vector3()
local var_0_4 = Vector3()

function var_0_0.getFixStandePos(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_1 and #arg_20_1 > 0 then
		for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
			if arg_20_3 >= iter_20_1.pos[2] and (iter_20_1.type == FeiLinShiDuoEnum.ObjectType.ColorPlane or iter_20_1.type == FeiLinShiDuoEnum.ObjectType.Wall or iter_20_1.type == FeiLinShiDuoEnum.ObjectType.Box or iter_20_1.type == FeiLinShiDuoEnum.ObjectType.Trap) then
				var_0_3.x = iter_20_1.pos[1]
				var_0_3.y = iter_20_1.pos[2]
				var_0_4.x = var_0_3.x + iter_20_1.width
				var_0_4.y = var_0_3.y + iter_20_1.height

				if arg_20_3 >= var_0_3.y and arg_20_3 <= var_0_4.y then
					return var_0_3, var_0_4
				end
			end
		end
	end
end

function var_0_0.setElememntShowStateByColor(arg_21_0, arg_21_1)
	arg_21_0.curColor = arg_21_1

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.elementList) do
		if arg_21_1 == FeiLinShiDuoEnum.ColorType.Yellow and iter_21_1.color == FeiLinShiDuoEnum.ColorType.Red then
			arg_21_0.elementShowStateMap[iter_21_1.id] = false
		else
			arg_21_0.elementShowStateMap[iter_21_1.id] = iter_21_1.color ~= arg_21_1 or arg_21_1 == FeiLinShiDuoEnum.ColorType.None
		end
	end
end

function var_0_0.showAllElementState(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.elementList) do
		arg_22_0.elementShowStateMap[iter_22_1.id] = true
	end
end

function var_0_0.getCurColor(arg_23_0)
	return arg_23_0.curColor
end

function var_0_0.getElementShowStateMap(arg_24_0)
	return arg_24_0.elementShowStateMap
end

function var_0_0.getElementShowState(arg_25_0, arg_25_1)
	return arg_25_0.elementShowStateMap[arg_25_1.id]
end

function var_0_0.setDoorOpenState(arg_26_0, arg_26_1, arg_26_2)
	arg_26_0.doorOpenStateMap[arg_26_1] = arg_26_2
end

function var_0_0.getDoorOpenStateMap(arg_27_0)
	return arg_27_0.doorOpenStateMap
end

function var_0_0.setIsPlayerInColorChanging(arg_28_0, arg_28_1)
	arg_28_0.isInColorChanging = arg_28_1
end

function var_0_0.getIsPlayerInColorChanging(arg_29_0)
	return arg_29_0.isInColorChanging
end

function var_0_0.setPlayerIsIdleState(arg_30_0, arg_30_1)
	arg_30_0.isPlayerInIdleState = arg_30_1
end

function var_0_0.getPlayerIsIdleState(arg_31_0)
	return arg_31_0.isPlayerInIdleState
end

function var_0_0.checkForwardCanMove(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	local var_32_0 = {}

	if arg_32_5 then
		local var_32_1 = arg_32_3 > 0 and FeiLinShiDuoEnum.checkDir.Right or FeiLinShiDuoEnum.checkDir.Left

		var_32_0 = arg_32_0:checkItemTouchElemenet(arg_32_1, arg_32_2, arg_32_4, var_32_1)
	else
		var_32_0 = arg_32_0:checkTouchElement(arg_32_1, arg_32_2)
	end

	if var_32_0 and #var_32_0 > 0 then
		for iter_32_0, iter_32_1 in ipairs(var_32_0) do
			if iter_32_1.type == FeiLinShiDuoEnum.ObjectType.Wall or iter_32_1.type == FeiLinShiDuoEnum.ObjectType.ColorPlane then
				return false, arg_32_3 > 0 and iter_32_1.pos[1] or iter_32_1.pos[1] + iter_32_1.width
			elseif iter_32_1.type == FeiLinShiDuoEnum.ObjectType.Door and not arg_32_0.doorOpenStateMap[iter_32_1.id] then
				if arg_32_4 and arg_32_4.type == FeiLinShiDuoEnum.ObjectType.Box and Mathf.Abs(iter_32_1.pos[1] + iter_32_1.width / 2 - (arg_32_1 + (arg_32_3 > 0 and arg_32_4.width or 0))) <= FeiLinShiDuoEnum.touchElementRange then
					return false, iter_32_1.pos[1] + iter_32_1.width / 2 - arg_32_3 * FeiLinShiDuoEnum.doorTouchCheckRang / 2
				elseif not arg_32_4 and Mathf.Abs(iter_32_1.pos[1] + iter_32_1.width / 2 - arg_32_1) <= FeiLinShiDuoEnum.touchElementRange then
					return false, iter_32_1.pos[1] + iter_32_1.width / 2 - arg_32_3 * FeiLinShiDuoEnum.doorTouchCheckRang / 2
				end
			elseif iter_32_1.type == FeiLinShiDuoEnum.ObjectType.Box then
				local var_32_2, var_32_3 = arg_32_0:checkForwardCanMove(iter_32_1.pos[1] + arg_32_3, iter_32_1.pos[2], arg_32_3, iter_32_1, true)

				var_32_3 = var_32_3 and (arg_32_3 > 0 and iter_32_1.pos[1] or iter_32_1.pos[1] + iter_32_1.width)

				return var_32_2, var_32_3
			end
		end
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
