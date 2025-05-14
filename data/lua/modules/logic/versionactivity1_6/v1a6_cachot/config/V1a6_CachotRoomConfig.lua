module("modules.logic.versionactivity1_6.v1a6_cachot.config.V1a6_CachotRoomConfig", package.seeall)

local var_0_0 = class("V1a6_CachotRoomConfig")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._roomConfigTable = arg_1_1
	arg_1_0._roomConfigDict = arg_1_1.configDict
	arg_1_0._roomConfigList = arg_1_1.configList
end

function var_0_0.getRoomConfigList(arg_2_0)
	return arg_2_0._roomConfigList
end

function var_0_0.getRoomConfigDict(arg_3_0)
	return arg_3_0._roomConfigDict
end

function var_0_0.getCoByRoomId(arg_4_0, arg_4_1)
	return arg_4_0:getRoomConfigDict()[arg_4_1]
end

function var_0_0._initRoomInfo(arg_5_0)
	if not arg_5_0._layerRoomCount then
		arg_5_0._layerRoomCount = {}

		for iter_5_0, iter_5_1 in pairs(lua_rogue_difficulty.configDict) do
			local var_5_0 = iter_5_1.initRoom

			if not arg_5_0._layerRoomCount[iter_5_0] then
				arg_5_0._layerRoomCount[iter_5_0] = {}
			end

			local var_5_1
			local var_5_2 = 1
			local var_5_3 = lua_rogue_room.configDict[var_5_0]

			if var_5_3 then
				local var_5_4 = var_5_3.layer

				arg_5_0._layerRoomCount[iter_5_0][var_5_4] = {
					count = 1
				}
				arg_5_0._layerRoomCount[iter_5_0][var_5_4][var_5_0] = var_5_2

				local var_5_5 = lua_rogue_room.configDict[var_5_3.nextRoom]
				local var_5_6

				if isDebugBuild then
					var_5_6 = {}
				end

				while var_5_5 do
					if var_5_5.layer == var_5_4 then
						var_5_2 = var_5_2 + 1
						arg_5_0._layerRoomCount[iter_5_0][var_5_4][var_5_5.id] = var_5_2
						arg_5_0._layerRoomCount[iter_5_0][var_5_4].count = arg_5_0._layerRoomCount[iter_5_0][var_5_4].count + 1
					else
						var_5_2 = 1
						var_5_4 = var_5_5.layer
						arg_5_0._layerRoomCount[iter_5_0][var_5_4] = {
							count = 1
						}
						arg_5_0._layerRoomCount[iter_5_0][var_5_4][var_5_5.id] = var_5_2
					end

					if var_5_6 then
						if var_5_6[var_5_5.nextRoom] then
							logError("房间配置死循环了！！！！！！请检查配置")

							return
						else
							var_5_6[var_5_5.nextRoom] = true
						end
					end

					var_5_5 = lua_rogue_room.configDict[var_5_5.nextRoom]
				end
			end
		end
	end
end

function var_0_0.getRoomIndexAndTotal(arg_6_0, arg_6_1)
	arg_6_0:_initRoomInfo()

	local var_6_0 = lua_rogue_room.configDict[arg_6_1]

	if not var_6_0 then
		return 0, 0
	end

	if var_6_0.type == 0 then
		return arg_6_0:getRoomIndexAndTotal(lua_rogue_difficulty.configDict[var_6_0.difficulty].initRoom)
	end

	local var_6_1 = arg_6_0._layerRoomCount[var_6_0.difficulty][var_6_0.layer]

	if not var_6_1 then
		return 0, 0
	end

	return var_6_1[var_6_0.id], var_6_1.count
end

function var_0_0.getLayerIndexAndTotal(arg_7_0, arg_7_1)
	arg_7_0:_initRoomInfo()

	local var_7_0 = lua_rogue_room.configDict[arg_7_1]

	if not var_7_0 then
		return 0, 0
	end

	if var_7_0.type == 0 then
		return arg_7_0:getLayerIndexAndTotal(lua_rogue_difficulty.configDict[var_7_0.difficulty].initRoom)
	end

	local var_7_1 = arg_7_0._layerRoomCount[var_7_0.difficulty]

	if not var_7_1 then
		return 0, 0
	end

	return var_7_0.layer, #var_7_1
end

function var_0_0.getLayerName(arg_8_0, arg_8_1, arg_8_2)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._roomConfigDict) do
		if iter_8_1.layer == arg_8_1 and iter_8_1.difficulty == arg_8_2 then
			return iter_8_1.name
		end
	end
end

function var_0_0.checkNextRoomIsLastRoom(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._roomConfigDict[arg_9_1]

	if var_9_0 then
		local var_9_1 = var_9_0.nextRoom

		if not var_9_1 then
			return true
		else
			local var_9_2 = arg_9_0._roomConfigDict[var_9_1]

			if var_9_2 and var_9_2.layer ~= var_9_0.layer then
				return true
			end
		end
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
