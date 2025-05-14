module("modules.logic.versionactivity.view.VersionActivityExchangeView", package.seeall)

local var_0_0 = class("VersionActivityExchangeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gochat = gohelper.findChild(arg_1_0.viewGO, "taklkarea/#go_chat")
	arg_1_0._txttalk1 = gohelper.findChildText(arg_1_0.viewGO, "taklkarea/#go_chat/#txt_talk1")
	arg_1_0._txttalk2 = gohelper.findChildText(arg_1_0.viewGO, "taklkarea/#go_chat/#txt_talk2")
	arg_1_0._gohero1 = gohelper.findChild(arg_1_0.viewGO, "taklkarea/hero1/#go_hero1")
	arg_1_0._gohero2 = gohelper.findChild(arg_1_0.viewGO, "taklkarea/hero2/#go_hero2")
	arg_1_0._goroleimage = gohelper.findChild(arg_1_0.viewGO, "taklkarea/#go_role_image")
	arg_1_0._txtdeadline = gohelper.findChildText(arg_1_0.viewGO, "#txt_deadline")
	arg_1_0._txthas = gohelper.findChildText(arg_1_0.viewGO, "gohas/#txt_has")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_reward")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_Content")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_Content/#go_rewardItem")
	arg_1_0._gorewardcontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_Content/#go_rewardItem/#go_rewardcontent")
	arg_1_0._btngetres = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_getres")
	arg_1_0._btnrule = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rule")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._slider = gohelper.findChildSlider(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_Content/#slider_progress")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngetres:AddClickListener(arg_2_0._btngetresOnClick, arg_2_0)
	arg_2_0._btnrule:AddClickListener(arg_2_0.openTips, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngetres:RemoveClickListener()
	arg_3_0._btnrule:RemoveClickListener()
end

function var_0_0._btngetresOnClick(arg_4_0)
	if ActivityModel.instance:getActEndTime(arg_4_0.actId) / 1000 - ServerTime.now() < tonumber(arg_4_0._actMO.config.param) * 3600 then
		ToastController.instance:showToast(185)
	else
		ViewMgr.instance:openView(ViewName.VersionActivityExchangeTaskView, {
			actId = arg_4_0.actId
		})
	end
end

function var_0_0.openTips(arg_5_0)
	ViewMgr.instance:openView(ViewName.VersionActivityTipsView)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gorewardItem, false)

	arg_6_0.rewardItemList = {}
	arg_6_0.actId = 11114
	arg_6_0._actMO = ActivityModel.instance:getActMO(arg_6_0.actId)
	arg_6_0._uiSpine1 = GuiModelAgentNew.Create(arg_6_0._gohero1, true)
	arg_6_0._uiSpine2 = GuiModelAgentNew.Create(arg_6_0._gohero2, true)

	arg_6_0._simagebg:LoadImage(ResUrl.getVersionActivityExchangeIcon("full/bg"))

	arg_6_0._animator = gohelper.findChild(arg_6_0.viewGO, "taklkarea"):GetComponent(typeof(UnityEngine.Animator))

	local var_6_0 = ViewMgr.instance:getUIRoot().transform
	local var_6_1 = recthelper.getHeight(var_6_0)
	local var_6_2 = recthelper.getWidth(var_6_0)
	local var_6_3 = gohelper.findChild(arg_6_0._goroleimage, "maskhero1Shadow/img_hero1").transform
	local var_6_4 = gohelper.findChild(arg_6_0._goroleimage, "maskhero2Shadow/img_hero2").transform
	local var_6_5 = gohelper.findChild(arg_6_0._goroleimage, "maskhero1/img_hero1").transform
	local var_6_6 = gohelper.findChild(arg_6_0._goroleimage, "maskhero2/img_hero2").transform

	recthelper.setSize(var_6_3, var_6_2, var_6_1)
	recthelper.setSize(var_6_4, var_6_2, var_6_1)
	recthelper.setSize(var_6_5, var_6_2, var_6_1)
	recthelper.setSize(var_6_6, var_6_2, var_6_1)

	arg_6_0.iconClick = gohelper.findChildClick(arg_6_0.viewGO, "gohas/icon")

	arg_6_0.iconClick:AddClickListener(arg_6_0.onClickIcon, arg_6_0)

	arg_6_0._firstShow = true
	arg_6_0._gotaskdot = gohelper.findChild(arg_6_0.viewGO, "#btn_getres/dot")

	RedDotController.instance:addRedDot(arg_6_0._gotaskdot, RedDotEnum.DotNode.VersionActivityExchangeTask)
