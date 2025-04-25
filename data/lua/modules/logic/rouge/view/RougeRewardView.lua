module("modules.logic.rouge.view.RougeRewardView", package.seeall)

slot0 = class("RougeRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._goRewardNodeContent = gohelper.findChild(slot0.viewGO, "Lv/#scroll_RewardNode/Viewport/content")
	slot0._goRewardNodeScroll = gohelper.findChild(slot0.viewGO, "Lv/#scroll_RewardNode")
	slot0._goRewardNode = gohelper.findChild(slot0.viewGO, "Lv/#scroll_RewardNode/Viewport/content/#go_RewardNode")
	slot0._goRewardLayout = gohelper.findChild(slot0.viewGO, "Left/Reward/Layout/#go_RewardLayout")
	slot0._simageRightBG = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_RightBG")
	slot0._simageRightBGDec = gohelper.findChildSingleImage(slot0.viewGO, "Right/#simage_RightBGDec")
	slot0._goRight = gohelper.findChild(slot0.viewGO, "Right")
	slot0._animator = slot0._goRight:GetComponent(typeof(UnityEngine.Animator))
	slot0._goRewardSign = gohelper.findChild(slot0.viewGO, "Right/RewardSign")
	slot0._goReward = gohelper.findChild(slot0.viewGO, "Right/RewardNode")
	slot0._btnClaim = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_Claim")
	slot0._goClaimBg = gohelper.findChild(slot0.viewGO, "Right/#btn_Claim/ClaimBG")
	slot0._goClaimGreyBg = gohelper.findChild(slot0.viewGO, "Right/#btn_Claim/greybg")
	slot0._goClaimedAll = gohelper.findChild(slot0.viewGO, "#go_ClaimedAll")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "#go_ClaimedAll/#txt_Tips")
	slot0._goHasGet = gohelper.findChild(slot0.viewGO, "Right/#go_hasget")
	slot0._btnPreview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_preview")
	slot0._btnEmpty = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_empty")
	slot0._txtCoin = gohelper.findChildText(slot0.viewGO, "Top/coin/#txt_coin")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "Top/coin/#btn_click")
	slot0._gotoprighttips = gohelper.findChild(slot0.viewGO, "Top/tips")
	slot0._txttoprighttips = gohelper.findChildText(slot0.viewGO, "Top/tips/#txt_tips")
	slot0._goBigRewardList = {}
	slot0._rewardNodeList = {}
	slot0._layoutList = {}
	slot0._startPosY = 12
	slot0._itemHeight = 100
	slot0._itemSpace = 80

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnClaim:AddClickListener(slot0._btnClaimOnClick, slot0)
	slot0._btnPreview:AddClickListener(slot0._btnPreviewOnClick, slot0)
	slot0._btnEmpty:AddClickListener(slot0._btnEmptyOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, slot0.refreshView, slot0)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnClickBigReward, slot0._onClickBigReward, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClaim:RemoveClickListener()
	slot0._btnPreview:RemoveClickListener()
	slot0._btnEmpty:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnUpdateRougeRewardInfo, slot0.refreshView, slot0)
	slot0:removeEventCb(RougeController.instance, RougeEvent.OnClickBigReward, slot0._onClickBigReward, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)

	if slot0._skinClick then
		slot0._skinClick:RemoveClickListener()
	end

	if slot0._rewardClick then
		slot0._rewardClick:RemoveClickListener()
	end

	if slot0._skinClick2 then
		slot0._skinClick2:RemoveClickListener()
	end
end

function slot0._btnClaimOnClick(slot0)
	if RougeRewardModel.instance:checkCanGetBigReward(slot0._currentSelectStage) then
		RougeOutsideRpc.instance:sendRougeReceivePointBonusRequest(RougeOutsideModel.instance:season(), RougeRewardConfig.instance:getBigRewardConfigByStage(slot0._currentSelectStage).id)
	end
end

function slot0._btnclickOnClick(slot0)
	slot0._isopentips = not slot0._isopentips

	gohelper.setActive(slot0._gotoprighttips, slot0._isopentips)
end

function slot0._btnPreviewOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RougeRewardNoticeView)
end

