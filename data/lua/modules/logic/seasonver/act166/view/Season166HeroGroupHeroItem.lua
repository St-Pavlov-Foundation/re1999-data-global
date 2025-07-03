module("modules.logic.seasonver.act166.view.Season166HeroGroupHeroItem", package.seeall)

local var_0_0 = class("Season166HeroGroupHeroItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._heroGroupListView = arg_1_1
end

var_0_0.EquipTweenDuration = 0.16
var_0_0.EquipDragOffset = Vector2(0, 150)
var_0_0.EquipDragMobileScale = 1.7
var_0_0.EquipDragOtherScale = 1.4
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
	arg_2_0._commonHeroCard = CommonHeroCard.create(arg_2_0._charactericon, arg_2_0._heroGroupListView.viewName)
end

function var_0_0.setIndex(arg_3_0, arg_3_1)
	arg_3_0._index = arg_3_1
end

function var_0_0.setParent(arg_4_0, arg_4_1)
	arg_4_0.currentParent = arg_4_1

	arg_4_0._subGO.transform:SetParent(arg_4_1, true)
	arg_4_0._equipGO.transform:SetParent(arg_4_1, true)
end

function var_0_0.flowOriginParent(arg_5_0)
	arg_5_0._equipGO.transform:SetParent(arg_5_0._animGO.transform, false)
end

function var_0_0.flowCurrentParent(arg_6_0)
	arg_6_0._equipGO.transform:SetParent(arg_6_0.currentParent, false)
end

function var_0_0.initEquips(arg_7_0, arg_7_1)
	arg_7_0._equipType = -1

	if arg_7_0.isLock or arg_7_0.isAid or arg_7_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not arg_7_0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(arg_7_0._equipGO, false)
		gohelper.setActive(arg_7_0._fakeEquipGO, false)
		gohelper.setActive(arg_7_0._emptyEquipGo, false)
	else
		gohelper.setActive(arg_7_0._equipGO, true)
		gohelper.setActive(arg_7_0._fakeEquipGO, true)
		gohelper.setActive(arg_7_0._emptyEquipGo, true)

		if not arg_7_0._equip then
			arg_7_0._equip = arg_7_0:getUserDataTb_()
			arg_7_0._equip.moveContainer = gohelper.findChild(arg_7_0._equipGO, "moveContainer")
			arg_7_0._equip.equipIcon = gohelper.findChildImage(arg_7_0._equipGO, "moveContainer/equipIcon")
			arg_7_0._equip.equipRare = gohelper.findChildImage(arg_7_0._equipGO, "moveContainer/equiprare")
			arg_7_0._equip.equiptxten = gohelper.findChildText(arg_7_0._equipGO, "equiptxten")
			arg_7_0._equip.equiptxtlv = gohelper.findChildText(arg_7_0._equipGO, "moveContainer/equiplv/txtequiplv")
			arg_7_0._equip.equipGolv = gohelper.findChild(arg_7_0._equipGO, "moveContainer/equiplv")

			arg_7_0:_equipIconAddDrag(arg_7_0._equip.moveContainer, arg_7_0._equip.equipIcon)
		end

		local var_7_0 = Season166HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_7_0.mo.id - 1).equipUid[1]

		arg_7_0._equipMO = EquipModel.instance:getEquip(var_7_0) or HeroGroupTrialModel.instance:getEquipMo(var_7_0)

		local var_7_1

		if arg_7_0.trialCO and arg_7_0.trialCO.equipId > 0 then
			var_7_1 = EquipConfig.instance:getEquipCo(arg_7_0.trialCO.equipId)
		end

		if arg_7_0._equipMO then
			arg_7_0._equipType = arg_7_0._equipMO.config.rare - 2
		elseif var_7_1 then
			arg_7_0._equipType = var_7_1.rare - 2
		end

		gohelper.setActive(arg_7_0._equip.equipIcon.gameObject, arg_7_0._equipMO or var_7_1)
		gohelper.setActive(arg_7_0._equip.equipRare.gameObject, arg_7_0._equipMO or var_7_1)
		gohelper.setActive(arg_7_0._equip.equipAddGO, not arg_7_0._equipMO and not var_7_1)
		gohelper.setActive(arg_7_0._equip.equipGolv, arg_7_0._equipMO or var_7_1)
		ZProj.UGUIHelper.SetColorAlpha(arg_7_0._equip.equiptxten, (arg_7_0._equipMO or var_7_1) and 0.15 or 0.06)

		if arg_7_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_7_0._equip.equipIcon, arg_7_0._equipMO.config.icon)

			local var_7_2, var_7_3, var_7_4 = HeroGroupBalanceHelper.getBalanceLv()

			if var_7_4 and var_7_4 > arg_7_0._equipMO.level and arg_7_0._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				arg_7_0._equip.equiptxtlv.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">LV." .. var_7_4
			else
				arg_7_0._equip.equiptxtlv.text = "LV." .. arg_7_0._equipMO.level
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_7_0._equip.equipRare, "bianduixingxian_" .. arg_7_0._equipMO.config.rare)
			arg_7_0:_showEquipParticleEffect(arg_7_1)
		elseif var_7_1 then
			local var_7_5 = EquipConfig.instance:getEquipCo(arg_7_0.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_7_0._equip.equipIcon, var_7_5.icon)

			arg_7_0._equip.equiptxtlv.text = "LV." .. arg_7_0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_7_0._equip.equipRare, "bianduixingxian_" .. var_7_5.rare)
			arg_7_0:_showEquipParticleEffect(arg_7_1)
		end
	end

	arg_7_0.last_equip = arg_7_0._equipMO and arg_7_0._equipMO.uid
	arg_7_0.last_hero = arg_7_0._heroMO and arg_7_0._heroMO.heroId or 0
