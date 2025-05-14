module("modules.logic.gm.model.GMHelpViewBrowseModel", package.seeall)

local var_0_0 = class("GMHelpViewBrowseModel", ListScrollModel)

var_0_0.tabModeEnum = {
	fightTechniqueGuide = 5,
	fightTechniqueView = 3,
	weekWalkRuleView = 6,
	helpView = 1,
	fightTechniqueTipView = 4,
	fightGuideView = 2
}

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.getCurrentTabMode(arg_3_0)
	return arg_3_0._currentTabMode
end

function var_0_0._getTabModeList(arg_4_0, arg_4_1)
	local var_4_0 = {}

	if arg_4_1 == var_0_0.tabModeEnum.helpView then
		var_4_0 = arg_4_0:_getHelpViewList()
	elseif arg_4_1 == var_0_0.tabModeEnum.fightGuideView then
		var_4_0 = arg_4_0:_getFightGuideList()
	elseif arg_4_1 == var_0_0.tabModeEnum.fightTechniqueView then
		var_4_0 = arg_4_0:_getFightTechniqueList()
	elseif arg_4_1 == var_0_0.tabModeEnum.fightTechniqueTipView then
		var_4_0 = arg_4_0:_getFightTechniqueTipList()
	elseif arg_4_1 == var_0_0.tabModeEnum.fightTechniqueGuide then
		var_4_0 = arg_4_0:_getFightTechniqueGuideList()
	elseif arg_4_1 == var_0_0.tabModeEnum.weekWalkRuleView then
		var_4_0 = arg_4_0:_getWeekWalkRuleList()
	else
		logError("GMHelpViewBrowseModel错误，tabMode获取列表未定义：" .. arg_4_1)
	end

	return var_4_0
end

function var_0_0.setListByTabMode(arg_5_0, arg_5_1)
	if arg_5_0._currentTabMode and arg_5_0._currentTabMode == arg_5_1 then
		return
	end

	local var_5_0 = arg_5_0:_getTabModeList(arg_5_1)

	arg_5_0._currentTabMode = arg_5_1

	arg_5_0:setList(var_5_0)
	arg_5_0:onModelUpdate()
end

function var_0_0.setSearch(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:_getTabModeList(arg_6_0._currentTabMode)
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_2 = true

		if not string.nilorempty(arg_6_1) then
			var_6_2 = string.find(tostring(iter_6_1.id), arg_6_1) or string.find(iter_6_1.icon, arg_6_1)
		end

		if var_6_2 then
			table.insert(var_6_1, iter_6_1)
		end
	end

	arg_6_0:setList(var_6_1)
	arg_6_0:onModelUpdate()
end

function var_0_0._getHelpViewList(arg_7_0)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(lua_helppage.configList) do
		if not string.nilorempty(iter_7_1.icon) then
			local var_7_1

			if iter_7_1.type == HelpEnum.HelpType.Normal then
				var_7_1 = ResUrl.getHelpItem(iter_7_1.icon, iter_7_1.isCn == 1)
			elseif iter_7_1.type == HelpEnum.HelpType.VersionActivity then
				var_7_1 = ResUrl.getVersionActivityHelpItem(iter_7_1.icon, iter_7_1.isCn == 1)
			end

			if var_7_1 then
				local var_7_2 = System.IO.Path.Combine(SLFramework.FrameworkSettings.AssetRootDir, var_7_1)

				if GameResMgr.IsFromEditorDir == false or SLFramework.FileHelper.IsFileExists(var_7_2) then
					table.insert(var_7_0, iter_7_1)
				end
			end
		end
	end

	return var_7_0
end

function var_0_0._getFightGuideList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = ResUrl.getFightGuideLangDir()

	arg_8_0:_fillFightGuideListByDirPath(var_8_0, var_8_1)

	local var_8_2 = ResUrl.getFightGuideDir()

	arg_8_0:_fillFightGuideListByDirPath(var_8_0, var_8_2)

	return var_8_0
end

function var_0_0._fillFightGuideListByDirPath(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = SLFramework.FileHelper.GetDirFilePaths(arg_9_2)

	if not var_9_0 then
		return
	end

	for iter_9_0 = 0, var_9_0.Length - 1 do
		local var_9_1 = var_9_0[iter_9_0]:match(".+/([^/]+)%.png$")

		if var_9_1 then
			local var_9_2 = var_9_1:match("%d+$")

			if var_9_2 then
				local var_9_3 = {
					id = tonumber(var_9_2),
					icon = var_9_1
				}

				table.insert(arg_9_1, var_9_3)
			end
		end
	end
end

function var_0_0._getFightTechniqueList(arg_10_0)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(lua_fight_technique.configList) do
		local var_10_1 = {
			id = iter_10_1.id,
			icon = iter_10_1.picture1
		}

		table.insert(var_10_0, var_10_1)
	end

	return var_10_0
end

function var_0_0._getFightTechniqueTipList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(lua_fight_technique.configList) do
		if not string.nilorempty(iter_11_1.picture2) then
			local var_11_1 = {
				id = iter_11_1.id,
				icon = iter_11_1.picture2
			}

			table.insert(var_11_0, var_11_1)
		end
	end

	return var_11_0
end

function var_0_0._getFightTechniqueGuideList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in ipairs(lua_monster_guide_focus.configList) do
		if not string.nilorempty(iter_12_1.icon) then
			local var_12_1 = {
				id = iter_12_1.id,
				icon = iter_12_1.icon,
				cfg = iter_12_1
			}

			table.insert(var_12_0, var_12_1)
		end
	end

	return var_12_0
end

function var_0_0._getWeekWalkRuleList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(lua_weekwalk_rule.configList) do
		local var_13_1 = {
			id = iter_13_1.id,
			icon = iter_13_1.icon
		}

		table.insert(var_13_0, var_13_1)
	end

	return var_13_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
