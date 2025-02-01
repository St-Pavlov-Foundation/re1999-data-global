module("modules.logic.season.view1_2.Season1_2HeroFightViewLevel", package.seeall)

slot0 = class("Season1_2HeroFightViewLevel", BaseView)

function slot0.onInitView(slot0)
	slot0._goTarget = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain")
	slot0._gonormalcondition = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_normalcondition")
	slot0._txtnormalcondition = gohelper.findChildText(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_normalcondition/#txt_normalcondition")
	slot0._gonormalfinish = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalfinish")
	slot0._gonormalunfinish = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_normalcondition/#go_normalunfinish")
	slot0._goplatinumcondition = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_platinumcondition")
	slot0._txtplatinumcondition = gohelper.findChildText(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_platinumcondition/#txt_platinumcondition")
	slot0._goplatinumfinish = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumfinish")
	slot0._goplatinumunfinish = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_platinumcondition/#go_platinumunfinish")
	slot0._goplatinumcondition2 = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_platinumcondition2")
	slot0._txtplatinumcondition2 = gohelper.findChildText(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_platinumcondition2/#txt_platinumcondition")
	slot0._goplatinumfinish2 = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumfinish")
	slot0._goplatinumunfinish2 = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_platinumcondition2/#go_platinumunfinish")
	slot0._gotargetlist = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList")
	slot0._goplace = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/targetList/#go_place")
	slot0._gostar3 = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/text/starcontainer/#go_star3")
	slot0._gostar2 = gohelper.findChild(slot0.viewGO, "#go_container/infocontain/targetcontain/text/starcontainer/#go_star2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._monsterGroupItemList = {}
end

function slot0._refreshUI(slot0)
	slot0._episodeId = HeroGroupModel.instance.episodeId
	slot0._battleId = HeroGroupModel.instance.battleId

	slot0:_refreshTarget()
end

function slot0._refreshTarget(slot0)
	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId).type ~= DungeonEnum.EpisodeType.Season then
		gohelper.setActive(slot0._goTarget, false)

		return
	end

	gohelper.setActive(slot0._goTarget, true)

	slot4 = slot0._episodeId and DungeonModel.instance:getEpisodeInfo(slot3)
	slot5 = slot3 and DungeonModel.instance:hasPassLevelAndStory(slot3)
	slot6 = slot3 and DungeonConfig.instance:getEpisodeAdvancedConditionText(slot3)
	slot7 = true

	gohelper.setActive(slot0._gonormalcondition, true)

	slot0._txtnormalcondition.text = DungeonConfig.instance:getFirstEpisodeWinConditionText(slot3)
	slot8 = slot4 and DungeonEnum.StarType.Normal <= slot4.star and slot5
	slot9 = slot4 and DungeonEnum.StarType.Advanced <= slot4.star and slot5
	slot10 = false

	gohelper.setActive(slot0._gonormalfinish, slot8)
	gohelper.setActive(slot0._gonormalunfinish, not slot8)
	ZProj.UGUIHelper.SetColorAlpha(slot0._txtnormalcondition, slot8 and 1 or 0.63)
	gohelper.setActive(slot0._goplatinumcondition, not string.nilorempty(slot6))

	if not string.nilorempty(slot6) then
		slot0._txtplatinumcondition.text = slot6

		gohelper.setActive(slot0._goplatinumfinish, slot9)
		gohelper.setActive(slot0._goplatinumunfinish, not slot9)
		ZProj.UGUIHelper.SetColorAlpha(slot0._txtplatinumcondition, slot9 and 1 or 0.63)

		slot7 = false
	end

	gohelper.setActive(slot0._goplace, slot7)
	slot0:_showStar(slot4, slot6, slot8, slot9, slot10)
end

function slot0._initStars(slot0)
	if slot0._starList then
		return
	end

	slot1 = 2

	if DungeonConfig.instance:getEpisodeCO(slot0._episodeId).type == DungeonEnum.EpisodeType.WeekWalk then
		slot1 = WeekWalkModel.instance:getCurMapInfo():getStarNumConfig()
	end

	gohelper.setActive(slot0._gostar2, slot1 == 2)
	gohelper.setActive(slot0._gostar3, slot1 == 3)

	slot0._starList = slot0:getUserDataTb_()

	for slot7 = 1, slot1 do
		table.insert(slot0._starList, gohelper.findChildImage(slot1 == 2 and slot0._gostar2 or slot0._gostar3, "star" .. slot7))
	end
end

function slot0._showStar(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:_initStars()
	gohelper.setActive(slot0._starList[1].gameObject, true)
	slot0:_setStar(slot0._starList[1], slot3)

	if string.nilorempty(slot2) then
		gohelper.setActive(slot0._starList[2].gameObject, false)
	else
		gohelper.setActive(slot0._starList[2].gameObject, true)
		slot0:_setStar(slot0._starList[2], slot4)

		if slot0._starList[3] then
			gohelper.setActive(slot0._starList[3].gameObject, true)
			slot0:_setStar(slot0._starList[3], slot5)
		end
	end
end

function slot0._setStar(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setCommonSprite(slot1, "zhuxianditu_pt_xingxing_001", true)
	SLFramework.UGUI.GuiHelper.SetColor(slot1, slot2 and "#F77040" or "#87898C")
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
