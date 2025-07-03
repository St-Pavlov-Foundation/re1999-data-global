module("modules.logic.rouge.view.RougeHeroGroupHeroItem", package.seeall)

local var_0_0 = class("RougeHeroGroupHeroItem", RougeLuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._heroGroupListView = arg_1_1
end

var_0_0.EquipTweenDuration = 0.16
var_0_0.EquipDragOffset = Vector2(0, 150)
var_0_0.EquipDragMobileScale = 1.7
var_0_0.EquipDragOtherScale = 1.4
var_0_0.PressColor = GameUtil.parseColor("#C8C8C8")

function var_0_0.init(arg_2_0, arg_2_1)
	var_0_0.super.init(arg_2_0, arg_2_1)

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
	arg_2_0._animGO2 = gohelper.findChild(arg_2_1, "#go_rouge")
	arg_2_0.anim2 = arg_2_0._animGO2:GetComponent(typeof(UnityEngine.Animator))
	arg_2_0._replayReady = gohelper.findChild(arg_2_1, "heroitemani/hero/replayready")
	arg_2_0._gorecommended = gohelper.findChild(arg_2_1, "heroitemani/hero/#go_recommended")
	arg_2_0._gocounter = gohelper.findChild(arg_2_1, "heroitemani/hero/#go_counter")
	arg_2_0._herocardGo = gohelper.findChild(arg_2_1, "heroitemani/roleequip")
	arg_2_0._leftDrop = gohelper.findChildDropdown(arg_2_1, "heroitemani/roleequip/left")
	arg_2_0._rightDrop = gohelper.findChildDropdown(arg_2_1, "heroitemani/roleequip/right")
	arg_2_0._imageAdd = gohelper.findChildImage(arg_2_1, "heroitemani/none/add")
	arg_2_0._gomojing = gohelper.findChild(arg_2_1, "heroitemani/#go_mojing")
	arg_2_0._gomojingtxt = gohelper.findChildText(arg_2_1, "heroitemani/#go_mojing/#txt")
	arg_2_0._golayout = gohelper.findChild(arg_2_1, "#go_rouge/layout")
	arg_2_0._gohp = gohelper.findChild(arg_2_1, "#go_rouge/#go_hp")
	arg_2_0._sliderhp = gohelper.findChildSlider(arg_2_1, "#go_rouge/#go_hp/#slider_hp")
	arg_2_0._commonHeroCard = CommonHeroCard.create(arg_2_0._charactericon, arg_2_0._heroGroupListView.viewName)

	arg_2_0:_initCapacity()
	arg_2_0:_initAssit()
	arg_2_0:_initAssitSkill()
end

function var_0_0._initAssitSkill(arg_3_0)
	arg_3_0._rougeGo = gohelper.findChild(arg_3_0.go, "#go_rouge")
	arg_3_0._assitSkillGo = gohelper.findChild(arg_3_0.go, "#go_rouge/layout/skillicon")
	arg_3_0._assitSkillTipsGo = gohelper.findChild(arg_3_0.go, "#go_rouge/layout/assitskilltips")
	arg_3_0._assitSkillEmptyGo = gohelper.findChild(arg_3_0.go, "#go_rouge/layout/skillicon_empty")
	arg_3_0._skillItemComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_3_0._assitSkillGo, RougeRoleSkillItemComp)

	arg_3_0._skillItemComp:setClickCallback(arg_3_0._onSkillItemClick, arg_3_0)

	arg_3_0._skillTipsComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_3_0._assitSkillTipsGo, RougeRoleSkillTipsComp)

	arg_3_0._skillTipsComp:setClickCallback(arg_3_0._onSkillTipsClick, arg_3_0)
	gohelper.setActive(arg_3_0._assitSkillGo, false)
	gohelper.setActive(arg_3_0._assitSkillTipsGo, false)
	gohelper.setActive(arg_3_0._assitSkillEmptyGo, true)
end

function var_0_0._onSkillTipsClick(arg_4_0)
	gohelper.addChild(arg_4_0._rougeGo, arg_4_0._assitSkillTipsGo)

	arg_4_0._assitSkillTipsGo.transform.position = arg_4_0._skillTipsPos

	gohelper.setActive(arg_4_0._assitSkillTipsGo, false)
end

function var_0_0._onSkillItemClick(arg_5_0)
	arg_5_0._skillTipsPos = arg_5_0._assitSkillTipsGo.transform.position

	gohelper.addChild(arg_5_0._heroGroupListView.viewGO, arg_5_0._assitSkillTipsGo)

	arg_5_0._assitSkillTipsGo.transform.position = arg_5_0._skillTipsPos

	gohelper.setActive(arg_5_0._assitSkillTipsGo, true)
	arg_5_0._skillTipsComp:refresh(arg_5_0._assitSkillList, arg_5_0._skillItemComp)
end

function var_0_0._initAssit(arg_6_0)
	arg_6_0._assitAddGo = gohelper.findChild(arg_6_0.go, "#go_rouge/layout/rolehead_add")
	arg_6_0._assitEmptyGo = gohelper.findChild(arg_6_0.go, "#go_rouge/layout/rolehead_empty")
	arg_6_0._clickAssit = gohelper.getClickWithDefaultAudio(arg_6_0._assitAddGo)
	arg_6_0._assitGo = gohelper.findChild(arg_6_0.go, "#go_rouge/layout/rolehead")
	arg_6_0._assitIcon = gohelper.findChildSingleImage(arg_6_0._assitGo, "#simage_rolehead")
	arg_6_0._assitCareer = gohelper.findChildImage(arg_6_0._assitGo, "career")
	arg_6_0._assitIconBtn = gohelper.findChildButtonWithAudio(arg_6_0._assitGo, "#simage_rolehead")

	local var_6_0 = gohelper.findChild(arg_6_0.go, "#go_rouge/layout/rolehead/volume")

	arg_6_0._assitCapacityComp = RougeCapacityComp.Add(var_6_0, nil, nil, true)

	arg_6_0._assitCapacityComp:setSpriteType(RougeCapacityComp.SpriteType3, RougeCapacityComp.SpriteType3)
	gohelper.setActive(arg_6_0._assitGo, false)
end