end

function var_0_0._showEquipParticleEffect(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function var_0_0._equipIconAddDrag(arg_9_0, arg_9_1, arg_9_2)
	arg_9_2:GetComponent(gohelper.Type_Image).raycastTarget = true

	local var_9_0 = var_0_0.EquipDragOtherScale
	local var_9_1

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_9_1 = var_0_0.EquipDragOffset
		var_9_0 = var_0_0.EquipDragMobileScale
	end

	CommonDragHelper.instance:registerDragObj(arg_9_1, arg_9_0._onBeginDrag, nil, arg_9_0._onEndDrag, arg_9_0._checkDrag, arg_9_0, arg_9_1.transform, nil, var_9_1, var_9_0)
end

function var_0_0._checkDrag(arg_10_0)
	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		return true
	end

	if arg_10_0.trialCO and arg_10_0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return true
	end

	return false
end

function var_0_0._onBeginDrag(arg_11_0)
	gohelper.setAsLastSibling(arg_11_0._heroGroupListView.heroPosTrList[arg_11_0.mo.id].parent.gameObject)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(arg_11_0._equip.equipGolv, false)
end

function var_0_0._onEndDrag(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_12_0 = var_12_0 + var_0_0.EquipDragOffset
	end

	local var_12_1 = arg_12_0:_moveToTarget(var_12_0)

	arg_12_0:_setEquipDragEnabled(false)

	local var_12_2 = var_12_1 and var_12_1.trialCO and var_12_1.trialCO.equipId > 0

	if not var_12_1 or var_12_1 == arg_12_0 or var_12_1.mo.aid or var_12_2 or not var_12_1._equipGO.activeSelf then
		if var_12_2 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		arg_12_0:_setToPos(arg_12_0._equip.moveContainer.transform, Vector2(), true, function()
			gohelper.setActive(arg_12_0._equip.equipGolv, true)
			arg_12_0:_setEquipDragEnabled(true)
		end, arg_12_0)
		arg_12_0:_showEquipParticleEffect()

		return
	end

	arg_12_0:_playDragEndAudio(var_12_1)
	gohelper.setAsLastSibling(arg_12_0._heroGroupListView.heroPosTrList[var_12_1.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(arg_12_0._heroGroupListView.heroPosTrList[arg_12_0.mo.id].parent.gameObject)

	local var_12_3 = recthelper.rectToRelativeAnchorPos(arg_12_0._equipGO.transform.position, var_12_1._equipGO.transform)

	arg_12_0._tweenId = arg_12_0:_setToPos(var_12_1._equip.moveContainer.transform, var_12_3, true)

	local var_12_4 = recthelper.rectToRelativeAnchorPos(var_12_1._equipGO.transform.position, arg_12_0._equipGO.transform)

	arg_12_0:_setToPos(arg_12_0._equip.moveContainer.transform, var_12_4, true, function()
		local var_14_0 = Season166HeroGroupModel.instance:getCurGroupMO()

		EquipTeamListModel.instance:openTeamEquip(arg_12_0.mo.id - 1, arg_12_0._heroMO, var_14_0)

		if arg_12_0._tweenId then
			ZProj.TweenHelper.KillById(arg_12_0._tweenId)
		end

		arg_12_0:_setToPos(arg_12_0._equip.moveContainer.transform, Vector2())
		arg_12_0:_setToPos(var_12_1._equip.moveContainer.transform, Vector2())
		gohelper.setActive(arg_12_0._equip.equipGolv, true)
		arg_12_0:_setEquipDragEnabled(true)

		local var_14_1 = arg_12_0.mo.id - 1
		local var_14_2 = var_12_1.mo.id - 1
		local var_14_3 = EquipTeamListModel.instance:getTeamEquip(var_14_1)[1]

		var_14_3 = (EquipModel.instance:getEquip(var_14_3) or HeroGroupTrialModel.instance:getEquipMo(var_14_3)) and var_14_3 or nil

		if var_14_3 then
			EquipTeamShowItem.removeEquip(var_14_1, true)
		end

		local var_14_4 = EquipTeamListModel.instance:getTeamEquip(var_14_2)[1]

		var_14_4 = (EquipModel.instance:getEquip(var_14_4) or HeroGroupTrialModel.instance:getEquipMo(var_14_4)) and var_14_4 or nil

		if var_14_4 then
			EquipTeamShowItem.removeEquip(var_14_2, true)
		end

		if var_14_3 then
			EquipTeamShowItem.replaceEquip(var_14_2, var_14_3, true)
		end

		if var_14_4 then
			EquipTeamShowItem.replaceEquip(var_14_1, var_14_4, true)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
		Season166HeroGroupModel.instance:saveCurGroupData()
	end, arg_12_0)
end

function var_0_0.resetEquipPos(arg_15_0)
	if not arg_15_0._equip then
		return
	end

	local var_15_0 = arg_15_0._equip.moveContainer.transform

	recthelper.setAnchor(var_15_0, 0, 0)
	transformhelper.setLocalScale(var_15_0, 1, 1, 1)
end

function var_0_0._playDragEndAudio(arg_16_0, arg_16_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function var_0_0._setToPos(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	local var_17_0, var_17_1 = recthelper.getAnchor(arg_17_1)

	if arg_17_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_17_1, arg_17_2.x, arg_17_2.y, 0.2, arg_17_4, arg_17_5)
	else
		recthelper.setAnchor(arg_17_1, arg_17_2.x, arg_17_2.y)

		if arg_17_4 then
			arg_17_4(arg_17_5)
		end
	end
end

function var_0_0._moveToTarget(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._heroGroupListView.heroPosTrList) do
		if arg_18_0._heroGroupListView._heroItemList[iter_18_0] ~= arg_18_0 then
			local var_18_0 = iter_18_1.parent
			local var_18_1 = recthelper.screenPosToAnchorPos(arg_18_1, var_18_0)

			if math.abs(var_18_1.x) * 2 < recthelper.getWidth(var_18_0) and math.abs(var_18_1.y) * 2 < recthelper.getHeight(var_18_0) then
				local var_18_2 = arg_18_0._heroGroupListView._heroItemList[iter_18_0]

				return not var_18_2:selfIsLock() and var_18_2 or nil
			end
		end
	end

	return nil
end

function var_0_0._setEquipDragEnabled(arg_19_0, arg_19_1)
	CommonDragHelper.instance:setGlobalEnabled(arg_19_1)
end

function var_0_0.addEventListeners(arg_20_0)
	arg_20_0._clickThis:AddClickListener(arg_20_0._onClickThis, arg_20_0)
	arg_20_0._clickThis:AddClickDownListener(arg_20_0._onClickThisDown, arg_20_0)
	arg_20_0._clickThis:AddClickUpListener(arg_20_0._onClickThisUp, arg_20_0)
	arg_20_0._clickEquip:AddClickListener(arg_20_0._onClickEquip, arg_20_0)
	arg_20_0._clickEquip:AddClickDownListener(arg_20_0._onClickEquipDown, arg_20_0)
	arg_20_0._clickEquip:AddClickUpListener(arg_20_0._onClickEquipUp, arg_20_0)
	arg_20_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, arg_20_0.setHeroGroupEquipEffect, arg_20_0)
	arg_20_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, arg_20_0.playHeroGroupHeroEffect, arg_20_0)
	arg_20_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_20_0.initEquips, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_20_0.initEquips, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_20_0.initEquips, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_20_0.initEquips, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_20_0.initEquips, arg_20_0)
	arg_20_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_20_0.initEquips, arg_20_0)
end

function var_0_0.removeEventListeners(arg_21_0)
	arg_21_0._clickThis:RemoveClickListener()
	arg_21_0._clickThis:RemoveClickUpListener()
	arg_21_0._clickThis:RemoveClickDownListener()
	arg_21_0._clickEquip:RemoveClickListener()
	arg_21_0._clickEquip:RemoveClickUpListener()
	arg_21_0._clickEquip:RemoveClickDownListener()
end

function var_0_0.playHeroGroupHeroEffect(arg_22_0, arg_22_1)
	arg_22_0:playAnim(arg_22_1)

	arg_22_0.last_equip = nil
	arg_22_0.last_hero = nil
end

function var_0_0.onUpdateMO(arg_23_0, arg_23_1)
	arg_23_0._commonHeroCard:setGrayScale(false)

	local var_23_0 = Season166HeroGroupModel.instance.battleId
	local var_23_1

	var_23_1 = var_23_0 and lua_battle.configDict[var_23_0]
	arg_23_0.mo = arg_23_1
	arg_23_0._posIndex = arg_23_0.mo.id - 1
	arg_23_0._heroMO = arg_23_1:getHeroMO()
	arg_23_0.monsterCO = not arg_23_1.isAssist and arg_23_1:getMonsterCO()
	arg_23_0.trialCO = not arg_23_1.isAssist and arg_23_1:getTrialCO()

	gohelper.setActive(arg_23_0._replayReady, Season166HeroGroupModel.instance:getCurGroupMO().isReplay)

	local var_23_2

	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		var_23_2 = Season166HeroGroupModel.instance:getCurGroupMO().replay_hero_data[arg_23_0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_23_0._lvnumen, "#E9E9E9")

	for iter_23_0 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(arg_23_0._goRankList[iter_23_0], "#F6F3EC")
	end

	if arg_23_0._heroMO then
		local var_23_3 = arg_23_0.mo.isAssist and arg_23_0._heroMO or HeroModel.instance:getByHeroId(arg_23_0._heroMO.heroId)
		local var_23_4 = FightConfig.instance:getSkinCO(var_23_2 and var_23_2.skin or var_23_3.skin)

		arg_23_0._commonHeroCard:onUpdateMO(var_23_4)

		if arg_23_0.isLock or arg_23_0.isAid or arg_23_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_23_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_23_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_23_0._careericon, "lssx_" .. tostring(arg_23_0._heroMO.config.career))

		local var_23_5 = var_23_2 and var_23_2.level or arg_23_0._heroMO.level
		local var_23_6 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_23_0._heroMO.heroId)
		local var_23_7

		if var_23_5 < var_23_6 then
			var_23_5 = var_23_6
			var_23_7 = true
		end

		local var_23_8, var_23_9 = HeroConfig.instance:getShowLevel(var_23_5)

		if var_23_7 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_23_0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			arg_23_0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. var_23_8

			for iter_23_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_23_0._goRankList[iter_23_1], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			arg_23_0._lvnum.text = var_23_8
		end

		for iter_23_2 = 1, 3 do
			local var_23_10 = arg_23_0._goRankList[iter_23_2]

			gohelper.setActive(var_23_10, iter_23_2 == var_23_9 - 1)
		end

		gohelper.setActive(arg_23_0._goStars, true)

		for iter_23_3 = 1, 6 do
			local var_23_11 = arg_23_0._goStarList[iter_23_3]

			gohelper.setActive(var_23_11, iter_23_3 <= CharacterEnum.Star[arg_23_0._heroMO.config.rare])
		end
	elseif arg_23_0.monsterCO then
		local var_23_12 = FightConfig.instance:getSkinCO(arg_23_0.monsterCO.skinId)

		arg_23_0._commonHeroCard:onUpdateMO(var_23_12)
		UISpriteSetMgr.instance:setCommonSprite(arg_23_0._careericon, "lssx_" .. tostring(arg_23_0.monsterCO.career))

		local var_23_13, var_23_14 = HeroConfig.instance:getShowLevel(arg_23_0.monsterCO.level)

		arg_23_0._lvnum.text = var_23_13

		for iter_23_4 = 1, 3 do
			local var_23_15 = arg_23_0._goRankList[iter_23_4]

			gohelper.setActive(var_23_15, iter_23_4 == var_23_14 - 1)
		end

		gohelper.setActive(arg_23_0._goStars, false)
	elseif arg_23_0.trialCO then
		local var_23_16 = HeroConfig.instance:getHeroCO(arg_23_0.trialCO.heroId)
		local var_23_17

		if arg_23_0.trialCO.skin > 0 then
			var_23_17 = SkinConfig.instance:getSkinCo(arg_23_0.trialCO.skin)
		else
			var_23_17 = SkinConfig.instance:getSkinCo(var_23_16.skinId)
		end

		if arg_23_0.isLock or arg_23_0.isAid or arg_23_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_23_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_23_0._goblackmask.transform, 300)
		end

		arg_23_0._commonHeroCard:onUpdateMO(var_23_17)
		UISpriteSetMgr.instance:setCommonSprite(arg_23_0._careericon, "lssx_" .. tostring(var_23_16.career))

		local var_23_18, var_23_19 = HeroConfig.instance:getShowLevel(arg_23_0.trialCO.level)

		arg_23_0._lvnum.text = var_23_18

		for iter_23_5 = 1, 3 do
			local var_23_20 = arg_23_0._goRankList[iter_23_5]

			gohelper.setActive(var_23_20, iter_23_5 == var_23_19 - 1)
		end

		gohelper.setActive(arg_23_0._goStars, true)

		for iter_23_6 = 1, 6 do
			local var_23_21 = arg_23_0._goStarList[iter_23_6]

			gohelper.setActive(var_23_21, iter_23_6 <= CharacterEnum.Star[var_23_16.rare])
		end
	end

	if arg_23_0._heroItemContainer then
		arg_23_0._heroItemContainer.compColor[arg_23_0._lvnumen] = arg_23_0._lvnumen.color

		for iter_23_7 = 1, 3 do
			arg_23_0._heroItemContainer.compColor[arg_23_0._goRankList[iter_23_7]] = arg_23_0._goRankList[iter_23_7].color
		end
	end

	arg_23_0.isLock = not Season166HeroGroupModel.instance:isPositionOpen(arg_23_0.mo.id)
	arg_23_0.isAidLock = arg_23_0.isTeachItem and not arg_23_0.mo.trial
	arg_23_0.isAid = not arg_23_0.mo.trial and arg_23_0.isTeachItem
	arg_23_0.isTrialLock = (arg_23_0.mo.trial and arg_23_0.mo.trialPos) ~= nil
	arg_23_0.roleNum = Season166HeroGroupModel.instance:getBattleRoleNum()
	arg_23_0.isRoleNumLock = arg_23_0.roleNum and arg_23_0.roleNum < arg_23_0.mo.id
	arg_23_0.isEmpty = arg_23_1:isEmpty()

	gohelper.setActive(arg_23_0._heroGO, (arg_23_0._heroMO ~= nil or arg_23_0.monsterCO ~= nil or arg_23_0.trialCO ~= nil) and not arg_23_0.isLock and not arg_23_0.isRoleNumLock)
	gohelper.setActive(arg_23_0._noneGO, arg_23_0._heroMO == nil and arg_23_0.monsterCO == nil and arg_23_0.trialCO == nil or arg_23_0.isLock or arg_23_0.isAidLock or arg_23_0.isRoleNumLock)
	gohelper.setActive(arg_23_0._addGO, arg_23_0._heroMO == nil and arg_23_0.monsterCO == nil and arg_23_0.trialCO == nil and not arg_23_0.isLock and not arg_23_0.isAidLock and not arg_23_0.isRoleNumLock)
	gohelper.setActive(arg_23_0._lockGO, arg_23_0:selfIsLock())
	gohelper.setActive(arg_23_0._aidGO, arg_23_0.mo.trial and arg_23_0.isTeachItem)
	gohelper.setActive(arg_23_0._subGO, false)
	transformhelper.setLocalPosXY(arg_23_0._tagTr, 36.3, arg_23_0._subGO.activeSelf and 144.1 or 212.1)

	if (arg_23_0.trialCO or arg_23_0.mo.isAssist) and not arg_23_0.isTeachItem then
		gohelper.setActive(arg_23_0._trialTagGO, true)

		arg_23_0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(arg_23_0._trialTagGO, false)
	end

	if not Season166HeroSingleGroupModel.instance:isTemp() and arg_23_0.isRoleNumLock and arg_23_0._heroMO ~= nil and arg_23_0.monsterCO == nil then
		Season166HeroSingleGroupModel.instance:remove(arg_23_0._heroMO.id)
	end

	arg_23_0:initEquips()
	arg_23_0:showCounterSign()

	if arg_23_0._playDeathAnim then
		arg_23_0._playDeathAnim = nil

		arg_23_0:playAnim(UIAnimationName.Open)
	end
