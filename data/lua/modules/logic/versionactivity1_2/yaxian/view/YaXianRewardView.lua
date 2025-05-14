module("modules.logic.versionactivity1_2.yaxian.view.YaXianRewardView", package.seeall)

local var_0_0 = class("YaXianRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._btncloseview = gohelper.findChildButton(arg_1_0.viewGO, "#btn_closeview")
	arg_1_0._simageblackbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blackbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_tips")
	arg_1_0._txttipsinfo = gohelper.findChildText(arg_1_0.viewGO, "#go_tips/#txt_tipsinfo")
	arg_1_0._scrollreward = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_reward")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_content")
	arg_1_0._gobottom = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom")
	arg_1_0._gograyline = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_grayline")
	arg_1_0._gonormalline = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_normalline")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#scroll_reward/Viewport/#go_content/#go_bottom/#go_arrow")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "#go_target")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "progresstip/#txt_progress")
	arg_1_0._btnclose = gohelper.findChildButton(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseview:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseviewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.initTargetRewardItem(arg_6_0)
	local var_6_0 = arg_6_0:getResInst(arg_6_0.itemPath, arg_6_0.goTargetRewardItemContainer, "item")

	arg_6_0.targetRewardItem = YaXianRewardItem.New(var_6_0)

	arg_6_0.targetRewardItem:init()
	arg_6_0.targetRewardItem:show()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simagebg:LoadImage(ResUrl.getYaXianImage("img_deco_zhizhuwang"))
	arg_7_0._simageblackbg:LoadImage(ResUrl.getYaXianImage("img_tanchuang_bg"))

	arg_7_0.progressIcon = gohelper.findChildImage(arg_7_0.viewGO, "progresstip/icon")

	UISpriteSetMgr.instance:setYaXianSprite(arg_7_0.progressIcon, "icon_zhanluedian_get")

	arg_7_0.goTargetRewardItemContainer = gohelper.findChild(arg_7_0.viewGO, "#go_target/#go_targetRewardItemContainer")
	arg_7_0.contentTransform = arg_7_0._gocontent.transform
	arg_7_0.scrollWidth = recthelper.getWidth(arg_7_0._scrollreward.transform)
	arg_7_0.grayLineTransform = arg_7_0._gograyline.transform
	arg_7_0.normalLineTransform = arg_7_0._gonormalline.transform
	arg_7_0.arrowTransform = arg_7_0._goarrow.transform
	arg_7_0.itemPath = arg_7_0.viewContainer:getSetting().otherRes[1]
	arg_7_0.rewardItemList = {}
	arg_7_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_7_0._scrollreward.gameObject)

	arg_7_0._drag:AddDragBeginListener(arg_7_0._onDragBeginHandler, arg_7_0)
	arg_7_0._drag:AddDragEndListener(arg_7_0._onDragEndHandler, arg_7_0)

	arg_7_0._touch = SLFramework.UGUI.UIClickListener.Get(arg_7_0._scrollreward.gameObject)

	arg_7_0._touch:AddClickDownListener(arg_7_0._onClickDownHandler, arg_7_0)

	arg_7_0._audioScroll = MonoHelper.addLuaComOnceToGo(arg_7_0._scrollreward.gameObject, DungeonMapEpisodeAudio, arg_7_0._scrollreward)

	arg_7_0:initTargetRewardItem()
	arg_7_0._scrollreward:AddOnValueChanged(arg_7_0.onValueChanged, arg_7_0)
end

function var_0_0._onDragBeginHandler(arg_8_0)
	arg_8_0._audioScroll:onDragBegin()
end

function var_0_0._onDragEndHandler(arg_9_0)
	arg_9_0._audioScroll:onDragEnd()
end

function var_0_0._onClickDownHandler(arg_10_0)
	arg_10_0._audioScroll:onClickDown()
end

function var_0_0.onValueChanged(arg_11_0)
	arg_11_0:refreshTargetRewardItem()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._txtprogress.text = YaXianModel.instance:getScore()

	arg_12_0:refreshItems()
	arg_12_0:refreshContentWidth()
	arg_12_0:refreshLineWidthAndArrowAnchor()
	arg_12_0:refreshTargetRewardItem()
	TaskDispatcher.runDelay(arg_12_0.senGetBonusRequest, arg_12_0, 1)
end

