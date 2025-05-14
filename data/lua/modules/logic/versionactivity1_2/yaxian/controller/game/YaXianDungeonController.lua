module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianDungeonController", package.seeall)

local var_0_0 = class("YaXianDungeonController", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.enterFight(arg_3_0, arg_3_1)
	local var_3_0 = YaXianGameEnum.EpisodeId

	DungeonModel.instance.versionActivityChapterType = DungeonEnum.ChapterType.YaXian

	local var_3_1 = DungeonConfig.instance:getEpisodeCO(var_3_0)

	DungeonFightController.instance:enterFightByBattleId(var_3_1.chapterId, var_3_0, arg_3_1)
end

function var_0_0.openGameAfterFight(arg_4_0)
	local var_4_0 = YaXianModel.instance.currentMapMo

	if not var_4_0 then
		logError("not playing map data")

		return
	end

	YaXianGameController.instance:initMapByMapMo(var_4_0)
	ViewMgr.instance:openView(ViewName.YaXianGameView)
end

var_0_0.instance = var_0_0.New()

return var_0_0