function slot0._btnEmptyOnClick(slot0)
	if #slot0._layoutList <= 0 then
		return
	end

	for slot4, slot5 in ipairs(slot0._layoutList) do
		slot5.comp:hideExchangeBtn()
	end
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._seasonParam = slot0.viewParam and slot0.viewParam.season
	slot0._stageParam = slot0.viewParam and slot0.viewParam.stage
	slot0._season = slot0._seasonParam or RougeOutsideModel.instance:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(slot0._season)
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRewardView)
	RougeOutsideRpc.instance:sendRougeMarkBonusNewStageRequest(slot0._season)
	slot0:_initRewardNode()
	slot0:_initRewardLayout()
	slot0:_initBigReward()

	slot0._txtCoin.text = RougeRewardModel.instance:getRewardPoint()
	slot0._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_rewardview_pointlimit"), {
		RougeRewardModel.instance:getHadGetRewardPoint(),
		RougeRewardConfig.instance:getPointLimitByStage(slot0._season, RougeRewardModel.instance:getLastOpenStage())
	})

	TaskDispatcher.runDelay(slot0._onEnterAnim, slot0, 0.03)
end

function slot0._onEnterAnim(slot0)
	TaskDispatcher.cancelTask(slot0._onEnterAnim, slot0)
	slot0._animator:Update(0)
	slot0._animator:Play("in", 0, 0)
	gohelper.setActive(slot0._goReward, false)
	TaskDispatcher.runDelay(slot0._afterAnim, slot0, 0.05)
end

function slot0._afterAnim(slot0)
	TaskDispatcher.cancelTask(slot0._afterAnim, slot0)
	slot0:refreshView()
end

function slot0._onSwitchAnim(slot0)
	slot0._animator:Update(0)
	slot0._animator:Play("out", 0, 0)
	TaskDispatcher.runDelay(slot0._onEnterAnim, slot0, 0.167)
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		slot2 = RougeRewardConfig.instance:getStageLayoutCount(slot0._currentSelectStage) or 1

		for slot7 = 1, slot0._beforeNum do
			gohelper.setActive(slot0._goSignList[slot7].img, true)
		end

		if slot2 - slot3 - 1 > 0 then
			for slot7 = slot3 + 1, slot2 do
				gohelper.setActive(slot0._goSignList[slot7].img, false)
			end
		end

		for slot7 = 1, slot2 do
			slot8 = slot0._goSignList[slot7]

			gohelper.setActive(slot8.vxlight, slot8.isShowAnim)
		end

		slot4 = RougeRewardModel.instance:checkCanGetBigReward(slot0._currentSelectStage)

		gohelper.setActive(slot0._goClaimBg, slot4)
		gohelper.setActive(slot0._goClaimGreyBg, not slot4)
	end
end

function slot0._initRewardNode(slot0)
	slot0._currentSelectStage = slot0._stageParam or RougeRewardModel.instance:getLastUnlockStage() or 1

	for slot5, slot6 in pairs(RougeRewardConfig.instance:getRewardDict()) do
		if not slot0._rewardNodeList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot8 = gohelper.cloneInPlace(slot0._goRewardNode, "rewardNode" .. slot5)

			gohelper.setActive(slot8, true)

			slot7.go = slot8
			slot7.stage = slot5
			slot7.co = slot6
			slot7.goNoraml = gohelper.findChild(slot8, "#go_RewardNormal")
			slot7.txtNoramlNum = gohelper.findChildText(slot8, "#go_RewardNormal/#txt_Num")
			slot7.goCurrent = gohelper.findChild(slot8, "#go_RewardCurrent")
			slot7.imgCurrent = gohelper.findChildImage(slot8, "#go_RewardCurrent")
			slot7.txtCurrentNum = gohelper.findChildText(slot8, "#go_RewardCurrent/#txt_Num")
			slot7.goLock = gohelper.findChild(slot8, "#go_Locked")
			slot7.goClaimd = gohelper.findChild(slot8, "#go_Claimed")
			slot7.btn = gohelper.findChildButtonWithAudio(slot8, "btn", AudioEnum.UI.RewardCommonClick)

			slot7.btn:AddClickListener(slot0._btnRewardNodeOnClick, slot0, slot7)
			gohelper.setActive(slot8, true)
			table.insert(slot0._rewardNodeList, slot7)
		end

		slot7.txtNoramlNum.text = GameUtil.getRomanNums(slot5)
		slot7.txtCurrentNum.text = GameUtil.getRomanNums(slot5)

		slot0:refreshRewardNode()
	end

	slot2 = slot0._startPosY + slot0._currentSelectStage * slot0._itemHeight + (slot0._currentSelectStage - 1) * slot0._itemSpace
	slot3 = recthelper.getHeight(slot0._goRewardNodeScroll.transform)

	recthelper.setAnchorY(slot0._goRewardNodeContent.transform, Mathf.Clamp(slot2 - slot3, 0, slot2 - slot3))
