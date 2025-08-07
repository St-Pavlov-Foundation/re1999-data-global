module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupItem", package.seeall)

local var_0_0 = class("OdysseyHeroGroupItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._heroGroupListView = arg_1_1
end

var_0_0.EquipTweenDuration = 0.16
var_0_0.EquipDragOffset = Vector2(0, 150)
var_0_0.EquipDragMobileScale = 1.7
var_0_0.EquipDragOtherScale = 1.4
var_0_0.OdysseyEquipDragOtherScale = 1.1
var_0_0.PressColor = GameUtil.parseColor("#C8C8C8")

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0._noneGO = gohelper.findChild(arg_2_1, "heroitemani/none")
	arg_2_0._addGO = gohelper.findChild(arg_2_1, "heroitemani/none/add")
	arg_2_0._lockGO = gohelper.findChild(arg_2_1, "heroitemani/none/lock")
	arg_2_0._heroGO = gohelper.findChild(arg_2_1, "heroitemani/hero")
	arg_2_0._tagTr = gohelper.findChildComponent(arg_2_1, "heroitemani/tags", typeof(UnityEngine.Transform))
	arg_2_0._subGO = gohelper.findChild(arg_2_1, "heroitemani/tags/aidtag")
	arg_2_0._aidGO = gohelper.findChild(arg_2_1, "heroitemani/tags/storytag")
	arg_2_0._trialTagGO = gohelper.findChild(arg_2_1, "heroitemani/tags/trialtag")
	arg_2_0._trialTagTxt = gohelper.findChildTextMesh(arg_2_1, "heroitemani/tags/trialtag/#txt_trial_tag")
	arg_2_0._clickGO = gohelper.findChild(arg_2_1, "heroitemani/click")
	arg_2_0._clickThis = gohelper.getClick(arg_2_0._clickGO)
	arg_2_0._equipGO = gohelper.findChild(arg_2_1, "heroitemani/equip")
	arg_2_0._clickEquip = gohelper.getClick(arg_2_0._equipGO)
	arg_2_0._charactericon = gohelper.findChild(arg_2_1, "heroitemani/hero/charactericon")
	arg_2_0._careericon = gohelper.findChildImage(arg_2_1, "heroitemani/hero/career")
	arg_2_0._goblackmask = gohelper.findChild(arg_2_1, "heroitemani/hero/blackmask")
	arg_2_0.level_part = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/layout")
	arg_2_0._lvnum = gohelper.findChildText(arg_2_1, "heroitemani/hero/vertical/layout/lv/lvnum")
	arg_2_0._lvnumen = gohelper.findChildText(arg_2_1, "heroitemani/hero/vertical/layout/lv/lvnum/lv")
	arg_2_0._goRankList = arg_2_0:getUserDataTb_()

	for iter_2_0 = 1, 3 do
		local var_2_0 = gohelper.findChildImage(arg_2_1, "heroitemani/hero/vertical/layout/rankobj/rank" .. iter_2_0)

		table.insert(arg_2_0._goRankList, var_2_0)
	end

	arg_2_0._goStarList = arg_2_0:getUserDataTb_()

	for iter_2_1 = 1, 6 do
		local var_2_1 = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/#go_starList/star" .. iter_2_1)

		table.insert(arg_2_0._goStarList, var_2_1)
	end

	arg_2_0._goStars = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/#go_starList")
	arg_2_0._fakeEquipGO = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/fakeequip")
	arg_2_0._dragFrameGO = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect")
	arg_2_0._dragFrameSelectGO = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect/xuanzhong")
	arg_2_0._dragFrameCompleteGO = gohelper.findChild(arg_2_1, "heroitemani/selectedeffect/wancheng")

	gohelper.setActive(arg_2_0._dragFrameGO, false)

	arg_2_0._emptyEquipGo = gohelper.findChild(arg_2_1, "heroitemani/emptyequip")
	arg_2_0._animGO = gohelper.findChild(arg_2_1, "heroitemani")
	arg_2_0.anim = arg_2_0._animGO:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._replayReady = gohelper.findChild(arg_2_1, "heroitemani/hero/replayready")
	arg_2_0._gorecommended = gohelper.findChild(arg_2_1, "heroitemani/hero/#go_recommended")
	arg_2_0._gocounter = gohelper.findChild(arg_2_1, "heroitemani/hero/#go_counter")
	arg_2_0._herocardGo = gohelper.findChild(arg_2_1, "heroitemani/roleequip")
	arg_2_0._leftDrop = gohelper.findChildDropdown(arg_2_1, "heroitemani/roleequip/left")
	arg_2_0._rightDrop = gohelper.findChildDropdown(arg_2_1, "heroitemani/roleequip/right")
	arg_2_0._imageAdd = gohelper.findChildImage(arg_2_1, "heroitemani/none/add")
	arg_2_0._gomojing = gohelper.findChild(arg_2_1, "heroitemani/#go_mojing")
	arg_2_0._gomojingtxt = gohelper.findChildText(arg_2_1, "heroitemani/#go_mojing/#txt")
	arg_2_0._commonHeroCard = CommonHeroCard.create(arg_2_0._charactericon, arg_2_0._heroGroupListView.viewName)
	arg_2_0._goOdysseyEquipParent = gohelper.findChild(arg_2_1, "go_Equip")
end

function var_0_0.initEquipItem(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._odysseyItemList = {}

	local var_3_0 = arg_3_0._goOdysseyEquipParent.transform
	local var_3_1 = gohelper.clone(arg_3_0._goOdysseyEquipParent, arg_3_0._animGO)
	local var_3_2 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.MainHeroEquipCount)
	local var_3_3 = tonumber(var_3_2.value)

	for iter_3_0 = 1, var_3_3 do
		local var_3_4 = arg_3_1(arg_3_2, var_3_0.gameObject)
		local var_3_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_3_4.gameObject, OdysseyHeroGroupEquipItem)

		var_3_5:setEmptyParent(var_3_1.transform)
		arg_3_0:_odysseyEquipAddDrag(var_3_5)
		table.insert(arg_3_0._odysseyItemList, var_3_5)
	end

	arg_3_0._odysseyEmptyEquipParent = var_3_1
	arg_3_0._odysseyEquipOriginPos = var_3_0.localPosition
	arg_3_0._odysseyEquipEmptyOriginPos = var_3_1.transform.localPosition
