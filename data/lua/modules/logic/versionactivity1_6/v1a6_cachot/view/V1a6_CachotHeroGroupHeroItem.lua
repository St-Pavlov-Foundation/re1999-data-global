module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupHeroItem", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupHeroItem", LuaCompBase)

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
		local var_2_0 = gohelper.findChildImage(arg_2_1, "heroitemani/hero/vertical/layout/lv/rankobj/rank" .. iter_2_0)

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
	arg_2_0._goquality = gohelper.findChild(arg_2_1, "heroitemani/#go_quality")
	arg_2_0._seatbgicon = gohelper.findChildImage(arg_2_1, "heroitemani/hero/#go_qualitytag")
	arg_2_0._seaticon = gohelper.findChildImage(arg_2_1, "heroitemani/#go_quality/icon")
	arg_2_0._gohp = gohelper.findChild(arg_2_1, "heroitemani/#go_hp")
	arg_2_0._sliderhp = gohelper.findChildSlider(arg_2_1, "heroitemani/#go_hp/#slider_hp")
	arg_2_0._gotalent = gohelper.findChild(arg_2_1, "heroitemani/hero/vertical/layout/gongming")
	arg_2_0._txttalent = gohelper.findChildText(arg_2_1, "heroitemani/hero/vertical/layout/gongming/lvltxt")
	arg_2_0._txtlvtalent = gohelper.findChildText(arg_2_1, "heroitemani/hero/vertical/layout/gongming/lv")
	arg_2_0._icontalent = gohelper.findChildImage(arg_2_1, "heroitemani/hero/vertical/layout/gongming/icon")
	arg_2_0._commonHeroCard = CommonHeroCard.create(arg_2_0._charactericon, arg_2_0._heroGroupListView.viewName)
end

function var_0_0.getQualityGo(arg_3_0)
	return arg_3_0._goquality
end

function var_0_0.setIndex(arg_4_0, arg_4_1)
	arg_4_0._index = arg_4_1
	arg_4_0._goquality.name = "#go_quality_" .. tostring(arg_4_1)
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
end

function var_0_0.flowOriginParent(arg_7_0)
	arg_7_0._equipGO.transform:SetParent(arg_7_0._animGO.transform, false)
end

function var_0_0.flowCurrentParent(arg_8_0)
	arg_8_0._equipGO.transform:SetParent(arg_8_0.currentParent, false)
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

			arg_9_0:_equipIconAddDrag(arg_9_0._equip.equipIcon.gameObject)
		end

		local var_9_0 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()
		local var_9_1 = var_9_0:getPosEquips(arg_9_0.mo.id - 1).equipUid[1]

		arg_9_0._equipMO = EquipModel.instance:getEquip(var_9_1) or HeroGroupTrialModel.instance:getEquipMo(var_9_1)

		if var_9_0.isReplay then
			arg_9_0._equipMO = nil

			local var_9_2 = var_9_0.replay_equip_data[arg_9_0.mo.heroUid]

			if var_9_2 then
				local var_9_3 = EquipConfig.instance:getEquipCo(var_9_2.equipId)

				if var_9_3 then
					arg_9_0._equipMO = {}
					arg_9_0._equipMO.config = var_9_3
					arg_9_0._equipMO.refineLv = var_9_2.refineLv
					arg_9_0._equipMO.level = var_9_2.equipLv
				end
			end
		end

		local var_9_4

		if arg_9_0.trialCO and arg_9_0.trialCO.equipId > 0 then
			var_9_4 = EquipConfig.instance:getEquipCo(arg_9_0.trialCO.equipId)
		end

		if arg_9_0._equipMO then
			arg_9_0._equipType = arg_9_0._equipMO.config.rare - 2
		elseif var_9_4 then
			arg_9_0._equipType = var_9_4.rare - 2
		end

		gohelper.setActive(arg_9_0._equip.equipIcon.gameObject, arg_9_0._equipMO or var_9_4)
		gohelper.setActive(arg_9_0._equip.equipRare.gameObject, arg_9_0._equipMO or var_9_4)
		gohelper.setActive(arg_9_0._equip.equipAddGO, not arg_9_0._equipMO and not var_9_4)
		gohelper.setActive(arg_9_0._equip.equipGolv, arg_9_0._equipMO or var_9_4)
		ZProj.UGUIHelper.SetColorAlpha(arg_9_0._equip.equiptxten, (arg_9_0._equipMO or var_9_4) and 0.15 or 0.06)

		if arg_9_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_9_0._equip.equipIcon, arg_9_0._equipMO.config.icon)

			local var_9_5, var_9_6, var_9_7 = HeroGroupBalanceHelper.getBalanceLv()

			if var_9_7 and var_9_7 > arg_9_0._equipMO.level and arg_9_0._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				arg_9_0._equip.equiptxtlv.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">LV." .. var_9_7
			else
				local var_9_8 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(arg_9_0._equipMO, arg_9_0._seatLevel)
				local var_9_9 = arg_9_0._equipMO.level ~= var_9_8

				arg_9_0._equip.equiptxtlv.text = "LV." .. var_9_8

				if var_9_9 then
					SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._equip.equiptxtlv, "#bfdaff")
				else
					SLFramework.UGUI.GuiHelper.SetColor(arg_9_0._equip.equiptxtlv, "#d2d2d2")
				end
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_9_0._equip.equipRare, "bianduixingxian_" .. arg_9_0._equipMO.config.rare)
			arg_9_0:_showEquipParticleEffect(arg_9_1)
		elseif var_9_4 then
			local var_9_10 = EquipConfig.instance:getEquipCo(arg_9_0.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_9_0._equip.equipIcon, var_9_10.icon)

			arg_9_0._equip.equiptxtlv.text = "LV." .. arg_9_0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_9_0._equip.equipRare, "bianduixingxian_" .. var_9_10.rare)
			arg_9_0:_showEquipParticleEffect(arg_9_1)
		end
	end

	arg_9_0.last_equip = arg_9_0._equipMO and arg_9_0._equipMO.uid
	arg_9_0.last_hero = arg_9_0._heroMO and arg_9_0._heroMO.heroId or 0