end

function var_0_0.onClickIcon(arg_7_0)
	MaterialTipController.instance:showMaterialInfo(1, 970002, false, nil, false)
end

function var_0_0.onUpdateParam(arg_8_0)
	Activity112Rpc.instance:sendGet112InfosRequest(arg_8_0.actId)
	arg_8_0:refreshReward()
	arg_8_0:updateItemNum()
	arg_8_0:updateDeadline()
end

function var_0_0.onOpen(arg_9_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_paraphrase_open)
	arg_9_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_9_0.updateItemNum, arg_9_0)
	arg_9_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112Update, arg_9_0.refreshReward, arg_9_0)
	Activity112Rpc.instance:sendGet112InfosRequest(arg_9_0.actId)

	local var_9_0 = VersionActivityConfig.instance:getAct112Config(arg_9_0.actId)

	arg_9_0._needList = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = string.splitToNumber(iter_9_1.items, "#")

		arg_9_0._needList[iter_9_0] = var_9_1[3]
	end

	arg_9_0:updateItemNum()
	arg_9_0:updateDeadline()
	TaskDispatcher.runRepeat(arg_9_0.updateDeadline, arg_9_0, 60)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_10_0.updateItemNum, arg_10_0)
	arg_10_0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.VersionActivity112Update, arg_10_0.refreshReward, arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.updateDeadline, arg_10_0)
end

function var_0_0.removeEventCb(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.rewardItemList) do
		iter_12_1:onDestroyView()
	end

	arg_12_0.iconClick:RemoveClickListener()

	arg_12_0.rewardItemList = nil

	arg_12_0._simagebg:UnLoadImage()
end

function var_0_0.refreshReward(arg_13_0)
	local var_13_0 = VersionActivityConfig.instance:getAct112Config(arg_13_0.actId)
	local var_13_1 = ActivityModel.instance:getActStartTime(arg_13_0.actId) / 1000
	local var_13_2 = (ServerTime.now() - var_13_1) / 86400
	local var_13_3
	local var_13_4 = PlayerPrefsHelper.getNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, 0)

	if var_13_4 == 0 then
		var_13_4 = var_13_0[1].id

		PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, var_13_4)
	end

	local var_13_5

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_6 = arg_13_0.rewardItemList[iter_13_0]

		if var_13_6 == nil then
			local var_13_7 = gohelper.cloneInPlace(arg_13_0._gorewardItem, "item" .. iter_13_0)

			gohelper.setActive(var_13_7, true)

			var_13_6 = MonoHelper.addLuaComOnceToGo(var_13_7, VersionActivityExchangeItem, arg_13_0)
			arg_13_0.rewardItemList[iter_13_0] = var_13_6

			var_13_6:setSelectFunc(arg_13_0.onSelectItem, arg_13_0)
		end

		if var_13_4 == iter_13_1.id then
			var_13_5 = iter_13_1
		end

		var_13_6:updateItem(iter_13_1, iter_13_0, arg_13_0._firstShow)
		var_13_6:updateSelect(var_13_4)
	end

	arg_13_0._firstShow = false

	if var_13_5 == nil then
		var_13_5 = var_13_0[1]

		local var_13_8 = var_13_0[1].id

		arg_13_0.rewardItemList[1]:updateSelect(var_13_8)
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, var_13_8)
	end

	arg_13_0.selectConfig = var_13_5

	arg_13_0:updateSelectInfo()
end

function var_0_0.updateDeadline(arg_14_0)
	local var_14_0 = ActivityModel.instance:getActivityInfo()[arg_14_0.actId]:getRemainTimeStr2ByEndTime()

	arg_14_0._txtdeadline.text = string.format(luaLang("activity_remain_time"), var_14_0)
end