end

function var_0_0.setIndex(arg_4_0, arg_4_1)
	arg_4_0._index = arg_4_1
end

function var_0_0._showMojingTip(arg_5_0)
	local var_5_0 = false
	local var_5_1 = HeroGroupModel.instance.episodeId
	local var_5_2 = DungeonConfig.instance:getEpisodeCO(var_5_1)

	if var_5_2 and var_5_2.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.Daily then
		var_5_0 = arg_5_0._index == 3
	end

	gohelper.setActive(arg_5_0._gomojing, var_5_0)

	if not var_5_0 then
		return
	end

	arg_5_0._gomojingtxt.text = luaLang("p_v1a3_herogroup_mojing_" .. tostring(var_5_1))
end

function var_0_0.setParent(arg_6_0, arg_6_1)
	arg_6_0.currentParent = arg_6_1

	arg_6_0._subGO.transform:SetParent(arg_6_1, true)
	arg_6_0._equipGO.transform:SetParent(arg_6_1, true)
	arg_6_0._goOdysseyEquipParent.transform:SetParent(arg_6_1, true)
end

function var_0_0.flowOriginParent(arg_7_0)
	arg_7_0._equipGO.transform:SetParent(arg_7_0._animGO.transform, true)
	arg_7_0._goOdysseyEquipParent.transform:SetParent(arg_7_0._animGO.transform, true)
end

function var_0_0.flowCurrentParent(arg_8_0)
	arg_8_0._equipGO.transform:SetParent(arg_8_0.currentParent, true)
	arg_8_0._goOdysseyEquipParent.transform:SetParent(arg_8_0.currentParent, true)
end

function var_0_0.initEquips(arg_9_0, arg_9_1)
	arg_9_0._equipType = -1

	if arg_9_0.isLock or arg_9_0.isAid or arg_9_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not arg_9_0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(arg_9_0._equipGO, false)
		gohelper.setActive(arg_9_0._fakeEquipGO, false)
		gohelper.setActive(arg_9_0._emptyEquipGo, false)
	else
		gohelper.setActive(arg_9_0._equipGO, true)
		gohelper.setActive(arg_9_0._fakeEquipGO, true)
		gohelper.setActive(arg_9_0._emptyEquipGo, true)

		if not arg_9_0._equip then
			arg_9_0._equip = arg_9_0:getUserDataTb_()
			arg_9_0._equip.moveContainer = gohelper.findChild(arg_9_0._equipGO, "moveContainer")
			arg_9_0._equip.equipIcon = gohelper.findChildImage(arg_9_0._equipGO, "moveContainer/equipIcon")
			arg_9_0._equip.equipRare = gohelper.findChildImage(arg_9_0._equipGO, "moveContainer/equiprare")
			arg_9_0._equip.equiptxten = gohelper.findChildText(arg_9_0._equipGO, "equiptxten")
			arg_9_0._equip.equiptxtlv = gohelper.findChildText(arg_9_0._equipGO, "moveContainer/equiplv/txtequiplv")
			arg_9_0._equip.equipGolv = gohelper.findChild(arg_9_0._equipGO, "moveContainer/equiplv")

			arg_9_0:_equipIconAddDrag(arg_9_0._equip.moveContainer, arg_9_0._equip.equipIcon)
		end

		local var_9_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_9_0.mo.id - 1).equipUid[1]

		arg_9_0._equipMO = EquipModel.instance:getEquip(var_9_0) or HeroGroupTrialModel.instance:getEquipMo(var_9_0)

		if HeroGroupModel.instance:getCurGroupMO().isReplay then
			arg_9_0._equipMO = nil

			local var_9_1 = HeroGroupModel.instance:getCurGroupMO().replay_equip_data[arg_9_0.mo.heroUid]

			if var_9_1 then
				local var_9_2 = EquipConfig.instance:getEquipCo(var_9_1.equipId)

				if var_9_2 then
					arg_9_0._equipMO = {}
					arg_9_0._equipMO.config = var_9_2
					arg_9_0._equipMO.refineLv = var_9_1.refineLv
					arg_9_0._equipMO.level = var_9_1.equipLv
				end
			end
		end

		local var_9_3

		if arg_9_0.trialCO and arg_9_0.trialCO.equipId > 0 then
			var_9_3 = EquipConfig.instance:getEquipCo(arg_9_0.trialCO.equipId)
		end

		if arg_9_0._equipMO then
			arg_9_0._equipType = arg_9_0._equipMO.config.rare - 2
		elseif var_9_3 then
			arg_9_0._equipType = var_9_3.rare - 2
		end

		gohelper.setActive(arg_9_0._equip.equipIcon.gameObject, arg_9_0._equipMO or var_9_3)
		gohelper.setActive(arg_9_0._equip.equipRare.gameObject, arg_9_0._equipMO or var_9_3)
		gohelper.setActive(arg_9_0._equip.equipAddGO, not arg_9_0._equipMO and not var_9_3)
		gohelper.setActive(arg_9_0._equip.equipGolv, arg_9_0._equipMO or var_9_3)
		ZProj.UGUIHelper.SetColorAlpha(arg_9_0._equip.equiptxten, (arg_9_0._equipMO or var_9_3) and 0.15 or 0.06)

		if arg_9_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_9_0._equip.equipIcon, arg_9_0._equipMO.config.icon)

			local var_9_4, var_9_5, var_9_6 = HeroGroupBalanceHelper.getBalanceLv()

			if var_9_6 and var_9_6 > arg_9_0._equipMO.level and arg_9_0._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				arg_9_0._equip.equiptxtlv.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">LV." .. var_9_6
			else
				arg_9_0._equip.equiptxtlv.text = "LV." .. arg_9_0._equipMO.level
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_9_0._equip.equipRare, "bianduixingxian_" .. arg_9_0._equipMO.config.rare)
			arg_9_0:_showEquipParticleEffect(arg_9_1)
		elseif var_9_3 then
			local var_9_7 = EquipConfig.instance:getEquipCo(arg_9_0.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_9_0._equip.equipIcon, var_9_7.icon)

			arg_9_0._equip.equiptxtlv.text = "LV." .. arg_9_0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_9_0._equip.equipRare, "bianduixingxian_" .. var_9_7.rare)
			arg_9_0:_showEquipParticleEffect(arg_9_1)
		end
	end

	arg_9_0.last_equip = arg_9_0._equipMO and arg_9_0._equipMO.uid
	arg_9_0.last_hero = arg_9_0._heroMO and arg_9_0._heroMO.heroId or 0