end

function slot0.refreshRewardNode(slot0)
	slot1 = GameUtil.parseColor("#A6A6A6")
	slot2 = GameUtil.parseColor("#FFFFFF")

	for slot6, slot7 in ipairs(slot0._rewardNodeList) do
		if not slot7 then
			return
		end

		slot8 = slot7.stage == slot0._currentSelectStage

		if not RougeRewardModel.instance:isStageOpen(slot7.stage) then
			gohelper.setActive(slot7.go, false)
		end

		gohelper.setActive(slot7.goLock, not RougeRewardModel.instance:isStageUnLock(slot7.stage))
		gohelper.setActive(slot7.goNoraml, not slot8)
		gohelper.setActive(slot7.goCurrent, slot8)
		gohelper.setActive(slot7.goClaimd, RougeRewardModel.instance:isStageClear(slot7.stage) and not slot8)

		if slot11 and slot8 then
			slot7.imgCurrent.color = slot1
		else
			slot7.imgCurrent.color = slot2
		end
	end
end

function slot0._btnRewardNodeOnClick(slot0, slot1)
	if slot0._currentSelectStage ~= slot1.stage then
		slot0._currentSelectStage = slot1.stage
		slot0._beforeNum = nil

		slot0:_onSwitchAnim()
		slot0:refreshRewardLayout()
	end
end

function slot0._onClickBigReward(slot0, slot1)
	slot0._openStage = RougeRewardModel.instance:checkOpenStage(slot1)

	if slot0._openStage and slot0._openStage ~= slot0._currentSelectStage then
		slot0._currentSelectStage = slot0._openStage
		slot0._beforeNum = nil

		slot0:_onSwitchAnim()
		slot0:refreshRewardLayout()
	end

	slot2 = slot0._startPosY + slot0._openStage * slot0._itemHeight + (slot0._openStage - 1) * slot0._itemSpace
	slot3 = recthelper.getHeight(slot0._goRewardNodeScroll.transform)

	recthelper.setAnchorY(slot0._goRewardNodeContent.transform, Mathf.Clamp(slot2 - slot3, 0, slot2 - slot3))
end

function slot0._initRewardLayout(slot0)
	for slot5 = 1, RougeRewardConfig.instance:getStageLayoutCount(slot0._currentSelectStage) or 1 do
		if not slot0._layoutList[slot5] then
			slot6 = slot0:getUserDataTb_()
			slot6.go = gohelper.cloneInPlace(slot0._goRewardLayout, "rewardLayout" .. slot5)

			gohelper.setActive(slot6.go, true)

			slot6.comp = MonoHelper.addNoUpdateLuaComOnceToGo(slot6.go, RougeRewardLayout)

			table.insert(slot0._layoutList, slot6)
		end

		slot6.comp:initcomp(slot6.go, RougeRewardConfig.instance:getStageToLayourConfig(slot0._currentSelectStage, slot5), slot5, slot0._currentSelectStage)
	end
end

function slot0._initBigReward(slot0)
	slot0:_initRewardSign()
	slot0:_initBigRewardNode()
	slot0:refreshBigReward()
end

function slot0._initRewardSign(slot0)
	slot0._goSignList = slot0:getUserDataTb_()

	for slot6 = 1, slot0._goRewardSign.transform.childCount do
		slot7 = slot0:getUserDataTb_()
		slot8 = slot1:GetChild(slot6 - 1)
		slot9 = gohelper.findChild(slot8.gameObject, "image_SignFG")
		slot10 = gohelper.findChild(slot8.gameObject, "image_SignFG/vx_light")
		slot7.child = slot8
		slot7.img = slot9
		slot7.vxlight = slot10
		slot7.isShowAnim = false

		gohelper.setActive(slot9, false)
		gohelper.setActive(slot10, false)
		table.insert(slot0._goSignList, slot7)
	end
end

function slot0._initBigRewardNode(slot0)
	for slot4 = 1, 5 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "Right/RewardNode/#go_Reward" .. slot4)
		slot5.bg = gohelper.findChildSingleImage(slot5.go, "bg")

		if slot4 == RougeEnum.BigRewardType.Multi then
			slot5.nodeList = {}

			for slot9 = 1, 2 do
				slot10 = {
					go = gohelper.findChild(slot5.go, "reward" .. slot9)
				}
				slot10.simge = gohelper.findChildSingleImage(slot10.go, "img_reward")
				slot10.img = gohelper.findChildImage(slot10.go, "img_reward")
				slot10.txt = gohelper.findChildText(slot10.go, "txt_reward")
				slot10.defultposx, slot10.defultposy = recthelper.getAnchor(slot10.txt.transform)

				table.insert(slot5.nodeList, slot10)
			end
		else
			slot5.name = gohelper.findChildText(slot5.go, "name")
		end

		table.insert(slot0._goBigRewardList, slot5)
	end