end

function var_0_0.selfIsLock(arg_24_0)
	return arg_24_0.isLock or arg_24_0.isAidLock or arg_24_0.isRoleNumLock
end

function var_0_0.setIsTeachItem(arg_25_0, arg_25_1)
	arg_25_0.isTeachItem = arg_25_1
end

function var_0_0.playRestrictAnimation(arg_26_0, arg_26_1)
	if arg_26_0._heroMO and arg_26_1[arg_26_0._heroMO.uid] then
		arg_26_0._playDeathAnim = true

		arg_26_0:playAnim("herogroup_hero_deal")

		arg_26_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_26_0.setGrayFactor, nil, arg_26_0)
	end
end

function var_0_0.setGrayFactor(arg_27_0, arg_27_1)
	arg_27_0._commonHeroCard:setGrayFactor(arg_27_1)
end

function var_0_0.showCounterSign(arg_28_0)
	local var_28_0

	if arg_28_0._heroMO then
		var_28_0 = lua_character.configDict[arg_28_0._heroMO.heroId].career
	elseif arg_28_0.trialCO then
		var_28_0 = HeroConfig.instance:getHeroCO(arg_28_0.trialCO.heroId).career
	elseif arg_28_0.monsterCO then
		var_28_0 = arg_28_0.monsterCO.career
	end

	local var_28_1, var_28_2 = FightHelper.detectAttributeCounter()

	gohelper.setActive(arg_28_0._gorecommended, tabletool.indexOf(var_28_1, var_28_0))
	gohelper.setActive(arg_28_0._gocounter, tabletool.indexOf(var_28_2, var_28_0))
