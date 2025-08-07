module("modules.logic.bossrush.view.v2a9.V2a9_BossRushLevelDetail", package.seeall)

local var_0_0 = class("V2a9_BossRushLevelDetail", V1a4_BossRushLevelDetail)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefull = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_full")
	arg_1_0._gospines = gohelper.findChild(arg_1_0.viewGO, "#go_spines")
	arg_1_0._goAssassinNormalMask = gohelper.findChild(arg_1_0.viewGO, "BG/#go_AssassinNormalMask")
	arg_1_0._goAssassinHardMask = gohelper.findChild(arg_1_0.viewGO, "BG/#go_AssassinHardMask")
	arg_1_0._goNormalMask = gohelper.findChild(arg_1_0.viewGO, "BG/#go_NormalMask")
	arg_1_0._goHardMask = gohelper.findChild(arg_1_0.viewGO, "BG/#go_HardMask")
	arg_1_0._goHardBG = gohelper.findChild(arg_1_0.viewGO, "BG/#go_HardBG")
	arg_1_0._simageLeftBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "BG/#go_HardBG/#simage_LeftBG")
	arg_1_0._simageRightBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "BG/#go_HardBG/#simage_RightBG")
	arg_1_0._btnSimple = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Simple")
	arg_1_0._btnHard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_Hard")
	arg_1_0._btnAssassinSimple = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_AssassinSimple")
	arg_1_0._btnAssassinHard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_AssassinHard")
	arg_1_0._btnbonus = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_bonus")
	arg_1_0._imageSliderFG = gohelper.findChildImage(arg_1_0.viewGO, "Left/#btn_bonus/image_SliderBG/#image_SliderFG")
	arg_1_0._goAssessIcon = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_bonus/#go_AssessIcon")
	arg_1_0._goRedPoint1 = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_bonus/#go_RedPoint1")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/Title/#txt_Title")
	arg_1_0._simageTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "DetailPanel/Title/#txt_Title/#simage_Title")
	arg_1_0._imageIssxIcon = gohelper.findChildImage(arg_1_0.viewGO, "DetailPanel/Title/#txt_Title/#image_IssxIcon")
	arg_1_0._btnSearchIcon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "DetailPanel/Title/#txt_Title/#btn_SearchIcon")
	arg_1_0._scrolldesc = gohelper.findChildScrollRect(arg_1_0.viewGO, "DetailPanel/#scroll_desc")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/#scroll_desc/Viewport/#txt_Descr")
	arg_1_0._txtLvNum = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/Attention/Lv/#txt_LvNum")
	arg_1_0._btnGo = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "DetailPanel/#btn_Go")
	arg_1_0._txtDoubleTimes = gohelper.findChildText(arg_1_0.viewGO, "DetailPanel/#btn_Go/#txt_DoubleTimes")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnSimple:AddClickListener(arg_2_0._btnSimpleOnClick, arg_2_0)
	arg_2_0._btnHard:AddClickListener(arg_2_0._btnHardOnClick, arg_2_0)
	arg_2_0._btnAssassinSimple:AddClickListener(arg_2_0._btnAssassinSimpleOnClick, arg_2_0)
	arg_2_0._btnAssassinHard:AddClickListener(arg_2_0._btnAssassinHardOnClick, arg_2_0)
	arg_2_0._btnbonus:AddClickListener(arg_2_0._btnbonusOnClick, arg_2_0)
	arg_2_0._btnSearchIcon:AddClickListener(arg_2_0._btnSearchIconOnClick, arg_2_0)
	arg_2_0._btnGo:AddClickListener(arg_2_0._btnGoOnClick, arg_2_0)
	arg_2_0._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, arg_2_0._onBtnGoEnter, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnSimple:RemoveClickListener()
	arg_3_0._btnHard:RemoveClickListener()
	arg_3_0._btnAssassinSimple:RemoveClickListener()
	arg_3_0._btnAssassinHard:RemoveClickListener()
	arg_3_0._btnbonus:RemoveClickListener()
	arg_3_0._btnSearchIcon:RemoveClickListener()
	arg_3_0._btnGo:RemoveClickListener()
	arg_3_0._animEvent:AddEventListener(BossRushEnum.AnimEvtAchievementItem.onBtnGoEnter, arg_3_0._onBtnGoEnter, arg_3_0)
end