end

function slot0.refreshView(slot0)
	slot0:refreshRewardNode()
	slot0:refreshBigReward()
	slot0:refreshRewardLayout()

	slot0._txtCoin.text = RougeRewardModel.instance:getRewardPoint()
	slot0._txttoprighttips.text = GameUtil.getSubPlaceholderLuaLang(luaLang("rouge_rewardview_pointlimit"), {
		RougeRewardModel.instance:getHadGetRewardPoint(),
		RougeRewardConfig.instance:getPointLimitByStage(slot0._season, RougeRewardModel.instance:getLastOpenStage())
	})
	slot5 = RougeRewardModel.instance:isStageUnLock(slot0._currentSelectStage)

	gohelper.setActive(slot0._goClaimedAll, not slot5)

	if not slot5 then
		slot0._txtTips.text = formatLuaLang("rogue_rewardview_block", GameUtil.getRomanNums(RougeRewardConfig.instance:getStageRewardConfigById(slot0._season, slot0._currentSelectStage).preStage))
	end
end

function slot0.refreshRewardLayout(slot0)
	for slot5 = 1, RougeRewardConfig.instance:getStageLayoutCount(slot0._currentSelectStage) or 1 do
		if not slot0._layoutList[slot5] then
			return
		end

		slot6.comp:refreshcomp(RougeRewardConfig.instance:getStageToLayourConfig(slot0._currentSelectStage, slot5))
	end
end

