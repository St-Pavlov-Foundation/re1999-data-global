module("modules.logic.rouge.view.RougeRewardView", package.seeall)

local var_0_0 = class("RougeRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._goRewardNodeContent = gohelper.findChild(arg_1_0.viewGO, "Lv/#scroll_RewardNode/Viewport/content")
	arg_1_0._goRewardNodeScroll = gohelper.findChild(arg_1_0.viewGO, "Lv/#scroll_RewardNode")
	arg_1_0._goRewardNode = gohelper.findChild(arg_1_0.viewGO, "Lv/#scroll_RewardNode/Viewport/content/#go_RewardNode")
	arg_1_0._goRewardLayout = gohelper.findChild(arg_1_0.viewGO, "Left/Reward/Layout/#go_RewardLayout")
	arg_1_0._simageRightBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_RightBG")
	arg_1_0._simageRightBGDec = gohelper.findChildSingleImage(arg_1_0.viewGO, "Right/#simage_RightBGDec")
	arg_1_0._goRight = gohelper.findChild(arg_1_0.viewGO, "Right")
	arg_1_0._animator = arg_1_0._goRight:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._goRewardSign = gohelper.findChild(arg_1_0.viewGO, "Right/RewardSign")
	arg_1_0._goReward = gohelper.findChild(arg_1_0.viewGO, "Right/RewardNode")
	arg_1_0._btnClaim = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_Claim")
	arg_1_0._goClaimBg = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Claim/ClaimBG")
	arg_1_0._goClaimGreyBg = gohelper.findChild(arg_1_0.viewGO, "Right/#btn_Claim/greybg")
	arg_1_0._goClaimedAll = gohelper.findChild(arg_1_0.viewGO, "#go_ClaimedAll")
	arg_1_0._txtTips = gohelper.findChildText(arg_1_0.viewGO, "#go_ClaimedAll/#txt_Tips")
	arg_1_0._goHasGet = gohelper.findChild(arg_1_0.viewGO, "Right/#go_hasget")
	arg_1_0._btnPreview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_preview")
	arg_1_0._btnEmpty = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_empty")
	arg_1_0._txtCoin = gohelper.findChildText(arg_1_0.viewGO, "Top/coin/#txt_coin")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Top/coin/#btn_click")
	arg_1_0._gotoprighttips = gohelper.findChild(arg_1_0.viewGO, "Top/tips")
	arg_1_0._txttoprighttips = gohelper.findChildText(arg_1_0.viewGO, "Top/tips/#txt_tips")
	arg_1_0._goBigRewardList = {}
	arg_1_0._rewardNodeList = {}
	arg_1_0._layoutList = {}
	arg_1_0._startPosY = 12
	arg_1_0._itemHeight = 100
	arg_1_0._itemSpace = 80

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClaim:AddClickListener(arg_2_0._btnClaimOnClick, arg_2_0)
	arg_2_0._btnPreview:AddClickListener(arg_2_0._btnPreviewOnClick, arg_2_0)
	arg_2_0._btnEmpty:AddClickListener(arg_2_0._btnEmptyOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_2_0.refreshView, arg_2_0)
	arg_2_0:addEventCb(RougeController.instance, RougeEvent.OnClickBigReward, arg_2_0._onClickBigReward, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClaim:RemoveClickListener()
	arg_3_0._btnPreview:RemoveClickListener()
	arg_3_0._btnEmpty:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, arg_3_0.refreshView, arg_3_0)
	arg_3_0:removeEventCb(RougeController.instance, RougeEvent.OnClickBigReward, arg_3_0._onClickBigReward, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)

	if arg_3_0._skinClick then
		arg_3_0._skinClick:RemoveClickListener()
	end

	if arg_3_0._rewardClick then
		arg_3_0._rewardClick:RemoveClickListener()
	end

	if arg_3_0._skinClick2 then
		arg_3_0._skinClick2:RemoveClickListener()
	end
end

function var_0_0._btnClaimOnClick(arg_4_0)
	if RougeRewardModel.instance:checkCanGetBigReward(arg_4_0._currentSelectStage) then
		local var_4_0 = RougeRewardConfig.instance:getBigRewardConfigByStage(arg_4_0._currentSelectStage)
		local var_4_1 = RougeOutsideModel.instance:season()

		RougeOutsideRpc.instance:sendRougeReceivePointBonusRequest(var_4_1, var_4_0.id)
	end
end

function var_0_0._btnclickOnClick(arg_5_0)
	arg_5_0._isopentips = not arg_5_0._isopentips

	gohelper.setActive(arg_5_0._gotoprighttips, arg_5_0._isopentips)
end

function var_0_0._btnPreviewOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.RougeRewardNoticeView)
end

