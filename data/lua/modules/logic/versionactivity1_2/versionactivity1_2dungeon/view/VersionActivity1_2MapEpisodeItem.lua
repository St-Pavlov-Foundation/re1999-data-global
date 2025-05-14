module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2MapEpisodeItem", package.seeall)

local var_0_0 = class("VersionActivity1_2MapEpisodeItem", VersionActivity1_2MapEpisodeBaseItem)

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)
end

function var_0_0.getDungeonMapLevelView(arg_2_0)
	return ViewName.VersionActivity1_2DungeonMapLevelView
end

function var_0_0._editableInitView(arg_3_0)
	var_0_0.super._editableInitView(arg_3_0)
end

function var_0_0.refreshFlag(arg_4_0)
	local var_4_0 = DungeonModel.instance:hasPassLevelAndStory(arg_4_0._config.id)

	gohelper.setActive(arg_4_0._goflag, not var_4_0)
end

function var_0_0._onStarItemShow(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_2
	local var_5_1 = DungeonConfig.instance:getEpisodeAdvancedConditionText(var_5_0)
	local var_5_2 = DungeonModel.instance:getEpisodeInfo(var_5_0)
	local var_5_3 = gohelper.findChildImage(arg_5_1, "#image_star1")
	local var_5_4 = gohelper.findChildImage(arg_5_1, "#image_star2")
	local var_5_5 = arg_5_0:isDungeonHardModel()
	local var_5_6

	if var_5_5 then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(var_5_3, "juqing_xing1_kn")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(var_5_4, "juqing_xing2_kn")

		var_5_6 = "#e43938"
	else
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(var_5_3, "juqing_xing1")
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(var_5_4, "juqing_xing2")

		if arg_5_3 == 1 then
			var_5_6 = "#e4b472"
		elseif arg_5_3 == 2 then
			var_5_6 = "#e7853d"
		elseif arg_5_3 == 3 then
			var_5_6 = "#ef3939"
		end
	end

	local var_5_7 = "#949494"
	local var_5_8 = DungeonModel.instance:hasPassLevelAndStory(var_5_0)

	SLFramework.UGUI.GuiHelper.SetColor(var_5_3, var_5_8 and var_5_6 or var_5_7)

	if string.nilorempty(var_5_1) then
		gohelper.setActive(var_5_4.gameObject, false)
	else
		gohelper.setActive(var_5_4.gameObject, true)
		SLFramework.UGUI.GuiHelper.SetColor(var_5_4, var_5_8 and var_5_2 and var_5_2.star >= DungeonEnum.StarType.Advanced and var_5_6 or var_5_7)
	end
end

function var_0_0.setImage(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return
end

function var_0_0.getMapCfg(arg_7_0)
	return VersionActivity1_2DungeonConfig.instance:get1_2EpisodeMapConfig(arg_7_0._config.id)
end

function var_0_0.playAnimation(arg_8_0, arg_8_1)
	arg_8_0.animator:Play(arg_8_1, 0, 0)
end

function var_0_0.getEpisodeId(arg_9_0)
	return arg_9_0._config and arg_9_0._config.id
end

function var_0_0.createStarItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getUserDataTb_()

	var_10_0.goStar = arg_10_1
	var_10_0.imgStar1 = gohelper.findChildImage(arg_10_1, "#image_star1")
	var_10_0.imgStar2 = gohelper.findChildImage(arg_10_1, "#image_star2")

	return var_10_0
end

function var_0_0.onClose(arg_11_0)
	var_0_0.super.onClose(arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	var_0_0.super.onDestroyView(arg_12_0)
	arg_12_0.goClick:RemoveClickListener()
end

return var_0_0
