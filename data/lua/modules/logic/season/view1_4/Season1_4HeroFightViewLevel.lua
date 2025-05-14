module("modules.logic.season.view1_4.Season1_4HeroFightViewLevel", package.seeall)

local var_0_0 = class("Season1_4HeroFightViewLevel", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goTarget = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain")
	arg_1_0._gonormalcondition = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition")
	arg_1_0._txtnormalcondition = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#txt_normalcondition")
	arg_1_0._gonormalfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalfinish")
	arg_1_0._gonormalunfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalunfinish")
	arg_1_0._goplatinumcondition = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition")
	arg_1_0._txtplatinumcondition = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#txt_platinumcondition")
	arg_1_0._goplatinumfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumfinish")
	arg_1_0._goplatinumunfinish = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumunfinish")
	arg_1_0._goplatinumcondition2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2")
	arg_1_0._txtplatinumcondition2 = gohelper.findChildText(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#txt_platinumcondition")
	arg_1_0._goplatinumfinish2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumfinish")
	arg_1_0._goplatinumunfinish2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumunfinish")
	arg_1_0._gotargetlist = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList")
	arg_1_0._goplace = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/targetList/#go_place")
	arg_1_0._gostar3 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star3")
	arg_1_0._gostar2 = gohelper.findChild(arg_1_0.viewGO, "#go_container/#scroll_info/infocontain/targetcontain/text/starcontainer/#go_star2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._monsterGroupItemList = {}
end

function var_0_0._refreshUI(arg_5_0)
	arg_5_0._episodeId = HeroGroupModel.instance.episodeId
	arg_5_0._battleId = HeroGroupModel.instance.battleId

	arg_5_0:_refreshTarget()
end

function var_0_0._refreshTarget(arg_6_0)
	if DungeonConfig.instance:getEpisodeCO(arg_6_0._episodeId).type ~= DungeonEnum.EpisodeType.Season then
		gohelper.setActive(arg_6_0._goTarget, false)

		return
	end

	gohelper.setActive(arg_6_0._goTarget, true)

	local var_6_0 = arg_6_0._episodeId
	local var_6_1 = var_6_0 and DungeonModel.instance:getEpisodeInfo(var_6_0)
	local var_6_2 = var_6_0 and DungeonModel.instance:hasPassLevelAndStory(var_6_0)
	local var_6_3 = var_6_0 and DungeonConfig.instance:getEpisodeAdvancedConditionText(var_6_0)
	local var_6_4 = true

	gohelper.setActive(arg_6_0._gonormalcondition, true)

	arg_6_0._txtnormalcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(var_6_0)

	local var_6_5 = var_6_1 and var_6_1.star >= DungeonEnum.StarType.Normal and var_6_2
	local var_6_6 = var_6_1 and var_6_1.star >= DungeonEnum.StarType.Advanced and var_6_2
	local var_6_7 = false

	gohelper.setActive(arg_6_0._gonormalfinish, var_6_5)
	gohelper.setActive(arg_6_0._gonormalunfinish, not var_6_5)
	ZProj.UGUIHelper.SetColorAlpha(arg_6_0._txtnormalcondition, var_6_5 and 1 or 0.63)
	gohelper.setActive(arg_6_0._goplatinumcondition, not string.nilorempty(var_6_3))

	if not string.nilorempty(var_6_3) then
		arg_6_0._txtplatinumcondition.text = var_6_3

		gohelper.setActive(arg_6_0._goplatinumfinish, var_6_6)
		gohelper.setActive(arg_6_0._goplatinumunfinish, not var_6_6)
		ZProj.UGUIHelper.SetColorAlpha(arg_6_0._txtplatinumcondition, var_6_6 and 1 or 0.63)

		var_6_4 = false
	end

	gohelper.setActive(arg_6_0._goplace, var_6_4)
	arg_6_0:_showStar(var_6_1, var_6_3, var_6_5, var_6_6, var_6_7)
end

function var_0_0._initStars(arg_7_0)
	if arg_7_0._starList then
		return
	end

	local var_7_0 = 2

	if DungeonConfig.instance:getEpisodeCO(arg_7_0._episodeId).type == DungeonEnum.EpisodeType.WeekWalk then
		var_7_0 = WeekWalkModel.instance:getCurMapInfo():getStarNumConfig()
	end

	gohelper.setActive(arg_7_0._gostar2, var_7_0 == 2)
	gohelper.setActive(arg_7_0._gostar3, var_7_0 == 3)

	local var_7_1 = var_7_0 == 2 and arg_7_0._gostar2 or arg_7_0._gostar3

	arg_7_0._starList = arg_7_0:getUserDataTb_()

	for iter_7_0 = 1, var_7_0 do
		local var_7_2 = gohelper.findChildImage(var_7_1, "star" .. iter_7_0)

		table.insert(arg_7_0._starList, var_7_2)
	end
end

function var_0_0._showStar(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_0:_initStars()
	gohelper.setActive(arg_8_0._starList[1].gameObject, true)
	arg_8_0:_setStar(arg_8_0._starList[1], arg_8_3)

	if string.nilorempty(arg_8_2) then
		gohelper.setActive(arg_8_0._starList[2].gameObject, false)
	else
		gohelper.setActive(arg_8_0._starList[2].gameObject, true)
		arg_8_0:_setStar(arg_8_0._starList[2], arg_8_4)

		if arg_8_0._starList[3] then
			gohelper.setActive(arg_8_0._starList[3].gameObject, true)
			arg_8_0:_setStar(arg_8_0._starList[3], arg_8_5)
		end
	end
end

function var_0_0._setStar(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = "zhuxianditu_pt_xingxing_001"
	local var_9_1 = arg_9_2 and "#F77040" or "#87898C"

	UISpriteSetMgr.instance:setCommonSprite(arg_9_1, var_9_0, true)
	SLFramework.UGUI.GuiHelper.SetColor(arg_9_1, var_9_1)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_refreshUI()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