end

function var_0_0._showEquipParticleEffect(arg_10_0, arg_10_1)
	if arg_10_1 == arg_10_0.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function var_0_0._equipIconAddDrag(arg_11_0, arg_11_1)
	if arg_11_0._drag then
		return
	end

	arg_11_1:GetComponent(gohelper.Type_Image).raycastTarget = true
	arg_11_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_11_1)

	arg_11_0._drag:AddDragBeginListener(arg_11_0._onBeginDrag, arg_11_0, arg_11_1.transform)
	arg_11_0._drag:AddDragListener(arg_11_0._onDrag, arg_11_0)
	arg_11_0._drag:AddDragEndListener(arg_11_0._onEndDrag, arg_11_0, arg_11_1.transform)
end

function var_0_0._onBeginDrag(arg_12_0, arg_12_1, arg_12_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_12_0.trialCO and arg_12_0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return
	end

	gohelper.setAsLastSibling(arg_12_0._heroGroupListView.heroPosTrList[arg_12_0.mo.id].parent.gameObject)

	local var_12_0 = arg_12_2.position
	local var_12_1 = var_0_0.EquipDragOtherScale

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_12_1 = var_0_0.EquipDragMobileScale
		var_12_0 = var_12_0 + var_0_0.EquipDragOffset
	end

	local var_12_2 = recthelper.screenPosToAnchorPos(var_12_0, arg_12_0._equipGO.transform)

	arg_12_0:_tweenToPos(arg_12_0._equip.moveContainer.transform, var_12_2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(arg_12_0._equip.equipGolv, false)
	arg_12_0:killEquipTweenId()

	arg_12_0.equipTweenId = ZProj.TweenHelper.DOScale(arg_12_1.parent, var_12_1, var_12_1, var_12_1, var_0_0.EquipTweenDuration)
end

function var_0_0._onDrag(arg_13_0, arg_13_1, arg_13_2)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_13_0.trialCO and arg_13_0.trialCO.equipId > 0 then
		return
	end

	local var_13_0 = arg_13_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_13_0 = var_13_0 + var_0_0.EquipDragOffset
	end

	local var_13_1 = recthelper.screenPosToAnchorPos(var_13_0, arg_13_0._equipGO.transform)

	arg_13_0:_tweenToPos(arg_13_0._equip.moveContainer.transform, var_13_1)
end

function var_0_0._onEndDrag(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_0.trialCO and arg_14_0.trialCO.equipId > 0 then
		return
	end

	arg_14_0:killEquipTweenId()

	arg_14_0.equipTweenId = ZProj.TweenHelper.DOScale(arg_14_1.parent, 1, 1, 1, var_0_0.EquipTweenDuration)

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_14_0 = arg_14_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_14_0 = var_14_0 + var_0_0.EquipDragOffset
	end

	local var_14_1 = arg_14_0:_moveToTarget(var_14_0)

	arg_14_0:_setEquipDragEnabled(false)

	local var_14_2 = var_14_1 and var_14_1.trialCO and var_14_1.trialCO.equipId > 0

	if not var_14_1 or var_14_1 == arg_14_0 or var_14_1.mo.aid or var_14_2 or not var_14_1._equipGO.activeSelf then
		if var_14_2 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		arg_14_0:_setToPos(arg_14_0._equip.moveContainer.transform, Vector2(), true, function()
			gohelper.setActive(arg_14_0._equip.equipGolv, true)
			arg_14_0:_setEquipDragEnabled(true)
		end, arg_14_0)
		arg_14_0:_showEquipParticleEffect()

		return
	end

	arg_14_0:_playDragEndAudio(var_14_1)
	gohelper.setAsLastSibling(arg_14_0._heroGroupListView.heroPosTrList[var_14_1.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(arg_14_0._heroGroupListView.heroPosTrList[arg_14_0.mo.id].parent.gameObject)

	local var_14_3 = recthelper.rectToRelativeAnchorPos(arg_14_0._equipGO.transform.position, var_14_1._equipGO.transform)

	arg_14_0._tweenId = arg_14_0:_setToPos(var_14_1._equip.moveContainer.transform, var_14_3, true)

	local var_14_4 = recthelper.rectToRelativeAnchorPos(var_14_1._equipGO.transform.position, arg_14_0._equipGO.transform)

	arg_14_0:_setToPos(arg_14_0._equip.moveContainer.transform, var_14_4, true, function()
		EquipTeamListModel.instance:openTeamEquip(arg_14_0.mo.id - 1, arg_14_0._heroMO, V1a6_CachotHeroGroupModel.instance:getCurGroupMO())

		if arg_14_0._tweenId then
			ZProj.TweenHelper.KillById(arg_14_0._tweenId)
		end

		arg_14_0:_setToPos(arg_14_0._equip.moveContainer.transform, Vector2())
		arg_14_0:_setToPos(var_14_1._equip.moveContainer.transform, Vector2())
		gohelper.setActive(arg_14_0._equip.equipGolv, true)
		arg_14_0:_setEquipDragEnabled(true)

		local var_16_0 = arg_14_0.mo.id - 1
		local var_16_1 = var_14_1.mo.id - 1
		local var_16_2 = EquipTeamListModel.instance:getTeamEquip(var_16_0)[1]

		var_16_2 = (EquipModel.instance:getEquip(var_16_2) or HeroGroupTrialModel.instance:getEquipMo(var_16_2)) and var_16_2 or nil

		if var_16_2 then
			V1a6_CachotHeroGroupController.removeEquip(var_16_0, true)
		end

		local var_16_3 = EquipTeamListModel.instance:getTeamEquip(var_16_1)[1]

		var_16_3 = (EquipModel.instance:getEquip(var_16_3) or HeroGroupTrialModel.instance:getEquipMo(var_16_3)) and var_16_3 or nil

		if var_16_3 then
			V1a6_CachotHeroGroupController.removeEquip(var_16_1, true)
		end

		if var_16_2 then
			V1a6_CachotHeroGroupController.replaceEquip(var_16_1, var_16_2, true)
		end

		if var_16_3 then
			V1a6_CachotHeroGroupController.replaceEquip(var_16_0, var_16_3, true)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
		V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()
	end, arg_14_0)
end

function var_0_0._playDragEndAudio(arg_17_0, arg_17_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function var_0_0._tweenToPos(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = recthelper.getAnchor(arg_18_1)

	if math.abs(var_18_0 - arg_18_2.x) > 10 or math.abs(var_18_1 - arg_18_2.y) > 10 then
		return ZProj.TweenHelper.DOAnchorPos(arg_18_1, arg_18_2.x, arg_18_2.y, 0.2)
	else
		recthelper.setAnchor(arg_18_1, arg_18_2.x, arg_18_2.y)
	end
end

function var_0_0._setToPos(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4, arg_19_5)
	local var_19_0, var_19_1 = recthelper.getAnchor(arg_19_1)

	if arg_19_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_19_1, arg_19_2.x, arg_19_2.y, 0.2, arg_19_4, arg_19_5)
	else
		recthelper.setAnchor(arg_19_1, arg_19_2.x, arg_19_2.y)

		if arg_19_4 then
			arg_19_4(arg_19_5)
		end
	end
end

function var_0_0._moveToTarget(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0._heroGroupListView.heroPosTrList) do
		if arg_20_0._heroGroupListView._heroItemList[iter_20_0] ~= arg_20_0 then
			local var_20_0 = iter_20_1.parent
			local var_20_1 = recthelper.screenPosToAnchorPos(arg_20_1, var_20_0)

			if math.abs(var_20_1.x) * 2 < recthelper.getWidth(var_20_0) and math.abs(var_20_1.y) * 2 < recthelper.getHeight(var_20_0) then
				local var_20_2 = arg_20_0._heroGroupListView._heroItemList[iter_20_0]

				return not var_20_2:selfIsLock() and var_20_2 or nil
			end
		end
	end

	return nil
end

function var_0_0._setEquipDragEnabled(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0._heroGroupListView._heroItemList) do
		if iter_21_1._drag then
			iter_21_1._drag.enabled = arg_21_1
		end
	end
end

function var_0_0.addEventListeners(arg_22_0)
	arg_22_0._clickThis:AddClickListener(arg_22_0._onClickThis, arg_22_0)
	arg_22_0._clickThis:AddClickDownListener(arg_22_0._onClickThisDown, arg_22_0)
	arg_22_0._clickThis:AddClickUpListener(arg_22_0._onClickThisUp, arg_22_0)
	arg_22_0._clickEquip:AddClickListener(arg_22_0._onClickEquip, arg_22_0)
	arg_22_0._clickEquip:AddClickDownListener(arg_22_0._onClickEquipDown, arg_22_0)
	arg_22_0._clickEquip:AddClickUpListener(arg_22_0._onClickEquipUp, arg_22_0)
	arg_22_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, arg_22_0.setHeroGroupEquipEffect, arg_22_0)
	arg_22_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, arg_22_0.playHeroGroupHeroEffect, arg_22_0)
	arg_22_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_22_0.initEquips, arg_22_0)
	arg_22_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_22_0.initEquips, arg_22_0)
	arg_22_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_22_0.initEquips, arg_22_0)
	arg_22_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_22_0.initEquips, arg_22_0)
	arg_22_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_22_0.initEquips, arg_22_0)
	arg_22_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_22_0.initEquips, arg_22_0)