function var_0_0._btnEmptyOnClick(arg_7_0)
	if #arg_7_0._layoutList <= 0 then
		return
	end

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._layoutList) do
		iter_7_1.comp:hideExchangeBtn()
	end
end

function var_0_0._editableInitView(arg_8_0)
	return
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0._seasonParam = arg_10_0.viewParam and arg_10_0.viewParam.season
	arg_10_0._stageParam = arg_10_0.viewParam and arg_10_0.viewParam.stage
	arg_10_0._season = arg_10_0._seasonParam or RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(arg_10_0._season)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardView)
	RougeOutsideRpc.instance:sendRougeMarkBonusNewStageRequest(arg_10_0._season)
	arg_10_0:_initRewardNode()
	arg_10_0:_initRewardLayout()
	arg_10_0:_initBigReward()

	arg_10_0._txtCoin.text = RougeRewardModel.instance:getRewardPoint()

	local var_10_0 = RougeRewardModel.instance:getLastOpenStage()
	local var_10_1 = RougeRewardConfig.instance:getPointLimitByStage(arg_10_0._season, var_10_0)
	local var_10_2 = RougeRewardModel.instance:getHadGetRewardPoint()
	local var_10_3 = {
		var_10_2,
		var_10_1
	}

	arg_10_0._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_rewardview_pointlimit"), var_10_3)

	local var_10_4 = 0.03

	TaskDispatcher.runDelay(arg_10_0._onEnterAnim, arg_10_0, var_10_4)
end

function var_0_0._onEnterAnim(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onEnterAnim, arg_11_0)
	arg_11_0._animator:Update(0)
	arg_11_0._animator:Play("in", 0, 0)
	gohelper.setActive(arg_11_0._goReward, false)

	local var_11_0 = 0.05

	TaskDispatcher.runDelay(arg_11_0._afterAnim, arg_11_0, var_11_0)
end

function var_0_0._afterAnim(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._afterAnim, arg_12_0)
	arg_12_0:refreshView()
end

function var_0_0._onSwitchAnim(arg_13_0)
	arg_13_0._animator:Update(0)
	arg_13_0._animator:Play("out", 0, 0)

	local var_13_0 = 0.167

	TaskDispatcher.runDelay(arg_13_0._onEnterAnim, arg_13_0, var_13_0)
end

function var_0_0._onCloseViewFinish(arg_14_0, arg_14_1)
	if arg_14_1 == ViewName.CommonPropView then
		local var_14_0 = RougeRewardConfig.instance:getStageLayoutCount(arg_14_0._currentSelectStage) or 1
		local var_14_1 = arg_14_0._beforeNum

		for iter_14_0 = 1, var_14_1 do
			local var_14_2 = arg_14_0._goSignList[iter_14_0]

			gohelper.setActive(var_14_2.img, true)
		end

		if var_14_0 - var_14_1 - 1 > 0 then
			for iter_14_1 = var_14_1 + 1, var_14_0 do
				gohelper.setActive(arg_14_0._goSignList[iter_14_1].img, false)
			end
		end

		for iter_14_2 = 1, var_14_0 do
			local var_14_3 = arg_14_0._goSignList[iter_14_2]

			gohelper.setActive(var_14_3.vxlight, var_14_3.isShowAnim)
		end

		local var_14_4 = RougeRewardModel.instance:checkCanGetBigReward(arg_14_0._currentSelectStage)

		gohelper.setActive(arg_14_0._goClaimBg, var_14_4)
		gohelper.setActive(arg_14_0._goClaimGreyBg, not var_14_4)
	end
