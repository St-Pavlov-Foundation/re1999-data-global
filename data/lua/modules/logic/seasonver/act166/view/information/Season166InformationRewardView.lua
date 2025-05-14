module("modules.logic.seasonver.act166.view.information.Season166InformationRewardView", package.seeall)

local var_0_0 = class("Season166InformationRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.txtTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/SmallTitle/txt_SmallTitle")
	arg_1_0.rewardItems = {}
	arg_1_0.goReward = gohelper.findChild(arg_1_0.viewGO, "Bottom/SliderPoint/#go_rewards")

	gohelper.setActive(arg_1_0.goReward, false)

	arg_1_0.slider = gohelper.findChildSlider(arg_1_0.viewGO, "Bottom/Slider")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, arg_2_0.onInformationUpdate, arg_2_0)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.OnGetInformationBonus, arg_2_0.onGetInformationBonus, arg_2_0)
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

function var_0_0.onInformationUpdate(arg_6_0)
	arg_6_0:refreshUI()
end

function var_0_0.onGetInformationBonus(arg_7_0)
	return
end

function var_0_0.onCloseViewFinish(arg_8_0, arg_8_1)
	if arg_8_1 == ViewName.CommonPropView or arg_8_1 == ViewName.CharacterSkinGainView then
		arg_8_0:refreshReward()
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0.actId = arg_9_0.viewParam.actId

	arg_9_0:refreshUI()
end

function var_0_0.refreshUI(arg_10_0)
	if not arg_10_0.actId then
		return
	end

	local var_10_0 = Season166Model.instance:getActInfo(arg_10_0.actId)
	local var_10_1, var_10_2 = var_10_0:getBonusNum()
	local var_10_3 = {
		var_10_1,
		var_10_2
	}

	arg_10_0.txtTitle.text = GameUtil.getSubPlaceholderLuaLang(luaLang("season166_infoanalyze_rewardview_txt"), var_10_3)
	arg_10_0.infoAnalyCount = var_10_0:getInfoAnalyCount()

	arg_10_0:refreshReward()
end

function var_0_0.refreshReward(arg_11_0)
	if ViewMgr.instance:isOpen(ViewName.CommonPropView) or ViewMgr.instance:isOpen(ViewName.CharacterSkinGainView) then
		return
	end

	local var_11_0 = Season166Config.instance:getSeasonInfoBonuss(arg_11_0.actId) or {}

	for iter_11_0 = 1, math.max(#var_11_0, #arg_11_0.rewardItems) do
		local var_11_1 = arg_11_0.rewardItems[iter_11_0] or arg_11_0:createRewardItem(iter_11_0)

		arg_11_0:refreshRewardItem(var_11_1, var_11_0[iter_11_0])
	end

	local var_11_2 = #var_11_0
	local var_11_3 = arg_11_0.infoAnalyCount
	local var_11_4 = Mathf.Clamp01((var_11_3 - 1) / (var_11_2 - 1))

	arg_11_0.slider:SetValue(var_11_4)
end

function var_0_0.onGetReward(arg_12_0, arg_12_1)
	if not arg_12_1.config then
		return
	end

	local var_12_0 = arg_12_1.config

	if Season166Model.instance:getActInfo(var_12_0.activityId):isBonusGet(var_12_0.analyCount) then
		arg_12_0:showInfo(var_12_0)

		return
	end

	if arg_12_0.infoAnalyCount >= var_12_0.analyCount then
		Activity166Rpc.instance:sendAct166ReceiveInformationBonusRequest(arg_12_0.actId)
	else
		arg_12_0:showInfo(var_12_0)
	end
end

function var_0_0.showInfo(arg_13_0, arg_13_1)
	local var_13_0 = GameUtil.splitString2(arg_13_1.bonus, true)[1]

	MaterialTipController.instance:showMaterialInfo(var_13_0[1], var_13_0[2], nil, nil, true)
end

function var_0_0.createRewardItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = gohelper.cloneInPlace(arg_14_0.goReward, string.format("reward%s", arg_14_1))
	var_14_0.goStatus0 = gohelper.findChild(var_14_0.go, "image_status0")
	var_14_0.goStatus = gohelper.findChild(var_14_0.go, "#image_status")
	var_14_0.goReward = gohelper.findChild(var_14_0.go, "#go_reward_template")
	var_14_0.imgBg = gohelper.findChildImage(var_14_0.goReward, "image_bg")
	var_14_0.imgCircle = gohelper.findChildImage(var_14_0.goReward, "image_circle")
	var_14_0.goHasGet = gohelper.findChild(var_14_0.goReward, "go_hasget")
	var_14_0.goIcon = gohelper.findChild(var_14_0.goReward, "go_icon")
	var_14_0.txtCount = gohelper.findChildTextMesh(var_14_0.goReward, "txt_rewardcount")
	var_14_0.goCanget = gohelper.findChild(var_14_0.goReward, "go_canget")
	var_14_0.btn = gohelper.findButtonWithAudio(var_14_0.go)

	var_14_0.btn:AddClickListener(arg_14_0.onGetReward, arg_14_0, var_14_0)

	var_14_0.animStatus = var_14_0.goStatus:GetComponent(typeof(UnityEngine.Animator))
	var_14_0.animHasGet = var_14_0.goHasGet:GetComponent(typeof(UnityEngine.Animator))
	arg_14_0.rewardItems[arg_14_1] = var_14_0

	return var_14_0
end

function var_0_0.refreshRewardItem(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1.config = arg_15_2

	if not arg_15_2 then
		gohelper.setActive(arg_15_1.go, false)

		return
	end

	local var_15_0 = Season166Model.instance:getActInfo(arg_15_2.activityId):isBonusGet(arg_15_2.analyCount)

	gohelper.setActive(arg_15_1.go, true)
	gohelper.setActive(arg_15_1.goHasGet, var_15_0)
	gohelper.setActive(arg_15_1.goStatus, arg_15_0.infoAnalyCount >= arg_15_2.analyCount)
	gohelper.setActive(arg_15_1.goCanget, not var_15_0 and arg_15_0.infoAnalyCount >= arg_15_2.analyCount)

	local var_15_1 = GameUtil.splitString2(arg_15_2.bonus, true)[1]
	local var_15_2 = ItemModel.instance:getItemConfig(var_15_1[1], var_15_1[2])

	UISpriteSetMgr.instance:setUiFBSprite(arg_15_1.imgBg, "bg_pinjidi_" .. var_15_2.rare)
	UISpriteSetMgr.instance:setUiFBSprite(arg_15_1.imgCircle, "bg_pinjidi_lanse_" .. var_15_2.rare)

	arg_15_1.txtCount.text = string.format("x%s", var_15_1[3])

	if var_15_1 then
		if not arg_15_1.itemIcon then
			arg_15_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_15_1.goIcon)
		end

		arg_15_1.itemIcon:setMOValue(var_15_1[1], var_15_1[2], var_15_1[3], nil, true)
		arg_15_1.itemIcon:isShowQuality(false)
		arg_15_1.itemIcon:isShowCount(false)
	end

	if var_15_0 and arg_15_1.hasGet == false then
		arg_15_1.animStatus:Play("open")
	end

	arg_15_1.hasGet = var_15_0
end

function var_0_0.onClose(arg_16_0)
	return
end

function var_0_0.onDestroyView(arg_17_0)
	for iter_17_0, iter_17_1 in ipairs(arg_17_0.rewardItems) do
		iter_17_1.btn:RemoveClickListener()
	end
end

return var_0_0