end

function var_0_0.removeEventListeners(arg_23_0)
	arg_23_0._clickThis:RemoveClickListener()
	arg_23_0._clickThis:RemoveClickUpListener()
	arg_23_0._clickThis:RemoveClickDownListener()
	arg_23_0._clickEquip:RemoveClickListener()
	arg_23_0._clickEquip:RemoveClickUpListener()
	arg_23_0._clickEquip:RemoveClickDownListener()
end

function var_0_0.playHeroGroupHeroEffect(arg_24_0, arg_24_1)
	arg_24_0.anim:Play(arg_24_1, 0, 0)

	arg_24_0.last_equip = nil
	arg_24_0.last_hero = nil
end

function var_0_0.onUpdateMO(arg_25_0, arg_25_1)
	arg_25_0._commonHeroCard:setGrayScale(false)

	local var_25_0 = HeroGroupModel.instance.battleId
	local var_25_1 = var_25_0 and lua_battle.configDict[var_25_0]

	arg_25_0.mo = arg_25_1
	arg_25_0._posIndex = arg_25_0.mo.id - 1
	arg_25_0._heroMO = arg_25_1:getHeroMO()
	arg_25_0.monsterCO = arg_25_1:getMonsterCO()

	gohelper.setActive(arg_25_0._replayReady, HeroGroupModel.instance:getCurGroupMO().isReplay)

	local var_25_2

	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		var_25_2 = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[arg_25_0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_25_0._lvnumen, "#E9E9E9")

	for iter_25_0 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(arg_25_0._goRankList[iter_25_0], "#F6F3EC")
	end

	if arg_25_0._heroMO then
		local var_25_3 = HeroModel.instance:getByHeroId(arg_25_0._heroMO.heroId)
		local var_25_4 = FightConfig.instance:getSkinCO(var_25_2 and var_25_2.skin or var_25_3.skin)

		arg_25_0._commonHeroCard:onUpdateMO(var_25_4)

		if arg_25_0.isLock or arg_25_0.isAid or arg_25_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_25_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_25_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._careericon, "lssx_" .. tostring(arg_25_0._heroMO.config.career))

		local var_25_5 = var_25_2 and var_25_2.level or arg_25_0._heroMO.level
		local var_25_6 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_25_0._heroMO.heroId)
		local var_25_7

		if var_25_5 < var_25_6 then
			var_25_5 = var_25_6
			var_25_7 = true
		end

		local var_25_8 = arg_25_0._heroMO.level
		local var_25_9, var_25_10 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_25_0._heroMO, arg_25_0._seatLevel)
		local var_25_11 = var_25_8 ~= var_25_9

		if not var_25_7 then
			var_25_5 = var_25_9
		end

		local var_25_12, var_25_13 = HeroConfig.instance:getShowLevel(var_25_5)

		if var_25_7 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_25_0._lvnumen, HeroGroupBalanceHelper.BalanceColor)

			arg_25_0._lvnum.text = "<color=" .. HeroGroupBalanceHelper.BalanceColor .. ">" .. var_25_12

			for iter_25_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_25_0._goRankList[iter_25_1], HeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			arg_25_0._lvnum.text = var_25_12

			if var_25_11 then
				SLFramework.UGUI.GuiHelper.SetColor(arg_25_0._lvnumen, "#bfdaff")
				SLFramework.UGUI.GuiHelper.SetColor(arg_25_0._lvnum, "#bfdaff")
			else
				SLFramework.UGUI.GuiHelper.SetColor(arg_25_0._lvnumen, "#E9E9E9")
				SLFramework.UGUI.GuiHelper.SetColor(arg_25_0._lvnum, "#E9E9E9")
			end
		end

		for iter_25_2 = 1, 3 do
			local var_25_14 = arg_25_0._goRankList[iter_25_2]
			local var_25_15 = iter_25_2 == var_25_13 - 1

			gohelper.setActive(var_25_14, var_25_15)

			if var_25_15 then
				var_25_14.color = var_25_11 and GameUtil.parseColor("#81abe5") or Color.white
			end
		end

		gohelper.setActive(arg_25_0._goStars, true)

		for iter_25_3 = 1, 6 do
			local var_25_16 = arg_25_0._goStarList[iter_25_3]

			gohelper.setActive(var_25_16, iter_25_3 <= CharacterEnum.Star[arg_25_0._heroMO.config.rare])
		end
	elseif arg_25_0.monsterCO then
		local var_25_17 = FightConfig.instance:getSkinCO(arg_25_0.monsterCO.skinId)

		arg_25_0._commonHeroCard:onUpdateMO(var_25_17)
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._careericon, "lssx_" .. tostring(arg_25_0.monsterCO.career))

		local var_25_18, var_25_19 = HeroConfig.instance:getShowLevel(arg_25_0.monsterCO.level)

		arg_25_0._lvnum.text = var_25_18

		for iter_25_4 = 1, 3 do
			local var_25_20 = arg_25_0._goRankList[iter_25_4]

			gohelper.setActive(var_25_20, iter_25_4 == var_25_19 - 1)
		end

		gohelper.setActive(arg_25_0._goStars, false)
	elseif arg_25_0.trialCO then
		local var_25_21 = HeroConfig.instance:getHeroCO(arg_25_0.trialCO.heroId)
		local var_25_22

		if arg_25_0.trialCO.skin > 0 then
			var_25_22 = SkinConfig.instance:getSkinCo(arg_25_0.trialCO.skin)
		else
			var_25_22 = SkinConfig.instance:getSkinCo(var_25_21.skinId)
		end

		if arg_25_0.isLock or arg_25_0.isAid or arg_25_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_25_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_25_0._goblackmask.transform, 300)
		end

		arg_25_0._commonHeroCard:onUpdateMO(var_25_22)
		UISpriteSetMgr.instance:setCommonSprite(arg_25_0._careericon, "lssx_" .. tostring(var_25_21.career))

		local var_25_23, var_25_24 = HeroConfig.instance:getShowLevel(arg_25_0.trialCO.level)

		arg_25_0._lvnum.text = var_25_23

		for iter_25_5 = 1, 3 do
			local var_25_25 = arg_25_0._goRankList[iter_25_5]

			gohelper.setActive(var_25_25, iter_25_5 == var_25_24 - 1)
		end

		gohelper.setActive(arg_25_0._goStars, true)

		for iter_25_6 = 1, 6 do
			local var_25_26 = arg_25_0._goStarList[iter_25_6]

			gohelper.setActive(var_25_26, iter_25_6 <= CharacterEnum.Star[var_25_21.rare])
		end
	end

	arg_25_0.isLock = not HeroGroupModel.instance:isPositionOpen(arg_25_0.mo.id)
	arg_25_0.isAidLock = arg_25_0.mo.aid and arg_25_0.mo.aid == -1
	arg_25_0.isAid = arg_25_0.mo.aid ~= nil
	arg_25_0.isTrialLock = (arg_25_0.mo.trial and arg_25_0.mo.trialPos) ~= nil

	local var_25_27 = HeroGroupModel.instance:getBattleRoleNum()

	arg_25_0.isRoleNumLock = var_25_27 and var_25_27 < arg_25_0.mo.id
	arg_25_0.isEmpty = arg_25_1:isEmpty()

	gohelper.setActive(arg_25_0._heroGO, (arg_25_0._heroMO ~= nil or arg_25_0.monsterCO ~= nil or arg_25_0.trialCO ~= nil) and not arg_25_0.isLock and not arg_25_0.isRoleNumLock)
	gohelper.setActive(arg_25_0._noneGO, arg_25_0._heroMO == nil and arg_25_0.monsterCO == nil and arg_25_0.trialCO == nil or arg_25_0.isLock or arg_25_0.isAidLock or arg_25_0.isRoleNumLock)
	gohelper.setActive(arg_25_0._addGO, arg_25_0._heroMO == nil and arg_25_0.monsterCO == nil and arg_25_0.trialCO == nil and not arg_25_0.isLock and not arg_25_0.isAidLock and not arg_25_0.isRoleNumLock)
	gohelper.setActive(arg_25_0._lockGO, arg_25_0:selfIsLock())
	gohelper.setActive(arg_25_0._aidGO, arg_25_0.mo.aid and arg_25_0.mo.aid ~= -1)

	if var_25_1 then
		gohelper.setActive(arg_25_0._subGO, not arg_25_0.isLock and not arg_25_0.isAidLock and not arg_25_0.isRoleNumLock and arg_25_0.mo.id > var_25_1.playerMax)
	else
		gohelper.setActive(arg_25_0._subGO, not arg_25_0.isLock and not arg_25_0.isAidLock and not arg_25_0.isRoleNumLock and arg_25_0.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	transformhelper.setLocalPosXY(arg_25_0._tagTr, 36.3, arg_25_0._subGO.activeSelf and 144.1 or 212.1)

	if arg_25_0.trialCO then
		gohelper.setActive(arg_25_0._trialTagGO, true)

		arg_25_0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(arg_25_0._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and arg_25_0.isRoleNumLock and arg_25_0._heroMO ~= nil and arg_25_0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(arg_25_0._heroMO.id)
	end

	arg_25_0:initEquips()
	arg_25_0:showCounterSign()

	if arg_25_0._playDeathAnim then
		arg_25_0._playDeathAnim = nil

		arg_25_0.anim:Play(UIAnimationName.Open, 0, 0)
	end

	arg_25_0:_showMojingTip()
	arg_25_0:_updateCachot()

	if arg_25_0._heroItemContainer then
		arg_25_0._heroItemContainer.compColor[arg_25_0._lvnumen] = arg_25_0._lvnumen.color
		arg_25_0._heroItemContainer.compColor[arg_25_0._lvnum] = arg_25_0._lvnum.color
		arg_25_0._heroItemContainer.compColor[arg_25_0._txttalent] = arg_25_0._txttalent.color
		arg_25_0._heroItemContainer.compColor[arg_25_0._txtlvtalent] = arg_25_0._txtlvtalent.color
		arg_25_0._heroItemContainer.compColor[arg_25_0._icontalent] = arg_25_0._icontalent.color

		for iter_25_7 = 1, 3 do
			arg_25_0._heroItemContainer.compColor[arg_25_0._goRankList[iter_25_7]] = arg_25_0._goRankList[iter_25_7].color
		end
	end
end

function var_0_0.moveQuality(arg_26_0)
	if arg_26_0._qualityDefaultPos then
		return
	end

	local var_26_0 = arg_26_0._goquality.transform

	arg_26_0._qualityDefaultPos = var_26_0.position
	var_26_0.position = arg_26_0._qualityDefaultPos, gohelper.addChild(arg_26_0._heroGroupListView.heroGo, arg_26_0._goquality)
end

function var_0_0.resetQualityParent(arg_27_0)
	local var_27_0 = arg_27_0._goquality.transform

	var_27_0.position = var_27_0.position, gohelper.addChild(arg_27_0._animGO, arg_27_0._goquality)
	arg_27_0._goquality.name = "#go_quality"
end

function var_0_0._updateCachot(arg_28_0)
	arg_28_0._seatLevel = V1a6_CachotTeamModel.instance:getSeatLevel(arg_28_0._index)

	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_28_0._seaticon, "v1a6_cachot_quality2_0" .. arg_28_0._seatLevel)
	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_28_0._seatbgicon, "v1a6_cachot_quality3_0" .. arg_28_0._seatLevel)

	if not arg_28_0._qualityEffectList then
		arg_28_0._qualityEffectList = arg_28_0:getUserDataTb_()

		local var_28_0 = gohelper.findChild(arg_28_0._goquality, "quality_effect").transform
		local var_28_1 = var_28_0.childCount

		for iter_28_0 = 1, var_28_1 do
			local var_28_2 = var_28_0:GetChild(iter_28_0 - 1)

			if string.find(var_28_2.name, "effect_") then
				arg_28_0._qualityEffectList[var_28_2.name] = var_28_2
			end
		end
	end

	local var_28_3 = "effect_0" .. arg_28_0._seatLevel

	for iter_28_1, iter_28_2 in pairs(arg_28_0._qualityEffectList) do
		gohelper.setActive(iter_28_2, iter_28_1 == var_28_3)
	end

	arg_28_0:_updateHp()
	arg_28_0:_updateTalent()