end

function var_0_0._setUIPressState(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	if not arg_29_1 then
		return
	end

	local var_29_0 = arg_29_1:GetEnumerator()

	while var_29_0:MoveNext() do
		local var_29_1

		if arg_29_2 then
			var_29_1 = arg_29_3 and arg_29_3[var_29_0.Current] * 0.7 or var_0_0.PressColor
			var_29_1.a = var_29_0.Current.color.a
		else
			var_29_1 = arg_29_3 and arg_29_3[var_29_0.Current] or Color.white
		end

		var_29_0.Current.color = var_29_1
	end
end

function var_0_0._onClickThis(arg_30_0)
	if Season166HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_30_0.isTeachItem or arg_30_0.isRoleNumLock then
		if not arg_30_0.mo.trial or arg_30_0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if arg_30_0.isLock then
		logError(arg_30_0.mo.id .. " is lock, check Error")
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_30_0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function var_0_0._onClickThisDown(arg_31_0)
	arg_31_0:_setHeroItemPressState(true)
end

function var_0_0._onClickThisUp(arg_32_0)
	arg_32_0:_setHeroItemPressState(false)
end

function var_0_0._setHeroItemPressState(arg_33_0, arg_33_1)
	if not arg_33_0._heroItemContainer then
		arg_33_0._heroItemContainer = arg_33_0:getUserDataTb_()

		local var_33_0 = arg_33_0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_33_0._heroItemContainer.images = var_33_0

		local var_33_1 = arg_33_0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_33_0._heroItemContainer.tmps = var_33_1
		arg_33_0._heroItemContainer.compColor = {}

		local var_33_2 = var_33_0:GetEnumerator()

		while var_33_2:MoveNext() do
			arg_33_0._heroItemContainer.compColor[var_33_2.Current] = var_33_2.Current.color
		end

		local var_33_3 = var_33_1:GetEnumerator()

		while var_33_3:MoveNext() do
			arg_33_0._heroItemContainer.compColor[var_33_3.Current] = var_33_3.Current.color
		end
	end

	local var_33_4 = arg_33_0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	arg_33_0._heroItemContainer.spines = var_33_4

	if arg_33_0._heroItemContainer then
		arg_33_0:_setUIPressState(arg_33_0._heroItemContainer.images, arg_33_1, arg_33_0._heroItemContainer.compColor)
		arg_33_0:_setUIPressState(arg_33_0._heroItemContainer.tmps, arg_33_1, arg_33_0._heroItemContainer.compColor)
		arg_33_0:_setUIPressState(arg_33_0._heroItemContainer.spines, arg_33_1)
	end

	if arg_33_0._imageAdd then
		local var_33_5 = arg_33_1 and var_0_0.PressColor or Color.white

		arg_33_0._imageAdd.color = var_33_5
	end
end

function var_0_0._onClickEquip(arg_34_0)
	local var_34_0 = Season166HeroGroupModel.instance:getCurGroupMO()

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or arg_34_0.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		arg_34_0._viewParam = {
			heroGroupMo = var_34_0,
			heroMo = arg_34_0._heroMO,
			equipMo = arg_34_0._equipMO,
			posIndex = arg_34_0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromSeason166HeroGroupFightView,
			maxHeroNum = arg_34_0.roleNum
		}

		if arg_34_0.trialCO then
			arg_34_0._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(arg_34_0.trialCO)

			if arg_34_0.trialCO.equipId > 0 then
				arg_34_0._viewParam.equipMo = arg_34_0._viewParam.heroMo.trialEquipMo
			end
		end

		arg_34_0:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._onClickEquipDown(arg_35_0)
	arg_35_0:_setEquipItemPressState(true)
end

function var_0_0._onClickEquipUp(arg_36_0)
	arg_36_0:_setEquipItemPressState(false)
end

function var_0_0._setEquipItemPressState(arg_37_0, arg_37_1)
	if not arg_37_0._equipItemContainer then
		arg_37_0._equipItemContainer = arg_37_0:getUserDataTb_()
		arg_37_0._equipEmtpyContainer = arg_37_0:getUserDataTb_()

		local var_37_0 = arg_37_0._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_37_0._equipItemContainer.images = var_37_0

		local var_37_1 = arg_37_0._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_37_0._equipItemContainer.tmps = var_37_1
		arg_37_0._equipItemContainer.compColor = {}

		local var_37_2 = arg_37_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_37_0._equipEmtpyContainer.images = var_37_2

		local var_37_3 = arg_37_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_37_0._equipEmtpyContainer.tmps = var_37_3
		arg_37_0._equipEmtpyContainer.compColor = {}

		local var_37_4 = var_37_0:GetEnumerator()

		while var_37_4:MoveNext() do
			arg_37_0._equipItemContainer.compColor[var_37_4.Current] = var_37_4.Current.color
		end

		local var_37_5 = var_37_1:GetEnumerator()

		while var_37_5:MoveNext() do
			arg_37_0._equipItemContainer.compColor[var_37_5.Current] = var_37_5.Current.color
		end

		local var_37_6 = var_37_2:GetEnumerator()

		while var_37_6:MoveNext() do
			arg_37_0._equipEmtpyContainer.compColor[var_37_6.Current] = var_37_6.Current.color
		end

		local var_37_7 = var_37_3:GetEnumerator()

		while var_37_7:MoveNext() do
			arg_37_0._equipEmtpyContainer.compColor[var_37_7.Current] = var_37_7.Current.color
		end
	end

	if arg_37_0._equipItemContainer then
		arg_37_0:_setUIPressState(arg_37_0._equipItemContainer.images, arg_37_1, arg_37_0._equipItemContainer.compColor)
		arg_37_0:_setUIPressState(arg_37_0._equipItemContainer.tmps, arg_37_1, arg_37_0._equipItemContainer.compColor)
	end

	if arg_37_0._equipEmtpyContainer then
		arg_37_0:_setUIPressState(arg_37_0._equipEmtpyContainer.images, arg_37_1, arg_37_0._equipEmtpyContainer.compColor)
		arg_37_0:_setUIPressState(arg_37_0._equipEmtpyContainer.tmps, arg_37_1, arg_37_0._equipEmtpyContainer.compColor)
	end
end

function var_0_0._onOpenEquipTeamView(arg_38_0)
	EquipController.instance:openEquipInfoTeamView(arg_38_0._viewParam)
end

function var_0_0.onItemBeginDrag(arg_39_0, arg_39_1)
	if arg_39_1 == arg_39_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_39_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(arg_39_0._dragFrameGO, true)
		gohelper.setActive(arg_39_0._dragFrameSelectGO, true)
		gohelper.setActive(arg_39_0._dragFrameCompleteGO, false)
	end

	gohelper.setActive(arg_39_0._clickGO, false)
end

function var_0_0.onItemEndDrag(arg_40_0, arg_40_1, arg_40_2)
	ZProj.TweenHelper.DOScale(arg_40_0.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	arg_40_0:_setHeroItemPressState(false)
end

function var_0_0.onItemCompleteDrag(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if arg_41_2 == arg_41_0.mo.id and arg_41_1 ~= arg_41_2 then
		if arg_41_3 then
			gohelper.setActive(arg_41_0._dragFrameGO, true)
			gohelper.setActive(arg_41_0._dragFrameSelectGO, false)
			gohelper.setActive(arg_41_0._dragFrameCompleteGO, false)
			gohelper.setActive(arg_41_0._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(arg_41_0.hideDragEffect, arg_41_0)
			TaskDispatcher.runDelay(arg_41_0.hideDragEffect, arg_41_0, 0.833)
		end
	else
		gohelper.setActive(arg_41_0._dragFrameGO, false)
	end

	gohelper.setActive(arg_41_0._clickGO, true)
end

function var_0_0.hideDragEffect(arg_42_0)
	gohelper.setActive(arg_42_0._dragFrameGO, false)
end

function var_0_0.setHeroGroupEquipEffect(arg_43_0, arg_43_1)
	arg_43_0._canPlayEffect = arg_43_1
end

function var_0_0.getAnimStateLength(arg_44_0, arg_44_1)
	arg_44_0.clipLengthDict = arg_44_0.clipLengthDict or {
		swicth = 0.833,
		herogroup_hero_deal = 1.667,
		[UIAnimationName.Open] = 0.833,
		[UIAnimationName.Close] = 0.333
	}

	local var_44_0 = arg_44_0.clipLengthDict[arg_44_1]

	if not var_44_0 then
		logError("not get animation state name :  " .. tostring(arg_44_1))
	end

	return var_44_0 or 0
end

function var_0_0.playAnim(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0:getAnimStateLength(arg_45_1)

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, var_45_0)
	arg_45_0.anim:Play(arg_45_1, 0, 0)
end

function var_0_0.onDestroy(arg_46_0)
	if arg_46_0._equip then
		CommonDragHelper.instance:unregisterDragObj(arg_46_0._equip.moveContainer)
	end

	TaskDispatcher.cancelTask(arg_46_0._onOpenEquipTeamView, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0.hideDragEffect, arg_46_0)
end

return var_0_0
