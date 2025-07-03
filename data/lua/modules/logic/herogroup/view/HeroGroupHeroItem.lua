module("modules.logic.herogroup.view.HeroGroupHeroItem", package.seeall)

local var_0_0 = class("HeroGroupHeroItem", LuaCompBase)

function var_0_0._init_overseas(arg_1_0)
	local var_1_0 = arg_1_0._tagTr.childCount

	arg_1_0._tagTranList = arg_1_0:getUserDataTb_()

	for iter_1_0 = 1, var_1_0 do
		local var_1_1 = arg_1_0._tagTr:GetChild(iter_1_0 - 1)

		table.insert(arg_1_0._tagTranList, var_1_1)
	end
end

function var_0_0._refreshTagsPos(arg_2_0)
	local var_2_0 = 160
	local var_2_1 = -80

	for iter_2_0, iter_2_1 in ipairs(arg_2_0._tagTranList) do
		if iter_2_1.gameObject.activeSelf then
			recthelper.setAnchorY(iter_2_1, var_2_0)

			var_2_0 = var_2_0 + var_2_1
		end
	end
end

function var_0_0.ctor(arg_3_0, arg_3_1)
	arg_3_0._heroGroupListView = arg_3_1
end

var_0_0.EquipTweenDuration = 0.16
var_0_0.EquipDragOffset = Vector2(0, 150)
var_0_0.EquipDragMobileScale = 1.7
var_0_0.EquipDragOtherScale = 1.4
var_0_0.PressColor = GameUtil.parseColor("#C8C8C8")

function var_0_0.init(arg_4_0, arg_4_1)
	arg_4_0.go = arg_4_1
	arg_4_0._noneGO = gohelper.findChild(arg_4_1, "heroitemani/none")
	arg_4_0._addGO = gohelper.findChild(arg_4_1, "heroitemani/none/add")
	arg_4_0._lockGO = gohelper.findChild(arg_4_1, "heroitemani/none/lock")
	arg_4_0._heroGO = gohelper.findChild(arg_4_1, "heroitemani/hero")
	arg_4_0._tagTr = gohelper.findChildComponent(arg_4_1, "heroitemani/tags", typeof(UnityEngine.Transform))
	arg_4_0._subGO = gohelper.findChild(arg_4_1, "heroitemani/tags/aidtag")
	arg_4_0._aidGO = gohelper.findChild(arg_4_1, "heroitemani/tags/storytag")
	arg_4_0._trialTagGO = gohelper.findChild(arg_4_1, "heroitemani/tags/trialtag")
	arg_4_0._trialTagTxt = gohelper.findChildTextMesh(arg_4_1, "heroitemani/tags/trialtag/#txt_trial_tag")
	arg_4_0._clickGO = gohelper.findChild(arg_4_1, "heroitemani/click")
	arg_4_0._clickThis = gohelper.getClick(arg_4_0._clickGO)
	arg_4_0._equipGO = gohelper.findChild(arg_4_1, "heroitemani/equip")
	arg_4_0._clickEquip = gohelper.getClick(arg_4_0._equipGO)
	arg_4_0._charactericon = gohelper.findChild(arg_4_1, "heroitemani/hero/charactericon")
	arg_4_0._careericon = gohelper.findChildImage(arg_4_1, "heroitemani/hero/career")
	arg_4_0._goblackmask = gohelper.findChild(arg_4_1, "heroitemani/hero/blackmask")
	arg_4_0.level_part = gohelper.findChild(arg_4_1, "heroitemani/hero/vertical/layout")
	arg_4_0._lvnum = gohelper.findChildText(arg_4_1, "heroitemani/hero/vertical/layout/lv/lvnum")
	arg_4_0._lvnumen = gohelper.findChildText(arg_4_1, "heroitemani/hero/vertical/layout/lv/lvnum/lv")
	arg_4_0._goRankList = arg_4_0:getUserDataTb_()

	for iter_4_0 = 1, 3 do
		local var_4_0 = gohelper.findChildImage(arg_4_1, "heroitemani/hero/vertical/layout/rankobj/rank" .. iter_4_0)

		table.insert(arg_4_0._goRankList, var_4_0)
	end

	arg_4_0._goStarList = arg_4_0:getUserDataTb_()

	for iter_4_1 = 1, 6 do
		local var_4_1 = gohelper.findChild(arg_4_1, "heroitemani/hero/vertical/#go_starList/star" .. iter_4_1)

		table.insert(arg_4_0._goStarList, var_4_1)
	end

	arg_4_0._goStars = gohelper.findChild(arg_4_1, "heroitemani/hero/vertical/#go_starList")
	arg_4_0._fakeEquipGO = gohelper.findChild(arg_4_1, "heroitemani/hero/vertical/fakeequip")
	arg_4_0._dragFrameGO = gohelper.findChild(arg_4_1, "heroitemani/selectedeffect")
	arg_4_0._dragFrameSelectGO = gohelper.findChild(arg_4_1, "heroitemani/selectedeffect/xuanzhong")
	arg_4_0._dragFrameCompleteGO = gohelper.findChild(arg_4_1, "heroitemani/selectedeffect/wancheng")

	gohelper.setActive(arg_4_0._dragFrameGO, false)

	arg_4_0._emptyEquipGo = gohelper.findChild(arg_4_1, "heroitemani/emptyequip")
	arg_4_0._animGO = gohelper.findChild(arg_4_1, "heroitemani")
	arg_4_0.anim = arg_4_0._animGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._replayReady = gohelper.findChild(arg_4_1, "heroitemani/hero/replayready")
	arg_4_0._gorecommended = gohelper.findChild(arg_4_1, "heroitemani/hero/#go_recommended")
	arg_4_0._gocounter = gohelper.findChild(arg_4_1, "heroitemani/hero/#go_counter")
	arg_4_0._herocardGo = gohelper.findChild(arg_4_1, "heroitemani/roleequip")
	arg_4_0._leftDrop = gohelper.findChildDropdown(arg_4_1, "heroitemani/roleequip/left")
	arg_4_0._rightDrop = gohelper.findChildDropdown(arg_4_1, "heroitemani/roleequip/right")
	arg_4_0._imageAdd = gohelper.findChildImage(arg_4_1, "heroitemani/none/add")
	arg_4_0._gomojing = gohelper.findChild(arg_4_1, "heroitemani/#go_mojing")
	arg_4_0._gomojingtxt = gohelper.findChildText(arg_4_1, "heroitemani/#go_mojing/#txt")
	arg_4_0._commonHeroCard = CommonHeroCard.create(arg_4_0._charactericon, arg_4_0._heroGroupListView.viewName)

	arg_4_0:_init_overseas()
