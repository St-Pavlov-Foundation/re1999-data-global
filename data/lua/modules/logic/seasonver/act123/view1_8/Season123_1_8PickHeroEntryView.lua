module("modules.logic.seasonver.act123.view1_8.Season123_1_8PickHeroEntryView", package.seeall)

local var_0_0 = class("Season123_1_8PickHeroEntryView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/#go_item")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_start/#btn_start")
	arg_1_0._btndisstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_start/#btn_disstart")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnmaincard1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_supercard1/#btn_supercardclick")
	arg_1_0._btnmaincard2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_supercard2/#btn_supercardclick")
	arg_1_0._btndetails = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_details")
	arg_1_0._gorecomment = gohelper.findChild(arg_1_0.viewGO, "Right/#go_recommend")
	arg_1_0._gorecommentnone = gohelper.findChild(arg_1_0.viewGO, "Right/#go_recommend/txt_recommend/txt_none")
	arg_1_0._gorecommentexist = gohelper.findChild(arg_1_0.viewGO, "Right/#go_recommend/txt_recommend/recommends")
	arg_1_0._gocareeritem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_recommend/txt_recommend/recommends/career")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btndisstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnmaincard1:AddClickListener(arg_2_0._btnmaincardOnClick, arg_2_0, 1)
	arg_2_0._btnmaincard2:AddClickListener(arg_2_0._btnmaincardOnClick, arg_2_0, 2)
	arg_2_0._btndetails:AddClickListener(arg_2_0._btndetailsOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btndisstart:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnmaincard1:RemoveClickListener()
	arg_3_0._btnmaincard2:RemoveClickListener()
	arg_3_0._btndetails:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._heroItems = {}
	arg_4_0._careerItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._heroItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._heroItems) do
			iter_5_1.component:dispose()
		end

		arg_5_0._heroItems = nil
	end

	Season123PickHeroEntryController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.PickEntryRefresh, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.EnterStageSuccess, arg_6_0.handleEnterStageSuccess, arg_6_0)
	Season123PickHeroEntryController.instance:onOpenView(arg_6_0.viewParam.actId, arg_6_0.viewParam.stage)

	local var_6_0 = ActivityModel.instance:getActMO(arg_6_0.viewParam.actId)

	if not var_6_0 or not var_6_0:isOpen() or var_6_0:isExpired() then
		return
	end

	arg_6_0:refreshUI()
	gohelper.setActive(arg_6_0._goitem, false)
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshItems()
	arg_8_0:refreshButton()
	arg_8_0:refreshRecommendCareer()
end

function var_0_0.refreshButton(arg_9_0)
	local var_9_0 = Season123PickHeroEntryModel.instance:getSelectCount()
	local var_9_1 = Season123PickHeroEntryModel.instance:getLimitCount()
	local var_9_2 = var_9_0 > 0

	gohelper.setActive(arg_9_0._btndisstart, not var_9_2)
	gohelper.setActive(arg_9_0._btnstart, var_9_2)
end

function var_0_0.refreshItems(arg_10_0)
	local var_10_0 = Season123PickHeroEntryModel.instance:getCutHeroList()

	for iter_10_0 = 1, Activity123Enum.PickHeroCount do
		local var_10_1 = arg_10_0:getOrCreateItem(iter_10_0)

		var_10_1.component:refreshUI()

		local var_10_2 = var_10_0 and LuaUtil.tableContains(var_10_0, iter_10_0)

		var_10_1.component:cutHeroAnim(var_10_2)
	end

	Season123PickHeroEntryModel.instance:refeshLastHeroList()
end

function var_0_0.getOrCreateItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._heroItems[arg_11_1]

	if not var_11_0 then
		var_11_0 = arg_11_0:getUserDataTb_()
		var_11_0.go = gohelper.cloneInPlace(arg_11_0._goitem, "item_" .. tostring(arg_11_1))
		var_11_0.component = Season123_1_8PickHeroEntryItem.New()

		var_11_0.component:init(var_11_0.go)
		var_11_0.component:initData(arg_11_1)
		gohelper.setActive(var_11_0.go, true)

		arg_11_0._heroItems[arg_11_1] = var_11_0
	end

	return var_11_0
end

function var_0_0.refreshRecommendCareer(arg_12_0)
	local var_12_0 = Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage)

	if var_12_0 and #var_12_0 > 0 then
		gohelper.setActive(arg_12_0._gorecommentnone, false)
		gohelper.setActive(arg_12_0._gorecommentexist, true)

		for iter_12_0 = 1, #var_12_0 do
			local var_12_1 = arg_12_0:getOrCreateCareer(iter_12_0)

			gohelper.setActive(var_12_1.go, true)
			UISpriteSetMgr.instance:setHeroGroupSprite(var_12_1.imageicon, "career_" .. tostring(var_12_0[iter_12_0]))
		end

		for iter_12_1 = #var_12_0 + 1, #var_12_0 do
			local var_12_2 = arg_12_0._careerItems[iter_12_1]

			if var_12_2 then
				gohelper.setActive(var_12_2.go, false)
			end
		end
	else
		gohelper.setActive(arg_12_0._gorecommentnone, true)
		gohelper.setActive(arg_12_0._gorecommentexist, false)
	end
end

function var_0_0.getOrCreateCareer(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._careerItems[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = gohelper.cloneInPlace(arg_13_0._gocareeritem, "career_" .. tostring(arg_13_1))
		var_13_0.imageicon = gohelper.findChildImage(var_13_0.go, "")
		arg_13_0._careerItems[arg_13_1] = var_13_0
	end

	return var_13_0
end

function var_0_0._btnstartOnClick(arg_14_0)
	Season123PickHeroEntryController.instance:sendEnterStage()
end

function var_0_0._btncloseOnClick(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0._btndetailsOnClick(arg_16_0)
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, 1)
end

function var_0_0.handleEnterStageSuccess(arg_17_0)
	local var_17_0 = arg_17_0.viewParam.finishCall
	local var_17_1 = arg_17_0.viewParam.finishCallObj

	arg_17_0:closeThis()

	if var_17_0 then
		var_17_0(var_17_1)
	end
end

return var_0_0