end

function var_0_0._initRewardNode(arg_15_0)
	arg_15_0._currentSelectStage = arg_15_0._stageParam or RougeRewardModel.instance:getLastUnlockStage() or 1

	local var_15_0 = RougeRewardConfig.instance:getRewardDict()

	for iter_15_0, iter_15_1 in pairs(var_15_0) do
		local var_15_1 = arg_15_0._rewardNodeList[iter_15_0]

		if not var_15_1 then
			var_15_1 = arg_15_0:getUserDataTb_()

			local var_15_2 = gohelper.cloneInPlace(arg_15_0._goRewardNode, "rewardNode" .. iter_15_0)

			gohelper.setActive(var_15_2, true)

			var_15_1.go = var_15_2
			var_15_1.stage = iter_15_0
			var_15_1.co = iter_15_1
			var_15_1.goNoraml = gohelper.findChild(var_15_2, "#go_RewardNormal")
			var_15_1.txtNoramlNum = gohelper.findChildText(var_15_2, "#go_RewardNormal/#txt_Num")
			var_15_1.goCurrent = gohelper.findChild(var_15_2, "#go_RewardCurrent")
			var_15_1.imgCurrent = gohelper.findChildImage(var_15_2, "#go_RewardCurrent")
			var_15_1.txtCurrentNum = gohelper.findChildText(var_15_2, "#go_RewardCurrent/#txt_Num")
			var_15_1.goLock = gohelper.findChild(var_15_2, "#go_Locked")
			var_15_1.goClaimd = gohelper.findChild(var_15_2, "#go_Claimed")
			var_15_1.btn = gohelper.findChildButtonWithAudio(var_15_2, "btn", AudioEnum.UI.RewardCommonClick)

			var_15_1.btn:AddClickListener(arg_15_0._btnRewardNodeOnClick, arg_15_0, var_15_1)
			gohelper.setActive(var_15_2, true)
			table.insert(arg_15_0._rewardNodeList, var_15_1)
		end

		var_15_1.txtNoramlNum.text = GameUtil.getRomanNums(iter_15_0)
		var_15_1.txtCurrentNum.text = GameUtil.getRomanNums(iter_15_0)

		arg_15_0:refreshRewardNode()
	end

	local var_15_3 = arg_15_0._startPosY + arg_15_0._currentSelectStage * arg_15_0._itemHeight + (arg_15_0._currentSelectStage - 1) * arg_15_0._itemSpace
	local var_15_4 = recthelper.getHeight(arg_15_0._goRewardNodeScroll.transform)
	local var_15_5 = Mathf.Clamp(var_15_3 - var_15_4, 0, var_15_3 - var_15_4)
	local var_15_6 = arg_15_0._goRewardNodeContent.transform

	recthelper.setAnchorY(var_15_6, var_15_5)
end

function var_0_0.refreshRewardNode(arg_16_0)
	local var_16_0 = GameUtil.parseColor("#A6A6A6")
	local var_16_1 = GameUtil.parseColor("#FFFFFF")

	for iter_16_0, iter_16_1 in ipairs(arg_16_0._rewardNodeList) do
		if not iter_16_1 then
			return
		end

		local var_16_2 = iter_16_1.stage == arg_16_0._currentSelectStage

		if not RougeRewardModel.instance:isStageOpen(iter_16_1.stage) then
			gohelper.setActive(iter_16_1.go, false)
		end

		local var_16_3 = RougeRewardModel.instance:isStageUnLock(iter_16_1.stage)
		local var_16_4 = RougeRewardModel.instance:isStageClear(iter_16_1.stage)

		gohelper.setActive(iter_16_1.goLock, not var_16_3)
		gohelper.setActive(iter_16_1.goNoraml, not var_16_2)
		gohelper.setActive(iter_16_1.goCurrent, var_16_2)
		gohelper.setActive(iter_16_1.goClaimd, var_16_4 and not var_16_2)

		if var_16_4 and var_16_2 then
			iter_16_1.imgCurrent.color = var_16_0
		else
			iter_16_1.imgCurrent.color = var_16_1
		end
	end
