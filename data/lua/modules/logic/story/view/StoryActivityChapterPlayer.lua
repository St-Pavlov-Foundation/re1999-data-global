module("modules.logic.story.view.StoryActivityChapterPlayer", package.seeall)

local var_0_0 = class("StoryActivityChapterPlayer", UserDataDispose)

var_0_0.StoryType = {
	Close = 2,
	Open = 1
}
var_0_0.VersionSetting = {
	{
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen1_1",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose1_1"
	},
	{
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen1_2",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose1_2"
	},
	{
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen1_3",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose1_3"
	},
	[5] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen1_5",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose1_5"
	},
	[6] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen1_6",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose1_6"
	},
	[8] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen1_8",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose1_8"
	},
	[20] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen2_0",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose2_0"
	},
	[21] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen2_1",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose2_1"
	},
	[23] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen2_3",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose2_3"
	},
	[24] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen2_4",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose2_4"
	},
	[25] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen2_5",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose2_5"
	},
	[27] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen2_7",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose2_7"
	},
	[2901] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpenSP01_1",
		[var_0_0.StoryType.Close] = "StoryActivityChapterCloseSP01_1"
	},
	[2902] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpenSP01_2",
		[var_0_0.StoryType.Close] = "StoryActivityChapterCloseSP01_2"
	},
	[31] = {
		[var_0_0.StoryType.Open] = "StoryActivityChapterOpen3_1",
		[var_0_0.StoryType.Close] = "StoryActivityChapterClose3_1"
	}
}

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.viewGO = arg_1_1
	arg_1_0.logicItems = {}
end

function var_0_0.getLogic(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_0.VersionSetting[arg_2_1][arg_2_2]

	return arg_2_0:getLogicByName(var_2_0)
end

function var_0_0.getLogicByName(arg_3_0, arg_3_1)
	if not arg_3_0.logicItems[arg_3_1] then
		local var_3_0 = _G[arg_3_1]

		arg_3_0.logicItems[arg_3_1] = var_3_0.New(arg_3_0.viewGO)
	end

	return arg_3_0.logicItems[arg_3_1]
end

function var_0_0.playStart(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0.viewGO, true)

	local var_4_0 = string.splitToNumber(arg_4_1.navigateChapterEn, "#")
	local var_4_1 = var_4_0[1] or 1

	if not var_4_0[2] then
		local var_4_2 = 1
	end

	arg_4_0:getLogic(var_4_1, var_0_0.StoryType.Open):setData(arg_4_1)
end

function var_0_0.loadStartImg(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0[string.format("loadStartImg" .. arg_5_1)]

	if var_5_0 then
		var_5_0(arg_5_0, arg_5_1, arg_5_2)
	end
end

function var_0_0.playEnd(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.viewGO, true)

	local var_6_0 = arg_6_1.navigateTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]

	if string.nilorempty(var_6_0) then
		var_6_0 = arg_6_1.navigateChapterEn
	end

	local var_6_1
	local var_6_2

	if tonumber(var_6_0) then
		var_6_2 = tonumber(var_6_0)
	else
		local var_6_3 = string.split(var_6_0, "#")

		if var_6_3[1] and var_6_3[2] then
			var_6_2 = var_6_3[1]
			var_6_1 = var_6_3[2]
		else
			var_6_1 = var_6_3[1]
		end
	end

	var_6_2 = var_6_2 or 1

	arg_6_0:getLogic(tonumber(var_6_2), var_0_0.StoryType.Close):setData(var_6_1)
end

function var_0_0.playRoleStoryStart(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0.viewGO, true)
	arg_7_0:getLogicByName("RoleStoryChapterOpen"):setData(arg_7_1)
end

function var_0_0.hide(arg_8_0)
	gohelper.setActive(arg_8_0.viewGO, false)

	if arg_8_0.logicItems then
		for iter_8_0, iter_8_1 in pairs(arg_8_0.logicItems) do
			iter_8_1:hide()
		end
	end
end

function var_0_0.dispose(arg_9_0)
	if arg_9_0.logicItems then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.logicItems) do
			iter_9_1:onDestory()
		end
	end

	arg_9_0:__onDispose()
end

return var_0_0