end

function var_0_0._updateTalent(arg_29_0)
	if not arg_29_0._heroMO then
		return
	end

	local var_29_0, var_29_1 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_29_0._heroMO, arg_29_0._seatLevel)
	local var_29_2, var_29_3 = HeroConfig.instance:getShowLevel(var_29_0)
	local var_29_4 = var_29_3 >= CharacterEnum.TalentRank and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent)

	gohelper.setActive(arg_29_0._gotalent, var_29_4)

	if not var_29_4 then
		return
	end

	local var_29_5 = arg_29_0._heroMO.talent
	local var_29_6, var_29_7 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_29_0._heroMO, arg_29_0._seatLevel)
	local var_29_8 = var_29_5 ~= var_29_7

	arg_29_0._txttalent.text = var_29_7

	if var_29_8 then
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txttalent, "#bfdaff")
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtlvtalent, "#bfdaff")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txttalent, "#E9E9E9")
		SLFramework.UGUI.GuiHelper.SetColor(arg_29_0._txtlvtalent, "#E9E9E9")
	end

	arg_29_0._icontalent.color = var_29_8 and GameUtil.parseColor("#81abe5") or Color.white
end

function var_0_0._updateHp(arg_30_0)
	gohelper.setActive(arg_30_0._gohp, arg_30_0._heroMO)

	if not arg_30_0._heroMO then
		return
	end

	local var_30_0 = V1a6_CachotModel.instance:getTeamInfo():getHeroHp(arg_30_0._heroMO.heroId)
	local var_30_1 = var_30_0 and var_30_0.life or 0

	arg_30_0._sliderhp:SetValue(var_30_1 / 1000)