function var_0_0.updateItemNum(arg_15_0)
	local var_15_0 = ItemModel.instance:getItemQuantity(1, 970002)

	arg_15_0._txthas.text = var_15_0

	local var_15_1 = 0
	local var_15_2 = 0
	local var_15_3 = 0
	local var_15_4 = 0
	local var_15_5 = 0.2
	local var_15_6 = 1 - var_15_5
	local var_15_7 = 0.1

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._needList) do
		if iter_15_1 <= var_15_0 then
			var_15_1 = iter_15_0
			var_15_2 = iter_15_1
			var_15_3 = iter_15_1
		elseif var_15_3 <= var_15_2 then
			var_15_3 = iter_15_1
		end
	end

	if var_15_3 ~= var_15_2 then
		var_15_4 = (var_15_0 - var_15_2) / (var_15_3 - var_15_2)
	end

	if var_15_1 == 0 then
		arg_15_0._slider:SetValue((var_15_7 + 0.3 * var_15_4) / (#arg_15_0._needList - 0.5))
	else
		arg_15_0._slider:SetValue((var_15_1 - 0.5 + var_15_7 + var_15_6 * var_15_4) / (#arg_15_0._needList - 0.5))
	end

	for iter_15_2, iter_15_3 in ipairs(arg_15_0.rewardItemList) do
		iter_15_3:updateNeed()
	end
end

function var_0_0.onSelectItem(arg_16_0, arg_16_1)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.rewardItemList) do
		iter_16_1:updateSelect(arg_16_1.id)
	end

	PlayerPrefsHelper.setNumber(PlayerPrefsKey.VersionActivityExchangeViewSelKey, arg_16_1.id)
	arg_16_0._animator:Play(UIAnimationName.Click, 0, 0)

	arg_16_0.selectConfig = arg_16_1

	TaskDispatcher.cancelTask(arg_16_0.updateSelectInfo, arg_16_0)
	TaskDispatcher.runDelay(arg_16_0.updateSelectInfo, arg_16_0, 0.3)
end

function var_0_0.updateSelectInfo(arg_17_0)
	local var_17_0 = arg_17_0.selectConfig

	arg_17_0.state = VersionActivity112Model.instance:getRewardState(var_17_0.activityId, var_17_0.id)

	if arg_17_0.state == 1 then
		arg_17_0._txttalk1.text = var_17_0.themeDone
		arg_17_0._txttalk2.text = var_17_0.themeDone2
	else
		arg_17_0._txttalk1.text = var_17_0.theme
		arg_17_0._txttalk2.text = var_17_0.theme2
	end

	gohelper.setActive(arg_17_0._gochat, true)
	gohelper.setActive(arg_17_0._goroleimage, false)
	transformhelper.setLocalScale(arg_17_0._gohero1.transform, 1, 1, 1)
	transformhelper.setLocalScale(arg_17_0._gohero2.transform, 1, 1, 1)
	arg_17_0._uiSpine1:setResPath(var_17_0.skin, string.find(var_17_0.skin, "live2d"), arg_17_0._onSpineLoaded1, arg_17_0)
	arg_17_0._uiSpine2:setResPath(var_17_0.skin2, string.find(var_17_0.skin2, "live2d"), arg_17_0._onSpineLoaded2, arg_17_0)
end

function var_0_0._onSpineLoaded1(arg_18_0)
	gohelper.setActive(arg_18_0._goroleimage, true)

	local var_18_0 = string.splitToNumber(arg_18_0.selectConfig.skinOffSet, "#")

	recthelper.setAnchor(arg_18_0._gohero1.transform, var_18_0[1], var_18_0[2])
	transformhelper.setLocalScale(arg_18_0._gohero1.transform, var_18_0[3], var_18_0[3], var_18_0[3])
end

function var_0_0._onSpineLoaded2(arg_19_0)
	gohelper.setActive(arg_19_0._goroleimage, true)

	local var_19_0 = string.splitToNumber(arg_19_0.selectConfig.skin2OffSet, "#")

	recthelper.setAnchor(arg_19_0._gohero2.transform, var_19_0[1], var_19_0[2])
	transformhelper.setLocalScale(arg_19_0._gohero2.transform, var_19_0[3], var_19_0[3], var_19_0[3])
end

return var_0_0