end

function var_0_0.initOdysseyEquips(arg_10_0)
	if OdysseyItemModel.instance:haveEquipItem() == false then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._odysseyItemList) do
			iter_10_1:setActive(false)
		end

		return
	end

	local var_10_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_10_1 = arg_10_0.mo.id
	local var_10_2 = var_10_0:getOdysseyEquips(var_10_1 - 1)

	for iter_10_2, iter_10_3 in ipairs(var_10_2.equipUid) do
		local var_10_3 = arg_10_0._odysseyItemList[iter_10_2]

		if not var_10_3 then
			logError("奥德赛编队界面 装备索引超过上限 index: " .. tostring(iter_10_2))
		else
			local var_10_4 = tonumber(iter_10_3)

			var_10_3:setActive(true)
			var_10_3:setInfo(var_10_1, iter_10_2, var_10_4, OdysseyEnum.BagType.FightPrepare)
			var_10_3:refreshUI()
		end
	end

	local var_10_5 = #arg_10_0._odysseyItemList
	local var_10_6 = #var_10_2.equipUid

	if var_10_6 < var_10_5 then
		for iter_10_4 = var_10_6 + 1, var_10_5 do
			local var_10_7 = arg_10_0._odysseyItemList[iter_10_4]

			var_10_7:clear()
			var_10_7:setActive(false)
		end
	end
end

function var_0_0._showEquipParticleEffect(arg_11_0, arg_11_1)
	if arg_11_1 == arg_11_0.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function var_0_0._odysseyEquipAddDrag(arg_12_0, arg_12_1)
	local var_12_0 = var_0_0.OdysseyEquipDragOtherScale
	local var_12_1

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_12_1 = var_0_0.EquipDragOffset
		var_12_0 = var_0_0.EquipDragMobileScale
	end

	local var_12_2 = {
		item = arg_12_1
	}

	CommonDragHelper.instance:registerDragObj(arg_12_1._gonoEmpty, arg_12_0._onOdysseyItemBeginDrag, nil, arg_12_0._onOdysseyItemEndDrag, arg_12_0._checkOdysseyItemDrag, arg_12_0, var_12_2, nil, var_12_1, var_12_0)
end

function var_0_0._checkOdysseyItemDrag(arg_13_0, arg_13_1)
	if UnityEngine.Input.touchCount > 1 then
		return false
	end

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return true
	end

	local var_13_0 = arg_13_1.item

	if var_13_0.isLongParse then
		return true
	end

	if var_13_0.equipUid == nil or var_13_0.equipUid == 0 then
		return true
	end

	if var_13_0.heroPos > OdysseyEnum.MaxHeroGroupCount then
		return true
	end

	return false
end

