module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_HeroGroupBuildView", package.seeall)

slot0 = class("VersionActivity_1_2_HeroGroupBuildView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._facilitycontain = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain")
	slot0._txtplacedcount = gohelper.findChildText(slot0.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain/info/#txt_placedcount")
	slot0._btnfacilitydetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#scroll_info/infocontain/facilitycontain/info/#txt_placedcount/#btn_facilitydetail", AudioEnum.TeachNote.play_ui_activity_switch)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfacilitydetail:AddClickListener(slot0._onBtnDetail, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfacilitydetail:RemoveClickListener()
end

function slot0._onBtnDetail(slot0)
	if #slot0._gainList == 0 then
		GameFacade.showToast(ToastEnum.Act114BuildingIsEmpty)
	else
		ViewMgr.instance:openView(ViewName.VersionActivity_1_2_FacilityTipsView)
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onRefreshViewParam(slot0)
end

function slot0.onOpen(slot0)
	slot1 = DungeonModel.instance:hasPassLevelAndStory(1210105)

	if FightModel.instance:getFightParam() and DungeonConfig.instance:getEpisodeCO(slot2.episodeId) and slot3.chapterId == 12102 then
		slot1 = false
	end

	gohelper.setActive(slot0._facilitycontain, slot1)

	slot0._gainList = VersionActivity1_2DungeonModel.instance:getBuildingGainList()
	slot0._txtplacedcount.text = formatLuaLang("versionactivity_1_2_herogroupview_placedcount", #slot0._gainList)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