end

function var_0_0.setIndex(arg_5_0, arg_5_1)
	arg_5_0._index = arg_5_1
end

function var_0_0._showMojingTip(arg_6_0)
	local var_6_0 = false
	local var_6_1 = HeroGroupModel.instance.episodeId
	local var_6_2 = DungeonConfig.instance:getEpisodeCO(var_6_1)

	if var_6_2 and var_6_2.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.Daily then
		var_6_0 = arg_6_0._index == 3
	end

	gohelper.setActive(arg_6_0._gomojing, var_6_0)

	if not var_6_0 then
		return
	end

	arg_6_0._gomojingtxt.text = luaLang("p_v1a3_herogroup_mojing_" .. tostring(var_6_1))
end

function var_0_0.setParent(arg_7_0, arg_7_1)
	arg_7_0.currentParent = arg_7_1

	for iter_7_0, iter_7_1 in ipairs(arg_7_0._tagTranList) do
		iter_7_1:SetParent(arg_7_1, true)

		iter_7_1.anchorMin = Vector2.New(0, 1)
		iter_7_1.anchorMax = Vector2.New(0, 1)
		iter_7_1.pivot = Vector2(0, 0)
	end

	arg_7_0._equipGO.transform:SetParent(arg_7_1, true)
end

function var_0_0.flowOriginParent(arg_8_0)
	arg_8_0._equipGO.transform:SetParent(arg_8_0._animGO.transform, false)
end

function var_0_0.flowCurrentParent(arg_9_0)
	arg_9_0._equipGO.transform:SetParent(arg_9_0.currentParent, false)
end

