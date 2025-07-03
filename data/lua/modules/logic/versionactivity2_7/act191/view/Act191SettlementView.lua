module("modules.logic.versionactivity2_7.act191.view.Act191SettlementView", package.seeall)

local var_0_0 = class("Act191SettlementView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imageLevel = gohelper.findChildImage(arg_1_0.viewGO, "Left/herogroupcontain/mainTitle/#image_Level")
	arg_1_0._scrollFetter = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/herogroupcontain/#scroll_Fetter")
	arg_1_0._goFetterContent = gohelper.findChild(arg_1_0.viewGO, "Left/herogroupcontain/#scroll_Fetter/Viewport/#go_FetterContent")
	arg_1_0._goNodeList = gohelper.findChild(arg_1_0.viewGO, "Right/node/#go_NodeList")
	arg_1_0._goBadgeItem = gohelper.findChild(arg_1_0.viewGO, "Right/badge/layout/#go_BadgeItem")
	arg_1_0._txtScore = gohelper.findChildText(arg_1_0.viewGO, "Right/score/#txt_Score")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.heroContainer = gohelper.findChild(arg_5_0.viewGO, "Left/herogroupcontain/heroContainer")

	arg_5_0:initHeroInfoItem()
	arg_5_0:initHeroAndEquipItem()

	arg_5_0.animEvent = arg_5_0.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_5_0.animEvent:AddEventListener("PlayBadgeAnim", arg_5_0.playBadgeAnim, arg_5_0)

	arg_5_0.actInfo = Activity191Model.instance:getActInfo()

	arg_5_0:initBadge()
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	Act191StatController.instance:onViewOpen(arg_7_0.viewName)

	arg_7_0.gameInfo = arg_7_0.actInfo:getGameInfo()
	arg_7_0.gameEndInfo = arg_7_0.actInfo:getGameEndInfo()

	arg_7_0:refreshLeft()
	arg_7_0:refreshRight()
	AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_fight_end)
end

function var_0_0.onClose(arg_8_0)
	arg_8_0.actInfo:clearEndInfo()

	local var_8_0 = arg_8_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_8_0.viewName, var_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	arg_9_0.animEvent:RemoveEventListener("PlayBadgeAnim")
end

function var_0_0.initHeroInfoItem(arg_10_0)
	arg_10_0.heroInfoItemList = {}

	for iter_10_0 = 1, 4 do
		local var_10_0 = arg_10_0:getUserDataTb_()
		local var_10_1 = gohelper.findChild(arg_10_0.heroContainer, "bg" .. iter_10_0)

		var_10_0.goIndex = gohelper.findChild(var_10_1, "Index")
		var_10_0.txtName = gohelper.findChildText(var_10_1, "Name")
		arg_10_0.heroInfoItemList[iter_10_0] = var_10_0
	end
end

function var_0_0.initHeroAndEquipItem(arg_11_0)
	arg_11_0.heroPosTrList = arg_11_0:getUserDataTb_()
	arg_11_0.equipPosTrList = arg_11_0:getUserDataTb_()

	local var_11_0 = gohelper.findChild(arg_11_0.viewGO, "Left/herogroupcontain/recordPos")

	for iter_11_0 = 1, 8 do
		local var_11_1 = gohelper.findChild(var_11_0, "heroPos" .. iter_11_0)

		arg_11_0.heroPosTrList[iter_11_0] = var_11_1.transform

		if iter_11_0 <= 4 then
			local var_11_2 = gohelper.findChild(var_11_0, "equipPos" .. iter_11_0)

			arg_11_0.equipPosTrList[iter_11_0] = var_11_2.transform
		end
	end

	local var_11_3 = gohelper.findChild(arg_11_0.heroContainer, "go_HeroItem")
	local var_11_4 = gohelper.findChild(arg_11_0.heroContainer, "go_EquipItem")

	arg_11_0.heroItemList = {}
	arg_11_0.equipItemList = {}

	for iter_11_1 = 1, 8 do
		local var_11_5 = gohelper.cloneInPlace(var_11_3, "hero" .. iter_11_1)
		local var_11_6 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_5, Act191HeroGroupItem1)

		var_11_6:setIndex(iter_11_1)

		arg_11_0.heroItemList[iter_11_1] = var_11_6

		arg_11_0:_setHeroItemPos(var_11_6, iter_11_1)

		if iter_11_1 <= 4 then
			local var_11_7 = gohelper.cloneInPlace(var_11_4, "equip" .. iter_11_1)
			local var_11_8 = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_7, Act191HeroGroupItem2, arg_11_0)

			var_11_8:setIndex(iter_11_1)
			var_11_8:setOverrideClick(arg_11_0.clickCollection, arg_11_0)

			arg_11_0.equipItemList[iter_11_1] = var_11_8

			arg_11_0:_setEquipItemPos(var_11_8, iter_11_1)
		end
	end

	gohelper.setActive(var_11_3, false)
	gohelper.setActive(var_11_4, false)
end