function var_0_0._updateAssit(arg_7_0)
	local var_7_0 = arg_7_0.mo.id + RougeEnum.FightTeamNormalHeroNum
	local var_7_1 = RougeHeroSingleGroupModel.instance:getById(var_7_0)
	local var_7_2 = var_7_1 and var_7_1:getHeroMO()

	if not arg_7_0._heroMO and var_7_2 then
		RougeHeroSingleGroupModel.instance:removeFrom(var_7_0)

		var_7_2 = nil
	end

	local var_7_3 = var_7_2 ~= nil

	gohelper.setActive(arg_7_0._assitGo, var_7_3)
	gohelper.setActive(arg_7_0._assitSkillGo, var_7_3)
	gohelper.setActive(arg_7_0._assitAddGo, arg_7_0._heroMO ~= nil)
	gohelper.setActive(arg_7_0._assitEmptyGo, arg_7_0._heroMO == nil)

	arg_7_0._assitHeroMo = var_7_2

	if var_7_2 then
		arg_7_0._skillItemComp:setHeroId(var_7_2.heroId)

		local var_7_4 = SkinConfig.instance:getSkinCo(var_7_2.skin)

		arg_7_0._assitIcon:LoadImage(ResUrl.getHeadIconSmall(var_7_4.headIcon))

		local var_7_5 = var_7_2.config.career

		UISpriteSetMgr.instance:setCommonSprite(arg_7_0._assitCareer, "lssx_" .. tostring(var_7_5))

		local var_7_6 = RougeController.instance:getRoleStyleCapacity(var_7_2, true)

		arg_7_0._assitCapacityComp:updateMaxNum(var_7_6)

		local var_7_7 = arg_7_0:_getSupportSkill(var_7_2)

		arg_7_0._skillItemComp:refresh(var_7_7)
		gohelper.setActive(arg_7_0._assitSkillGo, var_7_7 ~= nil)
	end
end

function var_0_0._getSupportSkill(arg_8_0, arg_8_1)
	local var_8_0 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(arg_8_1.heroId, nil, arg_8_1)

	arg_8_0._assitSkillList = var_8_0

	local var_8_1 = RougeModel.instance:getTeamInfo():getSupportSkill(arg_8_1.heroId)

	if not var_8_1 then
		for iter_8_0, iter_8_1 in pairs(var_8_0) do
			var_8_1 = iter_8_1

			break
		end
	end

	return lua_skill.configDict[var_8_1]
end

function var_0_0._initCapacity(arg_9_0)
	local var_9_0 = gohelper.findChild(arg_9_0.go, "heroitemani/hero/volume")

	arg_9_0._capacityComp = RougeCapacityComp.Add(var_9_0, nil, nil, true)

	arg_9_0._capacityComp:setSpriteType(RougeCapacityComp.SpriteType3, RougeCapacityComp.SpriteType3)
end

function var_0_0.setIndex(arg_10_0, arg_10_1)
	arg_10_0._index = arg_10_1
end

function var_0_0._showMojingTip(arg_11_0)
	local var_11_0 = false
	local var_11_1 = HeroGroupModel.instance.episodeId
	local var_11_2 = DungeonConfig.instance:getEpisodeCO(var_11_1)

	if var_11_2 and var_11_2.chapterId == VersionActivity1_3DungeonEnum.DungeonChapterId.Daily then
		var_11_0 = arg_11_0._index == 3
	end

	gohelper.setActive(arg_11_0._gomojing, var_11_0)

	if not var_11_0 then
		return
	end

	arg_11_0._gomojingtxt.text = luaLang("p_v1a3_herogroup_mojing_" .. tostring(var_11_1))
end

function var_0_0.setParent(arg_12_0, arg_12_1)
	arg_12_0.currentParent = arg_12_1

	arg_12_0._subGO.transform:SetParent(arg_12_1, true)
	arg_12_0._equipGO.transform:SetParent(arg_12_1, true)
end

function var_0_0.flowOriginParent(arg_13_0)
	arg_13_0._equipGO.transform:SetParent(arg_13_0._animGO.transform, false)
end

function var_0_0.flowCurrentParent(arg_14_0)
	arg_14_0._equipGO.transform:SetParent(arg_14_0.currentParent, false)
end