function var_0_0._onOdysseyItemBeginDrag(arg_14_0, arg_14_1)
	logNormal("onOdysseyItemBeginDrag")

	arg_14_1.item.isDrag = true

	gohelper.setAsLastSibling(arg_14_0._heroGroupListView.heroPosTrList[arg_14_0.mo.id].parent.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0._onOdysseyItemEndDrag(arg_15_0, arg_15_1, arg_15_2)
	logNormal("onOdysseyItemEndDrag")

	local var_15_0 = arg_15_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_15_0 = var_15_0 + var_0_0.EquipDragOffset
	end

	local var_15_1 = arg_15_1.item
	local var_15_2 = arg_15_0:_moveOdysseyToTarget(var_15_0, var_15_1)
	local var_15_3 = var_15_1._gonoEmpty.transform

	if var_15_2 == nil then
		logNormal("没有合适位置， 返回原处")
		arg_15_0:_setToPos(var_15_3, Vector2(), true, function()
			arg_15_0:_setEquipDragEnabled(true)

			var_15_1.isDrag = false
		end, arg_15_0)

		return
	end

	arg_15_0:_setEquipDragEnabled(false)
	arg_15_0:_playDragEndAudio()
	gohelper.setAsLastSibling(arg_15_0._heroGroupListView.heroPosTrList[arg_15_0.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(arg_15_0._heroGroupListView.heroPosTrList[var_15_2.heroPos].parent.gameObject)

	local var_15_4 = var_15_2._gonoEmpty.transform
	local var_15_5 = recthelper.rectToRelativeAnchorPos(var_15_1._goEmpty.transform.position, var_15_2._goEmpty.transform)
	local var_15_6 = recthelper.rectToRelativeAnchorPos(var_15_2._goEmpty.transform.position, var_15_1._goEmpty.transform)

	if var_15_2:isEmpty() == false then
		arg_15_0._odysseyTweenId = arg_15_0:_setToPos(var_15_4, var_15_5, true)
	end

	logNormal("有合适位置")
	arg_15_0:_setToPos(var_15_3, var_15_6, true, function()
		if arg_15_0._odysseyTweenId then
			ZProj.TweenHelper.KillById(arg_15_0._odysseyTweenId)
		end

		arg_15_0:_setEquipDragEnabled(true)
		OdysseyHeroGroupController.instance:swapOdysseyEquip(var_15_1.heroPos - 1, var_15_2.heroPos - 1, var_15_1.index, var_15_2.index)

		var_15_1.isDrag = false
	end, arg_15_0)
end

function var_0_0._moveOdysseyToTarget(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._heroGroupListView.odysseyEquipPosList) do
		local var_18_0 = arg_18_0._heroGroupListView.odysseyEquipItemList[iter_18_0]

		if var_18_0:isActive() and (var_18_0:isEmpty() or var_18_0.heroPos ~= arg_18_2.heroPos or var_18_0.index ~= arg_18_2.index) then
			local var_18_1 = var_18_0.go.transform
			local var_18_2 = recthelper.screenPosToAnchorPos(arg_18_1, var_18_1)

			if math.abs(var_18_2.x) * 2 < recthelper.getWidth(var_18_1) and math.abs(var_18_2.y) * 2 < recthelper.getHeight(var_18_1) then
				return var_18_0
			end
		end
	end

	return nil
end

function var_0_0._equipIconAddDrag(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2:GetComponent(gohelper.Type_Image).raycastTarget = true

	local var_19_0 = var_0_0.EquipDragOtherScale
	local var_19_1

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_19_1 = var_0_0.EquipDragOffset
		var_19_0 = var_0_0.EquipDragMobileScale
	end

	CommonDragHelper.instance:registerDragObj(arg_19_1, arg_19_0._onBeginDrag, nil, arg_19_0._onEndDrag, arg_19_0._checkDrag, arg_19_0, arg_19_1.transform, nil, var_19_1, var_19_0)
end

function var_0_0._checkDrag(arg_20_0)
	if arg_20_0.trialCO and arg_20_0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return true
	end

	return false
end

function var_0_0._onBeginDrag(arg_21_0)
	gohelper.setAsLastSibling(arg_21_0._heroGroupListView.heroPosTrList[arg_21_0.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(arg_21_0._equipGO)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(arg_21_0._equip.equipGolv, false)
end

function var_0_0._onEndDrag(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_22_0 = var_22_0 + var_0_0.EquipDragOffset
	end

	local var_22_1 = arg_22_0:_moveToTarget(var_22_0)

	arg_22_0:_setEquipDragEnabled(false)

	local var_22_2 = var_22_1 and var_22_1.trialCO and var_22_1.trialCO.equipId > 0

	if not var_22_1 or var_22_1 == arg_22_0 or var_22_1.mo.aid or var_22_2 or not var_22_1._equipGO.activeSelf then
		if var_22_2 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		arg_22_0:_setToPos(arg_22_0._equip.moveContainer.transform, Vector2(), true, function()
			gohelper.setActive(arg_22_0._equip.equipGolv, true)
			arg_22_0:_setEquipDragEnabled(true)
		end, arg_22_0)
		arg_22_0:_showEquipParticleEffect()

		return
	end

	arg_22_0:_playDragEndAudio(var_22_1)
	gohelper.setAsLastSibling(arg_22_0._heroGroupListView.heroPosTrList[var_22_1.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(arg_22_0._heroGroupListView.heroPosTrList[arg_22_0.mo.id].parent.gameObject)

	local var_22_3 = recthelper.rectToRelativeAnchorPos(arg_22_0._equipGO.transform.position, var_22_1._equipGO.transform)

	arg_22_0._tweenId = arg_22_0:_setToPos(var_22_1._equip.moveContainer.transform, var_22_3, true)

	local var_22_4 = recthelper.rectToRelativeAnchorPos(var_22_1._equipGO.transform.position, arg_22_0._equipGO.transform)

	arg_22_0:_setToPos(arg_22_0._equip.moveContainer.transform, var_22_4, true, function()
		EquipTeamListModel.instance:openTeamEquip(arg_22_0.mo.id - 1, arg_22_0._heroMO)

		if arg_22_0._tweenId then
			ZProj.TweenHelper.KillById(arg_22_0._tweenId)
		end

		arg_22_0:_setToPos(arg_22_0._equip.moveContainer.transform, Vector2())
		arg_22_0:_setToPos(var_22_1._equip.moveContainer.transform, Vector2())
		gohelper.setActive(arg_22_0._equip.equipGolv, true)
		arg_22_0:_setEquipDragEnabled(true)

		local var_24_0 = arg_22_0.mo.id - 1
		local var_24_1 = var_22_1.mo.id - 1
		local var_24_2 = EquipTeamListModel.instance:getTeamEquip(var_24_0)[1]

		var_24_2 = (EquipModel.instance:getEquip(var_24_2) or HeroGroupTrialModel.instance:getEquipMo(var_24_2)) and var_24_2 or nil

		if var_24_2 then
			EquipTeamShowItem.removeEquip(var_24_0, true)
		end

		local var_24_3 = EquipTeamListModel.instance:getTeamEquip(var_24_1)[1]

		var_24_3 = (EquipModel.instance:getEquip(var_24_3) or HeroGroupTrialModel.instance:getEquipMo(var_24_3)) and var_24_3 or nil

		if var_24_3 then
			EquipTeamShowItem.removeEquip(var_24_1, true)
		end

		if var_24_2 then
			EquipTeamShowItem.replaceEquip(var_24_1, var_24_2, true)
		end

		if var_24_3 then
			EquipTeamShowItem.replaceEquip(var_24_0, var_24_3, true)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
		HeroGroupModel.instance:saveCurGroupData()
	end, arg_22_0)
end

function var_0_0.resetEquipPos(arg_25_0)
	if not arg_25_0._equip then
		return
	end

	local var_25_0 = arg_25_0._equip.moveContainer.transform

	recthelper.setAnchor(var_25_0, 0, 0)
	transformhelper.setLocalScale(var_25_0, 1, 1, 1)
end

function var_0_0._playDragEndAudio(arg_26_0, arg_26_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function var_0_0._setToPos(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
	local var_27_0, var_27_1 = recthelper.getAnchor(arg_27_1)

	if arg_27_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_27_1, arg_27_2.x, arg_27_2.y, 0.2, arg_27_4, arg_27_5)
	else
		recthelper.setAnchor(arg_27_1, arg_27_2.x, arg_27_2.y)

		if arg_27_4 then
			arg_27_4(arg_27_5)
		end
	end
end

function var_0_0._moveToTarget(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._heroGroupListView.heroPosTrList) do
		if arg_28_0._heroGroupListView._heroItemList[iter_28_0] ~= arg_28_0 then
			local var_28_0 = iter_28_1.parent
			local var_28_1 = recthelper.screenPosToAnchorPos(arg_28_1, var_28_0)

			if math.abs(var_28_1.x) * 2 < recthelper.getWidth(var_28_0) and math.abs(var_28_1.y) * 2 < recthelper.getHeight(var_28_0) then
				local var_28_2 = arg_28_0._heroGroupListView._heroItemList[iter_28_0]

				return not var_28_2:selfIsLock() and var_28_2 or nil
			end
		end
	end

	return nil
end

function var_0_0._setEquipDragEnabled(arg_29_0, arg_29_1)
	CommonDragHelper.instance:setGlobalEnabled(arg_29_1)
end

function var_0_0.addEventListeners(arg_30_0)
	arg_30_0._clickThis:AddClickListener(arg_30_0._onClickThis, arg_30_0)
	arg_30_0._clickThis:AddClickDownListener(arg_30_0._onClickThisDown, arg_30_0)
	arg_30_0._clickThis:AddClickUpListener(arg_30_0._onClickThisUp, arg_30_0)
	arg_30_0._clickEquip:AddClickListener(arg_30_0._onClickEquip, arg_30_0)
	arg_30_0._clickEquip:AddClickDownListener(arg_30_0._onClickEquipDown, arg_30_0)
	arg_30_0._clickEquip:AddClickUpListener(arg_30_0._onClickEquipUp, arg_30_0)
	arg_30_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, arg_30_0.setHeroGroupEquipEffect, arg_30_0)
	arg_30_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, arg_30_0.playHeroGroupHeroEffect, arg_30_0)
	arg_30_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_30_0.initEquips, arg_30_0)
	arg_30_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_30_0.initEquips, arg_30_0)
	arg_30_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_30_0.initEquips, arg_30_0)
	arg_30_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_30_0.initEquips, arg_30_0)
	arg_30_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_30_0.initEquips, arg_30_0)
	arg_30_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_30_0.initEquips, arg_30_0)
end

function var_0_0.removeEventListeners(arg_31_0)
	arg_31_0._clickThis:RemoveClickListener()
	arg_31_0._clickThis:RemoveClickUpListener()
	arg_31_0._clickThis:RemoveClickDownListener()
	arg_31_0._clickEquip:RemoveClickListener()
	arg_31_0._clickEquip:RemoveClickUpListener()
	arg_31_0._clickEquip:RemoveClickDownListener()
end

function var_0_0.playHeroGroupHeroEffect(arg_32_0, arg_32_1)
	arg_32_0:playAnim(arg_32_1)

	arg_32_0.last_equip = nil
	arg_32_0.last_hero = nil
end

function var_0_0.onUpdateMO(arg_33_0, arg_33_1)
	arg_33_0._commonHeroCard:setGrayScale(false)

	local var_33_0 = HeroGroupModel.instance.battleId
	local var_33_1

	var_33_1 = var_33_0 and lua_battle.configDict[var_33_0]
	arg_33_0.mo = arg_33_1
	arg_33_0._posIndex = arg_33_0.mo.id - 1
	arg_33_0._heroMO = arg_33_1:getHeroMO()
	arg_33_0.monsterCO = arg_33_1:getMonsterCO()
	arg_33_0.trialCO = arg_33_1:getTrialCO()

	local var_33_2 = HeroGroupModel.instance:getCurGroupMO()

	gohelper.setActive(arg_33_0._replayReady, var_33_2.isReplay)

	local var_33_3

	if var_33_2.isReplay then
		var_33_3 = var_33_2.replay_hero_data[arg_33_0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_33_0._lvnumen, "#E9E9E9")

	for iter_33_0 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(arg_33_0._goRankList[iter_33_0], "#F6F3EC")
	end

	if arg_33_0._heroMO then
		local var_33_4 = HeroModel.instance:getByHeroId(arg_33_0._heroMO.heroId)
		local var_33_5 = FightConfig.instance:getSkinCO(var_33_3 and var_33_3.skin or var_33_4.skin)

		arg_33_0._commonHeroCard:onUpdateMO(var_33_5)

		if arg_33_0.isLock or arg_33_0.isAid or arg_33_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_33_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_33_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_33_0._careericon, "lssx_" .. tostring(arg_33_0._heroMO.config.career))

		local var_33_6 = var_33_3 and var_33_3.level or arg_33_0._heroMO.level
		local var_33_7 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_33_0._heroMO.heroId)
		local var_33_8

		if var_33_6 < var_33_7 then
			var_33_6 = var_33_7
			var_33_8 = true
		end

		local var_33_9, var_33_10 = HeroConfig.instance:getShowLevel(var_33_6)

		if var_33_8 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_33_0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			arg_33_0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. var_33_9

			for iter_33_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_33_0._goRankList[iter_33_1], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			arg_33_0._lvnum.text = var_33_9
		end

		for iter_33_2 = 1, 3 do
			local var_33_11 = arg_33_0._goRankList[iter_33_2]

			gohelper.setActive(var_33_11, iter_33_2 == var_33_10 - 1)
		end

		gohelper.setActive(arg_33_0._goStars, true)

		for iter_33_3 = 1, 6 do
			local var_33_12 = arg_33_0._goStarList[iter_33_3]

			gohelper.setActive(var_33_12, iter_33_3 <= CharacterEnum.Star[arg_33_0._heroMO.config.rare])
		end
	elseif arg_33_0.monsterCO then
		local var_33_13 = FightConfig.instance:getSkinCO(arg_33_0.monsterCO.skinId)

		arg_33_0._commonHeroCard:onUpdateMO(var_33_13)
		UISpriteSetMgr.instance:setCommonSprite(arg_33_0._careericon, "lssx_" .. tostring(arg_33_0.monsterCO.career))

		local var_33_14, var_33_15 = HeroConfig.instance:getShowLevel(arg_33_0.monsterCO.level)

		arg_33_0._lvnum.text = var_33_14

		for iter_33_4 = 1, 3 do
			local var_33_16 = arg_33_0._goRankList[iter_33_4]

			gohelper.setActive(var_33_16, iter_33_4 == var_33_15 - 1)
		end

		gohelper.setActive(arg_33_0._goStars, false)
	elseif arg_33_0.trialCO then
		local var_33_17 = HeroConfig.instance:getHeroCO(arg_33_0.trialCO.heroId)
		local var_33_18

		if arg_33_0.trialCO.skin > 0 then
			var_33_18 = SkinConfig.instance:getSkinCo(arg_33_0.trialCO.skin)
		else
			var_33_18 = SkinConfig.instance:getSkinCo(var_33_17.skinId)
		end

		if arg_33_0.isLock or arg_33_0.isAid or arg_33_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_33_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_33_0._goblackmask.transform, 300)
		end

		arg_33_0._commonHeroCard:onUpdateMO(var_33_18)
		UISpriteSetMgr.instance:setCommonSprite(arg_33_0._careericon, "lssx_" .. tostring(var_33_17.career))

		local var_33_19, var_33_20 = HeroConfig.instance:getShowLevel(arg_33_0.trialCO.level)

		arg_33_0._lvnum.text = var_33_19

		for iter_33_5 = 1, 3 do
			local var_33_21 = arg_33_0._goRankList[iter_33_5]

			gohelper.setActive(var_33_21, iter_33_5 == var_33_20 - 1)
		end

		gohelper.setActive(arg_33_0._goStars, true)

		for iter_33_6 = 1, 6 do
			local var_33_22 = arg_33_0._goStarList[iter_33_6]

			gohelper.setActive(var_33_22, iter_33_6 <= CharacterEnum.Star[var_33_17.rare])
		end
	end

	if arg_33_0._heroItemContainer then
		arg_33_0._heroItemContainer.compColor[arg_33_0._lvnumen] = arg_33_0._lvnumen.color

		for iter_33_7 = 1, 3 do
			arg_33_0._heroItemContainer.compColor[arg_33_0._goRankList[iter_33_7]] = arg_33_0._goRankList[iter_33_7].color
		end
	end

	arg_33_0.isLock = false
	arg_33_0.isAidLock = arg_33_0.mo.aid and arg_33_0.mo.aid == -1
	arg_33_0.isAid = arg_33_0.mo.aid ~= nil
	arg_33_0.isTrialLock = (arg_33_0.mo.trial and arg_33_0.mo.trialPos) ~= nil

	local var_33_23 = OdysseyHeroGroupModel.instance:getBattleRoleNum()

	arg_33_0.isRoleNumLock = var_33_23 and var_33_23 < arg_33_0.mo.id
	arg_33_0.isEmpty = arg_33_1:isEmpty()

	gohelper.setActive(arg_33_0._heroGO, (arg_33_0._heroMO ~= nil or arg_33_0.monsterCO ~= nil or arg_33_0.trialCO ~= nil) and not arg_33_0.isLock and not arg_33_0.isRoleNumLock)
	gohelper.setActive(arg_33_0._noneGO, arg_33_0._heroMO == nil and arg_33_0.monsterCO == nil and arg_33_0.trialCO == nil or arg_33_0.isLock or arg_33_0.isAidLock or arg_33_0.isRoleNumLock)
	gohelper.setActive(arg_33_0._addGO, arg_33_0._heroMO == nil and arg_33_0.monsterCO == nil and arg_33_0.trialCO == nil and not arg_33_0.isLock and not arg_33_0.isAidLock and not arg_33_0.isRoleNumLock)
	gohelper.setActive(arg_33_0._lockGO, arg_33_0:selfIsLock())

	local var_33_24 = arg_33_0.mo.aid and arg_33_0.mo.aid ~= -1

	gohelper.setActive(arg_33_0._aidGO, var_33_24)
	gohelper.setActive(arg_33_0._subGO, false)
	transformhelper.setLocalPosXY(arg_33_0._tagTr, 36.3, arg_33_0._subGO.activeSelf and 144.1 or 212.1)

	if arg_33_0.trialCO then
		gohelper.setActive(arg_33_0._trialTagGO, true)

		arg_33_0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(arg_33_0._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and arg_33_0.isRoleNumLock and arg_33_0._heroMO ~= nil and arg_33_0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(arg_33_0._heroMO.id)
	end

	arg_33_0:initEquips()
	arg_33_0:showCounterSign()

	if arg_33_0._playDeathAnim then
		arg_33_0._playDeathAnim = nil

		arg_33_0:playAnim(UIAnimationName.Open)
	end

	arg_33_0:_showMojingTip()
	arg_33_0:initOdysseyEquips()
end

function var_0_0.selfIsLock(arg_34_0)
	return arg_34_0.isLock or arg_34_0.isAidLock or arg_34_0.isRoleNumLock
end

function var_0_0.playRestrictAnimation(arg_35_0, arg_35_1)
	if arg_35_0._heroMO and arg_35_1[arg_35_0._heroMO.uid] then
		arg_35_0._playDeathAnim = true

		arg_35_0:playAnim("herogroup_hero_deal")

		arg_35_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_35_0.setGrayFactor, nil, arg_35_0)
	end
