module("modules.logic.herogrouppreset.controller.HeroGroupPresetController", package.seeall)

local var_0_0 = class("HeroGroupPresetController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	return
end

function var_0_0.updateFightHeroGroup(arg_5_0)
	if arg_5_0:isFightScene() then
		HeroGroupModel.instance:_setSingleGroup()
	end
end

function var_0_0.isFightScene(arg_6_0)
	return GameSceneMgr.instance:isFightScene()
end

function var_0_0.isFightShowType(arg_7_0)
	return arg_7_0._showType == HeroGroupPresetEnum.ShowType.Fight
end

function var_0_0.useTrial(arg_8_0)
	return GameSceneMgr.instance:isFightScene()
end

function var_0_0.getHeroGroupTypeList(arg_9_0)
	return arg_9_0._heroGroupTypeList
end

function var_0_0.getSelectedSubId(arg_10_0)
	return arg_10_0._subId
end

function var_0_0.snapshotUsePreset(arg_11_0)
	if not arg_11_0 then
		return
	end

	for iter_11_0, iter_11_1 in pairs(HeroGroupPresetEnum.HeroGroupType2SnapshotType) do
		if arg_11_0 == iter_11_1 then
			return HeroGroupPresetEnum.HeroGroupSnapshotTypeOpen[iter_11_0]
		end
	end
end

function var_0_0.openHeroGroupPresetTeamView(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._showType = arg_12_1 and arg_12_1.showType or HeroGroupPresetEnum.ShowType.Normal
	arg_12_0._heroGroupTypeList = arg_12_1 and arg_12_1.heroGroupTypeList
	arg_12_0._subId = arg_12_1 and arg_12_1.subId

	if not arg_12_0:isFightScene() then
		HeroGroupModel.instance.episodeId = nil

		HeroGroupModel.instance:initRestrictHeroData()
		HeroGroupTrialModel.instance:clear()
		TowerModel.instance:clearRecordFightParam()
		FightModel.instance:setFightParam(FightParam.New())
	end

	ViewMgr.instance:closeView(ViewName.HeroGroupPresetTeamView)
	var_0_0.instance:closeHeroGroupPresetEditView()
	ViewMgr.instance:openView(ViewName.HeroGroupPresetTeamView, arg_12_1, arg_12_2)
end

function var_0_0.closeHeroGroupPresetEditView(arg_13_0)
	ViewMgr.instance:closeView(ViewName.HeroGroupPresetEditView)
end

function var_0_0.openHeroGroupPresetEditView(arg_14_0, arg_14_1, arg_14_2)
	var_0_0.instance:closeHeroGroupPresetEditView()
	ViewMgr.instance:openView(ViewName.HeroGroupPresetEditView, arg_14_1, arg_14_2)
end

function var_0_0.openHeroGroupPresetModifyNameView(arg_15_0, arg_15_1, arg_15_2)
	ViewMgr.instance:openView(ViewName.HeroGroupPresetModifyNameView, arg_15_1, arg_15_2)
end

function var_0_0.initCopyHeroGroupList(arg_16_0)
	if not arg_16_0:isFightScene() then
		return
	end

	local var_16_0 = HeroGroupModel.instance:getPresetHeroGroupType()

	if not var_16_0 then
		return
	end

	arg_16_0._copyList = {}

	local var_16_1 = HeroGroupPresetHeroGroupChangeController.instance:getHeroGroupList(var_16_0)

	if var_16_1 then
		for iter_16_0, iter_16_1 in pairs(var_16_1) do
			local var_16_2 = HeroGroupMO.New()

			var_16_2:init(iter_16_1)
			table.insert(arg_16_0._copyList, var_16_2)
		end
	end
end

function var_0_0.getHeroGroupCopyList(arg_17_0, arg_17_1)
	if arg_17_0:isFightScene() and HeroGroupModel.instance:getPresetHeroGroupType() == arg_17_1 and arg_17_0._copyList then
		local var_17_0 = {}

		for iter_17_0, iter_17_1 in pairs(arg_17_0._copyList) do
			local var_17_1 = HeroGroupMO.New()

			var_17_1:init(iter_17_1)
			table.insert(var_17_0, var_17_1)
		end

		return var_17_0
	end
end

function var_0_0.deleteHeroGroupCopy(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0:isFightScene() then
		return
	end

	if not arg_18_0._copyList then
		return
	end

	local var_18_0 = HeroGroupModel.instance:getPresetHeroGroupType()

	if not var_18_0 then
		return
	end

	local var_18_1 = HeroGroupPresetEnum.HeroGroupType2SnapshotAllType[var_18_0]

	if var_18_1 ~= arg_18_1 then
		logError(string.format("HeroGroupPresetController:deleteHeroGroupCopy error heroGroupSnapShotId:%s,snapshotId:%s", var_18_1, arg_18_1))

		return
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_0._copyList) do
		if iter_18_1.groupId == arg_18_2 then
			table.remove(arg_18_0._copyList, iter_18_0)

			return
		end
	end

	logError(string.format("HeroGroupPresetController:deleteHeroGroupCopy error heroGroupSnapShotId:%s,snapshotSubId:%s", var_18_1, arg_18_2))
end

function var_0_0.addHeroGroupCopy(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_0:isFightScene() then
		return
	end

	if not arg_19_0._copyList then
		return
	end

	local var_19_0 = HeroGroupModel.instance:getPresetHeroGroupType()

	if not var_19_0 then
		return
	end

	local var_19_1 = HeroGroupPresetEnum.HeroGroupType2SnapshotAllType[var_19_0]

	if var_19_1 ~= arg_19_1 then
		logError(string.format("HeroGroupPresetController:addHeroGroupCopy error heroGroupSnapShotId:%s,snapshotId:%s", var_19_1, arg_19_1))

		return
	end

	for iter_19_0, iter_19_1 in ipairs(arg_19_0._copyList) do
		if iter_19_1.groupId == arg_19_2 then
			table.remove(arg_19_0._copyList, iter_19_0)
			logError(string.format("HeroGroupPresetController:addHeroGroupCopy remove error heroGroupSnapShotId:%s,snapshotSubId:%s", var_19_1, arg_19_2))

			break
		end
	end

	table.insert(arg_19_0._copyList, arg_19_3)
end

function var_0_0.revertCurHeroGroup(arg_20_0)
	if not arg_20_0:isFightScene() then
		return
	end

	if not arg_20_0._copyList then
		return
	end

	local var_20_0 = HeroGroupModel.instance:getPresetHeroGroupType()

	if not var_20_0 then
		return
	end

	local var_20_1 = HeroGroupModel.instance.heroGroupType

	if var_20_1 == ModuleEnum.HeroGroupType.Temp or var_20_1 == ModuleEnum.HeroGroupType.Trial then
		return
	end

	local var_20_2 = HeroGroupModel.instance:getCurGroupMO()

	if not var_20_2 or not var_20_2.groupId then
		return
	end

	local var_20_3 = ""

	for iter_20_0, iter_20_1 in ipairs(arg_20_0._copyList) do
		var_20_3 = string.format("%s#%s", var_20_3, iter_20_1.groupId)

		if iter_20_1.groupId == var_20_2.groupId then
			var_20_2.name = var_20_2.name, var_20_2:init(iter_20_1)

			return
		end
	end

	logError(string.format("HeroGroupPresetController:revertCurHeroGroup error presetHeroGroupType:%s,heroGroupType:%s,snapshotSubId:%s,copyList:%s", var_20_0, var_20_1, var_20_2.groupId, var_20_3))
end

function var_0_0.clearCopyList(arg_21_0)
	arg_21_0._copyList = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