function var_0_0.initEquips(arg_10_0, arg_10_1)
	arg_10_0._equipType = -1

	if arg_10_0.isLock or arg_10_0.isAid or arg_10_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not arg_10_0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(arg_10_0._equipGO, false)
		gohelper.setActive(arg_10_0._fakeEquipGO, false)
		gohelper.setActive(arg_10_0._emptyEquipGo, false)
	else
		gohelper.setActive(arg_10_0._equipGO, true)
		gohelper.setActive(arg_10_0._fakeEquipGO, true)
		gohelper.setActive(arg_10_0._emptyEquipGo, true)

		if not arg_10_0._equip then
			arg_10_0._equip = arg_10_0:getUserDataTb_()
			arg_10_0._equip.moveContainer = gohelper.findChild(arg_10_0._equipGO, "moveContainer")
			arg_10_0._equip.equipIcon = gohelper.findChildImage(arg_10_0._equipGO, "moveContainer/equipIcon")
			arg_10_0._equip.equipRare = gohelper.findChildImage(arg_10_0._equipGO, "moveContainer/equiprare")
			arg_10_0._equip.equiptxten = gohelper.findChildText(arg_10_0._equipGO, "equiptxten")
			arg_10_0._equip.equiptxtlv = gohelper.findChildText(arg_10_0._equipGO, "moveContainer/equiplv/txtequiplv")
			arg_10_0._equip.equipGolv = gohelper.findChild(arg_10_0._equipGO, "moveContainer/equiplv")

			arg_10_0:_equipIconAddDrag(arg_10_0._equip.moveContainer, arg_10_0._equip.equipIcon)
		end

		local var_10_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_10_0.mo.id - 1).equipUid[1]

		arg_10_0._equipMO = EquipModel.instance:getEquip(var_10_0) or HeroGroupTrialModel.instance:getEquipMo(var_10_0)

		if HeroGroupModel.instance:getCurGroupMO().isReplay then
			arg_10_0._equipMO = nil

			local var_10_1 = HeroGroupModel.instance:getCurGroupMO().replay_equip_data[arg_10_0.mo.heroUid]

			if var_10_1 then
				local var_10_2 = EquipConfig.instance:getEquipCo(var_10_1.equipId)

				if var_10_2 then
					arg_10_0._equipMO = {}
					arg_10_0._equipMO.config = var_10_2
					arg_10_0._equipMO.refineLv = var_10_1.refineLv
					arg_10_0._equipMO.level = var_10_1.equipLv
				end
			end
		end

		local var_10_3

		if arg_10_0.trialCO and arg_10_0.trialCO.equipId > 0 then
			var_10_3 = EquipConfig.instance:getEquipCo(arg_10_0.trialCO.equipId)
		end

		if arg_10_0._equipMO then
			arg_10_0._equipType = arg_10_0._equipMO.config.rare - 2
		elseif var_10_3 then
			arg_10_0._equipType = var_10_3.rare - 2
		end

		gohelper.setActive(arg_10_0._equip.equipIcon.gameObject, arg_10_0._equipMO or var_10_3)
		gohelper.setActive(arg_10_0._equip.equipRare.gameObject, arg_10_0._equipMO or var_10_3)
		gohelper.setActive(arg_10_0._equip.equipAddGO, not arg_10_0._equipMO and not var_10_3)
		gohelper.setActive(arg_10_0._equip.equipGolv, arg_10_0._equipMO or var_10_3)
		ZProj.UGUIHelper.SetColorAlpha(arg_10_0._equip.equiptxten, (arg_10_0._equipMO or var_10_3) and 0.15 or 0.06)

		if arg_10_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_10_0._equip.equipIcon, arg_10_0._equipMO.config.icon)

			local var_10_4, var_10_5, var_10_6 = HeroGroupBalanceHelper.getBalanceLv()

			if var_10_6 and var_10_6 > arg_10_0._equipMO.level and arg_10_0._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				arg_10_0._equip.equiptxtlv.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">Lv." .. var_10_6
			else
				arg_10_0._equip.equiptxtlv.text = "Lv." .. arg_10_0._equipMO.level
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_10_0._equip.equipRare, "bianduixingxian_" .. arg_10_0._equipMO.config.rare)
			arg_10_0:_showEquipParticleEffect(arg_10_1)
		elseif var_10_3 then
			local var_10_7 = EquipConfig.instance:getEquipCo(arg_10_0.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_10_0._equip.equipIcon, var_10_7.icon)

			arg_10_0._equip.equiptxtlv.text = luaLang("level") .. arg_10_0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_10_0._equip.equipRare, "bianduixingxian_" .. var_10_7.rare)
			arg_10_0:_showEquipParticleEffect(arg_10_1)
		end
	end

	arg_10_0.last_equip = arg_10_0._equipMO and arg_10_0._equipMO.uid
	arg_10_0.last_hero = arg_10_0._heroMO and arg_10_0._heroMO.heroId or 0
end