end

function var_0_0._btnRewardNodeOnClick(arg_17_0, arg_17_1)
	if arg_17_0._currentSelectStage ~= arg_17_1.stage then
		arg_17_0._currentSelectStage = arg_17_1.stage
		arg_17_0._beforeNum = nil

		arg_17_0:_onSwitchAnim()
		arg_17_0:refreshRewardLayout()
	end
end

function var_0_0._onClickBigReward(arg_18_0, arg_18_1)
	arg_18_0._openStage = RougeRewardModel.instance:checkOpenStage(arg_18_1)

	if arg_18_0._openStage and arg_18_0._openStage ~= arg_18_0._currentSelectStage then
		arg_18_0._currentSelectStage = arg_18_0._openStage
		arg_18_0._beforeNum = nil

		arg_18_0:_onSwitchAnim()
		arg_18_0:refreshRewardLayout()
	end

	local var_18_0 = arg_18_0._startPosY + arg_18_0._openStage * arg_18_0._itemHeight + (arg_18_0._openStage - 1) * arg_18_0._itemSpace
	local var_18_1 = recthelper.getHeight(arg_18_0._goRewardNodeScroll.transform)
	local var_18_2 = Mathf.Clamp(var_18_0 - var_18_1, 0, var_18_0 - var_18_1)
	local var_18_3 = arg_18_0._goRewardNodeContent.transform

	recthelper.setAnchorY(var_18_3, var_18_2)
end

function var_0_0._initRewardLayout(arg_19_0)
	local var_19_0 = RougeRewardConfig.instance:getStageLayoutCount(arg_19_0._currentSelectStage) or 1

	for iter_19_0 = 1, var_19_0 do
		local var_19_1 = arg_19_0._layoutList[iter_19_0]

		if not var_19_1 then
			var_19_1 = arg_19_0:getUserDataTb_()
			var_19_1.go = gohelper.cloneInPlace(arg_19_0._goRewardLayout, "rewardLayout" .. iter_19_0)

			gohelper.setActive(var_19_1.go, true)

			var_19_1.comp = MonoHelper.addNoUpdateLuaComOnceToGo(var_19_1.go, RougeRewardLayout)

			table.insert(arg_19_0._layoutList, var_19_1)
		end

		local var_19_2 = RougeRewardConfig.instance:getStageToLayourConfig(arg_19_0._currentSelectStage, iter_19_0)

		var_19_1.comp:initcomp(var_19_1.go, var_19_2, iter_19_0, arg_19_0._currentSelectStage)
	end
end

function var_0_0._initBigReward(arg_20_0)
	arg_20_0:_initRewardSign()
	arg_20_0:_initBigRewardNode()
	arg_20_0:refreshBigReward()
end

function var_0_0._initRewardSign(arg_21_0)
	arg_21_0._goSignList = arg_21_0:getUserDataTb_()

	local var_21_0 = arg_21_0._goRewardSign.transform
	local var_21_1 = var_21_0.childCount

	for iter_21_0 = 1, var_21_1 do
		local var_21_2 = arg_21_0:getUserDataTb_()
		local var_21_3 = var_21_0:GetChild(iter_21_0 - 1)
		local var_21_4 = gohelper.findChild(var_21_3.gameObject, "image_SignFG")
		local var_21_5 = gohelper.findChild(var_21_3.gameObject, "image_SignFG/vx_light")

		var_21_2.child = var_21_3
		var_21_2.img = var_21_4
		var_21_2.vxlight = var_21_5
		var_21_2.isShowAnim = false

		gohelper.setActive(var_21_4, false)
		gohelper.setActive(var_21_5, false)
		table.insert(arg_21_0._goSignList, var_21_2)
	end
end

