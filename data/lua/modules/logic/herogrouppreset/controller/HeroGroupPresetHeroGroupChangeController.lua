module("modules.logic.herogrouppreset.controller.HeroGroupPresetHeroGroupChangeController", package.seeall)

local var_0_0 = class("HeroGroupPresetHeroGroupChangeController", BaseController)

function var_0_0.getHeroGroupList(arg_1_0, arg_1_1)
	local var_1_0 = {}

	if arg_1_1 == HeroGroupPresetEnum.HeroGroupType.Common then
		for iter_1_0 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			local var_1_1 = HeroGroupModel.instance:getCommonGroupList(iter_1_0)

			if var_1_1 then
				table.insert(var_1_0, var_1_1)
			end
		end

		return var_1_0
	end

	local var_1_2 = HeroGroupPresetEnum.HeroGroupType2SnapshotType[arg_1_1]

	if var_1_2 then
		for iter_1_1 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			local var_1_3 = HeroGroupSnapshotModel.instance:getHeroGroupInfo(var_1_2, iter_1_1)

			if var_1_3 then
				table.insert(var_1_0, var_1_3)
			end
		end

		return var_1_0
	end

	logError(string.format("HeroGroupPresetHeroGroupChangeController:getHeroGroupList heroGroupType:%s 没有可用的列表", arg_1_1))

	return var_1_0
end

function var_0_0.removeHeroGroup(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 == HeroGroupPresetEnum.HeroGroupType.Common then
		HeroGroupModel.instance:removeCommonGroupList(arg_2_2)

		return
	end

	local var_2_0 = HeroGroupPresetEnum.HeroGroupType2SnapshotType[arg_2_1]

	if var_2_0 then
		HeroGroupSnapshotModel.instance:removeHeroGroup(var_2_0, arg_2_2)
	end
end

function var_0_0.updateHeroGroup(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_1 == ModuleEnum.HeroGroupSnapshotType.TowerPermanentAndLimit then
		HeroGroupSnapshotModel.instance:updateHeroGroupInfo(arg_3_1, arg_3_2, arg_3_3)
	end
end

function var_0_0.addHeroGroup(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_1 == HeroGroupPresetEnum.HeroGroupType.Common then
		HeroGroupModel.instance:addCommonGroupList(arg_4_2, arg_4_3)

		return
	end

	local var_4_0 = HeroGroupPresetEnum.HeroGroupType2SnapshotType[arg_4_1]

	if var_4_0 then
		HeroGroupSnapshotModel.instance:addHeroGroup(var_4_0, arg_4_2, arg_4_3)
	end
end

function var_0_0.getEmptyHeroGroupId(arg_5_0, arg_5_1)
	if arg_5_1 == HeroGroupPresetEnum.HeroGroupType.Common then
		for iter_5_0 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			if not HeroGroupModel.instance:getCommonGroupList(iter_5_0) then
				return iter_5_0
			end
		end
	end

	local var_5_0 = HeroGroupPresetEnum.HeroGroupType2SnapshotType[arg_5_1]

	if var_5_0 then
		for iter_5_1 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			if not HeroGroupSnapshotModel.instance:getHeroGroupInfo(var_5_0, iter_5_1) then
				return iter_5_1
			end
		end
	end

	logError(string.format("HeroGroupPresetHeroGroupChangeController:getEmptyHeroGroupId heroGroupType:%s 没有可用的索引", arg_5_1))
end

function var_0_0.getValidHeroGroupId(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1 == HeroGroupPresetEnum.HeroGroupType.Common then
		if HeroGroupModel.instance:getCommonGroupList(arg_6_2) then
			return arg_6_2
		end

		for iter_6_0 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			if HeroGroupModel.instance:getCommonGroupList(iter_6_0) then
				return iter_6_0
			end
		end
	end

	local var_6_0 = HeroGroupPresetEnum.HeroGroupType2SnapshotType[arg_6_1]

	if var_6_0 then
		if HeroGroupSnapshotModel.instance:getHeroGroupInfo(var_6_0, arg_6_2) then
			return arg_6_2
		end

		for iter_6_1 = HeroGroupPresetEnum.MinNum, HeroGroupPresetEnum.MaxNum do
			if HeroGroupSnapshotModel.instance:getHeroGroupInfo(var_6_0, iter_6_1) then
				return iter_6_1
			end
		end
	end

	logError(string.format("HeroGroupPresetHeroGroupChangeController:getFirstHeroGroupId heroGroupType:%s 没有可用的索引", arg_6_1))

	return arg_6_2
end

function var_0_0.handleHeroListData(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == HeroGroupPresetEnum.HeroGroupType.TowerPermanentAndLimit then
		HeroGroupHandler.setTowerHeroListData(nil, arg_7_2)
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
