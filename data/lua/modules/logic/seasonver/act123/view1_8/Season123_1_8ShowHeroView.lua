module("modules.logic.seasonver.act123.view1_8.Season123_1_8ShowHeroView", package.seeall)

local var_0_0 = class("Season123_1_8ShowHeroView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/#go_item")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_reset")
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
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btndetails:AddClickListener(arg_2_0._btndetailsOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnmaincard1:AddClickListener(arg_2_0._btnmaincardOnClick, arg_2_0, 1)
	arg_2_0._btnmaincard2:AddClickListener(arg_2_0._btnmaincardOnClick, arg_2_0, 2)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btndetails:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnmaincard1:RemoveClickListener()
	arg_3_0._btnmaincard2:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._heroItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._heroItems then
		for iter_5_0, iter_5_1 in pairs(arg_5_0._heroItems) do
			iter_5_1.component:dispose()
		end

		arg_5_0._heroItems = nil
	end

	Season123ShowHeroController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.OnResetSucc, arg_6_0.closeThis, arg_6_0)
	Season123ShowHeroController.instance:onOpenView(arg_6_0.viewParam.actId, arg_6_0.viewParam.stage, arg_6_0.viewParam.layer)

	local var_6_0 = ActivityModel.instance:getActMO(arg_6_0.viewParam.actId)

	if not var_6_0 or not var_6_0:isOpen() or var_6_0:isExpired() then
		return
	end

	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	if arg_7_0._heroItems then
		for iter_7_0, iter_7_1 in pairs(arg_7_0._heroItems) do
			iter_7_1.component:onClose()
		end
	end
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshItems()
	gohelper.setActive(arg_8_0._gorecommentnone, false)
	gohelper.setActive(arg_8_0._gorecommentexist, false)
end

function var_0_0.refreshItems(arg_9_0)
	for iter_9_0 = 1, Activity123Enum.PickHeroCount do
		arg_9_0:getOrCreateItem(iter_9_0).component:refreshUI()
	end
end

function var_0_0.getOrCreateItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._heroItems[arg_10_1]

	if not var_10_0 then
		var_10_0 = arg_10_0:getUserDataTb_()
		var_10_0.go = gohelper.cloneInPlace(arg_10_0._goitem, "item_" .. tostring(arg_10_1))
		var_10_0.component = Season123_1_8ShowHeroItem.New()

		var_10_0.component:init(var_10_0.go)
		var_10_0.component:initData(arg_10_1)
		gohelper.setActive(var_10_0.go, true)

		arg_10_0._heroItems[arg_10_1] = var_10_0
	end

	return var_10_0
end

function var_0_0._btndetailsOnClick(arg_11_0)
	EnemyInfoController.instance:openSeason123EnemyInfoView(Season123ShowHeroModel.instance.activityId, Season123ShowHeroModel.instance.stage, Season123ShowHeroModel.instance.layer)
end

function var_0_0._btnresetOnClick(arg_12_0)
	Season123ShowHeroController.instance:openReset()
end

function var_0_0._btncloseOnClick(arg_13_0)
	arg_13_0:closeThis()
end

function var_0_0.handleEnterStageSuccess(arg_14_0)
	local var_14_0 = arg_14_0.viewParam.finishCall
	local var_14_1 = arg_14_0.viewParam.finishCallObj

	arg_14_0:closeThis()

	if var_14_0 then
		var_14_0(var_14_1)
	end
end

return var_0_0