function var_0_0.initEquips(arg_15_0, arg_15_1)
	arg_15_0._equipType = -1

	if arg_15_0.isLock or arg_15_0.isAid or arg_15_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) and not arg_15_0.trialCO and not HeroGroupTrialModel.instance:haveTrialEquip() then
		gohelper.setActive(arg_15_0._equipGO, false)
		gohelper.setActive(arg_15_0._fakeEquipGO, false)
		gohelper.setActive(arg_15_0._emptyEquipGo, false)
	else
		gohelper.setActive(arg_15_0._equipGO, true)
		gohelper.setActive(arg_15_0._fakeEquipGO, true)
		gohelper.setActive(arg_15_0._emptyEquipGo, true)

		if not arg_15_0._equip then
			arg_15_0._equip = arg_15_0:getUserDataTb_()
			arg_15_0._equip.moveContainer = gohelper.findChild(arg_15_0._equipGO, "moveContainer")
			arg_15_0._equip.equipIcon = gohelper.findChildImage(arg_15_0._equipGO, "moveContainer/equipIcon")
			arg_15_0._equip.equipRare = gohelper.findChildImage(arg_15_0._equipGO, "moveContainer/equiprare")
			arg_15_0._equip.equiptxten = gohelper.findChildText(arg_15_0._equipGO, "equiptxten")
			arg_15_0._equip.equiptxtlv = gohelper.findChildText(arg_15_0._equipGO, "moveContainer/equiplv/txtequiplv")
			arg_15_0._equip.equipGolv = gohelper.findChild(arg_15_0._equipGO, "moveContainer/equiplv")

			arg_15_0:_equipIconAddDrag(arg_15_0._equip.equipIcon.gameObject)
		end

		local var_15_0 = RougeHeroGroupModel.instance:getCurGroupMO()
		local var_15_1 = var_15_0:getPosEquips(arg_15_0.mo.id - 1).equipUid[1]

		arg_15_0._equipMO = EquipModel.instance:getEquip(var_15_1) or HeroGroupTrialModel.instance:getEquipMo(var_15_1)

		if var_15_0.isReplay then
			arg_15_0._equipMO = nil

			local var_15_2 = var_15_0.replay_equip_data[arg_15_0.mo.heroUid]

			if var_15_2 then
				local var_15_3 = EquipConfig.instance:getEquipCo(var_15_2.equipId)

				if var_15_3 then
					arg_15_0._equipMO = {}
					arg_15_0._equipMO.config = var_15_3
					arg_15_0._equipMO.refineLv = var_15_2.refineLv
					arg_15_0._equipMO.level = var_15_2.equipLv
				end
			end
		end

		local var_15_4

		if arg_15_0.trialCO and arg_15_0.trialCO.equipId > 0 then
			var_15_4 = EquipConfig.instance:getEquipCo(arg_15_0.trialCO.equipId)
		end

		if arg_15_0._equipMO then
			arg_15_0._equipType = arg_15_0._equipMO.config.rare - 2
		elseif var_15_4 then
			arg_15_0._equipType = var_15_4.rare - 2
		end

		gohelper.setActive(arg_15_0._equip.equipIcon.gameObject, arg_15_0._equipMO or var_15_4)
		gohelper.setActive(arg_15_0._equip.equipRare.gameObject, arg_15_0._equipMO or var_15_4)
		gohelper.setActive(arg_15_0._equip.equipAddGO, not arg_15_0._equipMO and not var_15_4)
		gohelper.setActive(arg_15_0._equip.equipGolv, arg_15_0._equipMO or var_15_4)
		ZProj.UGUIHelper.SetColorAlpha(arg_15_0._equip.equiptxten, (arg_15_0._equipMO or var_15_4) and 0.15 or 0.06)

		if arg_15_0._equipMO then
			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_15_0._equip.equipIcon, arg_15_0._equipMO.config.icon)

			local var_15_5, var_15_6, var_15_7 = RougeHeroGroupBalanceHelper.getBalanceLv()

			if var_15_7 and var_15_7 > arg_15_0._equipMO.level and arg_15_0._equipMO.equipType == EquipEnum.ClientEquipType.Normal then
				arg_15_0._equip.equiptxtlv.text = "<color=" .. RougeHeroGroupBalanceHelper.BalanceColor .. ">LV." .. var_15_7
			else
				arg_15_0._equip.equiptxtlv.text = "LV." .. arg_15_0._equipMO.level
			end

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_15_0._equip.equipRare, "bianduixingxian_" .. arg_15_0._equipMO.config.rare)
			arg_15_0:_showEquipParticleEffect(arg_15_1)
		elseif var_15_4 then
			local var_15_8 = EquipConfig.instance:getEquipCo(arg_15_0.trialCO.equipId)

			UISpriteSetMgr.instance:setHerogroupEquipIconSprite(arg_15_0._equip.equipIcon, var_15_8.icon)

			arg_15_0._equip.equiptxtlv.text = "LV." .. arg_15_0.trialCO.equipLv

			UISpriteSetMgr.instance:setHeroGroupSprite(arg_15_0._equip.equipRare, "bianduixingxian_" .. var_15_8.rare)
			arg_15_0:_showEquipParticleEffect(arg_15_1)
		end
	end

	arg_15_0.last_equip = arg_15_0._equipMO and arg_15_0._equipMO.uid
	arg_15_0.last_hero = arg_15_0._heroMO and arg_15_0._heroMO.heroId or 0
end

function var_0_0._showEquipParticleEffect(arg_16_0, arg_16_1)
	if arg_16_1 == arg_16_0.mo.id - 1 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_fail)
	end
end

function var_0_0._equipIconAddDrag(arg_17_0, arg_17_1)
	if arg_17_0._drag then
		return
	end

	arg_17_1:GetComponent(gohelper.Type_Image).raycastTarget = true
	arg_17_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_17_1)

	arg_17_0._drag:AddDragBeginListener(arg_17_0._onBeginDrag, arg_17_0, arg_17_1.transform)
	arg_17_0._drag:AddDragListener(arg_17_0._onDrag, arg_17_0)
	arg_17_0._drag:AddDragEndListener(arg_17_0._onEndDrag, arg_17_0, arg_17_1.transform)
end

function var_0_0._onBeginDrag(arg_18_0, arg_18_1, arg_18_2)
	if RougeHeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_18_0.trialCO and arg_18_0.trialCO.equipId > 0 then
		GameFacade.showToast(ToastEnum.TrialCantEditEquip)

		return
	end

	gohelper.setAsLastSibling(arg_18_0._heroGroupListView.heroPosTrList[arg_18_0.mo.id].parent.gameObject)

	local var_18_0 = arg_18_2.position
	local var_18_1 = var_0_0.EquipDragOtherScale

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_18_1 = var_0_0.EquipDragMobileScale
		var_18_0 = var_18_0 + var_0_0.EquipDragOffset
	end

	local var_18_2 = recthelper.screenPosToAnchorPos(var_18_0, arg_18_0._equipGO.transform)

	arg_18_0:_tweenToPos(arg_18_0._equip.moveContainer.transform, var_18_2)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
	gohelper.setActive(arg_18_0._equip.equipGolv, false)
	arg_18_0:killEquipTweenId()

	arg_18_0.equipTweenId = ZProj.TweenHelper.DOScale(arg_18_1.parent, var_18_1, var_18_1, var_18_1, var_0_0.EquipTweenDuration)
end

function var_0_0._onDrag(arg_19_0, arg_19_1, arg_19_2)
	if RougeHeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_19_0.trialCO and arg_19_0.trialCO.equipId > 0 then
		return
	end

	local var_19_0 = arg_19_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_19_0 = var_19_0 + var_0_0.EquipDragOffset
	end

	local var_19_1 = recthelper.screenPosToAnchorPos(var_19_0, arg_19_0._equipGO.transform)

	arg_19_0:_tweenToPos(arg_19_0._equip.moveContainer.transform, var_19_1)
end