function slot0.refreshBigReward(slot0)
	gohelper.setActive(slot0._goReward, true)

	slot0._showAnim = false
	slot1 = RougeRewardConfig.instance:getCurStageBigRewardConfig(slot0._currentSelectStage)
	slot2 = slot1.rewardType
	slot3 = "reward/" .. slot1.icon

	for slot7, slot8 in ipairs(slot0._goBigRewardList) do
		if slot7 ~= slot2 then
			gohelper.setActive(slot8.go, false)
		end
	end

	if not slot0._goBigRewardList[slot2] then
		return
	end

	gohelper.setActive(slot4.go, true)
	slot4.bg:LoadImage(ResUrl.getRougeIcon(slot3), function ()
		uv0.bg.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	end, slot0)

	if slot2 == RougeEnum.BigRewardType.Multi then
		slot6 = string.split(slot1.value, "|")
		slot7 = string.split(slot1.rewardName, "|")
		slot8 = nil

		if not string.nilorempty(slot1.offset) then
			slot8 = GameUtil.splitString2(slot1.offset, true)
		end

		for slot13, slot14 in ipairs(slot7) do
			slot15 = string.split(slot14, "#")

			table.insert({}, {
				name = slot15[1],
				icon = slot15[2],
				hideConfigIcon = slot15[3],
				hideNumber = slot15[4]
			})
		end

		for slot13, slot14 in ipairs(slot6) do
			slot15 = string.splitToNumber(slot14, "#")
			slot16 = slot15[1]
			slot17 = slot15[2]
			slot18 = slot15[3]
			slot19 = slot4.nodeList[slot13]

			if not slot9[slot13] then
				break
			end

			if slot16 == MaterialEnum.MaterialType.Equip then
				slot21 = false

				if slot9[slot13].icon then
					slot21 = true
				end

				gohelper.setActive(slot19.simge.gameObject, slot21)
				gohelper.setActive(slot19.img.gameObject, slot21)

				if slot21 then
					slot19.simge:LoadImage(ResUrl.getRougeIcon("reward/" .. slot9[slot13].icon))
				end

				if not slot9[slot13].hideNumber and slot18 > 1 then
					slot19.txt.text = slot9[slot13].name .. "×" .. slot18
				else
					slot19.txt.text = slot9[slot13].name
				end
			elseif slot16 == MaterialEnum.MaterialType.Item then
				slot21, slot22 = ItemModel.instance:getItemConfigAndIcon(slot16, slot17, true)
				slot23 = false

				if not string.nilorempty(slot9[slot13].icon) or not slot9[slot13].hideConfigIcon then
					slot23 = true
				end

				gohelper.setActive(slot19.simge.gameObject, slot23)
				gohelper.setActive(slot19.img.gameObject, slot23)

				if not string.nilorempty(slot9[slot13].icon) then
					slot19.simge:LoadImage(slot9[slot13].icon)
				elseif not slot9[slot13].hideConfigIcon then
					slot19.simge:LoadImage(slot22)
				end

				if not slot9[slot13].hideNumber and slot18 > 1 then
					slot19.txt.text = slot9[slot13].name .. "×" .. slot18
				else
					slot19.txt.text = slot9[slot13].name
				end
			end

			if slot8 and #slot8 > 0 then
				slot21 = slot8[slot13]

				recthelper.setAnchor(slot19.txt.transform, slot21[1], slot21[2])
			else
				recthelper.setAnchor(slot19.txt.transform, slot19.defultposx, slot19.defultposy)
			end
		end
	else
		slot4.name.text = slot1.rewardName

		gohelper.setActive(slot4.bg.gameObject, true)

		slot4.click = gohelper.getClick(slot4.bg.gameObject)

		if slot4.click then
			slot4.click:RemoveClickListener()
		end

		slot6 = nil

		if slot2 == RougeEnum.BigRewardType.Role then
			slot9 = SummonConfig.instance:getSummonDetailIdByHeroId(string.splitToNumber(slot1.value, "#")[2])

			slot4.click:AddClickListener(function ()
				ViewMgr.instance:openView(ViewName.SummonHeroDetailView, {
					id = uv0,
					heroId = uv1
				})
				AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
			end, slot0)
		elseif slot2 == RougeEnum.BigRewardType.Skin then
			if slot1.offset then
				slot7 = string.splitToNumber(slot1.offset, "#")

				recthelper.setAnchor(slot4.name.transform, slot7[1], slot7[2])
			end
		elseif slot0._currentSelectStage == 2 then
			slot4.click:AddClickListener(slot0._onClickRewardIcon, slot0)
		end
	end

	slot7 = RougeRewardConfig.instance:getStageLayoutCount(slot0._currentSelectStage) or 1
	slot8 = nil

	if not slot0._beforeNum then
		slot0._beforeNum = RougeRewardModel.instance:getLastRewardCounter(slot0._currentSelectStage) or 0
	elseif slot0._beforeNum and slot0._beforeNum < slot6 then
		for slot12 = 1, slot6 - slot0._beforeNum do
			slot0._goSignList[slot0._beforeNum + slot12].isShowAnim = true
		end

		slot0._beforeNum = slot6
		slot0._showAnim = true
	else
		for slot12 = 1, slot7 do
			slot0._goSignList[slot12].isShowAnim = false
		end
	end

	if slot6 > 0 then
		for slot12 = 1, slot6 do
			if not slot0._goSignList[slot12].isShowAnim then
				gohelper.setActive(slot13.img, true)
			end
		end

		if slot7 - slot6 - 1 >= 0 then
			for slot12 = slot6 + 1, slot7 do
				gohelper.setActive(slot0._goSignList[slot12].img, false)
			end
		end
	else
		for slot12 = 1, slot7 do
			gohelper.setActive(slot0._goSignList[slot12].img, false)
		end
	end

	if not slot0._showAnim then
		slot9 = RougeRewardModel.instance:checkCanGetBigReward(slot0._currentSelectStage)

		gohelper.setActive(slot0._goClaimBg, slot9)
		gohelper.setActive(slot0._goClaimGreyBg, not slot9)
	end

	slot9 = RougeRewardModel.instance:isStageClear(slot0._currentSelectStage)

	gohelper.setActive(slot0._btnClaim.gameObject, not slot9)
	gohelper.setActive(slot0._goHasGet, slot9)
end

function slot0._onClickRewardIcon(slot0)
	if RougeRewardConfig.instance:getCurStageBigRewardConfig(slot0._currentSelectStage).rewardType == RougeEnum.BigRewardType.RoomItem then
		ViewMgr.instance:openView(ViewName.RougerewardThemeTipView, slot1)
		AudioMgr.instance:trigger(AudioEnum.UI.RewardCommonClick)
	end
end

function slot0.onClose(slot0)
	for slot4, slot5 in ipairs(slot0._rewardNodeList) do
		slot5.btn:RemoveClickListener()
	end

	for slot4, slot5 in ipairs(slot0._goBigRewardList) do
		if slot5.click then
			slot5.click:RemoveClickListener()
		end
	end

	TaskDispatcher.cancelTask(slot0._onEnterAnim, slot0)
	TaskDispatcher.cancelTask(slot0._afterAnim, slot0)
	TaskDispatcher.cancelTask(slot0._onSwitchAnim, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
