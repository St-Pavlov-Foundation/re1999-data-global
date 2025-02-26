module("modules.logic.seasonver.act123.view1_9.Season123_1_9PickHeroEntryView", package.seeall)

slot0 = class("Season123_1_9PickHeroEntryView", BaseView)

function slot0.onInitView(slot0)
	slot0._goitem = gohelper.findChild(slot0.viewGO, "Right/#go_list/#go_item")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_start/#btn_start")
	slot0._btndisstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#go_start/#btn_disstart")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnmaincard1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_supercard1/#btn_supercardclick")
	slot0._btnmaincard2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_supercard2/#btn_supercardclick")
	slot0._btndetails = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_details")
	slot0._gorecomment = gohelper.findChild(slot0.viewGO, "Right/#go_recommend")
	slot0._gorecommentnone = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/txt_none")
	slot0._gorecommentexist = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/Career")
	slot0._gocareeritem = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/Career/career")
	slot0._gorecommendLine = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/Line")
	slot0._gorecommendTagContent = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/Tag")
	slot0._gorecommendTagItem = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/Tag/go_tagItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btndisstart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnmaincard1:AddClickListener(slot0._btnmaincardOnClick, slot0, 1)
	slot0._btnmaincard2:AddClickListener(slot0._btnmaincardOnClick, slot0, 2)
	slot0._btndetails:AddClickListener(slot0._btndetailsOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnstart:RemoveClickListener()
	slot0._btndisstart:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnmaincard1:RemoveClickListener()
	slot0._btnmaincard2:RemoveClickListener()
	slot0._btndetails:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._heroItems = {}
	slot0._careerItems = {}
end

function slot0.onDestroyView(slot0)
	if slot0._heroItems then
		for slot4, slot5 in pairs(slot0._heroItems) do
			slot5.component:dispose()
		end

		slot0._heroItems = nil
	end

	Season123PickHeroEntryController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.PickEntryRefresh, slot0.refreshUI, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.EnterStageSuccess, slot0.handleEnterStageSuccess, slot0)
	Season123PickHeroEntryController.instance:onOpenView(slot0.viewParam.actId, slot0.viewParam.stage)

	if not ActivityModel.instance:getActMO(slot0.viewParam.actId) or not slot1:isOpen() or slot1:isExpired() then
		return
	end

	slot0:refreshUI()
	gohelper.setActive(slot0._goitem, false)
end

function slot0.onClose(slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshItems()
	slot0:refreshButton()
	slot0:refreshRecommendCareer()
	slot0:refreshRecommendTag()
	slot0:refreshRecommendUI()
end

function slot0.refreshButton(slot0)
	slot2 = Season123PickHeroEntryModel.instance:getLimitCount()
	slot3 = Season123PickHeroEntryModel.instance:getSelectCount() > 0

	gohelper.setActive(slot0._btndisstart, not slot3)
	gohelper.setActive(slot0._btnstart, slot3)
end

function slot0.refreshItems(slot0)
	slot1 = Season123PickHeroEntryModel.instance:getCutHeroList()

	for slot5 = 1, Activity123Enum.PickHeroCount do
		slot0:getOrCreateItem(slot5).component:refreshUI()
		slot6.component:cutHeroAnim(slot1 and LuaUtil.tableContains(slot1, slot5))
	end

	Season123PickHeroEntryModel.instance:refeshLastHeroList()
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0._heroItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goitem, "item_" .. tostring(slot1))
		slot2.component = Season123_1_9PickHeroEntryItem.New()

		slot2.component:init(slot2.go)
		slot2.component:initData(slot1)
		gohelper.setActive(slot2.go, true)

		slot0._heroItems[slot1] = slot2
	end

	return slot2
end

function slot0.refreshRecommendCareer(slot0)
	if Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage) and #slot1 > 0 then
		gohelper.setActive(slot0._gorecommentexist, true)

		for slot5 = 1, #slot1 do
			slot6 = slot0:getOrCreateCareer(slot5)

			gohelper.setActive(slot6.go, true)
			UISpriteSetMgr.instance:setHeroGroupSprite(slot6.imageicon, "career_" .. tostring(slot1[slot5]))
		end

		for slot5 = #slot1 + 1, #slot1 do
			if slot0._careerItems[slot5] then
				gohelper.setActive(slot6.go, false)
			end
		end
	else
		gohelper.setActive(slot0._gorecommentexist, false)
	end
end

function slot0.getOrCreateCareer(slot0, slot1)
	if not slot0._careerItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._gocareeritem, "career_" .. tostring(slot1))
		slot2.imageicon = gohelper.findChildImage(slot2.go, "")
		slot0._careerItems[slot1] = slot2
	end

	return slot2
end

function slot0.refreshRecommendTag(slot0)
	if Season123Config.instance:getRecommendTagCoList(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage) and #slot1 > 0 then
		gohelper.setActive(slot0._gorecommendTagContent, true)
		gohelper.CreateObjList(slot0, slot0.tagItemShow, slot1, slot0._gorecommendTagContent, slot0._gorecommendTagItem)
	else
		gohelper.setActive(slot0._gorecommendTagContent, false)
	end
end

function slot0.tagItemShow(slot0, slot1, slot2, slot3)
	gohelper.findChildText(slot1, "txt_tag").text = slot2.desc
end

function slot0.refreshRecommendUI(slot0)
	slot2 = Season123Config.instance:getRecommendTagCoList(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)
	slot3 = Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage) and #slot1 > 0
	slot4 = slot2 and #slot2 > 0

	gohelper.setActive(slot0._gorecommendLine, slot3 and slot4)
	gohelper.setActive(slot0._gorecommentnone, not slot3 and not slot4)
end

function slot0._btnstartOnClick(slot0)
	Season123PickHeroEntryController.instance:sendEnterStage()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btndetailsOnClick(slot0)
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, 1)
end

function slot0.handleEnterStageSuccess(slot0)
	slot0:closeThis()

	if slot0.viewParam.finishCall then
		slot1(slot0.viewParam.finishCallObj)
	end
end

return slot0
