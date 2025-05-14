module("modules.logic.jump.config.JumpConfig", package.seeall)

local var_0_0 = class("JumpConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._jumpConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"jump"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "jump" then
		arg_3_0._jumpConfig = arg_3_2
	end
end

function var_0_0.getJumpConfig(arg_4_0, arg_4_1)
	arg_4_1 = tonumber(arg_4_1)

	if not arg_4_1 or arg_4_1 == 0 then
		logError("jumpId为空")

		return nil
	end

	local var_4_0 = arg_4_0._jumpConfig.configDict[arg_4_1]

	if not var_4_0 then
		logError("没有找到跳转配置, jumpId: " .. tostring(arg_4_1))
	end

	return var_4_0
end

function var_0_0.getJumpName(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getJumpConfig(arg_5_1)

	if var_5_0 then
		local var_5_1 = var_5_0.param

		if string.nilorempty(var_5_1) then
			logError("跳转参数为空")

			return ""
		end

		local var_5_2 = arg_5_2 or "#3f485f"
		local var_5_3 = string.split(var_5_1, "#")
		local var_5_4 = tonumber(var_5_3[1])

		if var_5_4 == JumpEnum.JumpView.DungeonViewWithEpisode then
			local var_5_5 = tonumber(var_5_3[2])

			return arg_5_0:getEpisodeNameAndIndex(var_5_5)
		elseif var_5_4 == JumpEnum.JumpView.DungeonViewWithChapter then
			local var_5_6 = tonumber(var_5_3[2])
			local var_5_7 = DungeonConfig.instance:getChapterCO(var_5_6)
			local var_5_8 = var_5_7.chapterIndex

			if var_5_7 then
				return string.format("<color=%s><size=32>%s</size></color>", var_5_2, var_5_0.name), ""
			end
		elseif var_5_4 == JumpEnum.JumpView.Show then
			return var_5_0.name or ""
		else
			return string.format("<color=%s><size=32>%s</size></color>", var_5_2, var_5_0.name) or ""
		end

		logError("跳转参数错误: " .. var_5_1)

		return ""
	end

	return ""
end

function var_0_0.getEpisodeNameAndIndex(arg_6_0, arg_6_1)
	local var_6_0 = DungeonConfig.instance:getEpisodeCO(arg_6_1)
	local var_6_1 = DungeonConfig.instance:getChapterCO(var_6_0.chapterId)

	if var_6_1 and var_6_1.type == DungeonEnum.ChapterType.Hard then
		var_6_0 = DungeonConfig.instance:getEpisodeCO(var_6_0.preEpisode)
		var_6_1 = DungeonConfig.instance:getChapterCO(var_6_0.chapterId)
	end

	if var_6_0 and var_6_1 then
		local var_6_2 = var_6_1.chapterIndex
		local var_6_3, var_6_4 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_6_1.id, var_6_0.id)

		if var_6_4 == DungeonEnum.EpisodeType.Sp then
			var_6_2 = "SP"
		end

		return string.format("<color=#3f485f><size=32>%s</size></color>", var_6_0.name), string.format("%s-%s", var_6_2, var_6_3)
	end
end

function var_0_0.getJumpEpisodeId(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getJumpConfig(arg_7_1).param
	local var_7_1 = string.split(var_7_0, "#")

	if tonumber(var_7_1[1]) == JumpEnum.JumpView.DungeonViewWithEpisode then
		return tonumber(var_7_1[2])
	end
end

function var_0_0.getJumpView(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return nil
	end

	local var_8_0 = arg_8_0:getJumpConfig(arg_8_1).param
	local var_8_1 = string.split(var_8_0, "#")

	return tonumber(var_8_1[1])
end

function var_0_0.isJumpHardDungeon(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 and DungeonConfig.instance:getEpisodeCO(arg_9_1)
	local var_9_1 = var_9_0 and DungeonConfig.instance:getChapterCO(var_9_0.chapterId)

	return var_9_1 and var_9_1.type == DungeonEnum.ChapterType.Hard
end

function var_0_0.isOpenJumpId(arg_10_0, arg_10_1)
	if VersionValidator.instance:isInReviewing() ~= true then
		return true
	end

	local var_10_0 = arg_10_0:getJumpConfig(arg_10_1).param
	local var_10_1 = string.split(var_10_0, "#")
	local var_10_2 = tonumber(var_10_1[1])

	if var_10_2 == JumpEnum.JumpView.DungeonViewWithEpisode then
		local var_10_3 = tonumber(var_10_1[2])
		local var_10_4 = var_10_3 and DungeonConfig.instance:getEpisodeCO(var_10_3)

		if var_10_4 then
			return ResSplitConfig.instance:isSaveChapter(var_10_4.chapterId)
		end
	elseif var_10_2 == JumpEnum.JumpView.NoticeView then
		return OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.Notice)
	end

	return true
end

var_0_0.instance = var_0_0.New()

return var_0_0