end

function var_0_0.selfIsLock(arg_31_0)
	return arg_31_0.isLock or arg_31_0.isAidLock or arg_31_0.isRoleNumLock
end

function var_0_0.checkWeekWalkCd(arg_32_0)
	if HeroGroupModel.instance:isAdventureOrWeekWalk() and arg_32_0._heroMO ~= nil and arg_32_0.monsterCO == nil then
		if WeekWalkModel.instance:getCurMapHeroCd(arg_32_0._heroMO.config.id) > 0 then
			arg_32_0._playDeathAnim = true

			arg_32_0.anim:Play("herogroup_hero_deal", 0, 0)

			arg_32_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_32_0.setGrayFactor, nil, arg_32_0)

			return arg_32_0._heroMO.id
		else
			arg_32_0._commonHeroCard:setGrayScale(false)
		end
	end
end

function var_0_0.playRestrictAnimation(arg_33_0, arg_33_1)
	if arg_33_0._heroMO and arg_33_1[arg_33_0._heroMO.uid] then
		arg_33_0._playDeathAnim = true

		arg_33_0.anim:Play("herogroup_hero_deal", 0, 0)

		arg_33_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_33_0.setGrayFactor, nil, arg_33_0)
	end
end

function var_0_0.setGrayFactor(arg_34_0, arg_34_1)
	arg_34_0._commonHeroCard:setGrayFactor(arg_34_1)
