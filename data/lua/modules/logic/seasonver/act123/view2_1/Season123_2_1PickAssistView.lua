module("modules.logic.seasonver.act123.view2_1.Season123_2_1PickAssistView", package.seeall)

slot0 = class("Season123_2_1PickAssistView", BaseView)

function slot0.onInitView(slot0)
	slot0._gofilter = gohelper.findChild(slot0.viewGO, "#go_filter")
	slot0._goattrItem = gohelper.findChild(slot0.viewGO, "#go_filter/#go_attrItem")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_empty")
	slot0._gorecommendAttr = gohelper.findChild(slot0.viewGO, "#go_recommendAttr")
	slot0._txtrecommendAttrDesc = gohelper.findChildText(slot0.viewGO, "#go_recommendAttr/txt_recommend")
	slot0._goattrlist = gohelper.findChild(slot0.viewGO, "#go_recommendAttr/txt_recommend/#go_attrlist")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_recommendAttr/txt_recommend/#go_attrlist/#go_recommendAttrItem")
	slot0._btnrefresh = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_refresh")
	slot0._simageprogress = gohelper.findChildImage(slot0.viewGO, "bottom/#btn_refresh/#simage_progress")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "bottom/#btn_detail")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_detail")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_confirm")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrefresh:AddClickListener(slot0._btnrefreshOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._onHeroDetailClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.BeforeRefreshAssistList, slot0.onBeforeRefreshAssistList, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.SetCareer, slot0.refreshIsEmpty, slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.RefreshSelectAssistHero, slot0.refreshBtnDetail, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrefresh:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0:addEventCb(Season123Controller.instance, Season123Event.BeforeRefreshAssistList, slot0.onBeforeRefreshAssistList, slot0)
	slot0:removeEventCb(Season123Controller.instance, Season123Event.SetCareer, slot0.refreshIsEmpty, slot0)
	slot0:removeEventCb(Season123Controller.instance, Season123Event.RefreshSelectAssistHero, slot0.refreshBtnDetail, slot0)
end

function slot0.onBeforeRefreshAssistList(slot0)
	if slot0.scrollView then
		slot0.scrollView._firstUpdate = true

		if not slot0.hasChangedItemDelayTime then
			slot0.scrollView:changeDelayTime(-slot0.viewContainer.viewOpenAnimTime)

			slot0.hasChangedItemDelayTime = true
		end
	end
end

function slot0._btnrefreshOnClick(slot0)
	Season123PickAssistController.instance:manualRefreshList()
end

function slot0._onHeroDetailClick(slot0)
	if Season123PickAssistListModel.instance:getSelectedMO() then
		CharacterController.instance:openCharacterView(slot1.heroMO)
	end
end

function slot0._btnconfirmOnClick(slot0)
	Season123PickAssistController.instance:pickOver()
	slot0:closeThis()
end

function slot0._btnCareerFilterOnClick(slot0, slot1)
	if Season123PickAssistController.instance:setCareer(slot1) then
		slot0:refreshCareerFilterItems()
	end
end

function slot0._editableInitView(slot0)
	slot0:_setFilterBtn()
end

function slot0._setFilterBtn(slot0)
	slot0._career2FilterItemDict = {}
	slot1 = {
		CharacterEnum.CareerType.Yan,
		CharacterEnum.CareerType.Xing,
		CharacterEnum.CareerType.Mu,
		CharacterEnum.CareerType.Shou,
		CharacterEnum.CareerType.Ling,
		CharacterEnum.CareerType.Zhi
	}
	slot0.careerTypeCount = #slot1

	gohelper.CreateObjList(slot0, slot0._onInitFilterBtn, slot1, slot0._gofilter, slot0._goattrItem)
end

function slot0._onInitFilterBtn(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.goSelected = gohelper.findChild(slot1, "#go_selected")
	slot4.attrIcon = gohelper.findChildImage(slot1, "#image_attrIcon")
	slot4.goLine = gohelper.findChild(slot1, "#go_line")
	slot4.btnClick = gohelper.findChildButtonWithAudio(slot1, "#btn_click")

	gohelper.setActive(slot4.goLine, slot3 ~= slot0.careerTypeCount)
	gohelper.setActive(slot4.goSelected, false)
	UISpriteSetMgr.instance:setHeroGroupSprite(slot4.attrIcon, "career_" .. slot2)
	slot4.btnClick:AddClickListener(slot0._btnCareerFilterOnClick, slot0, slot2)

	slot0._career2FilterItemDict[slot2] = slot4
end

function slot0.onOpen(slot0)
	slot0.scrollView = slot0.viewContainer and slot0.viewContainer.scrollView

	Season123PickAssistController.instance:onOpenView(slot0.viewParam.actId, slot0.viewParam.finishCall, slot0.viewParam.finishCallObj, slot0.viewParam.selectedHeroUid)
	slot0:refreshUI()
	TaskDispatcher.runRepeat(slot0.refreshCD, slot0, 0.01)
	slot0:showRecommendCareer()
end

function slot0.showRecommendCareer(slot0)
	if not Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage) then
		gohelper.setActive(slot0._gorecommendAttr, false)

		return
	end

	slot2 = #slot1 ~= 0
	slot0._txtrecommendAttrDesc.text = slot2 and luaLang("herogroupeditview_recommend") or luaLang("herogroupeditview_notrecommend")

	if slot2 then
		gohelper.CreateObjList(slot0, slot0._onRecommendCareerItemShow, slot1, slot0._goattrlist, slot0._goattritem)
	end

	gohelper.setActive(slot0._goattrlist, slot2)
	gohelper.setActive(slot0._gorecommendAttr, true)
end

function slot0._onRecommendCareerItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot1, "icon"), "career_" .. slot2)
end

function slot0.refreshUI(slot0)
	slot0:refreshCD()
	slot0:refreshCareerFilterItems()
	slot0:refreshIsEmpty()
	slot0:refreshBtnDetail()
end

function slot0.refreshCD(slot0)
	slot0._simageprogress.fillAmount = Season123PickAssistController.instance:getRefreshCDRate()
end

function slot0.refreshCareerFilterItems(slot0)
	for slot4, slot5 in pairs(slot0._career2FilterItemDict) do
		gohelper.setActive(slot5.goSelected, slot4 == Season123PickAssistListModel.instance:getCareer())
	end
end

function slot0.refreshIsEmpty(slot0)
	gohelper.setActive(slot0._goempty, not Season123PickAssistListModel.instance:isHasAssistList())
end

function slot0.refreshBtnDetail(slot0)
	gohelper.setActive(slot0._godetail, Season123PickAssistListModel.instance:getSelectedMO())
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshCD, slot0)
end

function slot0.onDestroyView(slot0)
	slot0:disposeCareerItems()
	Season123PickAssistController.instance:onCloseView()
end

function slot0.disposeCareerItems(slot0)
	if slot0._career2FilterItemDict then
		for slot4, slot5 in pairs(slot0._career2FilterItemDict) do
			if slot5.btnClick then
				slot5.btnClick:RemoveClickListener()
			end
		end

		slot0._career2FilterItemDict = nil
	end
end

return slot0