function var_0_0._initBigRewardNode(arg_22_0)
	for iter_22_0 = 1, 6 do
		local var_22_0 = arg_22_0:getUserDataTb_()

		var_22_0.go = gohelper.findChild(arg_22_0.viewGO, "Right/RewardNode/#go_Reward" .. iter_22_0)
		var_22_0.bg = gohelper.findChildSingleImage(var_22_0.go, "bg")

		if iter_22_0 == RougeEnum.BigRewardType.Double or iter_22_0 == RougeEnum.BigRewardType.Triple then
			local var_22_1 = iter_22_0 == RougeEnum.BigRewardType.Double and 2 or 3

			var_22_0.nodeList = {}

			for iter_22_1 = 1, var_22_1 do
				local var_22_2 = {
					go = gohelper.findChild(var_22_0.go, "reward" .. iter_22_1)
				}

				var_22_2.simge = gohelper.findChildSingleImage(var_22_2.go, "img_reward")
				var_22_2.img = gohelper.findChildImage(var_22_2.go, "img_reward")
				var_22_2.txt = gohelper.findChildText(var_22_2.go, "txt_reward")
				var_22_2.defultposx, var_22_2.defultposy = recthelper.getAnchor(var_22_2.txt.transform)

				table.insert(var_22_0.nodeList, var_22_2)
			end
		else
			var_22_0.name = gohelper.findChildText(var_22_0.go, "name")
		end

		table.insert(arg_22_0._goBigRewardList, var_22_0)
	end
end

function var_0_0.refreshView(arg_23_0)
	arg_23_0:refreshRewardNode()
	arg_23_0:refreshBigReward()
	arg_23_0:refreshRewardLayout()

	arg_23_0._txtCoin.text = RougeRewardModel.instance:getRewardPoint()

	local var_23_0 = RougeRewardModel.instance:getLastOpenStage()
	local var_23_1 = RougeRewardConfig.instance:getPointLimitByStage(arg_23_0._season, var_23_0)
	local var_23_2 = RougeRewardModel.instance:getHadGetRewardPoint()
	local var_23_3 = {
		var_23_2,
		var_23_1
	}

	arg_23_0._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_rewardview_pointlimit"), var_23_3)

	local var_23_4 = RougeRewardModel.instance:isStageUnLock(arg_23_0._currentSelectStage)

	gohelper.setActive(arg_23_0._goClaimedAll, not var_23_4)

	if not var_23_4 then
		local var_23_5 = RougeRewardConfig.instance:getStageRewardConfigById(arg_23_0._season, arg_23_0._currentSelectStage).preStage

		arg_23_0._txtTips.text = formatLuaLang("rogue_rewardview_block", GameUtil.getRomanNums(var_23_5))
	end
end

function var_0_0.refreshRewardLayout(arg_24_0)
	local var_24_0 = RougeRewardConfig.instance:getStageLayoutCount(arg_24_0._currentSelectStage) or 1

	for iter_24_0 = 1, var_24_0 do
		local var_24_1 = arg_24_0._layoutList[iter_24_0]

		if not var_24_1 then
			return
		end

		local var_24_2 = RougeRewardConfig.instance:getStageToLayourConfig(arg_24_0._currentSelectStage, iter_24_0)

		var_24_1.comp:refreshcomp(var_24_2)
	end
end

