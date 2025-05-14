module("modules.logic.seasonver.act123.view2_1.Season123_2_1PickAssistView", package.seeall)

local var_0_0 = class("Season123_2_1PickAssistView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "#go_filter")
	arg_1_0._goattrItem = gohelper.findChild(arg_1_0.viewGO, "#go_filter/#go_attrItem")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_empty")
	arg_1_0._gorecommendAttr = gohelper.findChild(arg_1_0.viewGO, "#go_recommendAttr")
	arg_1_0._txtrecommendAttrDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_recommendAttr/txt_recommend")
	arg_1_0._goattrlist = gohelper.findChild(arg_1_0.viewGO, "#go_recommendAttr/txt_recommend/#go_attrlist")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_recommendAttr/txt_recommend/#go_attrlist/#go_recommendAttrItem")
	arg_1_0._btnrefresh = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_refresh")
	arg_1_0._simageprogress = gohelper.findChildImage(arg_1_0.viewGO, "bottom/#btn_refresh/#simage_progress")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "bottom/#btn_detail")
	arg_1_0._btndetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_detail")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrefresh:AddClickListener(arg_2_0._btnrefreshOnClick, arg_2_0)
	arg_2_0._btndetail:AddClickListener(arg_2_0._onHeroDetailClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.BeforeRefreshAssistList, arg_2_0.onBeforeRefreshAssistList, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.SetCareer, arg_2_0.refreshIsEmpty, arg_2_0)
	arg_2_0:addEventCb(Season123Controller.instance, Season123Event.RefreshSelectAssistHero, arg_2_0.refreshBtnDetail, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrefresh:RemoveClickListener()
	arg_3_0._btndetail:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0:addEventCb(Season123Controller.instance, Season123Event.BeforeRefreshAssistList, arg_3_0.onBeforeRefreshAssistList, arg_3_0)
	arg_3_0:removeEventCb(Season123Controller.instance, Season123Event.SetCareer, arg_3_0.refreshIsEmpty, arg_3_0)
	arg_3_0:removeEventCb(Season123Controller.instance, Season123Event.RefreshSelectAssistHero, arg_3_0.refreshBtnDetail, arg_3_0)
end

function var_0_0.onBeforeRefreshAssistList(arg_4_0)
	if arg_4_0.scrollView then
		arg_4_0.scrollView._firstUpdate = true

		if not arg_4_0.hasChangedItemDelayTime then
			arg_4_0.scrollView:changeDelayTime(-arg_4_0.viewContainer.viewOpenAnimTime)

			arg_4_0.hasChangedItemDelayTime = true
		end
	end
end

function var_0_0._btnrefreshOnClick(arg_5_0)
	Season123PickAssistController.instance:manualRefreshList()
end

function var_0_0._onHeroDetailClick(arg_6_0)
	local var_6_0 = Season123PickAssistListModel.instance:getSelectedMO()

	if var_6_0 then
		CharacterController.instance:openCharacterView(var_6_0.heroMO)
	end
end

function var_0_0._btnconfirmOnClick(arg_7_0)
	Season123PickAssistController.instance:pickOver()
	arg_7_0:closeThis()
end

function var_0_0._btnCareerFilterOnClick(arg_8_0, arg_8_1)
	if Season123PickAssistController.instance:setCareer(arg_8_1) then
		arg_8_0:refreshCareerFilterItems()
	end
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0:_setFilterBtn()
end

function var_0_0._setFilterBtn(arg_10_0)
	arg_10_0._career2FilterItemDict = {}

	local var_10_0 = {
		CharacterEnum.CareerType.Yan,
		CharacterEnum.CareerType.Xing,
		CharacterEnum.CareerType.Mu,
		CharacterEnum.CareerType.Shou,
		CharacterEnum.CareerType.Ling,
		CharacterEnum.CareerType.Zhi
	}

	arg_10_0.careerTypeCount = #var_10_0

	gohelper.CreateObjList(arg_10_0, arg_10_0._onInitFilterBtn, var_10_0, arg_10_0._gofilter, arg_10_0._goattrItem)
end

function var_0_0._onInitFilterBtn(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.goSelected = gohelper.findChild(arg_11_1, "#go_selected")
	var_11_0.attrIcon = gohelper.findChildImage(arg_11_1, "#image_attrIcon")
	var_11_0.goLine = gohelper.findChild(arg_11_1, "#go_line")
	var_11_0.btnClick = gohelper.findChildButtonWithAudio(arg_11_1, "#btn_click")

	local var_11_1 = arg_11_3 ~= arg_11_0.careerTypeCount

	gohelper.setActive(var_11_0.goLine, var_11_1)
	gohelper.setActive(var_11_0.goSelected, false)
	UISpriteSetMgr.instance:setHeroGroupSprite(var_11_0.attrIcon, "career_" .. arg_11_2)
	var_11_0.btnClick:AddClickListener(arg_11_0._btnCareerFilterOnClick, arg_11_0, arg_11_2)

	arg_11_0._career2FilterItemDict[arg_11_2] = var_11_0
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0.scrollView = arg_12_0.viewContainer and arg_12_0.viewContainer.scrollView

	Season123PickAssistController.instance:onOpenView(arg_12_0.viewParam.actId, arg_12_0.viewParam.finishCall, arg_12_0.viewParam.finishCallObj, arg_12_0.viewParam.selectedHeroUid)
	arg_12_0:refreshUI()
	TaskDispatcher.runRepeat(arg_12_0.refreshCD, arg_12_0, 0.01)
	arg_12_0:showRecommendCareer()
end

function var_0_0.showRecommendCareer(arg_13_0)
	local var_13_0 = Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)

	if not var_13_0 then
		gohelper.setActive(arg_13_0._gorecommendAttr, false)

		return
	end

	local var_13_1 = #var_13_0 ~= 0
	local var_13_2 = var_13_1 and luaLang("herogroupeditview_recommend") or luaLang("herogroupeditview_notrecommend")

	arg_13_0._txtrecommendAttrDesc.text = var_13_2

	if var_13_1 then
		gohelper.CreateObjList(arg_13_0, arg_13_0._onRecommendCareerItemShow, var_13_0, arg_13_0._goattrlist, arg_13_0._goattritem)
	end

	gohelper.setActive(arg_13_0._goattrlist, var_13_1)
	gohelper.setActive(arg_13_0._gorecommendAttr, true)
end

function var_0_0._onRecommendCareerItemShow(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChildImage(arg_14_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_14_0, "career_" .. arg_14_2)
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0:refreshCD()
	arg_15_0:refreshCareerFilterItems()
	arg_15_0:refreshIsEmpty()
	arg_15_0:refreshBtnDetail()
end

function var_0_0.refreshCD(arg_16_0)
	local var_16_0 = Season123PickAssistController.instance:getRefreshCDRate()

	arg_16_0._simageprogress.fillAmount = var_16_0
end

function var_0_0.refreshCareerFilterItems(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._career2FilterItemDict) do
		local var_17_0 = Season123PickAssistListModel.instance:getCareer()

		gohelper.setActive(iter_17_1.goSelected, iter_17_0 == var_17_0)
	end
end

function var_0_0.refreshIsEmpty(arg_18_0)
	local var_18_0 = Season123PickAssistListModel.instance:isHasAssistList()

	gohelper.setActive(arg_18_0._goempty, not var_18_0)
end

function var_0_0.refreshBtnDetail(arg_19_0)
	local var_19_0 = Season123PickAssistListModel.instance:getSelectedMO()

	gohelper.setActive(arg_19_0._godetail, var_19_0)
end

function var_0_0.onClose(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0.refreshCD, arg_20_0)
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0:disposeCareerItems()
	Season123PickAssistController.instance:onCloseView()
end

function var_0_0.disposeCareerItems(arg_22_0)
	if arg_22_0._career2FilterItemDict then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._career2FilterItemDict) do
			if iter_22_1.btnClick then
				iter_22_1.btnClick:RemoveClickListener()
			end
		end

		arg_22_0._career2FilterItemDict = nil
	end
end

return var_0_0