local var_0_1 = {
	Second = 2,
	First = 1
}
local var_0_2 = {
	[BossRushEnum.LayerEnum.Endless] = var_0_1.First,
	[BossRushEnum.LayerEnum.V2a9] = var_0_1.Second
}
local var_0_3 = {
	[BossRushEnum.V2a9StageEnum.First] = {
		[var_0_1.First] = {
			color2 = "#463d3a",
			color3 = "#fffbf4",
			color1 = "#6d6d6d",
			alpha = 0.3
		},
		[var_0_1.Second] = {
			color2 = "#fffbf4",
			color3 = "#fffbf4",
			color1 = "#cac7c2",
			alpha = 0.3
		}
	},
	[BossRushEnum.V2a9StageEnum.Second] = {
		[var_0_1.First] = {
			color2 = "#beb9a6",
			color3 = "#beb9a6",
			color1 = "#6d6d6d",
			alpha = 0.5
		},
		[var_0_1.Second] = {
			color2 = "#beb9a6",
			color3 = "#beb9a6",
			color1 = "#6d6d6d",
			alpha = 0.5
		}
	}
}

function var_0_0._btnSimpleOnClick(arg_4_0)
	arg_4_0:_setSelect(var_0_1.First, true)
end

function var_0_0._btnHardOnClick(arg_5_0)
	arg_5_0:_setSelect(var_0_1.Second, true)
end

function var_0_0._btnAssassinSimpleOnClick(arg_6_0)
	arg_6_0:_setSelect(var_0_1.First, true)
end

function var_0_0._btnAssassinHardOnClick(arg_7_0)
	arg_7_0:_setSelect(var_0_1.Second, true)
end

function var_0_0._btnGoOnClick(arg_8_0)
	local var_8_0, var_8_1 = arg_8_0:_getStageAndLayer()

	if V2a9BossRushModel.instance:isV2a9SecondStageSpecialLayer(var_8_0, var_8_1) then
		OdysseyRpc.instance:sendOdysseyGetInfoRequest(arg_8_0._btnGoOnClickCB, arg_8_0)
	else
		arg_8_0:_btnGoOnClickCB()
	end
end

function var_0_0._btnGoOnClickCB(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:_getStageAndLayer()

	BossRushController.instance:enterFightScene(var_9_0, var_9_1)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0:_initAssessIcon()

	local var_10_0 = V1a4_BossRushLevelDetailItem

	arg_10_0._tabsList = {
		[BossRushEnum.V2a9StageEnum.First] = {
			[var_0_1.First] = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._btnAssassinSimple.gameObject, var_10_0),
			[var_0_1.Second] = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._btnAssassinHard.gameObject, var_10_0)
		},
		[BossRushEnum.V2a9StageEnum.Second] = {
			[var_0_1.First] = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._btnSimple.gameObject, var_10_0),
			[var_0_1.Second] = MonoHelper.addNoUpdateLuaComOnceToGo(arg_10_0._btnHard.gameObject, var_10_0)
		}
	}
	arg_10_0._animSelf = arg_10_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_10_0._animEvent = arg_10_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	arg_10_0._animSelf.enabled = false

	arg_10_0._animEvent:AddEventListener(BossRushEnum.AnimEvtLevelDetail.onPlayCloseTransitionFinish, arg_10_0._onPlayCloseTransitionFinish, arg_10_0)

	arg_10_0._imgLine = {
		gohelper.findChildImage(arg_10_0.viewGO, "DetailPanel/Title/image_Line"),
		gohelper.findChildImage(arg_10_0.viewGO, "DetailPanel/Title/image_Line/image_Line"),
		gohelper.findChildImage(arg_10_0.viewGO, "DetailPanel/Attention/Lv/image_Line"),
		gohelper.findChildImage(arg_10_0.viewGO, "DetailPanel/Attention/Lv/image_Line/image_Line")
	}
	arg_10_0._txtLvDesc = gohelper.findChildText(arg_10_0.viewGO, "DetailPanel/Attention/Lv/txt_Lv")
	arg_10_0._txtCondition = gohelper.findChildText(arg_10_0.viewGO, "DetailPanel/Condition/Title/txt_Condition")
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0._selectedIndex = nil

	local var_11_0 = arg_11_0.viewParam
	local var_11_1 = var_11_0.stage
	local var_11_2 = var_11_0.selectedIndex
	local var_11_3 = BossRushModel.instance:getStagePointInfo(var_11_1)

	arg_11_0._stageLayerInfos = BossRushModel.instance:getStageLayersInfo(var_11_1)
	arg_11_0._tabList = arg_11_0._tabsList[var_11_1]
	arg_11_0._actId = BossRushConfig.instance:getActivityId()

	if not var_11_2 then
		var_11_2 = arg_11_0:_tryLayer2TabIndex(BossRushModel.instance:getLastMarkSelectedLayer(var_11_1))
		var_11_0.selectedIndex = var_11_2
	else
		var_11_2 = arg_11_0:_tryLayer2TabIndex(var_11_2)
		var_11_0.selectedIndex = var_11_2
	end

	arg_11_0:_setSelect(var_11_2 or var_0_1.First)
	arg_11_0:_tweenUnlockTabs()
	arg_11_0:_refreshMonster()
	arg_11_0:_refreshRedDot()

	local var_11_4 = var_11_3.cur / var_11_3.max

	arg_11_0._imageSliderFG.fillAmount = var_11_4
	arg_11_0._animSelf.enabled = true

	if var_11_2 == var_0_1.Second then
		arg_11_0._animSelf:Play(BossRushEnum.AnimLevelDetail.HardEnter)
	elseif var_11_2 == var_0_1.First then
		arg_11_0._animSelf:Play(BossRushEnum.AnimLevelDetail.NormalEnter)
	end

	arg_11_0:_refreshGoBtn(var_11_2)
	gohelper.setActive(arg_11_0._gomask, false)

	for iter_11_0, iter_11_1 in pairs(arg_11_0._tabsList) do
		for iter_11_2, iter_11_3 in pairs(iter_11_1) do
			gohelper.setActive(iter_11_3.go, var_11_1 == iter_11_0)
		end
	end