function var_0_0.refreshItems(arg_13_0)
	local var_13_0 = lua_activity115_bonus.configList
	local var_13_1
	local var_13_2

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_3 = arg_13_0.rewardItemList[iter_13_0]

		if not var_13_3 then
			local var_13_4 = arg_13_0:getResInst(arg_13_0.itemPath, arg_13_0._gobottom, "item" .. iter_13_1.id)

			var_13_3 = YaXianRewardItem.New(var_13_4)

			var_13_3:init()
			table.insert(arg_13_0.rewardItemList, var_13_3)
		end

		var_13_3:update(iter_13_0, iter_13_1)
	end

	for iter_13_2 = #var_13_0 + 1, #arg_13_0.rewardItemList do
		arg_13_0.rewardItemList[iter_13_2]:hide()
	end
end

function var_0_0.refreshContentWidth(arg_14_0)
	arg_14_0.contentWidth = #lua_activity115_bonus.configList * (YaXianEnum.RewardEnum.RewardItemWidth + YaXianEnum.RewardEnum.IntervalX) + YaXianEnum.RewardEnum.RewardContentOffsetX

	recthelper.setWidth(arg_14_0.contentTransform, arg_14_0.contentWidth)
end

function var_0_0.calculateNormalWidth(arg_15_0)
	arg_15_0.normalLineWidth = 0

	local var_15_0 = YaXianModel.instance:getScore()
	local var_15_1 = false
	local var_15_2 = 0

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.rewardItemList) do
		if var_15_0 < iter_15_1.config.needScore then
			local var_15_3 = arg_15_0.rewardItemList[iter_15_0 - 1]
			local var_15_4 = var_15_3 and var_15_3:getAnchorPosX() or 0
			local var_15_5 = var_15_3 and var_15_3.config.needScore or 0
			local var_15_6 = iter_15_1:getAnchorPosX()

			arg_15_0.normalLineWidth = var_15_4 + (var_15_0 - var_15_5) / (iter_15_1.config.needScore - var_15_5) * (var_15_6 - var_15_4)
			var_15_2 = iter_15_0
			var_15_1 = true

			break
		end
	end

	if not var_15_1 then
		arg_15_0.normalLineWidth = arg_15_0.contentWidth
		var_15_2 = #arg_15_0.rewardItemList
	end

	local var_15_7 = #arg_15_0.rewardItemList - 4

	arg_15_0._scrollreward.horizontalNormalizedPosition = (var_15_2 - 4) / var_15_7
end

function var_0_0.refreshLineWidthAndArrowAnchor(arg_16_0)
	arg_16_0:calculateNormalWidth()
	recthelper.setWidth(arg_16_0.grayLineTransform, arg_16_0.contentWidth)
	recthelper.setWidth(arg_16_0.normalLineTransform, arg_16_0.normalLineWidth)
	recthelper.setAnchorX(arg_16_0.arrowTransform, arg_16_0.normalLineWidth)
end

function var_0_0.refreshTargetRewardItem(arg_17_0)
	local var_17_0 = arg_17_0:getTargetRewardConfig()

	if arg_17_0.targetRewardItem.config and arg_17_0.targetRewardItem.config.id == var_17_0.id then
		return
	end

	arg_17_0.targetRewardItem:updateByTarget(var_17_0)
end

function var_0_0.getTargetRewardConfig(arg_18_0)
	local var_18_0 = -(recthelper.getAnchorX(arg_18_0.contentTransform) - arg_18_0.scrollWidth - YaXianEnum.RewardEnum.HalfRewardItemWidth)

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.rewardItemList) do
		if iter_18_1:isImportItem() and var_18_0 <= iter_18_1:getAnchorPosX() then
			return iter_18_1.config
		end
	end

	for iter_18_2 = #lua_activity115_bonus.configList, 1, -1 do
		local var_18_1 = lua_activity115_bonus.configList[iter_18_2]

		if var_18_1.important ~= 0 then
			return var_18_1
		end
	end
end

function var_0_0.senGetBonusRequest(arg_19_0)
	Activity115Rpc.instance:sendAct115BonusRequest()
end

function var_0_0.onClose(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_insight_close)
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simagebg:UnLoadImage()
	arg_21_0._simageblackbg:UnLoadImage()
	arg_21_0._drag:RemoveDragBeginListener()
	arg_21_0._drag:RemoveDragEndListener()

	arg_21_0._drag = nil

	arg_21_0._touch:RemoveClickDownListener()

	arg_21_0._touch = nil

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.rewardItemList) do
		iter_21_1:onDestroy()
	end

	arg_21_0.targetRewardItem:onDestroy()
	arg_21_0._scrollreward:RemoveOnValueChanged()

	arg_21_0.rewardItemList = nil
end

return var_0_0
