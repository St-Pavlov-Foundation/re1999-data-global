module("modules.logic.versionactivity2_5.challenge.view.Act183ReportListItem", package.seeall)

slot0 = class("Act183ReportListItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gotime = gohelper.findChild(slot0.viewGO, "#go_time")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "#go_time/#txt_time")
	slot0._gonormal = gohelper.findChild(slot0.viewGO, "#go_normal")
	slot0._gohard = gohelper.findChild(slot0.viewGO, "#go_hard")
	slot0._goepisodes = gohelper.findChild(slot0.viewGO, "#go_episodes")
	slot0._goepisodeitem = gohelper.findChild(slot0.viewGO, "#go_episodes/#go_episodeitem")
	slot0._goherogroup = gohelper.findChild(slot0.viewGO, "#go_herogroup")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item1")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item2")
	slot0._goitem3 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item3")
	slot0._goitem4 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item4")
	slot0._goitem5 = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_item5")
	slot0._goheroitem = gohelper.findChild(slot0.viewGO, "#go_herogroup/#go_heroitem")
	slot0._imagebossicon = gohelper.findChildImage(slot0.viewGO, "#go_boss/#image_bossicon")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
end

function slot0._btndetailOnClick(slot0)
	Act183Controller.instance:openAct183SettlementView({
		activityId = Act183ReportListModel.instance:getActivityId(),
		groupRecordMo = slot0._mo
	})
end

function slot0._editableInitView(slot0)
	slot0._heroItemTab = slot0:getUserDataTb_()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._txttime.text = TimeUtil.timestampToString(slot0._mo:getFinishedTime() / 1000)
	slot0._type = slot0._mo:getGroupType()

	gohelper.setActive(slot0._gonormal, slot0._type == Act183Enum.GroupType.NormalMain)
	gohelper.setActive(slot0._gohard, slot0._type == Act183Enum.GroupType.HardMain)
	gohelper.CreateObjList(slot0, slot0.refreshSingleSubEpisodeItem, slot0._mo:getEpusideListByTypeAndPassOrder(Act183Enum.EpisodeType.Sub) or {}, slot0._goepisodes, slot0._goepisodeitem)
	Act183Helper.setEpisodeReportIcon(slot0._mo:getBossEpisode() and slot3:getEpisodeId(), slot0._imagebossicon)
	slot0:refreshBossEpisodeHeros()
end

function slot0.refreshSingleSubEpisodeItem(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setChallengeSprite(gohelper.findChildImage(slot1, "image_index"), "v2a5_challenge_result_level_" .. slot2:getPassOrder())
	Act183Helper.setEpisodeReportIcon(slot2:getEpisodeId(), gohelper.findChildImage(slot1, "image_icon"))
end

function slot0.refreshBossEpisodeHeros(slot0)
	if not (slot0._mo:getEpisodeListByType(Act183Enum.EpisodeType.Boss) and slot1[1]) then
		return
	end

	slot3 = slot2:getHeroMos()

	for slot7 = 1, Act183Enum.BossEpisodeMaxHeroNum do
		slot8 = slot0:_getOrCreateHeroItem(slot7)
		slot10 = (slot3 and slot3[slot7]) ~= nil

		gohelper.setActive(slot8.viewGO, true)
		gohelper.setActive(slot8.gohas, slot10)
		gohelper.setActive(slot8.goempty, not slot10)

		if slot10 then
			slot8.simageheroicon:LoadImage(slot9:getHeroIconUrl())
		end
	end
end

function slot0._getOrCreateHeroItem(slot0, slot1)
	if not slot0._heroItemTab[slot1] then
		slot2 = slot0:getUserDataTb_()

		if gohelper.isNil(slot0["_goitem" .. slot1]) then
			logError("缺少挂点 : " .. slot1)
		end

		slot2.viewGO = gohelper.clone(slot0._goheroitem, slot3, "hero")
		slot2.gohas = gohelper.findChild(slot2.viewGO, "go_has")
		slot2.goempty = gohelper.findChild(slot2.viewGO, "go_empty")
		slot2.simageheroicon = gohelper.findChildSingleImage(slot2.viewGO, "go_has/bg/simage_heroicon")
		slot0._heroItemTab[slot1] = slot2
	end

	return slot2
end

function slot0.releaseAllHeroItems(slot0)
	if slot0._heroItemTab then
		for slot4, slot5 in pairs(slot0._heroItemTab) do
			slot5.simageheroicon:UnLoadImage()
		end
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	slot0:releaseAllHeroItems()
end

return slot0