end

function var_0_0._setSelect(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._selectedIndex == arg_12_1 then
		return
	end

	local var_12_0 = arg_12_0._selectedIndex

	if not arg_12_0:_isOpen(arg_12_1) then
		GameFacade.showToast(ToastEnum.V1a4_BossRushLayerLockTip)

		return
	end

	if arg_12_2 then
		if arg_12_1 == var_0_1.Second then
			arg_12_0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToHard)
		elseif arg_12_1 == var_0_1.First then
			arg_12_0._animSelf:Play(BossRushEnum.AnimLevelDetail.SwitchToNormal)
		end
	end

	if var_12_0 then
		local var_12_1 = arg_12_0._tabList[var_12_0]

		var_12_1:setSelect(false)
		var_12_1:playIdle()
	end

	local var_12_2 = arg_12_0._tabList[arg_12_1]

	var_12_2:setSelect(true)

	arg_12_0._selectedIndex = arg_12_1

	if arg_12_2 then
		var_12_2:plaAnim(BossRushEnum.AnimLevelDetailBtn.Select, 0, 0)
	end

	arg_12_0:_refreshContent()

	local var_12_3, var_12_4 = arg_12_0:_getStageAndLayer()

	BossRushModel.instance:setLastMarkSelectedLayer(var_12_3, var_12_4)
	gohelper.setActive(arg_12_0._goAssassinNormalMask, var_12_3 == BossRushEnum.V2a9StageEnum.First and arg_12_1 == var_0_1.First)
	gohelper.setActive(arg_12_0._goAssassinHardMask, var_12_3 == BossRushEnum.V2a9StageEnum.First and arg_12_1 == var_0_1.Second)
	gohelper.setActive(arg_12_0._goNormalMask, var_12_3 == BossRushEnum.V2a9StageEnum.Second and arg_12_1 == var_0_1.First)
	gohelper.setActive(arg_12_0._goHardMask, var_12_3 == BossRushEnum.V2a9StageEnum.Second and arg_12_1 == var_0_1.Second)
	gohelper.setActive(arg_12_0._goHardBG, var_12_3 == BossRushEnum.V2a9StageEnum.Second and arg_12_1 == var_0_1.Second)

	local var_12_5 = var_0_3[var_12_3][arg_12_1]
	local var_12_6 = GameUtil.parseColor(var_12_5.color1)
	local var_12_7 = GameUtil.parseColor(var_12_5.color2)
	local var_12_8 = GameUtil.parseColor(var_12_5.color3)

	arg_12_0._txtDescr.color = var_12_6
	arg_12_0._txtLvDesc.color = var_12_7
	arg_12_0._txtCondition.color = var_12_8
	var_12_6.a = var_12_5.alpha

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._imgLine) do
		iter_12_1.color = var_12_6
	end
end

