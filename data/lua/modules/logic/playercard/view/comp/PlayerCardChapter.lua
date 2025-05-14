module("modules.logic.playercard.view.comp.PlayerCardChapter", package.seeall)

local var_0_0 = class("PlayerCardChapter", BasePlayerCardComp)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtChapter = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_chapter")
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onRefreshView(arg_4_0)
	local var_4_0 = arg_4_0:getPlayerInfo().lastEpisodeId
	local var_4_1 = var_4_0 and lua_episode.configDict[var_4_0]

	if var_4_1 then
		if DungeonConfig.instance:getChapterCO(var_4_1.chapterId).type == DungeonEnum.ChapterType.Simple then
			var_4_1 = lua_episode.configDict[var_4_1.normalEpisodeId]
		end

		if var_4_1 then
			arg_4_0.txtChapter.text = string.format("《%s %s》", DungeonController.getEpisodeName(var_4_1), var_4_1.name)
		end
	end
end

function var_0_0.onDestroy(arg_5_0)
	return
end

return var_0_0
