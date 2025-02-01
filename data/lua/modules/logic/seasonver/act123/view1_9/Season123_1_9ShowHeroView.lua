module("modules.logic.seasonver.act123.view1_9.Season123_1_9ShowHeroView", package.seeall)

slot0 = class("Season123_1_9ShowHeroView", BaseView)

function slot0.onInitView(slot0)
	slot0._goitem = gohelper.findChild(slot0.viewGO, "Right/#go_list/#go_item")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_reset")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnmaincard1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_supercard1/#btn_supercardclick")
	slot0._btnmaincard2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_supercard2/#btn_supercardclick")
	slot0._btndetails = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_details")
	slot0._gorecomment = gohelper.findChild(slot0.viewGO, "Right/#go_recommend")
	slot0._gorecommentnone = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/txt_recommend/txt_none")
	slot0._gorecommentexist = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/txt_recommend/recommends")
	slot0._gocareeritem = gohelper.findChild(slot0.viewGO, "Right/#go_recommend/txt_recommend/recommends/career")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btndetails:AddClickListener(slot0._btndetailsOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnmaincard1:AddClickListener(slot0._btnmaincardOnClick, slot0, 1)
	slot0._btnmaincard2:AddClickListener(slot0._btnmaincardOnClick, slot0, 2)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btndetails:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnmaincard1:RemoveClickListener()
	slot0._btnmaincard2:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._heroItems = {}
end

function slot0.onDestroyView(slot0)
	if slot0._heroItems then
		for slot4, slot5 in pairs(slot0._heroItems) do
			slot5.component:dispose()
		end

		slot0._heroItems = nil
	end

	Season123ShowHeroController.instance:onCloseView()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.OnResetSucc, slot0.closeThis, slot0)
	Season123ShowHeroController.instance:onOpenView(slot0.viewParam.actId, slot0.viewParam.stage, slot0.viewParam.layer)

	if not ActivityModel.instance:getActMO(slot0.viewParam.actId) or not slot1:isOpen() or slot1:isExpired() then
		return
	end

	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0.refreshUI, slot0)
	slot0:refreshUI()
end

function slot0.onClose(slot0)
	if slot0._heroItems then
		for slot4, slot5 in pairs(slot0._heroItems) do
			slot5.component:onClose()
		end
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshItems()
	gohelper.setActive(slot0._gorecommentnone, false)
	gohelper.setActive(slot0._gorecommentexist, false)
end

function slot0.refreshItems(slot0)
	for slot4 = 1, Activity123Enum.PickHeroCount do
		slot0:getOrCreateItem(slot4).component:refreshUI()
	end
end

function slot0.getOrCreateItem(slot0, slot1)
	if not slot0._heroItems[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.cloneInPlace(slot0._goitem, "item_" .. tostring(slot1))
		slot2.component = Season123_1_9ShowHeroItem.New()

		slot2.component:init(slot2.go)
		slot2.component:initData(slot1)
		gohelper.setActive(slot2.go, true)

		slot0._heroItems[slot1] = slot2
	end

	return slot2
end

function slot0._btndetailsOnClick(slot0)
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123ShowHeroModel.instance.activityId, Season123ShowHeroModel.instance.stage, Season123ShowHeroModel.instance.layer)
end

function slot0._btnresetOnClick(slot0)
	Season123ShowHeroController.instance:openReset()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.handleEnterStageSuccess(slot0)
	slot0:closeThis()

	if slot0.viewParam.finishCall then
		slot1(slot0.viewParam.finishCallObj)
	end
end

return slot0
