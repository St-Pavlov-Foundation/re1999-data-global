module("modules.logic.seasonver.act166.view2_6.Season166_2_6InformationAnalyRewardView", package.seeall)

local var_0_0 = class("Season166_2_6InformationAnalyRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.rewardItems = {}
	arg_1_0.goReward = gohelper.findChild(arg_1_0.viewGO, "Bottom/SliderPoint/#go_rewards")

	gohelper.setActive(arg_1_0.goReward, false)

	arg_1_0.slider = gohelper.findChildSlider(arg_1_0.viewGO, "Bottom/Slider")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, arg_2_0.onAnalyInfoSuccess, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, arg_2_0.onInformationUpdate, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnGetInfoBonus, arg_2_0.onGetInfoBonus, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.ChangeAnalyInfo, arg_2_0.onChangeAnalyInfo, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0.onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onAnalyInfoSuccess(arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onChangeAnalyInfo(arg_7_0, arg_7_1)
	arg_7_0.infoId = arg_7_1

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.rewardItems) do
		iter_7_1.activieStatus = nil
		iter_7_1.hasGet = nil
	end

	arg_7_0:refreshUI()
end

function var_0_0.onInformationUpdate(arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.onGetInfoBonus(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.actId = arg_10_0.viewParam.actId
	arg_10_0.infoId = arg_10_0.viewParam.infoId

	arg_10_0:refreshUI()
end

function var_0_0.refreshUI(arg_11_0)
	if not arg_11_0.actId then
		return
	end

	arg_11_0:refreshReward()
end

function var_0_0.refreshReward(arg_12_0)
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) then
		return
	end

	local var_12_0 = Season166Model.instance:getActInfo(arg_12_0.actId):getInformationMO(arg_12_0.infoId)
	local var_12_1 = Season166Config.instance:getSeasonInfoAnalys(arg_12_0.actId, arg_12_0.infoId) or {}

	for iter_12_0 = 1, math.max(#var_12_1, #arg_12_0.rewardItems) do
		local var_12_2 = arg_12_0.rewardItems[iter_12_0] or arg_12_0:createRewardItem(iter_12_0)

		arg_12_0:refreshRewardItem(var_12_2, var_12_1[iter_12_0])
	end

	local var_12_3 = #var_12_1
	local var_12_4 = var_12_0 and var_12_0.stage or 0
	local var_12_5 = Mathf.Clamp01((var_12_4 - 1) / (var_12_3 - 1))

	arg_12_0.slider:SetValue(var_12_5)
end

function var_0_0.onGetReward(arg_13_0, arg_13_1)
	if not arg_13_1.config then
		return
	end

	local var_13_0 = arg_13_1.config
	local var_13_1 = Season166Model.instance:getActInfo(var_13_0.activityId):getInformationMO(var_13_0.infoId)

	if not var_13_1 then
		return
	end

	if var_13_1.bonusStage >= var_13_0.stage then
		arg_13_0:showInfo(var_13_0)

		return
	end

	if var_13_1.stage >= var_13_0.stage then
		Activity166Rpc.instance:sendAct166ReceiveInfoBonusRequest(arg_13_0.actId, arg_13_0.infoId)
	else
		arg_13_0:showInfo(var_13_0)
	end
end

function var_0_0.showInfo(arg_14_0, arg_14_1)
	local var_14_0 = GameUtil.splitString2(arg_14_1.bonus, true)[1]

	MaterialTipController.instance:showMaterialInfo(var_14_0[1], var_14_0[2], nil, nil, true)
end

function var_0_0.createRewardItem(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = gohelper.cloneInPlace(arg_15_0.goReward, string.format("reward%s", arg_15_1))
	var_15_0.goStatus0 = gohelper.findChild(var_15_0.go, "image_status0")
	var_15_0.goStatus = gohelper.findChild(var_15_0.go, "#image_status")
	var_15_0.goReward = gohelper.findChild(var_15_0.go, "#go_reward_template")
	var_15_0.imgBg = gohelper.findChildImage(var_15_0.goReward, "image_bg")
	var_15_0.imgCircle = gohelper.findChildImage(var_15_0.goReward, "image_circle")
	var_15_0.goHasGet = gohelper.findChild(var_15_0.goReward, "go_hasget")
	var_15_0.goIcon = gohelper.findChild(var_15_0.goReward, "go_icon")
	var_15_0.txtCount = gohelper.findChildTextMesh(var_15_0.goReward, "txt_rewardcount")
	var_15_0.goCanget = gohelper.findChild(var_15_0.goReward, "go_canget")
	var_15_0.btn = gohelper.findButtonWithAudio(var_15_0.go)

	var_15_0.btn:AddClickListener(arg_15_0.onGetReward, arg_15_0, var_15_0)

	var_15_0.animStatus = var_15_0.goStatus:GetComponent(typeof(UnityEngine.Animator))
	var_15_0.animHasGet = var_15_0.goHasGet:GetComponent(typeof(UnityEngine.Animator))
	arg_15_0.rewardItems[arg_15_1] = var_15_0

	return var_15_0
end

function var_0_0.refreshRewardItem(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1.config = arg_16_2

	if not arg_16_2 then
		gohelper.setActive(arg_16_1.go, false)

		return
	end

	local var_16_0 = Season166Model.instance:getActInfo(arg_16_2.activityId):getInformationMO(arg_16_2.infoId)
	local var_16_1 = var_16_0 and var_16_0.bonusStage >= arg_16_2.stage or false
	local var_16_2 = var_16_0 and var_16_0.stage >= arg_16_2.stage or false

	gohelper.setActive(arg_16_1.go, true)
	gohelper.setActive(arg_16_1.goHasGet, var_16_1)
	gohelper.setActive(arg_16_1.goStatus, var_16_2)
	gohelper.setActive(arg_16_1.goCanget, not var_16_1 and var_16_2)

	local var_16_3 = GameUtil.splitString2(arg_16_2.bonus, true)[1]
	local var_16_4 = ItemModel.instance:getItemConfig(var_16_3[1], var_16_3[2])

	UISpriteSetMgr.instance:setUiFBSprite(arg_16_1.imgBg, "bg_pinjidi_" .. var_16_4.rare)
	UISpriteSetMgr.instance:setUiFBSprite(arg_16_1.imgCircle, "bg_pinjidi_lanse_" .. var_16_4.rare)

	arg_16_1.txtCount.text = string.format("x%s", var_16_3[3])

	if var_16_3 then
		if not arg_16_1.itemIcon then
			arg_16_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_16_1.goIcon)
		end

		arg_16_1.itemIcon:setMOValue(var_16_3[1], var_16_3[2], var_16_3[3], nil, true)
		arg_16_1.itemIcon:isShowQuality(false)
		arg_16_1.itemIcon:isShowCount(false)
	end

	if var_16_1 and arg_16_1.hasGet == false then
		arg_16_1.animHasGet:Play("open")
	end

	if var_16_2 and arg_16_1.activieStatus == false then
		arg_16_1.animStatus:Play("open")
	end

	arg_16_1.activieStatus = var_16_2
	arg_16_1.hasGet = var_16_1
end

function var_0_0.onCloseViewFinish(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.CommonPropView then
		arg_17_0:refreshReward()
	end
end

function var_0_0.onClose(arg_18_0)
	return
end

function var_0_0.onDestroyView(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.rewardItems) do
		iter_19_1.btn:RemoveClickListener()
	end
end

return var_0_0