function var_0_0._showEquipParticleEffect(arg_11_0, arg_11_1)
	if arg_11_1 == arg_11_0.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function var_0_0._equipIconAddDrag(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2:GetComponent(gohelper.Type_Image).raycastTarget = true

	local var_12_0 = var_0_0.EquipDragOtherScale
	local var_12_1

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_12_1 = var_0_0.EquipDragOffset
		var_12_0 = var_0_0.EquipDragMobileScale
	end

	CommonDragHelper.instance:registerDragObj(arg_12_1, arg_12_0._onBeginDrag, nil, arg_12_0._onEndDrag, arg_12_0._checkDrag, arg_12_0, arg_12_1.transform, nil, var_12_1, var_12_0)
end

function var_0_0._checkDrag(arg_13_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return true
	end

	if arg_13_0.trialCO and arg_13_0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return true
	end

	return false
end

function var_0_0._onBeginDrag(arg_14_0)
	gohelper.setAsLastSibling(arg_14_0._heroGroupListView.heroPosTrList[arg_14_0.mo.id].parent.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(arg_14_0._equip.equipGolv, false)
end

function var_0_0._onEndDrag(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_15_0 = var_15_0 + var_0_0.EquipDragOffset
	end

	local var_15_1 = arg_15_0:_moveToTarget(var_15_0)

	arg_15_0:_setEquipDragEnabled(false)

	local var_15_2 = var_15_1 and var_15_1.trialCO and var_15_1.trialCO.equipId > 0

	if not var_15_1 or var_15_1 == arg_15_0 or var_15_1.mo.aid or var_15_2 or not var_15_1._equipGO.activeSelf then
		if var_15_2 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		arg_15_0:_setToPos(arg_15_0._equip.moveContainer.transform, Vector2(), true, function()
			gohelper.setActive(arg_15_0._equip.equipGolv, true)
			arg_15_0:_setEquipDragEnabled(true)
		end, arg_15_0)
		arg_15_0:_showEquipParticleEffect()

		return
	end

	arg_15_0:_playDragEndAudio(var_15_1)
	gohelper.setAsLastSibling(arg_15_0._heroGroupListView.heroPosTrList[var_15_1.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(arg_15_0._heroGroupListView.heroPosTrList[arg_15_0.mo.id].parent.gameObject)

	local var_15_3 = recthelper.rectToRelativeAnchorPos(arg_15_0._equipGO.transform.position, var_15_1._equipGO.transform)

	arg_15_0._tweenId = arg_15_0:_setToPos(var_15_1._equip.moveContainer.transform, var_15_3, true)

	local var_15_4 = recthelper.rectToRelativeAnchorPos(var_15_1._equipGO.transform.position, arg_15_0._equipGO.transform)

	arg_15_0:_setToPos(arg_15_0._equip.moveContainer.transform, var_15_4, true, function()
		EquipTeamListModel.instance:openTeamEquip(arg_15_0.mo.id - 1, arg_15_0._heroMO)

		if arg_15_0._tweenId then
			ZProj.TweenHelper.KillById(arg_15_0._tweenId)
		end

		arg_15_0:_setToPos(arg_15_0._equip.moveContainer.transform, Vector2())
		arg_15_0:_setToPos(var_15_1._equip.moveContainer.transform, Vector2())
		gohelper.setActive(arg_15_0._equip.equipGolv, true)
		arg_15_0:_setEquipDragEnabled(true)

		local var_17_0 = arg_15_0.mo.id - 1
		local var_17_1 = var_15_1.mo.id - 1
		local var_17_2 = EquipTeamListModel.instance:getTeamEquip(var_17_0)[1]

		var_17_2 = (EquipModel.instance:getEquip(var_17_2) or HeroGroupTrialModel.instance:getEquipMo(var_17_2)) and var_17_2 or nil

		if var_17_2 then
			EquipTeamShowItem.removeEquip(var_17_0, true)
		end

		local var_17_3 = EquipTeamListModel.instance:getTeamEquip(var_17_1)[1]

		var_17_3 = (EquipModel.instance:getEquip(var_17_3) or HeroGroupTrialModel.instance:getEquipMo(var_17_3)) and var_17_3 or nil

		if var_17_3 then
			EquipTeamShowItem.removeEquip(var_17_1, true)
		end

		if var_17_2 then
			EquipTeamShowItem.replaceEquip(var_17_1, var_17_2, true)
		end

		if var_17_3 then
			EquipTeamShowItem.replaceEquip(var_17_0, var_17_3, true)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
		HeroGroupModel.instance:saveCurGroupData()
	end, arg_15_0)
end

function var_0_0.resetEquipPos(arg_18_0)
	if not arg_18_0._equip then
		return
	end

	local var_18_0 = arg_18_0._equip.moveContainer.transform

	recthelper.setAnchor(var_18_0, 0, 0)
	transformhelper.setLocalScale(var_18_0, 1, 1, 1)
end

function var_0_0._playDragEndAudio(arg_19_0, arg_19_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function var_0_0._setToPos(arg_20_0, arg_20_1, arg_20_2, arg_20_3, arg_20_4, arg_20_5)
	local var_20_0, var_20_1 = recthelper.getAnchor(arg_20_1)

	if arg_20_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_20_1, arg_20_2.x, arg_20_2.y, 0.2, arg_20_4, arg_20_5)
	else
		recthelper.setAnchor(arg_20_1, arg_20_2.x, arg_20_2.y)

		if arg_20_4 then
			arg_20_4(arg_20_5)
		end
	end
end

function var_0_0._moveToTarget(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0._heroGroupListView.heroPosTrList) do
		if arg_21_0._heroGroupListView._heroItemList[iter_21_0] ~= arg_21_0 then
			local var_21_0 = iter_21_1.parent
			local var_21_1 = recthelper.screenPosToAnchorPos(arg_21_1, var_21_0)

			if math.abs(var_21_1.x) * 2 < recthelper.getWidth(var_21_0) and math.abs(var_21_1.y) * 2 < recthelper.getHeight(var_21_0) then
				local var_21_2 = arg_21_0._heroGroupListView._heroItemList[iter_21_0]

				return not var_21_2:selfIsLock() and var_21_2 or nil
			end
		end
	end

	return nil
end

function var_0_0._setEquipDragEnabled(arg_22_0, arg_22_1)
	CommonDragHelper.instance:setGlobalEnabled(arg_22_1)
end

function var_0_0.addEventListeners(arg_23_0)
	arg_23_0._clickThis:AddClickListener(arg_23_0._onClickThis, arg_23_0)
	arg_23_0._clickThis:AddClickDownListener(arg_23_0._onClickThisDown, arg_23_0)
	arg_23_0._clickThis:AddClickUpListener(arg_23_0._onClickThisUp, arg_23_0)
	arg_23_0._clickEquip:AddClickListener(arg_23_0._onClickEquip, arg_23_0)
	arg_23_0._clickEquip:AddClickDownListener(arg_23_0._onClickEquipDown, arg_23_0)
	arg_23_0._clickEquip:AddClickUpListener(arg_23_0._onClickEquipUp, arg_23_0)
	arg_23_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, arg_23_0.setHeroGroupEquipEffect, arg_23_0)
	arg_23_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, arg_23_0.playHeroGroupHeroEffect, arg_23_0)
	arg_23_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_23_0.initEquips, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_23_0.initEquips, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_23_0.initEquips, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_23_0.initEquips, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_23_0.initEquips, arg_23_0)
	arg_23_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_23_0.initEquips, arg_23_0)
end

function var_0_0.removeEventListeners(arg_24_0)
	arg_24_0._clickThis:RemoveClickListener()
	arg_24_0._clickThis:RemoveClickUpListener()
	arg_24_0._clickThis:RemoveClickDownListener()
	arg_24_0._clickEquip:RemoveClickListener()
	arg_24_0._clickEquip:RemoveClickUpListener()
	arg_24_0._clickEquip:RemoveClickDownListener()
end

function var_0_0.playHeroGroupHeroEffect(arg_25_0, arg_25_1)
	arg_25_0:playAnim(arg_25_1)

	arg_25_0.last_equip = nil
	arg_25_0.last_hero = nil
end

function var_0_0.onUpdateMO(arg_26_0, arg_26_1)
	arg_26_0._commonHeroCard:setGrayScale(false)

	local var_26_0 = HeroGroupModel.instance.battleId
	local var_26_1 = var_26_0 and lua_battle.configDict[var_26_0]

	arg_26_0.mo = arg_26_1
	arg_26_0._posIndex = arg_26_0.mo.id - 1
	arg_26_0._heroMO = arg_26_1:getHeroMO()
	arg_26_0.monsterCO = arg_26_1:getMonsterCO()
	arg_26_0.trialCO = arg_26_1:getTrialCO()

	gohelper.setActive(arg_26_0._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	local var_26_2

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		var_26_2 = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[arg_26_0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_26_0._lvnumen, "#E9E9E9")

	for iter_26_0 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(arg_26_0._goRankList[iter_26_0], "#F6F3EC")
	end

	if arg_26_0._heroMO then
		local var_26_3 = HeroModel.instance:getByHeroId(arg_26_0._heroMO.heroId)
		local var_26_4 = FightConfig.instance:getSkinCO(var_26_2 and var_26_2.skin or var_26_3.skin)

		arg_26_0._commonHeroCard:onUpdateMO(var_26_4)

		if arg_26_0.isLock or arg_26_0.isAid or arg_26_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_26_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_26_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._careericon, "lssx_" .. tostring(arg_26_0._heroMO.config.career))

		local var_26_5 = var_26_2 and var_26_2.level or arg_26_0._heroMO.level
		local var_26_6 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_26_0._heroMO.heroId)
		local var_26_7

		if var_26_5 < var_26_6 then
			var_26_5 = var_26_6
			var_26_7 = true
		end

		local var_26_8, var_26_9 = HeroConfig.instance:getShowLevel(var_26_5)

		if var_26_7 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_26_0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			arg_26_0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. var_26_8

			for iter_26_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_26_0._goRankList[iter_26_1], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			arg_26_0._lvnum.text = var_26_8
		end

		for iter_26_2 = 1, 3 do
			local var_26_10 = arg_26_0._goRankList[iter_26_2]

			gohelper.setActive(var_26_10, iter_26_2 == var_26_9 - 1)
		end

		gohelper.setActive(arg_26_0._goStars, true)

		for iter_26_3 = 1, 6 do
			local var_26_11 = arg_26_0._goStarList[iter_26_3]

			gohelper.setActive(var_26_11, iter_26_3 <= CharacterEnum.Star[arg_26_0._heroMO.config.rare])
		end
	elseif arg_26_0.monsterCO then
		local var_26_12 = FightConfig.instance:getSkinCO(arg_26_0.monsterCO.skinId)

		arg_26_0._commonHeroCard:onUpdateMO(var_26_12)
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._careericon, "lssx_" .. tostring(arg_26_0.monsterCO.career))

		local var_26_13, var_26_14 = HeroConfig.instance:getShowLevel(arg_26_0.monsterCO.level)

		arg_26_0._lvnum.text = var_26_13

		for iter_26_4 = 1, 3 do
			local var_26_15 = arg_26_0._goRankList[iter_26_4]

			gohelper.setActive(var_26_15, iter_26_4 == var_26_14 - 1)
		end

		gohelper.setActive(arg_26_0._goStars, false)
	elseif arg_26_0.trialCO then
		local var_26_16 = HeroConfig.instance:getHeroCO(arg_26_0.trialCO.heroId)
		local var_26_17

		if arg_26_0.trialCO.skin > 0 then
			var_26_17 = SkinConfig.instance:getSkinCo(arg_26_0.trialCO.skin)
		else
			var_26_17 = SkinConfig.instance:getSkinCo(var_26_16.skinId)
		end

		if arg_26_0.isLock or arg_26_0.isAid or arg_26_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_26_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_26_0._goblackmask.transform, 300)
		end

		arg_26_0._commonHeroCard:onUpdateMO(var_26_17)
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._careericon, "lssx_" .. tostring(var_26_16.career))

		local var_26_18, var_26_19 = HeroConfig.instance:getShowLevel(arg_26_0.trialCO.level)

		arg_26_0._lvnum.text = var_26_18

		for iter_26_5 = 1, 3 do
			local var_26_20 = arg_26_0._goRankList[iter_26_5]

			gohelper.setActive(var_26_20, iter_26_5 == var_26_19 - 1)
		end

		gohelper.setActive(arg_26_0._goStars, true)

		for iter_26_6 = 1, 6 do
			local var_26_21 = arg_26_0._goStarList[iter_26_6]

			gohelper.setActive(var_26_21, iter_26_6 <= CharacterEnum.Star[var_26_16.rare])
		end
	end

	if arg_26_0._heroItemContainer then
		arg_26_0._heroItemContainer.compColor[arg_26_0._lvnumen] = arg_26_0._lvnumen.color

		for iter_26_7 = 1, 3 do
			arg_26_0._heroItemContainer.compColor[arg_26_0._goRankList[iter_26_7]] = arg_26_0._goRankList[iter_26_7].color
		end
	end

	arg_26_0.isLock = not HeroGroupModel.instance:isPositionOpen(arg_26_0.mo.id)
	arg_26_0.isAidLock = arg_26_0.mo.aid and arg_26_0.mo.aid == -1
	arg_26_0.isAid = arg_26_0.mo.aid ~= nil
	arg_26_0.isTrialLock = (arg_26_0.mo.trial and arg_26_0.mo.trialPos) ~= nil

	local var_26_22 = HeroGroupModel.instance:getBattleRoleNum()

	arg_26_0.isRoleNumLock = var_26_22 and var_26_22 < arg_26_0.mo.id
	arg_26_0.isEmpty = arg_26_1:isEmpty()

	gohelper.setActive(arg_26_0._heroGO, (arg_26_0._heroMO ~= nil or arg_26_0.monsterCO ~= nil or arg_26_0.trialCO ~= nil) and not arg_26_0.isLock and not arg_26_0.isRoleNumLock)
	gohelper.setActive(arg_26_0._noneGO, arg_26_0._heroMO == nil and arg_26_0.monsterCO == nil and arg_26_0.trialCO == nil or arg_26_0.isLock or arg_26_0.isAidLock or arg_26_0.isRoleNumLock)
	gohelper.setActive(arg_26_0._addGO, arg_26_0._heroMO == nil and arg_26_0.monsterCO == nil and arg_26_0.trialCO == nil and not arg_26_0.isLock and not arg_26_0.isAidLock and not arg_26_0.isRoleNumLock)
	gohelper.setActive(arg_26_0._lockGO, arg_26_0:selfIsLock())
	gohelper.setActive(arg_26_0._aidGO, arg_26_0.mo.aid and arg_26_0.mo.aid ~= -1)

	if var_26_1 then
		gohelper.setActive(arg_26_0._subGO, not arg_26_0.isLock and not arg_26_0.isAidLock and not arg_26_0.isRoleNumLock and arg_26_0.mo.id > var_26_1.playerMax)
	else
		gohelper.setActive(arg_26_0._subGO, not arg_26_0.isLock and not arg_26_0.isAidLock and not arg_26_0.isRoleNumLock and arg_26_0.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	if arg_26_0.trialCO then
		gohelper.setActive(arg_26_0._trialTagGO, true)

		arg_26_0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(arg_26_0._trialTagGO, false)
	end

	arg_26_0:_refreshTagsPos()

	if not HeroSingleGroupModel.instance:isTemp() and arg_26_0.isRoleNumLock and arg_26_0._heroMO ~= nil and arg_26_0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(arg_26_0._heroMO.id)
	end

	arg_26_0:initEquips()
	arg_26_0:showCounterSign()

	if arg_26_0._playDeathAnim then
		arg_26_0._playDeathAnim = nil

		arg_26_0:playAnim(UIAnimationName.Open)
	end

	arg_26_0:_showMojingTip()
end

function var_0_0.selfIsLock(arg_27_0)
	return arg_27_0.isLock or arg_27_0.isAidLock or arg_27_0.isRoleNumLock
end

function var_0_0.playRestrictAnimation(arg_28_0, arg_28_1)
	if arg_28_0._heroMO and arg_28_1[arg_28_0._heroMO.uid] then
		arg_28_0._playDeathAnim = true

		arg_28_0:playAnim("herogroup_hero_deal")

		arg_28_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_28_0.setGrayFactor, nil, arg_28_0)
	end