function var_0_0._onEndDrag(arg_20_0, arg_20_1, arg_20_2)
	if arg_20_0.trialCO and arg_20_0.trialCO.equipId > 0 then
		return
	end

	arg_20_0:killEquipTweenId()

	arg_20_0.equipTweenId = ZProj.TweenHelper.DOScale(arg_20_1.parent, 1, 1, 1, var_0_0.EquipTweenDuration)

	if RougeHeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_20_0 = arg_20_2.position

	if GameUtil.isMobilePlayerAndNotEmulator() then
		var_20_0 = var_20_0 + var_0_0.EquipDragOffset
	end

	local var_20_1 = arg_20_0:_moveToTarget(var_20_0)

	arg_20_0:_setEquipDragEnabled(false)

	local var_20_2 = var_20_1 and var_20_1.trialCO and var_20_1.trialCO.equipId > 0

	if not var_20_1 or var_20_1 == arg_20_0 or var_20_1.mo.aid or var_20_2 or not var_20_1._equipGO.activeSelf then
		if var_20_2 then
			GameFacade.showToast(ToastEnum.TrialCantEditEquip)
		end

		arg_20_0:_setToPos(arg_20_0._equip.moveContainer.transform, Vector2(), true, function()
			gohelper.setActive(arg_20_0._equip.equipGolv, true)
			arg_20_0:_setEquipDragEnabled(true)
		end, arg_20_0)
		arg_20_0:_showEquipParticleEffect()

		return
	end

	arg_20_0:_playDragEndAudio(var_20_1)
	gohelper.setAsLastSibling(arg_20_0._heroGroupListView.heroPosTrList[var_20_1.mo.id].parent.gameObject)
	gohelper.setAsLastSibling(arg_20_0._heroGroupListView.heroPosTrList[arg_20_0.mo.id].parent.gameObject)

	local var_20_3 = recthelper.rectToRelativeAnchorPos(arg_20_0._equipGO.transform.position, var_20_1._equipGO.transform)

	arg_20_0._tweenId = arg_20_0:_setToPos(var_20_1._equip.moveContainer.transform, var_20_3, true)

	local var_20_4 = recthelper.rectToRelativeAnchorPos(var_20_1._equipGO.transform.position, arg_20_0._equipGO.transform)

	arg_20_0:_setToPos(arg_20_0._equip.moveContainer.transform, var_20_4, true, function()
		EquipTeamListModel.instance:openTeamEquip(arg_20_0.mo.id - 1, arg_20_0._heroMO, RougeHeroGroupModel.instance:getCurGroupMO())

		if arg_20_0._tweenId then
			ZProj.TweenHelper.KillById(arg_20_0._tweenId)
		end

		arg_20_0:_setToPos(arg_20_0._equip.moveContainer.transform, Vector2())
		arg_20_0:_setToPos(var_20_1._equip.moveContainer.transform, Vector2())
		gohelper.setActive(arg_20_0._equip.equipGolv, true)
		arg_20_0:_setEquipDragEnabled(true)

		local var_22_0 = arg_20_0.mo.id - 1
		local var_22_1 = var_20_1.mo.id - 1
		local var_22_2 = EquipTeamListModel.instance:getTeamEquip(var_22_0)[1]

		var_22_2 = (EquipModel.instance:getEquip(var_22_2) or HeroGroupTrialModel.instance:getEquipMo(var_22_2)) and var_22_2 or nil

		if var_22_2 then
			RougeHeroGroupController.removeEquip(var_22_0, true)
		end

		local var_22_3 = EquipTeamListModel.instance:getTeamEquip(var_22_1)[1]

		var_22_3 = (EquipModel.instance:getEquip(var_22_3) or HeroGroupTrialModel.instance:getEquipMo(var_22_3)) and var_22_3 or nil

		if var_22_3 then
			RougeHeroGroupController.removeEquip(var_22_1, true)
		end

		if var_22_2 then
			RougeHeroGroupController.replaceEquip(var_22_1, var_22_2, true)
		end

		if var_22_3 then
			RougeHeroGroupController.replaceEquip(var_22_0, var_22_3, true)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.ChangeEquip)
		RougeHeroGroupModel.instance:rougeSaveCurGroup()
	end, arg_20_0)
end

function var_0_0.resetEquipPos(arg_23_0)
	if not arg_23_0._equip then
		return
	end

	arg_23_0:killEquipTweenId()

	local var_23_0 = arg_23_0._equip.moveContainer.transform

	recthelper.setAnchor(var_23_0, 0, 0)
	transformhelper.setLocalScale(var_23_0, 1, 1, 1)
end

function var_0_0._playDragEndAudio(arg_24_0, arg_24_1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inking_success)
end

function var_0_0._tweenToPos(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = recthelper.getAnchor(arg_25_1)

	if math.abs(var_25_0 - arg_25_2.x) > 10 or math.abs(var_25_1 - arg_25_2.y) > 10 then
		return ZProj.TweenHelper.DOAnchorPos(arg_25_1, arg_25_2.x, arg_25_2.y, 0.2)
	else
		recthelper.setAnchor(arg_25_1, arg_25_2.x, arg_25_2.y)
	end
end

function var_0_0._setToPos(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5)
	local var_26_0, var_26_1 = recthelper.getAnchor(arg_26_1)

	if arg_26_3 then
		return ZProj.TweenHelper.DOAnchorPos(arg_26_1, arg_26_2.x, arg_26_2.y, 0.2, arg_26_4, arg_26_5)
	else
		recthelper.setAnchor(arg_26_1, arg_26_2.x, arg_26_2.y)

		if arg_26_4 then
			arg_26_4(arg_26_5)
		end
	end
end

function var_0_0._moveToTarget(arg_27_0, arg_27_1)
	for iter_27_0, iter_27_1 in ipairs(arg_27_0._heroGroupListView.heroPosTrList) do
		if arg_27_0._heroGroupListView._heroItemList[iter_27_0] ~= arg_27_0 then
			local var_27_0 = iter_27_1.parent
			local var_27_1 = recthelper.screenPosToAnchorPos(arg_27_1, var_27_0)

			if math.abs(var_27_1.x) * 2 < recthelper.getWidth(var_27_0) and math.abs(var_27_1.y) * 2 < recthelper.getHeight(var_27_0) then
				local var_27_2 = arg_27_0._heroGroupListView._heroItemList[iter_27_0]

				return not var_27_2:selfIsLock() and var_27_2 or nil
			end
		end
	end

	return nil
end

function var_0_0._setEquipDragEnabled(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_0._heroGroupListView._heroItemList) do
		if iter_28_1._drag then
			iter_28_1._drag.enabled = arg_28_1
		end
	end
end

function var_0_0.addEventListeners(arg_29_0)
	arg_29_0._clickThis:AddClickListener(arg_29_0._onClickThis, arg_29_0)
	arg_29_0._clickThis:AddClickDownListener(arg_29_0._onClickThisDown, arg_29_0)
	arg_29_0._clickThis:AddClickUpListener(arg_29_0._onClickThisUp, arg_29_0)
	arg_29_0._clickEquip:AddClickListener(arg_29_0._onClickEquip, arg_29_0)
	arg_29_0._clickEquip:AddClickDownListener(arg_29_0._onClickEquipDown, arg_29_0)
	arg_29_0._clickEquip:AddClickUpListener(arg_29_0._onClickEquipUp, arg_29_0)
	arg_29_0._clickAssit:AddClickListener(arg_29_0._onClickAssit, arg_29_0)
	arg_29_0._assitIconBtn:AddClickListener(arg_29_0._onClickAssitIcon, arg_29_0)
	arg_29_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.setHeroGroupEquipEffect, arg_29_0.setHeroGroupEquipEffect, arg_29_0)
	arg_29_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupHeroEffect, arg_29_0.playHeroGroupHeroEffect, arg_29_0)
	arg_29_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_29_0.initEquips, arg_29_0)
	arg_29_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_29_0.initEquips, arg_29_0)
	arg_29_0:addEventCb(EquipController.instance, EquipEvent.onBreakSuccess, arg_29_0.initEquips, arg_29_0)
	arg_29_0:addEventCb(EquipController.instance, EquipEvent.onEquipStrengthenReply, arg_29_0.initEquips, arg_29_0)
	arg_29_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_29_0.initEquips, arg_29_0)
	arg_29_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_29_0.initEquips, arg_29_0)
