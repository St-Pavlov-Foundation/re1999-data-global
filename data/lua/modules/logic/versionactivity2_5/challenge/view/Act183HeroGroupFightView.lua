module("modules.logic.versionactivity2_5.challenge.view.Act183HeroGroupFightView", package.seeall)

slot0 = class("Act183HeroGroupFightView", HeroGroupFightView)

function slot0.onInitView(slot0)
	uv0.super.onInitView(slot0)

	slot0._gochallenge = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege")
	slot0._gobaserulecontainer = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt")
	slot0._gobaserules = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist")
	slot0._gobaseruleItem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/basictxt/Iconlist/#go_item")
	slot0._goescapecontainer = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt")
	slot0._goescaperules = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist")
	slot0._goescaperuleitem = gohelper.findChild(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/escapetxt/Iconlist/#go_item")
	slot0._btnchallengetip = gohelper.findChildButton(slot0.viewGO, "#go_container/#scroll_info/infocontain/#go_challege/title/#btn_info")
	slot0._gochallengetips = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips")
	slot0._btnclosechallengetips = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#go_challengetips/#btn_closechallengetips")
	slot0._gochallengetipscontent = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content")
	slot0._gochallengetiptitle = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/title")
	slot0._gochallengetipitem = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem")
	slot0._gochallengedescitem = gohelper.findChild(slot0.viewGO, "#go_container/#go_challengetips/#scroll_challengetips/Viewport/Content/#go_tipitem/#txt_desc")
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
end

function slot0._btnclothOnClock(slot0)
	if Act183Helper.isOnlyCanUseLimitPlayerCloth(slot0._episodeId) then
		GameFacade.showToast(ToastEnum.Act183OnlyOnePlayerCloth)

		return
	end

	uv0.super._btnclothOnClock(slot0)
end

function slot0._editableInitView(slot0)
	slot0._activityId = Act183Model.instance:getActivityId()
	slot0._episodeId = HeroGroupModel.instance.episodeId

	slot0:checkAct183HeroList()
	uv0.super._editableInitView(slot0)
end

function slot0._checkEquipClothSkill(slot0)
	if slot0:setLimitPlayerCloth() then
		return
	end

	uv0.super._checkEquipClothSkill(slot0)
end

function slot0.setLimitPlayerCloth(slot0)
	if Act183Helper.isOnlyCanUseLimitPlayerCloth(slot0._episodeId) then
		HeroGroupModel.instance:replaceCloth(PlayerClothModel.instance:hasCloth(Act183Helper.getLimitUsePlayerCloth()) and slot2 or 0)
		HeroGroupModel.instance:saveCurGroupData()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	end

	return slot1
end

function slot0._refreshBtns(slot0, slot1)
	uv0.super._refreshBtns(slot0, slot1)
	gohelper.setActive(slot0._dropherogroup, false)
	TaskDispatcher.cancelTask(slot0._checkDropArrow, slot0)
end

function slot0.checkAct183HeroList(slot0)
	slot3 = lua_battle.configDict[DungeonConfig.instance:getEpisodeCO(slot0._episodeId).battleId] and slot2.roleNum or ModuleEnum.MaxHeroCountInGroup
	slot5 = Act183Config.instance:getEpisodeCo(slot0._episodeId) and slot4.groupId
	slot6 = Act183Model.instance:getGroupEpisodeMo(slot5)
	slot7 = HeroGroupModel.instance:getCurGroupMO()

	slot7:checkAct183HeroList(slot3, slot6)
	HeroSingleGroupModel.instance:setMaxHeroCount(slot3)
	HeroSingleGroupModel.instance:setSingleGroup(slot7, true)

	slot0._groupEpisodeMo = slot6
	slot0._episodeMo = Act183Model.instance:getEpisodeMo(slot5, slot0._episodeId)
end

function slot0.openHeroGroupEditView(slot0)
	slot0._param = slot0._param or {}
	slot0._param.activityId = Act183Model.instance:getActivityId()
	slot0._param.episodeId = HeroGroupModel.instance.episodeId

	ViewMgr.instance:openView(ViewName.Act183HeroGroupEditView, slot0._param)
end

function slot0._refreshReplay(slot0)
	gohelper.setActive(slot0._goReplayBtn, false)
	gohelper.setActive(slot0._gomemorytimes, false)
end

function slot0.onOpen(slot0)
	uv0.super.onOpen(slot0)

	slot1 = Act183Model.instance:getUnlockSupportHeros()

	if Act183Helper.isEpisodeCanUseSupportHero(slot0._episodeId) and slot1 then
		for slot6, slot7 in ipairs(slot1) do
			HeroGroupTrialModel.instance:addAtLast(slot7)
		end
	end
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)
	HeroSingleGroupModel.instance:setMaxHeroCount()

	HeroGroupTrialModel.instance.curBattleId = nil
end

return slot0