end

function var_0_0.setGrayFactor(arg_29_0, arg_29_1)
	arg_29_0._commonHeroCard:setGrayFactor(arg_29_1)
end

function var_0_0.resetGrayFactor(arg_30_0)
	arg_30_0._commonHeroCard:setGrayFactor(0)
end

function var_0_0.showCounterSign(arg_31_0)
	local var_31_0

	if arg_31_0._heroMO then
		var_31_0 = lua_character.configDict[arg_31_0._heroMO.heroId].career
	elseif arg_31_0.trialCO then
		var_31_0 = HeroConfig.instance:getHeroCO(arg_31_0.trialCO.heroId).career
	elseif arg_31_0.monsterCO then
		var_31_0 = arg_31_0.monsterCO.career
	end

	local var_31_1, var_31_2 = FightHelper.detectAttributeCounter()

	gohelper.setActive(arg_31_0._gorecommended, tabletool.indexOf(var_31_1, var_31_0))
	gohelper.setActive(arg_31_0._gocounter, tabletool.indexOf(var_31_2, var_31_0))
end

function var_0_0._setUIPressState(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if not arg_32_1 then
		return
	end

	local var_32_0 = arg_32_1:GetEnumerator()

	while var_32_0:MoveNext() do
		local var_32_1

		if arg_32_2 then
			var_32_1 = arg_32_3 and arg_32_3[var_32_0.Current] * 0.7 or var_0_0.PressColor
			var_32_1.a = var_32_0.Current.color.a
		else
			var_32_1 = arg_32_3 and arg_32_3[var_32_0.Current] or Color.white
		end

		var_32_0.Current.color = var_32_1
	end
end

function var_0_0._onClickThis(arg_33_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_33_0.mo.aid or arg_33_0.isRoleNumLock then
		if arg_33_0.mo.aid == -1 or arg_33_0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if arg_33_0.isLock then
		local var_33_0, var_33_1 = HeroGroupModel.instance:getPositionLockDesc(arg_33_0.mo.id)

		GameFacade.showToast(var_33_0, var_33_1)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_33_0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function var_0_0._onClickThisDown(arg_34_0)
	arg_34_0:_setHeroItemPressState(true)
end

function var_0_0._onClickThisUp(arg_35_0)
	arg_35_0:_setHeroItemPressState(false)
end

function var_0_0._setHeroItemPressState(arg_36_0, arg_36_1)
	if not arg_36_0._heroItemContainer then
		arg_36_0._heroItemContainer = arg_36_0:getUserDataTb_()

		local var_36_0 = arg_36_0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_36_0._heroItemContainer.images = var_36_0

		local var_36_1 = arg_36_0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_36_0._heroItemContainer.tmps = var_36_1
		arg_36_0._heroItemContainer.compColor = {}

		local var_36_2 = var_36_0:GetEnumerator()

		while var_36_2:MoveNext() do
			arg_36_0._heroItemContainer.compColor[var_36_2.Current] = var_36_2.Current.color
		end

		local var_36_3 = var_36_1:GetEnumerator()

		while var_36_3:MoveNext() do
			arg_36_0._heroItemContainer.compColor[var_36_3.Current] = var_36_3.Current.color
		end
	end

	local var_36_4 = arg_36_0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	arg_36_0._heroItemContainer.spines = var_36_4

	if arg_36_0._heroItemContainer then
		arg_36_0:_setUIPressState(arg_36_0._heroItemContainer.images, arg_36_1, arg_36_0._heroItemContainer.compColor)
		arg_36_0:_setUIPressState(arg_36_0._heroItemContainer.tmps, arg_36_1, arg_36_0._heroItemContainer.compColor)
		arg_36_0:_setUIPressState(arg_36_0._heroItemContainer.spines, arg_36_1)
	end

	if arg_36_0._imageAdd then
		local var_36_5 = arg_36_1 and var_0_0.PressColor or Color.white

		arg_36_0._imageAdd.color = var_36_5
	end
end

function var_0_0._onClickEquip(arg_37_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or arg_37_0.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		arg_37_0._viewParam = {
			heroMo = arg_37_0._heroMO,
			equipMo = arg_37_0._equipMO,
			posIndex = arg_37_0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromHeroGroupFightView
		}

		if arg_37_0.trialCO then
			arg_37_0._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(arg_37_0.trialCO)

			if arg_37_0.trialCO.equipId > 0 then
				arg_37_0._viewParam.equipMo = arg_37_0._viewParam.heroMo.trialEquipMo
			end
		end

		arg_37_0:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._onClickEquipDown(arg_38_0)
	arg_38_0:_setEquipItemPressState(true)
end

function var_0_0._onClickEquipUp(arg_39_0)
	arg_39_0:_setEquipItemPressState(false)
end

function var_0_0._setEquipItemPressState(arg_40_0, arg_40_1)
	if not arg_40_0._equipItemContainer then
		arg_40_0._equipItemContainer = arg_40_0:getUserDataTb_()
		arg_40_0._equipEmtpyContainer = arg_40_0:getUserDataTb_()

		local var_40_0 = arg_40_0._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_40_0._equipItemContainer.images = var_40_0

		local var_40_1 = arg_40_0._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_40_0._equipItemContainer.tmps = var_40_1
		arg_40_0._equipItemContainer.compColor = {}

		local var_40_2 = arg_40_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_40_0._equipEmtpyContainer.images = var_40_2

		local var_40_3 = arg_40_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_40_0._equipEmtpyContainer.tmps = var_40_3
		arg_40_0._equipEmtpyContainer.compColor = {}

		local var_40_4 = var_40_0:GetEnumerator()

		while var_40_4:MoveNext() do
			arg_40_0._equipItemContainer.compColor[var_40_4.Current] = var_40_4.Current.color
		end

		local var_40_5 = var_40_1:GetEnumerator()

		while var_40_5:MoveNext() do
			arg_40_0._equipItemContainer.compColor[var_40_5.Current] = var_40_5.Current.color
		end

		local var_40_6 = var_40_2:GetEnumerator()

		while var_40_6:MoveNext() do
			arg_40_0._equipEmtpyContainer.compColor[var_40_6.Current] = var_40_6.Current.color
		end

		local var_40_7 = var_40_3:GetEnumerator()

		while var_40_7:MoveNext() do
			arg_40_0._equipEmtpyContainer.compColor[var_40_7.Current] = var_40_7.Current.color
		end
	end

	if arg_40_0._equipItemContainer then
		arg_40_0:_setUIPressState(arg_40_0._equipItemContainer.images, arg_40_1, arg_40_0._equipItemContainer.compColor)
		arg_40_0:_setUIPressState(arg_40_0._equipItemContainer.tmps, arg_40_1, arg_40_0._equipItemContainer.compColor)
	end

	if arg_40_0._equipEmtpyContainer then
		arg_40_0:_setUIPressState(arg_40_0._equipEmtpyContainer.images, arg_40_1, arg_40_0._equipEmtpyContainer.compColor)
		arg_40_0:_setUIPressState(arg_40_0._equipEmtpyContainer.tmps, arg_40_1, arg_40_0._equipEmtpyContainer.compColor)
	end
end

function var_0_0._onOpenEquipTeamView(arg_41_0)
	EquipController.instance:openEquipInfoTeamView(arg_41_0._viewParam)
end

function var_0_0.onItemBeginDrag(arg_42_0, arg_42_1)
	if arg_42_1 == arg_42_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_42_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(arg_42_0._dragFrameGO, true)
		gohelper.setActive(arg_42_0._dragFrameSelectGO, true)
		gohelper.setActive(arg_42_0._dragFrameCompleteGO, false)
	end

	gohelper.setActive(arg_42_0._clickGO, false)
end

function var_0_0.onItemEndDrag(arg_43_0, arg_43_1, arg_43_2)
	ZProj.TweenHelper.DOScale(arg_43_0.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	arg_43_0:_setHeroItemPressState(false)
end

function var_0_0.onItemCompleteDrag(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	if arg_44_2 == arg_44_0.mo.id and arg_44_1 ~= arg_44_2 then
		if arg_44_3 then
			gohelper.setActive(arg_44_0._dragFrameGO, true)
			gohelper.setActive(arg_44_0._dragFrameSelectGO, false)
			gohelper.setActive(arg_44_0._dragFrameCompleteGO, false)
			gohelper.setActive(arg_44_0._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(arg_44_0.hideDragEffect, arg_44_0)
			TaskDispatcher.runDelay(arg_44_0.hideDragEffect, arg_44_0, 0.833)
		end
	else
		gohelper.setActive(arg_44_0._dragFrameGO, false)
	end

	gohelper.setActive(arg_44_0._clickGO, true)
end

function var_0_0.hideDragEffect(arg_45_0)
	gohelper.setActive(arg_45_0._dragFrameGO, false)
end

function var_0_0.setHeroGroupEquipEffect(arg_46_0, arg_46_1)
	arg_46_0._canPlayEffect = arg_46_1
end

function var_0_0.getAnimStateLength(arg_47_0, arg_47_1)
	arg_47_0.clipLengthDict = arg_47_0.clipLengthDict or {
		swicth = 0.833,
		herogroup_hero_deal = 1.667,
		[UIAnimationName.Open] = 0.833,
		[UIAnimationName.Close] = 0.333
	}

	local var_47_0 = arg_47_0.clipLengthDict[arg_47_1]

	if not var_47_0 then
		logError("not get animation state name :  " .. tostring(arg_47_1))
	end

	return var_47_0 or 0
end

function var_0_0.playAnim(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_0:getAnimStateLength(arg_48_1)

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, var_48_0)
	arg_48_0.anim:Play(arg_48_1, 0, 0)
end

function var_0_0.onDestroy(arg_49_0)
	if arg_49_0._equip then
		CommonDragHelper.instance:unregisterDragObj(arg_49_0._equip.moveContainer)
	end

	TaskDispatcher.cancelTask(arg_49_0._onOpenEquipTeamView, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0.hideDragEffect, arg_49_0)
end

return var_0_0