end

function var_0_0.removeEventListeners(arg_30_0)
	arg_30_0._clickThis:RemoveClickListener()
	arg_30_0._clickThis:RemoveClickUpListener()
	arg_30_0._clickThis:RemoveClickDownListener()
	arg_30_0._clickEquip:RemoveClickListener()
	arg_30_0._clickEquip:RemoveClickUpListener()
	arg_30_0._clickEquip:RemoveClickDownListener()
	arg_30_0._clickAssit:RemoveClickListener()
	arg_30_0._assitIconBtn:RemoveClickListener()
end

function var_0_0.playHeroGroupHeroEffect(arg_31_0, arg_31_1)
	arg_31_0:playAnim(arg_31_1)

	arg_31_0.last_equip = nil
	arg_31_0.last_hero = nil
end

function var_0_0.onUpdateMO(arg_32_0, arg_32_1)
	arg_32_0._commonHeroCard:setGrayScale(false)

	local var_32_0 = HeroGroupModel.instance.battleId
	local var_32_1 = var_32_0 and lua_battle.configDict[var_32_0]

	arg_32_0.mo = arg_32_1
	arg_32_0._posIndex = arg_32_0.mo.id - 1
	arg_32_0._heroMO = arg_32_1:getHeroMO()
	arg_32_0.monsterCO = arg_32_1:getMonsterCO()
	arg_32_0.trialCO = arg_32_1:getTrialCO()

	gohelper.setActive(arg_32_0._replayReady, RougeHeroGroupModel.instance:getCurGroupMO().isReplay)

	local var_32_2

	if RougeHeroGroupModel.instance:getCurGroupMO().isReplay then
		var_32_2 = HeroGroupModel.instance:getCurGroupMO().replay_hero_data[arg_32_0.mo.heroUid]
	end

	SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._lvnumen, "#E9E9E9")

	for iter_32_0 = 1, 3 do
		SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._goRankList[iter_32_0], "#F6F3EC")
	end

	arg_32_0:_updateAssit()

	if arg_32_0._heroMO then
		local var_32_3 = RougeConfig1.instance:getRoleCapacity(arg_32_0._heroMO.config.rare)

		arg_32_0._capacityComp:updateMaxNum(var_32_3)

		local var_32_4 = HeroModel.instance:getByHeroId(arg_32_0._heroMO.heroId)
		local var_32_5 = FightConfig.instance:getSkinCO(var_32_2 and var_32_2.skin or var_32_4.skin)

		arg_32_0._commonHeroCard:onUpdateMO(var_32_5)

		if arg_32_0.isLock or arg_32_0.isAid or arg_32_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_32_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_32_0._goblackmask.transform, 300)
		end

		UISpriteSetMgr.instance:setCommonSprite(arg_32_0._careericon, "lssx_" .. tostring(arg_32_0._heroMO.config.career))

		local var_32_6 = var_32_2 and var_32_2.level or arg_32_0._heroMO.level
		local var_32_7 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(arg_32_0._heroMO.heroId)
		local var_32_8

		if var_32_6 < var_32_7 then
			var_32_6 = var_32_7
			var_32_8 = true
		end

		local var_32_9, var_32_10 = HeroConfig.instance:getShowLevel(var_32_6)

		if var_32_8 then
			SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._lvnumen, RougeHeroGroupBalanceHelper.BalanceColor)

			arg_32_0._lvnum.text = "<color=" .. RougeHeroGroupBalanceHelper.BalanceColor .. ">" .. var_32_9

			for iter_32_1 = 1, 3 do
				SLFramework.UGUI.GuiHelper.SetColor(arg_32_0._goRankList[iter_32_1], RougeHeroGroupBalanceHelper.BalanceIconColor)
			end
		else
			arg_32_0._lvnum.text = var_32_9
		end

		for iter_32_2 = 1, 3 do
			local var_32_11 = arg_32_0._goRankList[iter_32_2]

			gohelper.setActive(var_32_11, iter_32_2 == var_32_10 - 1)
		end

		gohelper.setActive(arg_32_0._goStars, true)

		for iter_32_3 = 1, 6 do
			local var_32_12 = arg_32_0._goStarList[iter_32_3]

			gohelper.setActive(var_32_12, iter_32_3 <= CharacterEnum.Star[arg_32_0._heroMO.config.rare])
		end
	elseif arg_32_0.monsterCO then
		local var_32_13 = FightConfig.instance:getSkinCO(arg_32_0.monsterCO.skinId)

		arg_32_0._commonHeroCard:onUpdateMO(var_32_13)
		UISpriteSetMgr.instance:setCommonSprite(arg_32_0._careericon, "lssx_" .. tostring(arg_32_0.monsterCO.career))

		local var_32_14, var_32_15 = HeroConfig.instance:getShowLevel(arg_32_0.monsterCO.level)

		arg_32_0._lvnum.text = var_32_14

		for iter_32_4 = 1, 3 do
			local var_32_16 = arg_32_0._goRankList[iter_32_4]

			gohelper.setActive(var_32_16, iter_32_4 == var_32_15 - 1)
		end

		gohelper.setActive(arg_32_0._goStars, false)
	elseif arg_32_0.trialCO then
		local var_32_17 = HeroConfig.instance:getHeroCO(arg_32_0.trialCO.heroId)
		local var_32_18

		if arg_32_0.trialCO.skin > 0 then
			var_32_18 = SkinConfig.instance:getSkinCo(arg_32_0.trialCO.skin)
		else
			var_32_18 = SkinConfig.instance:getSkinCo(var_32_17.skinId)
		end

		if arg_32_0.isLock or arg_32_0.isAid or arg_32_0.isRoleNumLock or not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) then
			recthelper.setHeight(arg_32_0._goblackmask.transform, 125)
		else
			recthelper.setHeight(arg_32_0._goblackmask.transform, 300)
		end

		arg_32_0._commonHeroCard:onUpdateMO(var_32_18)
		UISpriteSetMgr.instance:setCommonSprite(arg_32_0._careericon, "lssx_" .. tostring(var_32_17.career))

		local var_32_19, var_32_20 = HeroConfig.instance:getShowLevel(arg_32_0.trialCO.level)

		arg_32_0._lvnum.text = var_32_19

		for iter_32_5 = 1, 3 do
			local var_32_21 = arg_32_0._goRankList[iter_32_5]

			gohelper.setActive(var_32_21, iter_32_5 == var_32_20 - 1)
		end

		gohelper.setActive(arg_32_0._goStars, true)

		for iter_32_6 = 1, 6 do
			local var_32_22 = arg_32_0._goStarList[iter_32_6]

			gohelper.setActive(var_32_22, iter_32_6 <= CharacterEnum.Star[var_32_17.rare])
		end
	end

	if arg_32_0._heroItemContainer then
		arg_32_0._heroItemContainer.compColor[arg_32_0._lvnumen] = arg_32_0._lvnumen.color

		for iter_32_7 = 1, 3 do
			arg_32_0._heroItemContainer.compColor[arg_32_0._goRankList[iter_32_7]] = arg_32_0._goRankList[iter_32_7].color
		end
	end

	arg_32_0.isLock = not HeroGroupModel.instance:isPositionOpen(arg_32_0.mo.id)
	arg_32_0.isAidLock = arg_32_0.mo.aid and arg_32_0.mo.aid == -1
	arg_32_0.isAid = arg_32_0.mo.aid ~= nil
	arg_32_0.isTrialLock = (arg_32_0.mo.trial and arg_32_0.mo.trialPos) ~= nil

	local var_32_23 = HeroGroupModel.instance:getBattleRoleNum()

	arg_32_0.isRoleNumLock = var_32_23 and var_32_23 < arg_32_0.mo.id
	arg_32_0.isEmpty = arg_32_1:isEmpty()

	gohelper.setActive(arg_32_0._heroGO, (arg_32_0._heroMO ~= nil or arg_32_0.monsterCO ~= nil or arg_32_0.trialCO ~= nil) and not arg_32_0.isLock and not arg_32_0.isRoleNumLock)
	gohelper.setActive(arg_32_0._noneGO, arg_32_0._heroMO == nil and arg_32_0.monsterCO == nil and arg_32_0.trialCO == nil or arg_32_0.isLock or arg_32_0.isAidLock or arg_32_0.isRoleNumLock)
	gohelper.setActive(arg_32_0._addGO, arg_32_0._heroMO == nil and arg_32_0.monsterCO == nil and arg_32_0.trialCO == nil and not arg_32_0.isLock and not arg_32_0.isAidLock and not arg_32_0.isRoleNumLock)
	gohelper.setActive(arg_32_0._lockGO, arg_32_0:selfIsLock())
	gohelper.setActive(arg_32_0._aidGO, arg_32_0.mo.aid and arg_32_0.mo.aid ~= -1)

	if var_32_1 then
		gohelper.setActive(arg_32_0._subGO, not arg_32_0.isLock and not arg_32_0.isAidLock and not arg_32_0.isRoleNumLock and arg_32_0.mo.id > var_32_1.playerMax)
	else
		gohelper.setActive(arg_32_0._subGO, not arg_32_0.isLock and not arg_32_0.isAidLock and not arg_32_0.isRoleNumLock and arg_32_0.mo.id == ModuleEnum.MaxHeroCountInGroup)
	end

	transformhelper.setLocalPosXY(arg_32_0._tagTr, 36.3, arg_32_0._subGO.activeSelf and 144.1 or 212.1)

	if arg_32_0.trialCO then
		gohelper.setActive(arg_32_0._trialTagGO, true)

		arg_32_0._trialTagTxt.text = luaLang("herogroup_trial_tag0")
	else
		gohelper.setActive(arg_32_0._trialTagGO, false)
	end

	if not HeroSingleGroupModel.instance:isTemp() and arg_32_0.isRoleNumLock and arg_32_0._heroMO ~= nil and arg_32_0.monsterCO == nil then
		HeroSingleGroupModel.instance:remove(arg_32_0._heroMO.id)
	end

	arg_32_0:initEquips()
	arg_32_0:showCounterSign()

	if arg_32_0._playDeathAnim then
		arg_32_0._playDeathAnim = nil

		arg_32_0:playAnim(UIAnimationName.Open)
	end

	arg_32_0:_showMojingTip()
	arg_32_0:_updateHp()
	arg_32_0:tickUpdateDLCs(arg_32_0._heroMO)
