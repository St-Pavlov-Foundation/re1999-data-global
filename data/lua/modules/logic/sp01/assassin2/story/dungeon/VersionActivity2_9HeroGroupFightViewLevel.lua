module("modules.logic.sp01.assassin2.story.dungeon.VersionActivity2_9HeroGroupFightViewLevel", package.seeall)

local var_0_0 = class("VersionActivity2_9HeroGroupFightViewLevel", HeroGroupFightViewLevel)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0._gostarcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer")

	gohelper.setActive(arg_1_0._gostarcontainer, false)

	arg_1_0._conditionItemTab = arg_1_0:getUserDataTb_()
end

function var_0_0._refreshTarget(arg_2_0)
	local var_2_0 = DungeonConfig.instance:getEpisodeCO(arg_2_0._episodeId)
	local var_2_1 = DungeonConfig.instance:getChapterCO(var_2_0.chapterId)

	gohelper.setActive(arg_2_0._gotargetlist, true)

	local var_2_2 = var_2_1.type == DungeonEnum.ChapterType.Hard

	gohelper.setActive(arg_2_0._gohardEffect, var_2_2)
	gohelper.setActive(arg_2_0._gobalanceEffect, HeroGroupBalanceHelper.getIsBalanceMode())

	arg_2_0._isHardMode = var_2_2

	local var_2_3 = {}
	local var_2_4 = DungeonConfig.instance:getEpisodeWinConditionTextList(arg_2_0._episodeId)
	local var_2_5 = DungeonConfig.instance:getEpisodeAdvancedConditionText(arg_2_0._episodeId)
	local var_2_6 = DungeonConfig.instance:getEpisodeAdvancedCondition2Text(arg_2_0._episodeId)

	tabletool.addValues(var_2_3, var_2_4)
	table.insert(var_2_3, var_2_5)
	table.insert(var_2_3, var_2_6)

	local var_2_7 = var_2_4 and #var_2_4 or 0

	for iter_2_0, iter_2_1 in ipairs(var_2_3) do
		if not string.nilorempty(iter_2_1) then
			local var_2_8 = arg_2_0:_getOrCreateConditionItem(iter_2_0)

			var_2_8.txtcondition.text = iter_2_1

			local var_2_9 = iter_2_0 <= var_2_7 and DungeonEnum.StarType.Normal or DungeonEnum.StarType.Advanced

			VersionActivity2_9DungeonHelper.setEpisodeTargetProgress(arg_2_0._episodeId, var_2_9, var_2_8.txtprogress)
			VersionActivity2_9DungeonHelper.setEpisodeProgressIcon(arg_2_0._episodeId, var_2_8.imageprogress)
			gohelper.setActive(var_2_8.go, true)
		end
	end

	local var_2_10 = var_2_3 and #var_2_3 or 0
	local var_2_11 = arg_2_0._conditionItemTab and #arg_2_0._conditionItemTab or 0

	for iter_2_2 = var_2_10 + 1, var_2_11 do
		gohelper.setActive(arg_2_0._conditionItemTab[iter_2_2].go, false)
	end

	gohelper.setActive(arg_2_0._gonormalcondition, false)

	local var_2_12 = var_2_10 <= 1

	gohelper.setActive(arg_2_0._goplace, var_2_12)
end

function var_0_0._getOrCreateConditionItem(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._conditionItemTab[arg_3_1]

	if not var_3_0 then
		var_3_0 = arg_3_0:getUserDataTb_()
		var_3_0.go = gohelper.cloneInPlace(arg_3_0._gonormalcondition, "condition_" .. arg_3_1)
		var_3_0.txtcondition = gohelper.findChildText(var_3_0.go, "#txt_normalcondition")
		var_3_0.txtprogress = gohelper.findChildText(var_3_0.go, "star/condition")
		var_3_0.imageprogress = gohelper.findChildImage(var_3_0.go, "star")
		arg_3_0._conditionItemTab[arg_3_1] = var_3_0
	end

	return var_3_0
end

return var_0_0