function var_0_0._refreshContent(arg_13_0)
	local var_13_0 = arg_13_0.viewParam
	local var_13_1 = var_13_0.stage
	local var_13_2 = var_13_0.stageCO
	local var_13_3 = arg_13_0._selectedIndex
	local var_13_4 = arg_13_0._stageLayerInfos[var_13_3].layerCO
	local var_13_5 = var_13_4.layer
	local var_13_6 = BossRushConfig.instance:getBattleMaxPoints(var_13_1, var_13_5)
	local var_13_7 = BossRushConfig.instance:getIssxIconName(var_13_1, var_13_5)
	local var_13_8 = BossRushModel.instance:getHighestPoint(var_13_1)
	local var_13_9 = BossRushConfig.instance:isInfinite(var_13_1, var_13_5)
	local var_13_10 = BossRushConfig.instance:getDungeonBattleId(var_13_1, var_13_5)

	UISpriteSetMgr.instance:setCommonSprite(arg_13_0._imageIssxIcon, var_13_7)
	arg_13_0._simagefull:LoadImage(BossRushConfig.instance:getBossRushLevelDetailFullBgSimage(var_13_1))

	local var_13_11 = false
	local var_13_12 = V2a9BossRushModel.instance:getHighestPoint(var_13_1)
	local var_13_13 = math.max(var_13_8, var_13_12)

	arg_13_0._assessIcon:setData(var_13_1, var_13_13, var_13_11)

	local var_13_14 = BossRushConfig.instance:getAssessSpriteName(var_13_1, var_13_13, var_13_11)
	local var_13_15 = string.nilorempty(var_13_14)

	gohelper.setActive(arg_13_0._vxreceive1, not var_13_15)

	arg_13_0._txtTitle.text = ""

	if arg_13_0._scrollDescr then
		arg_13_0._scrollDescr.verticalNormalizedPosition = 1
	end

	arg_13_0._txtDescr.text = var_13_4.desc

	ZProj.UGUIHelper.RebuildLayout(arg_13_0._txtDescr.transform)

	arg_13_0._txtLvNum.text = var_13_4.recommendLevelDesc

	local var_13_16 = ResUrl.getV1a4BossRushLangPath("v2a9_bossrush_bossname_" .. var_13_1)

	arg_13_0._simageTitle:LoadImage(var_13_16)

	if var_13_9 then
		local var_13_17 = BossRushModel.instance:getDoubleTimesInfo(var_13_1)
		local var_13_18 = {
			var_13_17.cur,
			var_13_17.max
		}

		arg_13_0._txtDoubleTimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a4_bossrushleveldetail_txt_doubletimes"), var_13_18)
	else
		arg_13_0._txtDoubleTimes.text = ""
	end

	local var_13_19 = BossRushModel.instance:isSpecialLayer(var_13_5)

	gohelper.setActive(arg_13_0._goLeftBGEndless, not var_13_19 and var_13_9)
	gohelper.setActive(arg_13_0._goLeftBG, not var_13_19 and not var_13_9)
	gohelper.setActive(arg_13_0._goRightBGEndless, not var_13_19 and var_13_9)
	gohelper.setActive(arg_13_0._goRightBG, not var_13_19 and not var_13_9)
	gohelper.setActive(arg_13_0._goRightBGLayer4, var_13_19)
	arg_13_0:_doUpdateSelectIcon(var_13_10)
end

function var_0_0._refreshGoBtn(arg_14_0, arg_14_1)
	return
end

function var_0_0._refreshTabs(arg_15_0, arg_15_1)
	local var_15_0 = {}

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._stageLayerInfos) do
		local var_15_1 = iter_15_1.layer
		local var_15_2 = var_0_2[var_15_1]
		local var_15_3 = arg_15_0._tabList[var_15_2]

		if var_15_3 then
			var_15_3:setData(var_15_2, iter_15_1)

			if arg_15_1 and arg_15_1[var_15_1] then
				var_15_3:setIsLocked(true)
			end

			if iter_15_1.isOpen then
				var_15_3:setSelect(arg_15_0._selectedIndex == var_15_2)
			end
		end

		table.insert(var_15_0, var_15_1)
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0._tabsList) do
		local var_15_4 = LuaUtil.tableContains(var_15_0, iter_15_2)

		gohelper.setActive(iter_15_3.go, var_15_4)
	end
end

function var_0_0._onBtnGoEnter(arg_16_0)
	arg_16_0:_refreshGoBtn(arg_16_0._selectedIndex)
end

function var_0_0.playCloseTransition(arg_17_0)
	arg_17_0._animSelf:Play(BossRushEnum.AnimLevelDetail.CloseView)
	gohelper.setActive(arg_17_0._gomask, true)
end

function var_0_0._onPlayCloseTransitionFinish(arg_18_0)
	arg_18_0.viewContainer:onPlayCloseTransitionFinish()
end

function var_0_0.onDestroyView(arg_19_0)
	arg_19_0._animEvent:RemoveEventListener(BossRushEnum.AnimEvtLevelDetail.onPlayCloseTransitionFinish)
	arg_19_0._simagefull:UnLoadImage()
	GameUtil.onDestroyViewMemberList(arg_19_0, "_tabList")
	GameUtil.onDestroyViewMemberList(arg_19_0, "_uiSpineList")
end

return var_0_0
