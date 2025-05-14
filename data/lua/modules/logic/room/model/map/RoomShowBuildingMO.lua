module("modules.logic.room.model.map.RoomShowBuildingMO", package.seeall)

local var_0_0 = pureTable("RoomShowBuildingMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id or arg_1_1.uid
	arg_1_0.buildingId = arg_1_1.buildingId or arg_1_1.defineId
	arg_1_0.use = arg_1_1.use
	arg_1_0.uids = arg_1_1.uids or {}
	arg_1_0.levels = arg_1_1.levels or {}
	arg_1_0.config = RoomConfig.instance:getBuildingConfig(arg_1_0.buildingId)
	arg_1_0.level = arg_1_1.level or 0
	arg_1_0.isNeedToBuy = arg_1_1.isNeedToBuy or false
	arg_1_0.isBuyNoCost = arg_1_1.isBuyNoCost or false

	if arg_1_0.config.canLevelUp then
		local var_1_0 = RoomConfig.instance:getLevelGroupConfig(arg_1_1.buildingId, arg_1_0.level)

		if var_1_0 then
			arg_1_0.config = RoomHelper.mergeCfg(arg_1_0.config, var_1_0)
		end
	end
end

function var_0_0.add(arg_2_0, arg_2_1, arg_2_2)
	if not tabletool.indexOf(arg_2_0.uids, arg_2_1) then
		table.insert(arg_2_0.uids, arg_2_1)
		table.insert(arg_2_0.levels, arg_2_2 or 0)
	end
end

function var_0_0.removeUId(arg_3_0, arg_3_1)
	local var_3_0 = tabletool.indexOf(arg_3_0.uids, arg_3_1)

	if var_3_0 then
		table.remove(arg_3_0.uids, var_3_0)
		table.remove(arg_3_0.levels, var_3_0)
	end
end

function var_0_0.getCount(arg_4_0)
	return arg_4_0.uids and #arg_4_0.uids or 0
end

function var_0_0.isDecoration(arg_5_0)
	return arg_5_0.config and arg_5_0.config.buildingType == RoomBuildingEnum.BuildingType.Decoration
end

function var_0_0.getIcon(arg_6_0)
	if arg_6_0.config then
		if arg_6_0.config.canLevelUp then
			local var_6_0 = arg_6_0.levels[1]
			local var_6_1 = RoomConfig.instance:getLevelGroupConfig(arg_6_0.buildingId, var_6_0)

			if var_6_1 and not string.nilorempty(var_6_1.icon) then
				return var_6_1.icon
			end
		end

		return arg_6_0.config.icon
	end
end

return var_0_0