end

function var_0_0.setGrayFactor(arg_36_0, arg_36_1)
	arg_36_0._commonHeroCard:setGrayFactor(arg_36_1)
end

function var_0_0.resetGrayFactor(arg_37_0)
	arg_37_0._commonHeroCard:setGrayFactor(0)
end

function var_0_0.showCounterSign(arg_38_0)
	local var_38_0

	if arg_38_0._heroMO then
		var_38_0 = lua_character.configDict[arg_38_0._heroMO.heroId].career
	elseif arg_38_0.trialCO then
		var_38_0 = HeroConfig.instance:getHeroCO(arg_38_0.trialCO.heroId).career
	elseif arg_38_0.monsterCO then
		var_38_0 = arg_38_0.monsterCO.career
	end

	local var_38_1 = FightModel.instance:getFightParam()
	local var_38_2 = HeroGroupModel.instance:getHeroGroupType()
	local var_38_3 = var_38_2 and var_38_2 == OdysseyEnum.HeroGroupType.Fight
	local var_38_4 = 0
	local var_38_5 = 0

	if arg_38_0._goOdysseyEquipParent.transform.parent ~= arg_38_0._animGO.transform then
		var_38_5 = OdysseyEnum.CurrentOffset
	end

	local var_38_6 = arg_38_0._goOdysseyEquipParent.transform.localScale.x / arg_38_0._odysseyEmptyEquipParent.transform.localScale.x

	if var_38_3 and var_38_1 then
		local var_38_7, var_38_8 = FightHelper.detectAttributeCounter()
		local var_38_9 = tabletool.indexOf(var_38_7, var_38_0)
		local var_38_10 = tabletool.indexOf(var_38_8, var_38_0)

		gohelper.setActive(arg_38_0._gorecommended, var_38_9)
		gohelper.setActive(arg_38_0._gocounter, var_38_10)

		if var_38_9 or var_38_10 then
			var_38_4 = OdysseyEnum.RecommendOffset
		end
	else
		gohelper.setActive(arg_38_0._gorecommended, false)
		gohelper.setActive(arg_38_0._gocounter, false)
	end

	recthelper.setAnchorY(arg_38_0._odysseyEmptyEquipParent.transform, arg_38_0._odysseyEquipEmptyOriginPos.y + var_38_4)
	recthelper.setAnchorY(arg_38_0._goOdysseyEquipParent.transform, arg_38_0._odysseyEquipOriginPos.y + (var_38_4 + var_38_5) * var_38_6)