end

function var_0_0.showCounterSign(arg_35_0)
	local var_35_0

	if arg_35_0._heroMO then
		var_35_0 = lua_character.configDict[arg_35_0._heroMO.heroId].career
	elseif arg_35_0.trialCO then
		var_35_0 = HeroConfig.instance:getHeroCO(arg_35_0.trialCO.heroId).career
	elseif arg_35_0.monsterCO then
		var_35_0 = arg_35_0.monsterCO.career
	end

	local var_35_1, var_35_2 = FightHelper.detectAttributeCounter()
	local var_35_3 = tabletool.indexOf(var_35_1, var_35_0)

	gohelper.setActive(arg_35_0._gorecommended, var_35_3)

	local var_35_4 = tabletool.indexOf(var_35_2, var_35_0)

	gohelper.setActive(arg_35_0._gocounter, var_35_4)
	recthelper.setAnchorY(arg_35_0._gohp.transform, (var_35_3 or var_35_4) and -292 or -271)
end

function var_0_0._setUIPressState(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if not arg_36_1 then
		return
	end

	local var_36_0 = arg_36_1:GetEnumerator()

	while var_36_0:MoveNext() do
		local var_36_1

		if arg_36_2 then
			var_36_1 = arg_36_3 and arg_36_3[var_36_0.Current] * 0.7 or var_0_0.PressColor
			var_36_1.a = var_36_0.Current.color.a
		else
			var_36_1 = arg_36_3 and arg_36_3[var_36_0.Current] or Color.white
		end

		var_36_0.Current.color = var_36_1
	end
end

function var_0_0._onClickThis(arg_37_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_37_0.mo.aid or arg_37_0.isRoleNumLock then
		if arg_37_0.mo.aid == -1 or arg_37_0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if arg_37_0.isLock then
		local var_37_0, var_37_1 = HeroGroupModel.instance:getPositionLockDesc(arg_37_0.mo.id)

		GameFacade.showToast(var_37_0, var_37_1)
	else
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_37_0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function var_0_0._onClickThisDown(arg_38_0)
	arg_38_0:_setHeroItemPressState(true)
end

function var_0_0._onClickThisUp(arg_39_0)
	arg_39_0:_setHeroItemPressState(false)
end

function var_0_0._setHeroItemPressState(arg_40_0, arg_40_1)
	if not arg_40_0._heroItemContainer then
		arg_40_0._heroItemContainer = arg_40_0:getUserDataTb_()

		local var_40_0 = arg_40_0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_40_0._heroItemContainer.images = var_40_0

		local var_40_1 = arg_40_0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_40_0._heroItemContainer.tmps = var_40_1
		arg_40_0._heroItemContainer.compColor = {}

		local var_40_2 = var_40_0:GetEnumerator()

		while var_40_2:MoveNext() do
			arg_40_0._heroItemContainer.compColor[var_40_2.Current] = var_40_2.Current.color
		end

		local var_40_3 = var_40_1:GetEnumerator()

		while var_40_3:MoveNext() do
			arg_40_0._heroItemContainer.compColor[var_40_3.Current] = var_40_3.Current.color
		end
	end

	local var_40_4 = arg_40_0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	arg_40_0._heroItemContainer.spines = var_40_4

	if arg_40_0._heroItemContainer then
		arg_40_0:_setUIPressState(arg_40_0._heroItemContainer.images, arg_40_1, arg_40_0._heroItemContainer.compColor)
		arg_40_0:_setUIPressState(arg_40_0._heroItemContainer.tmps, arg_40_1, arg_40_0._heroItemContainer.compColor)
		arg_40_0:_setUIPressState(arg_40_0._heroItemContainer.spines, arg_40_1)
	end

	if arg_40_0._imageAdd then
		local var_40_5 = arg_40_1 and var_0_0.PressColor or Color.white

		arg_40_0._imageAdd.color = var_40_5
	end
end

function var_0_0._onClickEquip(arg_41_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or arg_41_0.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		local var_41_0 = V1a6_CachotHeroSingleGroupModel.instance:getCurGroupMO()

		arg_41_0._viewParam = {
			seatLevel = arg_41_0._seatLevel,
			heroGroupMo = var_41_0,
			heroMo = arg_41_0._heroMO,
			equipMo = arg_41_0._equipMO,
			posIndex = arg_41_0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromCachotHeroGroupFightView
		}

		if arg_41_0.trialCO then
			arg_41_0._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(arg_41_0.trialCO)

			if arg_41_0.trialCO.equipId > 0 then
				arg_41_0._viewParam.equipMo = arg_41_0._viewParam.heroMo.trialEquipMo
			end
		end

		arg_41_0:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._onClickEquipDown(arg_42_0)
	arg_42_0:_setEquipItemPressState(true)
end

function var_0_0._onClickEquipUp(arg_43_0)
	arg_43_0:_setEquipItemPressState(false)
end

function var_0_0._setEquipItemPressState(arg_44_0, arg_44_1)
	if not arg_44_0._equipItemContainer then
		arg_44_0._equipItemContainer = arg_44_0:getUserDataTb_()
		arg_44_0._equipEmtpyContainer = arg_44_0:getUserDataTb_()

		local var_44_0 = arg_44_0._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_44_0._equipItemContainer.images = var_44_0

		local var_44_1 = arg_44_0._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_44_0._equipItemContainer.tmps = var_44_1
		arg_44_0._equipItemContainer.compColor = {}

		local var_44_2 = arg_44_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_44_0._equipEmtpyContainer.images = var_44_2

		local var_44_3 = arg_44_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_44_0._equipEmtpyContainer.tmps = var_44_3
		arg_44_0._equipEmtpyContainer.compColor = {}

		local var_44_4 = var_44_0:GetEnumerator()

		while var_44_4:MoveNext() do
			arg_44_0._equipItemContainer.compColor[var_44_4.Current] = var_44_4.Current.color
		end

		local var_44_5 = var_44_1:GetEnumerator()

		while var_44_5:MoveNext() do
			arg_44_0._equipItemContainer.compColor[var_44_5.Current] = var_44_5.Current.color
		end

		local var_44_6 = var_44_2:GetEnumerator()

		while var_44_6:MoveNext() do
			arg_44_0._equipEmtpyContainer.compColor[var_44_6.Current] = var_44_6.Current.color
		end

		local var_44_7 = var_44_3:GetEnumerator()

		while var_44_7:MoveNext() do
			arg_44_0._equipEmtpyContainer.compColor[var_44_7.Current] = var_44_7.Current.color
		end
	end

	if arg_44_0._equipItemContainer then
		arg_44_0:_setUIPressState(arg_44_0._equipItemContainer.images, arg_44_1, arg_44_0._equipItemContainer.compColor)
		arg_44_0:_setUIPressState(arg_44_0._equipItemContainer.tmps, arg_44_1, arg_44_0._equipItemContainer.compColor)
	end

	if arg_44_0._equipEmtpyContainer then
		arg_44_0:_setUIPressState(arg_44_0._equipEmtpyContainer.images, arg_44_1, arg_44_0._equipEmtpyContainer.compColor)
		arg_44_0:_setUIPressState(arg_44_0._equipEmtpyContainer.tmps, arg_44_1, arg_44_0._equipEmtpyContainer.compColor)
	end
end

function var_0_0._onOpenEquipTeamView(arg_45_0)
	V1a6_CachotEquipInfoTeamListModel.instance:setSeatLevel(arg_45_0._seatLevel)
	V1a6_CachotController.instance:openV1a6_CachotEquipInfoTeamShowView(arg_45_0._viewParam)
end

function var_0_0.onItemBeginDrag(arg_46_0, arg_46_1)
	if arg_46_1 == arg_46_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_46_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(arg_46_0._dragFrameGO, true)
		gohelper.setActive(arg_46_0._dragFrameSelectGO, true)
		gohelper.setActive(arg_46_0._dragFrameCompleteGO, false)
		gohelper.setActive(arg_46_0._seatbgicon, false)
	end

	gohelper.setActive(arg_46_0._clickGO, false)
end

function var_0_0.onItemEndDrag(arg_47_0, arg_47_1, arg_47_2)
	gohelper.setActive(arg_47_0._seatbgicon, true)
	ZProj.TweenHelper.DOScale(arg_47_0.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	arg_47_0:_setHeroItemPressState(false)
end

function var_0_0.onItemCompleteDrag(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	if arg_48_2 == arg_48_0.mo.id and arg_48_1 ~= arg_48_2 then
		if arg_48_3 then
			gohelper.setActive(arg_48_0._dragFrameGO, true)
			gohelper.setActive(arg_48_0._dragFrameSelectGO, false)
			gohelper.setActive(arg_48_0._dragFrameCompleteGO, false)
			gohelper.setActive(arg_48_0._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(arg_48_0.hideDragEffect, arg_48_0)
			TaskDispatcher.runDelay(arg_48_0.hideDragEffect, arg_48_0, 0.833)
		end
	else
		gohelper.setActive(arg_48_0._dragFrameGO, false)
	end

	gohelper.setActive(arg_48_0._clickGO, true)
end

function var_0_0.hideDragEffect(arg_49_0)
	gohelper.setActive(arg_49_0._dragFrameGO, false)
end

function var_0_0.setHeroGroupEquipEffect(arg_50_0, arg_50_1)
	arg_50_0._canPlayEffect = arg_50_1
end

function var_0_0.killEquipTweenId(arg_51_0)
	if arg_51_0.equipTweenId then
		ZProj.TweenHelper.KillById(arg_51_0.equipTweenId)
	end
end

function var_0_0.onDestroy(arg_52_0)
	arg_52_0:killEquipTweenId()

	if arg_52_0._drag then
		arg_52_0._drag:RemoveDragBeginListener()
		arg_52_0._drag:RemoveDragListener()
		arg_52_0._drag:RemoveDragEndListener()
	end

	TaskDispatcher.cancelTask(arg_52_0._onOpenEquipTeamView, arg_52_0)
	TaskDispatcher.cancelTask(arg_52_0.hideDragEffect, arg_52_0)
end

return var_0_0
