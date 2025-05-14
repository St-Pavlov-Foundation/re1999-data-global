module("modules.logic.rouge.dlc.101.view.RougeMapView_1_101", package.seeall)

local var_0_0 = class("RougeMapView_1_101", BaseViewExtended)

var_0_0.AssetUrl = "ui/viewres/rouge/dlc/101/rougemapskillview.prefab"
var_0_0.ParentObjPath = "Left/#go_rougezhouyu"

local var_0_1 = {
	Expanding = 3,
	Simple = 1,
	Shrinking = 4,
	Detail = 2
}

function var_0_0.onInitView(arg_1_0)
	arg_1_0._heroSkillGO = gohelper.findChild(arg_1_0.viewGO, "heroSkill")
	arg_1_0._goSkillDescContent = gohelper.findChild(arg_1_0.viewGO, "heroSkill/#go_detail/skillDescContent")
	arg_1_0._goSkillDescItem = gohelper.findChild(arg_1_0.viewGO, "heroSkill/#go_detail/skillDescContent/#go_skillDescItem")
	arg_1_0._goSkillContent = gohelper.findChild(arg_1_0.viewGO, "heroSkill/#go_simple/skillContent")
	arg_1_0._goSkillItem = gohelper.findChild(arg_1_0.viewGO, "heroSkill/#go_simple/skillContent/#go_skillitem")
	arg_1_0._btnlimiter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_limiter")
	arg_1_0._txtrisk = gohelper.findChildText(arg_1_0.viewGO, "#btn_limiter/#txt_risk")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnTouchScreenUp, arg_2_0._onTouch, arg_2_0)
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfoPower, arg_2_0._onUpdateRougeInfoPower, arg_2_0)
	RougeController.instance:registerCallback(RougeEvent.OnUpdateRougeInfo, arg_2_0._onUpdateRougeInfo, arg_2_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onUpdateMapInfo, arg_2_0._onUpdateMapInfo, arg_2_0)
	RougeMapController.instance:registerCallback(RougeMapEvent.onChangeMapInfo, arg_2_0._onChangeMapInfo, arg_2_0)
	arg_2_0._btnlimiter:AddClickListener(arg_2_0._btnlimiterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlimiter:RemoveClickListener()
end

function var_0_0._btnlimiterOnClick(arg_4_0)
	local var_4_0 = RougeModel.instance:getRougeInfo()
	local var_4_1 = var_4_0 and var_4_0:getGameLimiterMo()
	local var_4_2 = var_4_1 and var_4_1:getRiskValue() or 0
	local var_4_3 = var_4_1 and var_4_1:getLimiterIds()
	local var_4_4 = var_4_1 and var_4_1:getLimiterBuffIds()
	local var_4_5 = {
		limiterIds = var_4_3,
		buffIds = var_4_4,
		totalRiskValue = var_4_2
	}

	RougeDLCController101.instance:openRougeLimiterOverView(var_4_5)
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._state = var_0_1.Simple
	arg_5_0._detailClick = arg_5_0:getUserDataTb_()
	arg_5_0._entryBtnClick = arg_5_0:getUserDataTb_()
	arg_5_0._animator = gohelper.onceAddComponent(arg_5_0._heroSkillGO, gohelper.Type_Animator)

	arg_5_0:checkAndShowLimiterEntry()
end

function var_0_0.checkAndShowLimiterEntry(arg_6_0)
	local var_6_0 = RougeModel.instance:getRougeInfo()
	local var_6_1 = var_6_0 and var_6_0:getGameLimiterMo()
	local var_6_2 = var_6_1 and var_6_1:getRiskValue() or 0
	local var_6_3 = var_6_1 ~= nil and var_6_2 > 0

	gohelper.setActive(arg_6_0._btnlimiter.gameObject, var_6_3)

	if not var_6_3 then
		return
	end

	arg_6_0._txtrisk.text = var_6_2
end

function var_0_0._onUpdateRougeInfo(arg_7_0)
	arg_7_0:_updateUI()
end

function var_0_0._onUpdateRougeInfoPower(arg_8_0)
	arg_8_0:_updateUI()
end

function var_0_0._onUpdateMapInfo(arg_9_0)
	arg_9_0:_updateUI()
end

function var_0_0._onChangeMapInfo(arg_10_0)
	arg_10_0:_updateUI()
end

function var_0_0._setState(arg_11_0)
	if arg_11_0._state == var_0_1.Expanding then
		arg_11_0._state = var_0_1.Detail
	elseif arg_11_0._state == var_0_1.Shrinking then
		arg_11_0._state = var_0_1.Simple
	end
end

function var_0_0._onTouch(arg_12_0)
	if arg_12_0._state == var_0_1.Detail then
		TaskDispatcher.runDelay(arg_12_0._delayDealTouch, arg_12_0, 0.01)
	end
end

function var_0_0._delayDealTouch(arg_13_0)
	if not arg_13_0._hasClickDetailIcon then
		arg_13_0:_shrinkDetailUI()
	end

	arg_13_0._hasClickDetailIcon = nil
end

function var_0_0._shrinkDetailUI(arg_14_0)
	arg_14_0._animator:Play("fight_heroskill_out", 0, 0)
	arg_14_0._animator:Update(0)

	arg_14_0._state = var_0_1.Shrinking

	TaskDispatcher.runDelay(arg_14_0._setState, arg_14_0, 0.533)
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_updateUI()
end

function var_0_0._getPower(arg_16_0)
	local var_16_0 = RougeModel.instance:getRougeInfo()

	return var_16_0 and var_16_0.power or 0
end

function var_0_0._getCoint(arg_17_0)
	local var_17_0 = RougeModel.instance:getRougeInfo()

	return var_17_0 and var_17_0.coin or 0
end

function var_0_0._updateUI(arg_18_0)
	arg_18_0._mapSkills = RougeMapModel.instance:getMapSkillList()
	arg_18_0._visible = (arg_18_0._mapSkills and #arg_18_0._mapSkills or 0) > 0

	gohelper.setActive(arg_18_0._heroSkillGO, arg_18_0._visible)

	if not arg_18_0._visible then
		return
	end

	gohelper.CreateObjList(arg_18_0, arg_18_0._refreshMapSkillDetail, arg_18_0._mapSkills, arg_18_0._goSkillDescContent, arg_18_0._goSkillDescItem)
	gohelper.CreateObjList(arg_18_0, arg_18_0._refreshMapSkillEntry, arg_18_0._mapSkills, arg_18_0._goSkillContent, arg_18_0._goSkillItem)
end

function var_0_0._refreshMapSkillDetail(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = lua_rouge_map_skill.configDict[arg_19_2.id]

	if var_19_0 then
		local var_19_1 = RougeMapSkillCheckHelper.canUseMapSkill(arg_19_2)
		local var_19_2 = gohelper.findChild(arg_19_1, "skill1/notcost1")
		local var_19_3 = gohelper.findChild(arg_19_1, "skill1/cancost1")

		gohelper.setActive(var_19_2, not var_19_1)
		gohelper.setActive(var_19_3, var_19_1)

		local var_19_4 = var_19_0.icon
		local var_19_5 = gohelper.findChildImage(arg_19_1, "skill1/notcost1")
		local var_19_6 = gohelper.findChildImage(arg_19_1, "skill1/cancost1")

		UISpriteSetMgr.instance:setRouge2Sprite(var_19_5, var_19_4)
		UISpriteSetMgr.instance:setRouge2Sprite(var_19_6, var_19_4 .. "_light")

		local var_19_7 = var_19_0.desc

		gohelper.findChildText(arg_19_1, "desc1").text = var_19_7 .. "\nCOST<color=#FFA500>-" .. var_19_0.powerCost .. "</color>"

		if not arg_19_0._detailClick[arg_19_3] then
			local var_19_8 = gohelper.getClick(arg_19_1)

			var_19_8:AddClickListener(arg_19_0._onClickSkillIcon, arg_19_0, arg_19_3)

			arg_19_0._detailClick[arg_19_3] = var_19_8
		end
	else
		logError("肉鸽地图技能配置不存在:" .. tostring(arg_19_2.id))
	end
end

function var_0_0._refreshMapSkillEntry(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = lua_rouge_map_skill.configDict[arg_20_2.id]

	if var_20_0 then
		local var_20_1 = RougeMapSkillCheckHelper.canUseMapSkill(arg_20_2)
		local var_20_2 = gohelper.findChild(arg_20_1, "notcost")
		local var_20_3 = gohelper.findChild(arg_20_1, "cancost")

		gohelper.setActive(var_20_2, not var_20_1)
		gohelper.setActive(var_20_3, var_20_1)

		local var_20_4 = var_20_0.icon
		local var_20_5 = gohelper.findChildImage(arg_20_1, "notcost/#image_skill_normal")
		local var_20_6 = gohelper.findChildImage(arg_20_1, "cancost/#image_skill_light")

		UISpriteSetMgr.instance:setRouge2Sprite(var_20_5, var_20_4)
		UISpriteSetMgr.instance:setRouge2Sprite(var_20_6, var_20_4 .. "_light")

		if not arg_20_0._entryBtnClick[arg_20_3] then
			local var_20_7 = gohelper.findChildButtonWithAudio(arg_20_1, "btn_click")

			var_20_7:AddClickListener(arg_20_0._onClickEntrySkillIcon, arg_20_0, arg_20_3)

			arg_20_0._entryBtnClick[arg_20_3] = var_20_7
		end
	else
		logError("肉鸽地图技能配置不存在:" .. tostring(arg_20_2.id))
	end
end

function var_0_0._onClickEntrySkillIcon(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._mapSkills and arg_21_0._mapSkills[arg_21_1]
	local var_21_1, var_21_2 = RougeMapSkillCheckHelper.canUseMapSkill(var_21_0)

	if not var_21_1 and var_21_2 == RougeMapSkillCheckHelper.CantUseMapSkillReason.DoingEvent then
		RougeMapSkillCheckHelper.showCantUseMapSkillToast(var_21_2)

		return
	end

	if arg_21_0._state == var_0_1.Simple then
		arg_21_0._animator:Play("fight_heroskill_tips", 0, 0)
		arg_21_0._animator:Update(0)

		arg_21_0._state = var_0_1.Expanding

		TaskDispatcher.runDelay(arg_21_0._setState, arg_21_0, 0.533)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_unfold)
	end
end

function var_0_0._onClickSkillIcon(arg_22_0, arg_22_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	local var_22_0 = arg_22_0._mapSkills and arg_22_0._mapSkills[arg_22_1]

	if not var_22_0 then
		return
	end

	arg_22_0._hasClickDetailIcon = true

	local var_22_1, var_22_2 = RougeMapSkillCheckHelper.canUseMapSkill(var_22_0)

	if var_22_1 then
		local var_22_3 = RougeModel.instance:getSeason()

		RougeRpc.instance:sendRougeUseMapSkillRequest(var_22_3, var_22_0.id, function(arg_23_0, arg_23_1)
			if arg_23_1 ~= 0 then
				return
			end

			arg_22_0:_updateUI()
			arg_22_0:_shrinkDetailUI()
			RougeMapSkillCheckHelper.executeUseMapSkillCallBack(var_22_0)
		end)
	else
		RougeMapSkillCheckHelper.showCantUseMapSkillToast(var_22_2)
	end
end

function var_0_0.onClose(arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._delayDealTouch, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._setState, arg_24_0)

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._detailClick) do
		iter_24_1:RemoveClickListener()
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_0._entryBtnClick) do
		iter_24_3:RemoveClickListener()
	end

	GameStateMgr.instance:unregisterCallback(GameStateEvent.OnTouchScreenUp, arg_24_0._onTouch, arg_24_0)
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfoPower, arg_24_0._onUpdateRougeInfoPower, arg_24_0)
	RougeController.instance:unregisterCallback(RougeEvent.OnUpdateRougeInfo, arg_24_0._onUpdateRougeInfo, arg_24_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onUpdateMapInfo, arg_24_0._onUpdateMapInfo, arg_24_0)
	RougeMapController.instance:unregisterCallback(RougeMapEvent.onChangeMapInfo, arg_24_0._onChangeMapInfo, arg_24_0)
end

return var_0_0