function var_0_0.refreshLeft(arg_12_0)
	local var_12_0 = Activity191Model.instance:getActInfo():getGameInfo()
	local var_12_1 = var_12_0.rank ~= 0 and var_12_0.rank or 1
	local var_12_2 = lua_activity191_rank.configDict[var_12_1].fightLevel or ""

	UISpriteSetMgr.instance:setAct174Sprite(arg_12_0._imageLevel, "act191_level_" .. string.lower(var_12_2))

	local var_12_3 = var_12_0:getTeamInfo()

	for iter_12_0 = 1, 4 do
		local var_12_4 = Activity191Helper.matchKeyInArray(var_12_3.battleHeroInfo, iter_12_0)
		local var_12_5
		local var_12_6

		if var_12_4 then
			var_12_5 = var_12_4.heroId
			var_12_6 = var_12_4.itemUid1
		end

		arg_12_0.heroItemList[iter_12_0]:setData(var_12_5)
		arg_12_0.equipItemList[iter_12_0]:setData(var_12_6)

		local var_12_7 = arg_12_0.heroInfoItemList[iter_12_0]

		if var_12_5 and var_12_5 ~= 0 then
			local var_12_8 = var_12_0:getHeroInfoInWarehouse(var_12_5)
			local var_12_9 = Activity191Config.instance:getRoleCoByNativeId(var_12_5, var_12_8.star)

			var_12_7.txtName.text = var_12_9.name

			gohelper.setActive(var_12_7.goIndex, false)
			gohelper.setActive(var_12_7.txtName, true)
		else
			gohelper.setActive(var_12_7.goIndex, true)
			gohelper.setActive(var_12_7.txtName, false)
		end

		local var_12_10 = iter_12_0 + 4
		local var_12_11 = Activity191Helper.matchKeyInArray(var_12_3.subHeroInfo, iter_12_0)
		local var_12_12 = var_12_11 and var_12_11.heroId or 0

		arg_12_0.heroItemList[var_12_10]:setData(var_12_12)
	end

	local var_12_13 = var_12_0:getTeamFetterCntDic()
	local var_12_14 = Activity191Helper.getActiveFetterInfoList(var_12_13)

	for iter_12_1, iter_12_2 in ipairs(var_12_14) do
		local var_12_15 = arg_12_0:getResInst(Activity191Enum.PrefabPath.FetterItem, arg_12_0._goFetterContent)
		local var_12_16 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_15, Act191FetterItem)

		var_12_16:setData(iter_12_2.config, iter_12_2.count)
		gohelper.setActive(var_12_16.go, true)
	end

	arg_12_0._scrollFetter.horizontalNormalizedPosition = 0
end

function var_0_0._setHeroItemPos(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4, arg_13_5)
	local var_13_0 = arg_13_0.heroPosTrList[arg_13_2]
	local var_13_1 = recthelper.rectToRelativeAnchorPos(var_13_0.position, arg_13_0.heroContainer.transform)

	if arg_13_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_13_1.go.transform, var_13_1.x, var_13_1.y, 0.2, arg_13_4, arg_13_5)
	else
		recthelper.setAnchor(arg_13_1.go.transform, var_13_1.x, var_13_1.y)

		if arg_13_4 then
			arg_13_4(arg_13_5)
		end
	end
end

function var_0_0._setEquipItemPos(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4, arg_14_5)
	local var_14_0 = arg_14_0.equipPosTrList[arg_14_2]
	local var_14_1 = recthelper.rectToRelativeAnchorPos(var_14_0.position, arg_14_0.heroContainer.transform)

	if arg_14_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_14_1.go.transform, var_14_1.x, var_14_1.y, 0.2, arg_14_4, arg_14_5)
	else
		recthelper.setAnchor(arg_14_1.go.transform, var_14_1.x, var_14_1.y)

		if arg_14_4 then
			arg_14_4(arg_14_5)
		end
	end
end

function var_0_0.refreshRight(arg_15_0)
	if arg_15_0.gameInfo.curStage ~= 0 then
		local var_15_0 = arg_15_0:getResInst(Activity191Enum.PrefabPath.NodeListItem, arg_15_0._goNodeList)

		MonoHelper.addNoUpdateLuaComOnceToGo(var_15_0, Act191NodeListItem):setClickEnable(false)
	end

	arg_15_0._txtScore.text = arg_15_0.gameEndInfo.gainScore
end

function var_0_0.initBadge(arg_16_0)
	arg_16_0.badgeItemList = {}

	local var_16_0 = arg_16_0.actInfo:getBadgeScoreChangeDic()
	local var_16_1 = arg_16_0.actInfo:getBadgeMoList()

	for iter_16_0, iter_16_1 in ipairs(var_16_1) do
		local var_16_2 = arg_16_0:getUserDataTb_()
		local var_16_3 = gohelper.cloneInPlace(arg_16_0._goBadgeItem)

		var_16_2.Icon = gohelper.findChildSingleImage(var_16_3, "root/image_icon")

		local var_16_4 = gohelper.findChildText(var_16_3, "root/txt_num")
		local var_16_5 = gohelper.findChildText(var_16_3, "root/txt_score")

		var_16_4.text = iter_16_1.count

		local var_16_6 = var_16_0[iter_16_1.id]

		if var_16_6 and var_16_6 ~= 0 then
			var_16_5.text = "+" .. var_16_6
		end

		gohelper.setActive(var_16_5, var_16_6 ~= 0)

		local var_16_7 = iter_16_1:getState()
		local var_16_8 = ResUrl.getAct174BadgeIcon(iter_16_1.config.icon, var_16_7)

		var_16_2.Icon:LoadImage(var_16_8)

		var_16_2.anim = var_16_3:GetComponent(gohelper.Type_Animator)
		var_16_2.id = iter_16_1.id
		arg_16_0.badgeItemList[#arg_16_0.badgeItemList] = var_16_2
	end

	gohelper.setActive(arg_16_0._goBadgeItem, false)
end

function var_0_0.playBadgeAnim(arg_17_0)
	local var_17_0 = arg_17_0.actInfo:getBadgeScoreChangeDic()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0.badgeItemList) do
		local var_17_1 = var_17_0[iter_17_1.id]

		if var_17_1 and var_17_1 ~= 0 then
			iter_17_1.anim:Play("refresh")
		end
	end
end

function var_0_0.clickCollection(arg_18_0, arg_18_1)
	if arg_18_1 and arg_18_1 ~= 0 then
		Activity191Controller.instance:openCollectionTipView({
			itemId = arg_18_1
		})
	end
end

return var_0_0