end

function var_0_0._updateHp(arg_33_0)
	gohelper.setActive(arg_33_0._gohp, arg_33_0._heroMO)

	if not arg_33_0._heroMO then
		return
	end

	local var_33_0 = RougeModel.instance:getTeamInfo():getHeroHp(arg_33_0._heroMO.heroId)
	local var_33_1 = var_33_0 and var_33_0.life or 0

	arg_33_0._sliderhp:SetValue(var_33_1 / 1000)
end

function var_0_0.selfIsLock(arg_34_0)
	return arg_34_0.isLock or arg_34_0.isAidLock or arg_34_0.isRoleNumLock
end

function var_0_0.checkWeekWalkCd(arg_35_0)
	if HeroGroupModel.instance:isAdventureOrWeekWalk() and arg_35_0._heroMO ~= nil and arg_35_0.monsterCO == nil then
		if WeekWalkModel.instance:getCurMapHeroCd(arg_35_0._heroMO.config.id) > 0 then
			arg_35_0._playDeathAnim = true

			arg_35_0:playAnim("herogroup_hero_deal")

			arg_35_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_35_0.setGrayFactor, nil, arg_35_0)

			return arg_35_0._heroMO.id
		else
			arg_35_0._commonHeroCard:setGrayScale(false)
		end
	end