end

function var_0_0._setUIPressState(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	if not arg_39_1 then
		return
	end

	local var_39_0 = arg_39_1:GetEnumerator()

	while var_39_0:MoveNext() do
		local var_39_1

		if arg_39_2 then
			var_39_1 = arg_39_3 and arg_39_3[var_39_0.Current] * 0.7 or var_0_0.PressColor
			var_39_1.a = var_39_0.Current.color.a
		else
			var_39_1 = arg_39_3 and arg_39_3[var_39_0.Current] or Color.white
		end

		var_39_0.Current.color = var_39_1
	end
end

function var_0_0._onClickThis(arg_40_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_40_0.mo.aid or arg_40_0.isRoleNumLock then
		if arg_40_0.mo.aid == -1 or arg_40_0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if arg_40_0.isLock then
		local var_40_0, var_40_1 = HeroGroupModel.instance:getPositionLockDesc(arg_40_0.mo.id)

		GameFacade.showToast(var_40_0, var_40_1)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_40_0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function var_0_0._onClickThisDown(arg_41_0)
	arg_41_0:_setHeroItemPressState(true)
end

function var_0_0._onClickThisUp(arg_42_0)
	arg_42_0:_setHeroItemPressState(false)
end

function var_0_0._setHeroItemPressState(arg_43_0, arg_43_1)
	if not arg_43_0._heroItemContainer then
		arg_43_0._heroItemContainer = arg_43_0:getUserDataTb_()

		local var_43_0 = arg_43_0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_43_0._heroItemContainer.images = var_43_0

		local var_43_1 = arg_43_0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_43_0._heroItemContainer.tmps = var_43_1
		arg_43_0._heroItemContainer.compColor = {}

		local var_43_2 = var_43_0:GetEnumerator()

		while var_43_2:MoveNext() do
			arg_43_0._heroItemContainer.compColor[var_43_2.Current] = var_43_2.Current.color
		end

		local var_43_3 = var_43_1:GetEnumerator()

		while var_43_3:MoveNext() do
			arg_43_0._heroItemContainer.compColor[var_43_3.Current] = var_43_3.Current.color
		end
	end

	local var_43_4 = arg_43_0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	arg_43_0._heroItemContainer.spines = var_43_4

	if arg_43_0._heroItemContainer then
		arg_43_0:_setUIPressState(arg_43_0._heroItemContainer.images, arg_43_1, arg_43_0._heroItemContainer.compColor)
		arg_43_0:_setUIPressState(arg_43_0._heroItemContainer.tmps, arg_43_1, arg_43_0._heroItemContainer.compColor)
		arg_43_0:_setUIPressState(arg_43_0._heroItemContainer.spines, arg_43_1)
	end

	if arg_43_0._imageAdd then
		local var_43_5 = arg_43_1 and var_0_0.PressColor or Color.white

		arg_43_0._imageAdd.color = var_43_5
	end
end

function var_0_0._onClickEquip(arg_44_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or arg_44_0.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		arg_44_0._viewParam = {
			heroMo = arg_44_0._heroMO,
			equipMo = arg_44_0._equipMO,
			posIndex = arg_44_0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromOdysseyHeroGroupFightView
		}

		if arg_44_0.trialCO then
			arg_44_0._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(arg_44_0.trialCO)

			if arg_44_0.trialCO.equipId > 0 then
				arg_44_0._viewParam.equipMo = arg_44_0._viewParam.heroMo.trialEquipMo
			end
		end

		arg_44_0:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._onClickEquipDown(arg_45_0)
	arg_45_0:_setEquipItemPressState(true)
end

function var_0_0._onClickEquipUp(arg_46_0)
	arg_46_0:_setEquipItemPressState(false)
end

function var_0_0._setEquipItemPressState(arg_47_0, arg_47_1)
	if not arg_47_0._equipItemContainer then
		arg_47_0._equipItemContainer = arg_47_0:getUserDataTb_()
		arg_47_0._equipEmtpyContainer = arg_47_0:getUserDataTb_()

		local var_47_0 = arg_47_0._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_47_0._equipItemContainer.images = var_47_0

		local var_47_1 = arg_47_0._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_47_0._equipItemContainer.tmps = var_47_1
		arg_47_0._equipItemContainer.compColor = {}

		local var_47_2 = arg_47_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_47_0._equipEmtpyContainer.images = var_47_2

		local var_47_3 = arg_47_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_47_0._equipEmtpyContainer.tmps = var_47_3
		arg_47_0._equipEmtpyContainer.compColor = {}

		local var_47_4 = var_47_0:GetEnumerator()

		while var_47_4:MoveNext() do
			arg_47_0._equipItemContainer.compColor[var_47_4.Current] = var_47_4.Current.color
		end

		local var_47_5 = var_47_1:GetEnumerator()

		while var_47_5:MoveNext() do
			arg_47_0._equipItemContainer.compColor[var_47_5.Current] = var_47_5.Current.color
		end

		local var_47_6 = var_47_2:GetEnumerator()

		while var_47_6:MoveNext() do
			arg_47_0._equipEmtpyContainer.compColor[var_47_6.Current] = var_47_6.Current.color
		end

		local var_47_7 = var_47_3:GetEnumerator()

		while var_47_7:MoveNext() do
			arg_47_0._equipEmtpyContainer.compColor[var_47_7.Current] = var_47_7.Current.color
		end
	end

	if arg_47_0._equipItemContainer then
		arg_47_0:_setUIPressState(arg_47_0._equipItemContainer.images, arg_47_1, arg_47_0._equipItemContainer.compColor)
		arg_47_0:_setUIPressState(arg_47_0._equipItemContainer.tmps, arg_47_1, arg_47_0._equipItemContainer.compColor)
	end

	if arg_47_0._equipEmtpyContainer then
		arg_47_0:_setUIPressState(arg_47_0._equipEmtpyContainer.images, arg_47_1, arg_47_0._equipEmtpyContainer.compColor)
		arg_47_0:_setUIPressState(arg_47_0._equipEmtpyContainer.tmps, arg_47_1, arg_47_0._equipEmtpyContainer.compColor)
	end
end

function var_0_0._onOpenEquipTeamView(arg_48_0)
	EquipController.instance:openEquipInfoTeamView(arg_48_0._viewParam)
end

function var_0_0.onItemBeginDrag(arg_49_0, arg_49_1)
	if arg_49_1 == arg_49_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_49_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		ZProj.TweenHelper.DOScale(arg_49_0._odysseyEmptyEquipParent.transform, 0.682, 0.682, 1, 0.2, nil, nil, nil, EaseType.Linear)
		ZProj.TweenHelper.DOScale(arg_49_0._goOdysseyEquipParent.transform, 0.682, 0.682, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(arg_49_0._dragFrameGO, true)
		gohelper.setActive(arg_49_0._dragFrameSelectGO, true)
		gohelper.setActive(arg_49_0._dragFrameCompleteGO, false)
	end

	gohelper.setActive(arg_49_0._clickGO, false)
end

function var_0_0.onItemEndDrag(arg_50_0, arg_50_1, arg_50_2)
	ZProj.TweenHelper.DOScale(arg_50_0.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	ZProj.TweenHelper.DOScale(arg_50_0._odysseyEmptyEquipParent.transform, 0.62, 0.62, 1, 0.2, nil, nil, nil, EaseType.Linear)
	ZProj.TweenHelper.DOScale(arg_50_0._goOdysseyEquipParent.transform, 0.62, 0.62, 1, 0.2, nil, nil, nil, EaseType.Linear)
	arg_50_0:_setHeroItemPressState(false)
end

function var_0_0.onItemCompleteDrag(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	if arg_51_2 == arg_51_0.mo.id and arg_51_1 ~= arg_51_2 then
		if arg_51_3 then
			gohelper.setActive(arg_51_0._dragFrameGO, true)
			gohelper.setActive(arg_51_0._dragFrameSelectGO, false)
			gohelper.setActive(arg_51_0._dragFrameCompleteGO, false)
			gohelper.setActive(arg_51_0._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(arg_51_0.hideDragEffect, arg_51_0)
			TaskDispatcher.runDelay(arg_51_0.hideDragEffect, arg_51_0, 0.833)
		end
	else
		gohelper.setActive(arg_51_0._dragFrameGO, false)
	end

	gohelper.setActive(arg_51_0._clickGO, true)
end

function var_0_0.hideDragEffect(arg_52_0)
	gohelper.setActive(arg_52_0._dragFrameGO, false)
end

function var_0_0.setHeroGroupEquipEffect(arg_53_0, arg_53_1)
	arg_53_0._canPlayEffect = arg_53_1
end

function var_0_0.getAnimStateLength(arg_54_0, arg_54_1)
	arg_54_0.clipLengthDict = arg_54_0.clipLengthDict or {
		swicth = 0.833,
		herogroup_hero_deal = 1.667,
		[UIAnimationName.Open] = 0.833,
		[UIAnimationName.Close] = 0.333
	}

	local var_54_0 = arg_54_0.clipLengthDict[arg_54_1]

	if not var_54_0 then
		logError("not get animation state name :  " .. tostring(arg_54_1))
	end

	return var_54_0 or 0
end

function var_0_0.playAnim(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:getAnimStateLength(arg_55_1)

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, var_55_0)
	arg_55_0.anim:Play(arg_55_1, 0, 0)
end

function var_0_0.getOdysseyEquipItem(arg_56_0)
	return arg_56_0._odysseyItemList
end

function var_0_0.onDestroy(arg_57_0)
	if arg_57_0._equip then
		CommonDragHelper.instance:unregisterDragObj(arg_57_0._equip.moveContainer)
	end

	TaskDispatcher.cancelTask(arg_57_0._onOpenEquipTeamView, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0.hideDragEffect, arg_57_0)

	for iter_57_0, iter_57_1 in ipairs(arg_57_0._odysseyItemList) do
		CommonDragHelper.instance:unregisterDragObj(iter_57_1._gonoEmpty)
	end

	if arg_57_0._odysseyTweenId then
		ZProj.TweenHelper.KillById(arg_57_0._odysseyTweenId)
	end

	if arg_57_0._tweenId then
		ZProj.TweenHelper.KillById(arg_57_0._tweenId)
	end

	arg_57_0:_setEquipDragEnabled(true)
end

return var_0_0
