module("modules.logic.versionactivity1_4.dungeon.model.VersionActivity1_4DungeonModel", package.seeall)

local var_0_0 = class("VersionActivity1_4DungeonModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.setSelectEpisodeId(arg_3_0, arg_3_1)
	arg_3_0._selectEpisodeId = arg_3_1

	VersionActivity1_4DungeonController.instance:dispatchEvent(VersionActivity1_4DungeonEvent.OnSelectEpisodeId)
end

function var_0_0.getSelectEpisodeId(arg_4_0)
	return arg_4_0._selectEpisodeId
end

function var_0_0.getEpisodeState(arg_5_0, arg_5_1)
	local var_5_0 = {}
	local var_5_1 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), "")
	local var_5_2 = GameUtil.splitString2(var_5_1, true)

	if var_5_2 then
		for iter_5_0, iter_5_1 in pairs(var_5_2) do
			var_5_0[iter_5_1[1]] = iter_5_1[2] or 0
		end
	end

	return var_5_0[arg_5_1] or 0
end

function var_0_0.setEpisodeState(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), "")
	local var_6_2 = GameUtil.splitString2(var_6_1, true)

	if var_6_2 then
		for iter_6_0, iter_6_1 in pairs(var_6_2) do
			var_6_0[iter_6_1[1]] = iter_6_1[2] or 0
		end
	end

	var_6_0[arg_6_1] = arg_6_2

	local var_6_3 = {}

	for iter_6_2, iter_6_3 in pairs(var_6_0) do
		table.insert(var_6_3, string.format("%s#%s", iter_6_2, iter_6_3))
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.Version1_4_DungeonAnim), table.concat(var_6_3, "|"))
end

var_0_0.instance = var_0_0.New()

return var_0_0