end

function var_0_0.playRestrictAnimation(arg_36_0, arg_36_1)
	if arg_36_0._heroMO and arg_36_1[arg_36_0._heroMO.uid] then
		arg_36_0._playDeathAnim = true

		arg_36_0:playAnim("herogroup_hero_deal")

		arg_36_0.tweenid = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.5, arg_36_0.setGrayFactor, nil, arg_36_0)
	end

	if arg_36_0._assitHeroMo and arg_36_1[arg_36_0._assitHeroMo.uid] then
		arg_36_1[arg_36_0._assitHeroMo.uid] = nil

		RougeHeroSingleGroupModel.instance:remove(arg_36_0._assitHeroMo.uid)
	end
end

function var_0_0.setGrayFactor(arg_37_0, arg_37_1)
	arg_37_0._commonHeroCard:setGrayFactor(arg_37_1)
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

	local var_38_1, var_38_2 = FightHelper.detectAttributeCounter()
	local var_38_3 = tabletool.indexOf(var_38_1, var_38_0)

	gohelper.setActive(arg_38_0._gorecommended, var_38_3)

	local var_38_4 = tabletool.indexOf(var_38_2, var_38_0)

	gohelper.setActive(arg_38_0._gocounter, var_38_4)
	recthelper.setAnchorY(arg_38_0._gohp.transform, (var_38_3 or var_38_4) and -292 or -271)
	recthelper.setAnchorY(arg_38_0._golayout.transform, (var_38_3 or var_38_4) and -21 or 0)
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

function var_0_0._onClickAssit(arg_40_0)
	RougeHeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_40_0.mo.id + RougeEnum.FightTeamNormalHeroNum)
end

function var_0_0._onClickAssitIcon(arg_41_0)
	RougeHeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_41_0.mo.id + RougeEnum.FightTeamNormalHeroNum)
end

function var_0_0._onClickThis(arg_42_0)
	if RougeHeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if arg_42_0.mo.aid or arg_42_0.isRoleNumLock then
		if arg_42_0.mo.aid == -1 or arg_42_0.isRoleNumLock then
			GameFacade.showToast(ToastEnum.IsRoleNumLock)
		else
			GameFacade.showToast(ToastEnum.IsRoleNumUnLock)
		end

		return
	end

	if arg_42_0.isLock then
		local var_42_0, var_42_1 = HeroGroupModel.instance:getPositionLockDesc(arg_42_0.mo.id)

		GameFacade.showToast(var_42_0, var_42_1)
	else
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickHeroGroupItem, arg_42_0.mo.id)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)
	end
end

function var_0_0._onClickThisDown(arg_43_0)
	arg_43_0:_setHeroItemPressState(true)
end

function var_0_0._onClickThisUp(arg_44_0)
	arg_44_0:_setHeroItemPressState(false)
end

function var_0_0._setHeroItemPressState(arg_45_0, arg_45_1)
	if not arg_45_0._heroItemContainer then
		arg_45_0._heroItemContainer = arg_45_0:getUserDataTb_()

		local var_45_0 = arg_45_0._heroGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_45_0._heroItemContainer.images = var_45_0

		local var_45_1 = arg_45_0._heroGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_45_0._heroItemContainer.tmps = var_45_1
		arg_45_0._heroItemContainer.compColor = {}

		local var_45_2 = var_45_0:GetEnumerator()

		while var_45_2:MoveNext() do
			arg_45_0._heroItemContainer.compColor[var_45_2.Current] = var_45_2.Current.color
		end

		local var_45_3 = var_45_1:GetEnumerator()

		while var_45_3:MoveNext() do
			arg_45_0._heroItemContainer.compColor[var_45_3.Current] = var_45_3.Current.color
		end
	end

	local var_45_4 = arg_45_0._heroGO:GetComponentsInChildren(GuiSpine.TypeSkeletonGraphic, true)

	arg_45_0._heroItemContainer.spines = var_45_4

	if arg_45_0._heroItemContainer then
		arg_45_0:_setUIPressState(arg_45_0._heroItemContainer.images, arg_45_1, arg_45_0._heroItemContainer.compColor)
		arg_45_0:_setUIPressState(arg_45_0._heroItemContainer.tmps, arg_45_1, arg_45_0._heroItemContainer.compColor)
		arg_45_0:_setUIPressState(arg_45_0._heroItemContainer.spines, arg_45_1)
	end

	if arg_45_0._imageAdd then
		local var_45_5 = arg_45_1 and var_0_0.PressColor or Color.white

		arg_45_0._imageAdd.color = var_45_5
	end
end

function var_0_0._onClickEquip(arg_46_0)
	if RougeHeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Equip) or arg_46_0.trialCO or HeroGroupTrialModel.instance:haveTrialEquip() then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Inking_Addmood)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HideAllGroupHeroItemEffect)

		local var_46_0 = RougeHeroSingleGroupModel.instance:getCurGroupMO()

		arg_46_0._viewParam = {
			heroGroupMo = var_46_0,
			heroMo = arg_46_0._heroMO,
			equipMo = arg_46_0._equipMO,
			maxHeroNum = RougeEnum.FightTeamNormalHeroNum,
			posIndex = arg_46_0._posIndex,
			fromView = EquipEnum.FromViewEnum.FromHeroGroupFightView,
			confirmViewType = EquipEnum.FromViewEnum.FromRougeHeroGroupFightView
		}

		if arg_46_0.trialCO then
			arg_46_0._viewParam.heroMo = HeroGroupTrialModel.instance:getHeroMo(arg_46_0.trialCO)

			if arg_46_0.trialCO.equipId > 0 then
				arg_46_0._viewParam.equipMo = arg_46_0._viewParam.heroMo.trialEquipMo
			end
		end

		arg_46_0:_onOpenEquipTeamView()
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.Equip))
	end
end

function var_0_0._onClickEquipDown(arg_47_0)
	arg_47_0:_setEquipItemPressState(true)
end

function var_0_0._onClickEquipUp(arg_48_0)
	arg_48_0:_setEquipItemPressState(false)
end