function var_0_0.refreshBigReward(arg_25_0)
	gohelper.setActive(arg_25_0._goReward, true)

	arg_25_0._showAnim = false

	local var_25_0 = RougeRewardConfig.instance:getCurStageBigRewardConfig(arg_25_0._currentSelectStage)
	local var_25_1 = var_25_0.rewardType
	local var_25_2 = "reward/" .. var_25_0.icon

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._goBigRewardList) do
		if iter_25_0 ~= var_25_1 then
			gohelper.setActive(iter_25_1.go, false)
		end
	end

	local var_25_3 = arg_25_0._goBigRewardList[var_25_1]

	if not var_25_3 then
		return
	end

	gohelper.setActive(var_25_3.go, true)

	local function var_25_4()
		var_25_3.bg.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	end

	var_25_3.bg:LoadImage(ResUrl.getRougeIcon(var_25_2), var_25_4, arg_25_0)

	if var_25_1 == RougeEnum.BigRewardType.Double or var_25_1 == RougeEnum.BigRewardType.Triple then
		local var_25_5 = string.split(var_25_0.value, "|")
		local var_25_6 = string.split(var_25_0.rewardName, "|")
		local var_25_7

		if not string.nilorempty(var_25_0.offset) then
			var_25_7 = GameUtil.splitString2(var_25_0.offset, true)
		end

		local var_25_8 = {}

		for iter_25_2, iter_25_3 in ipairs(var_25_6) do
			local var_25_9 = string.split(iter_25_3, "#")
			local var_25_10 = {
				name = var_25_9[1],
				icon = var_25_9[2],
				hideConfigIcon = var_25_9[3],
				hideNumber = var_25_9[4]
			}

			table.insert(var_25_8, var_25_10)
		end

		for iter_25_4, iter_25_5 in ipairs(var_25_5) do
			local var_25_11 = string.splitToNumber(iter_25_5, "#")
			local var_25_12 = var_25_11[1]
			local var_25_13 = var_25_11[2]
			local var_25_14 = var_25_11[3]
			local var_25_15 = var_25_3.nodeList[iter_25_4]

			if not var_25_8[iter_25_4] then
				break
			end

			if var_25_12 == MaterialEnum.MaterialType.Equip then
				local var_25_16 = false

				if not string.nilorempty(var_25_8[iter_25_4].icon) then
					var_25_16 = true
				end

				gohelper.setActive(var_25_15.simge.gameObject, var_25_16)
				gohelper.setActive(var_25_15.img.gameObject, var_25_16)

				if var_25_16 then
					var_25_15.simge:LoadImage(ResUrl.getRougeIcon("reward/" .. var_25_8[iter_25_4].icon))
				end

				if not var_25_8[iter_25_4].hideNumber and var_25_14 > 1 then
					var_25_15.txt.text = var_25_8[iter_25_4].name .. "×" .. var_25_14
				else
					var_25_15.txt.text = var_25_8[iter_25_4].name
				end
			elseif var_25_12 == MaterialEnum.MaterialType.Item then
				local var_25_17, var_25_18 = ItemModel.instance:getItemConfigAndIcon(var_25_12, var_25_13, true)
				local var_25_19 = false

				if not string.nilorempty(var_25_8[iter_25_4].icon) or not var_25_8[iter_25_4].hideConfigIcon then
					var_25_19 = true
				end

				gohelper.setActive(var_25_15.simge.gameObject, var_25_19)
				gohelper.setActive(var_25_15.img.gameObject, var_25_19)

				if not string.nilorempty(var_25_8[iter_25_4].icon) then
					var_25_15.simge:LoadImage(var_25_8[iter_25_4].icon)
				elseif not var_25_8[iter_25_4].hideConfigIcon then
					var_25_15.simge:LoadImage(var_25_18)
				end

				if not var_25_8[iter_25_4].hideNumber and var_25_14 > 1 then
					var_25_15.txt.text = var_25_8[iter_25_4].name .. "×" .. var_25_14
				else
					var_25_15.txt.text = var_25_8[iter_25_4].name
				end
			end

			if var_25_7 and #var_25_7 > 0 then
				local var_25_20 = var_25_7[iter_25_4]

				recthelper.setAnchor(var_25_15.txt.transform, var_25_20[1], var_25_20[2])
			else
				recthelper.setAnchor(var_25_15.txt.transform, var_25_15.defultposx, var_25_15.defultposy)
			end
		end
	else
		var_25_3.name.text = var_25_0.rewardName

		gohelper.setActive(var_25_3.bg.gameObject, true)

		var_25_3.click = gohelper.getClick(var_25_3.bg.gameObject)

		if var_25_3.click then
			var_25_3.click:RemoveClickListener()
		end

		local var_25_21

		if var_25_1 == RougeEnum.BigRewardType.Role then
			local var_25_22 = string.splitToNumber(var_25_0.value, "#")[2]
			local var_25_23 = SummonConfig.instance:getSummonDetailIdByHeroId(var_25_22)

			local function var_25_24()
				ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
					id = var_25_23,
					heroId = var_25_22
				})
				AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
			end

			var_25_3.click:AddClickListener(var_25_24, arg_25_0)
		elseif var_25_1 == RougeEnum.BigRewardType.Skin then
			if var_25_0.offset then
				local var_25_25 = string.splitToNumber(var_25_0.offset, "#")

				recthelper.setAnchor(var_25_3.name.transform, var_25_25[1], var_25_25[2])
			end
		elseif arg_25_0._currentSelectStage == 2 then
			var_25_3.click:AddClickListener(arg_25_0._onClickRewardIcon, arg_25_0)
		end
	end

	local var_25_26 = RougeRewardModel.instance:getLastRewardCounter(arg_25_0._currentSelectStage) or 0
	local var_25_27 = RougeRewardConfig.instance:getStageLayoutCount(arg_25_0._currentSelectStage) or 1
	local var_25_28

	if not arg_25_0._beforeNum then
		arg_25_0._beforeNum = var_25_26
	elseif arg_25_0._beforeNum and var_25_26 > arg_25_0._beforeNum then
		local var_25_29 = var_25_26 - arg_25_0._beforeNum

		for iter_25_6 = 1, var_25_29 do
			local var_25_30 = arg_25_0._beforeNum + iter_25_6

			arg_25_0._goSignList[var_25_30].isShowAnim = true
		end

		arg_25_0._beforeNum = var_25_26
		arg_25_0._showAnim = true
	else
		for iter_25_7 = 1, var_25_27 do
			arg_25_0._goSignList[iter_25_7].isShowAnim = false
		end
	end

	if var_25_26 > 0 then
		for iter_25_8 = 1, var_25_26 do
			local var_25_31 = arg_25_0._goSignList[iter_25_8]

			if not var_25_31.isShowAnim then
				gohelper.setActive(var_25_31.img, true)
			end
		end

		if var_25_27 - var_25_26 - 1 >= 0 then
			for iter_25_9 = var_25_26 + 1, var_25_27 do
				gohelper.setActive(arg_25_0._goSignList[iter_25_9].img, false)
			end
		end
	else
		for iter_25_10 = 1, var_25_27 do
			gohelper.setActive(arg_25_0._goSignList[iter_25_10].img, false)
		end
	end

	if not arg_25_0._showAnim then
		local var_25_32 = RougeRewardModel.instance:checkCanGetBigReward(arg_25_0._currentSelectStage)

		gohelper.setActive(arg_25_0._goClaimBg, var_25_32)
		gohelper.setActive(arg_25_0._goClaimGreyBg, not var_25_32)
	end

	local var_25_33 = RougeRewardModel.instance:isStageClear(arg_25_0._currentSelectStage)

	gohelper.setActive(arg_25_0._btnClaim.gameObject, not var_25_33)
	gohelper.setActive(arg_25_0._goHasGet, var_25_33)
end

function var_0_0._onClickRewardIcon(arg_28_0)
	local var_28_0 = RougeRewardConfig.instance:getCurStageBigRewardConfig(arg_28_0._currentSelectStage)

	if var_28_0.rewardType == RougeEnum.BigRewardType.RoomItem then
		ViewMgr.instance:openView(ViewName.RougerewardThemeTipView, var_28_0)
		AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
	end
end

function var_0_0.onClose(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0._rewardNodeList) do
		iter_29_1.btn:RemoveClickListener()
	end

	for iter_29_2, iter_29_3 in ipairs(arg_29_0._goBigRewardList) do
		if iter_29_3.click then
			iter_29_3.click:RemoveClickListener()
		end
	end

	TaskDispatcher.cancelTask(arg_29_0._onEnterAnim, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._afterAnim, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._onSwitchAnim, arg_29_0)
end

function var_0_0.onDestroyView(arg_30_0)
	return
end

return var_0_0