function var_0_0._setEquipItemPressState(arg_49_0, arg_49_1)
	if not arg_49_0._equipItemContainer then
		arg_49_0._equipItemContainer = arg_49_0:getUserDataTb_()
		arg_49_0._equipEmtpyContainer = arg_49_0:getUserDataTb_()

		local var_49_0 = arg_49_0._equipGO:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_49_0._equipItemContainer.images = var_49_0

		local var_49_1 = arg_49_0._equipGO:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_49_0._equipItemContainer.tmps = var_49_1
		arg_49_0._equipItemContainer.compColor = {}

		local var_49_2 = arg_49_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_Image, true)

		arg_49_0._equipEmtpyContainer.images = var_49_2

		local var_49_3 = arg_49_0._emptyEquipGo:GetComponentsInChildren(gohelper.Type_TextMesh, true)

		arg_49_0._equipEmtpyContainer.tmps = var_49_3
		arg_49_0._equipEmtpyContainer.compColor = {}

		local var_49_4 = var_49_0:GetEnumerator()

		while var_49_4:MoveNext() do
			arg_49_0._equipItemContainer.compColor[var_49_4.Current] = var_49_4.Current.color
		end

		local var_49_5 = var_49_1:GetEnumerator()

		while var_49_5:MoveNext() do
			arg_49_0._equipItemContainer.compColor[var_49_5.Current] = var_49_5.Current.color
		end

		local var_49_6 = var_49_2:GetEnumerator()

		while var_49_6:MoveNext() do
			arg_49_0._equipEmtpyContainer.compColor[var_49_6.Current] = var_49_6.Current.color
		end

		local var_49_7 = var_49_3:GetEnumerator()

		while var_49_7:MoveNext() do
			arg_49_0._equipEmtpyContainer.compColor[var_49_7.Current] = var_49_7.Current.color
		end
	end

	if arg_49_0._equipItemContainer then
		arg_49_0:_setUIPressState(arg_49_0._equipItemContainer.images, arg_49_1, arg_49_0._equipItemContainer.compColor)
		arg_49_0:_setUIPressState(arg_49_0._equipItemContainer.tmps, arg_49_1, arg_49_0._equipItemContainer.compColor)
	end

	if arg_49_0._equipEmtpyContainer then
		arg_49_0:_setUIPressState(arg_49_0._equipEmtpyContainer.images, arg_49_1, arg_49_0._equipEmtpyContainer.compColor)
		arg_49_0:_setUIPressState(arg_49_0._equipEmtpyContainer.tmps, arg_49_1, arg_49_0._equipEmtpyContainer.compColor)
	end
end

function var_0_0._onOpenEquipTeamView(arg_50_0)
	local var_50_0 = RougeHeroGroupBalanceHelper.getIsBalanceMode()
	local var_50_1, var_50_2, var_50_3 = RougeHeroGroupBalanceHelper.getBalanceLv()

	arg_50_0._viewParam.isBalance = var_50_0
	arg_50_0._viewParam.balanceEquipLv = var_50_3

	EquipController.instance:openEquipInfoTeamView(arg_50_0._viewParam)
end

function var_0_0.onItemBeginDrag(arg_51_0, arg_51_1)
	if arg_51_1 == arg_51_0.mo.id then
		ZProj.TweenHelper.DOScale(arg_51_0.go.transform, 1.1, 1.1, 1, 0.2, nil, nil, nil, EaseType.Linear)
		gohelper.setActive(arg_51_0._dragFrameGO, true)
		gohelper.setActive(arg_51_0._dragFrameSelectGO, true)
		gohelper.setActive(arg_51_0._dragFrameCompleteGO, false)
	end

	gohelper.setActive(arg_51_0._clickGO, false)
end

function var_0_0.onItemEndDrag(arg_52_0, arg_52_1, arg_52_2)
	ZProj.TweenHelper.DOScale(arg_52_0.go.transform, 1, 1, 1, 0.2, nil, nil, nil, EaseType.Linear)
	arg_52_0:_setHeroItemPressState(false)
end

function var_0_0.onItemCompleteDrag(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	if arg_53_2 == arg_53_0.mo.id and arg_53_1 ~= arg_53_2 then
		if arg_53_3 then
			gohelper.setActive(arg_53_0._dragFrameGO, true)
			gohelper.setActive(arg_53_0._dragFrameSelectGO, false)
			gohelper.setActive(arg_53_0._dragFrameCompleteGO, false)
			gohelper.setActive(arg_53_0._dragFrameCompleteGO, true)
			TaskDispatcher.cancelTask(arg_53_0.hideDragEffect, arg_53_0)
			TaskDispatcher.runDelay(arg_53_0.hideDragEffect, arg_53_0, 0.833)
		end
	else
		gohelper.setActive(arg_53_0._dragFrameGO, false)
	end

	gohelper.setActive(arg_53_0._clickGO, true)
end

function var_0_0.hideDragEffect(arg_54_0)
	gohelper.setActive(arg_54_0._dragFrameGO, false)
end

function var_0_0.setHeroGroupEquipEffect(arg_55_0, arg_55_1)
	arg_55_0._canPlayEffect = arg_55_1
end

function var_0_0.killEquipTweenId(arg_56_0)
	if arg_56_0.equipTweenId then
		ZProj.TweenHelper.KillById(arg_56_0.equipTweenId)
	end
end

function var_0_0.getAnimStateLength(arg_57_0, arg_57_1)
	arg_57_0.clipLengthDict = arg_57_0.clipLengthDict or {
		swicth = 0.833,
		herogroup_hero_deal = 1.667,
		[UIAnimationName.Open] = 0.833,
		[UIAnimationName.Close] = 0.333
	}

	local var_57_0 = arg_57_0.clipLengthDict[arg_57_1]

	if not var_57_0 then
		logError("not get animation state name :  " .. tostring(arg_57_1))
	end

	return var_57_0 or 0
end

function var_0_0.playAnim(arg_58_0, arg_58_1)
	local var_58_0 = arg_58_0:getAnimStateLength(arg_58_1)

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, var_58_0)
	arg_58_0.anim:Play(arg_58_1, 0, 0)
	arg_58_0.anim2:Play(arg_58_1, 0, 0)
end

function var_0_0.onDestroy(arg_59_0)
	arg_59_0:killEquipTweenId()

	if arg_59_0._drag then
		arg_59_0._drag:RemoveDragBeginListener()
		arg_59_0._drag:RemoveDragListener()
		arg_59_0._drag:RemoveDragEndListener()
	end

	TaskDispatcher.cancelTask(arg_59_0._onOpenEquipTeamView, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0.hideDragEffect, arg_59_0)
	var_0_0.super.onDestroy(arg_59_0)
end

return var_0_0
