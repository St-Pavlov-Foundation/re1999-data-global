module("modules.logic.survival.view.shelter.ShelterUnitUIItem", package.seeall)

local var_0_0 = class("ShelterUnitUIItem", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.unitType = arg_1_1.unitType
	arg_1_0.unitId = arg_1_1.unitId
	arg_1_0.root1 = arg_1_1.root1
	arg_1_0.root2 = arg_1_1.root2
	arg_1_0.bubbleIconName = -1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_1.transform

	transformhelper.setLocalPos(arg_2_0.trans, 9999, 9999, 0)

	arg_2_0.rootGO = gohelper.findChild(arg_2_1, "root")
	arg_2_0.animator = arg_2_0.rootGO:GetComponent(gohelper.Type_Animator)
	arg_2_0.imagebubble = gohelper.findChildImage(arg_2_0.rootGO, "#image_bubble")
	arg_2_0.imageicon = gohelper.findChildImage(arg_2_0.rootGO, "#image_icon")
	arg_2_0.cgImg = gohelper.findChildComponent(arg_2_0.rootGO, "#image_icon", typeof(UnityEngine.CanvasGroup))
	arg_2_0.goBuildLevelup = gohelper.findChild(arg_2_0.rootGO, "#go_levelUp")
	arg_2_0.goCanBuild = gohelper.findChild(arg_2_0.rootGO, "#go_canBuild")
	arg_2_0.goRest = gohelper.findChild(arg_2_0.rootGO, "#go_rest")
	arg_2_0.goRecruitFinish = gohelper.findChild(arg_2_0.rootGO, "#go_finish")
	arg_2_0.goBuildInfo = gohelper.findChild(arg_2_0.rootGO, "#go_Info")
	arg_2_0.animGoBuildInfo = arg_2_0.goBuildInfo:GetComponent(gohelper.Type_Animation)
	arg_2_0.txtBuildInfo = gohelper.findChildTextMesh(arg_2_0.rootGO, "#go_Info/Info/#txt_Info")
	arg_2_0.image_level_reputation = gohelper.findChildImage(arg_2_0.rootGO, "#go_Info/Info/#txt_Info/#image_level")
	arg_2_0.go_reddot_reputation = gohelper.findChild(arg_2_0.rootGO, "#go_Info/Info/#txt_Info/#go_reddot")
	arg_2_0.goMonster = gohelper.findChild(arg_2_0.rootGO, "monster")
	arg_2_0.sImageMonsterIcon = gohelper.findChildSingleImage(arg_2_0.rootGO, "monster/#go_monsterHeadIcon")
	arg_2_0.goMonsterTime = gohelper.findChild(arg_2_0.rootGO, "monster/Time")
	arg_2_0.txtTime = gohelper.findChildTextMesh(arg_2_0.rootGO, "monster/Time/#txt_LimitTime")
	arg_2_0.goHero = gohelper.findChild(arg_2_0.rootGO, "hero")
	arg_2_0.goarrow = gohelper.findChild(arg_2_0.rootGO, "arrow")
	arg_2_0.goarrowright = gohelper.findChild(arg_2_0.rootGO, "arrow/right")
	arg_2_0.goarrowtop = gohelper.findChild(arg_2_0.rootGO, "arrow/top")
	arg_2_0.goarrowleft = gohelper.findChild(arg_2_0.rootGO, "arrow/left")
	arg_2_0.goarrowbottom = gohelper.findChild(arg_2_0.rootGO, "arrow/bottom")
	arg_2_0.goRaycast = gohelper.findChild(arg_2_0.rootGO, "goRaycast")

	arg_2_0:initClick()
	arg_2_0:initFollower()
	arg_2_0:initBg()
	arg_2_0:refreshInfo()
	arg_2_0:refreshReputationRedDot()
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function var_0_0.addEventListeners(arg_4_0)
	arg_4_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalReputationExpReply, arg_4_0.refreshReputation, arg_4_0)
	arg_4_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnDelayPopupFinishEvent, arg_4_0.onDelayPopupFinishEvent, arg_4_0)
end

function var_0_0.initClick(arg_5_0)
	local var_5_0 = SurvivalEnum.ShelterUnitType.Build == arg_5_0.unitType or SurvivalEnum.ShelterUnitType.Monster == arg_5_0.unitType or SurvivalEnum.ShelterUnitType.Player == arg_5_0.unitType

	gohelper.setActive(arg_5_0.goRaycast, var_5_0)

	if not var_5_0 or arg_5_0.click then
		return
	end

	arg_5_0.click = gohelper.getClick(arg_5_0.go)

	arg_5_0.click:AddClickListener(arg_5_0.onClick, arg_5_0)
end

function var_0_0.initFollower(arg_6_0)
	if arg_6_0._uiFollower then
		return
	end

	local var_6_0 = arg_6_0:getEntity()

	if not var_6_0 then
		return
	end

	local var_6_1 = false

	if arg_6_0.unitType == SurvivalEnum.ShelterUnitType.Player then
		var_6_1 = true
	end

	if not var_6_1 then
		gohelper.setActive(arg_6_0.goarrow, false)

		arg_6_0._uiFollower = gohelper.onceAddComponent(arg_6_0.go, typeof(ZProj.UIFollower))
	else
		gohelper.setActive(arg_6_0.goarrow, true)

		arg_6_0._uiFollower = gohelper.onceAddComponent(arg_6_0.go, typeof(ZProj.UIFollowerInRange))

		arg_6_0._uiFollower:SetBoundArrow(arg_6_0.goarrowleft, arg_6_0.goarrowright, arg_6_0.goarrowtop, arg_6_0.goarrowbottom)

		local var_6_2 = ViewMgr.instance:getUIRoot().transform
		local var_6_3 = recthelper.getWidth(var_6_2)
		local var_6_4 = recthelper.getHeight(var_6_2)

		var_6_4 = var_6_3 / var_6_4 < 1.7777777777777777 and 1080 or var_6_4

		local var_6_5 = var_6_3 / 2
		local var_6_6 = var_6_4 / 2

		arg_6_0._uiFollower:SetRange(-var_6_5, var_6_5, -var_6_6, var_6_6)
		arg_6_0._uiFollower:SetArrowCallback(arg_6_0.onArrowCallback, arg_6_0)
	end

	arg_6_0._uiFollower:SetEnable(true)

	local var_6_7 = CameraMgr.instance:getMainCamera()
	local var_6_8 = CameraMgr.instance:getUICamera()
	local var_6_9 = ViewMgr.instance:getUIRoot().transform
	local var_6_10 = var_6_0:getFolowerTransform()

	arg_6_0._uiFollower:Set(var_6_7, var_6_8, var_6_9, var_6_10, 0, 0.4, 0, 0, 0)
end

function var_0_0.onArrowCallback(arg_7_0, arg_7_1)
	if arg_7_0.unitType == SurvivalEnum.ShelterUnitType.Player then
		if arg_7_1 then
			arg_7_0:setVisible(true)
		else
			arg_7_0:refreshPlayerInfo()
		end
	else
		gohelper.setActive(arg_7_0.imagebubble, not arg_7_1)
	end

	if arg_7_1 then
		gohelper.addChildPosStay(arg_7_0.root2, arg_7_0.go)
	else
		gohelper.addChildPosStay(arg_7_0.root1, arg_7_0.go)
	end
end

function var_0_0.onClick(arg_8_0)
	if SurvivalEnum.ShelterUnitType.Player == arg_8_0.unitType then
		local var_8_0 = arg_8_0:getEntity()

		if var_8_0 then
			var_8_0:onClickPlayer()
		end
	end

	if SurvivalMapHelper.instance:getSurvivalBubbleComp():isPlayerBubbleIntercept() then
		return
	end

	SurvivalMapHelper.instance:gotoUnit(arg_8_0.unitType, arg_8_0.unitId)
end

local var_0_1 = {
	[SurvivalEnum.ShelterUnitType.Monster] = "survival_map_bubble_red"
}

function var_0_0.initBg(arg_9_0)
	local var_9_0 = arg_9_0.unitType
	local var_9_1 = var_0_1[var_9_0] or "survival_map_bubble_green"

	UISpriteSetMgr.instance:setSurvivalSprite(arg_9_0.imagebubble, var_9_1)
end

function var_0_0.refreshInfo(arg_10_0)
	local var_10_0 = arg_10_0.unitType

	if var_10_0 == SurvivalEnum.ShelterUnitType.Player then
		arg_10_0:refreshPlayerInfo()
	elseif var_10_0 == SurvivalEnum.ShelterUnitType.Build then
		arg_10_0:refreshBuildingInfo()
	elseif var_10_0 == SurvivalEnum.ShelterUnitType.Monster then
		arg_10_0:refreshMonsterInfo()
	elseif var_10_0 == SurvivalEnum.ShelterUnitType.Npc then
		arg_10_0:refreshNpcInfo()
	end
end

function var_0_0.refreshNpcInfo(arg_11_0)
	local var_11_0 = arg_11_0:getEntity()

	if not var_11_0 then
		return
	end

	local var_11_1 = not var_11_0:isInPlayerPos()

	if var_11_1 then
		local var_11_2 = SurvivalMapHelper.instance:getShelterNpcPriorityBehavior(arg_11_0.unitId)

		var_11_1 = var_11_2 and var_11_2.isMark == 1 or false
	end

	arg_11_0:setVisible(var_11_1)
	arg_11_0:setBubbleIcon("survival_map_icon_1")
end

function var_0_0.refreshMonsterInfo(arg_12_0)
	local var_12_0 = SurvivalShelterModel.instance:getWeekInfo():getMonsterFight()

	if var_12_0.fightCo == nil then
		arg_12_0:setVisible(false)

		return
	end

	local var_12_1 = arg_12_0:getEntity()

	if not var_12_1 then
		return
	end

	local var_12_2 = not var_12_1:isInPlayerPos()

	arg_12_0:setVisible(var_12_2)

	if not var_12_2 then
		return
	end

	gohelper.setActive(arg_12_0.goMonster, true)
	gohelper.setActive(arg_12_0.goMonsterTime, false)

	local var_12_3 = var_12_0.fightCo.smallheadicon

	if var_12_3 and (arg_12_0._lastSmallIcon == nil or var_12_3 ~= arg_12_0._lastSmallIcon) then
		arg_12_0.sImageMonsterIcon:LoadImage(ResUrl.monsterHeadIcon(var_12_3))

		arg_12_0._lastSmallIcon = var_12_3
	end
end

function var_0_0.refreshPlayerInfo(arg_13_0)
	local var_13_0 = arg_13_0:getEntity()
	local var_13_1 = var_13_0 and var_13_0:isVisible() or false

	arg_13_0:setVisible(not var_13_1)
	gohelper.setActive(arg_13_0.goHero, true)
	gohelper.setActive(arg_13_0.imagebubble, false)
	arg_13_0:setBubbleIcon()
end

function var_0_0.refreshBuildingInfo(arg_14_0)
	local var_14_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_14_1 = var_14_0:getBuildingInfo(arg_14_0.unitId)

	if not var_14_1 then
		arg_14_0:setVisible(false)

		return
	end

	local var_14_2 = var_14_1:getLevel()
	local var_14_3 = var_14_1:isBuild()

	if not var_14_3 and not var_14_0:isBuildingUnlock(var_14_1.buildingId, var_14_2 + 1) then
		arg_14_0:setVisible(false)

		return
	end

	arg_14_0:setVisible(true)

	local var_14_4 = var_14_1.baseCo.unName ~= 1

	gohelper.setActive(arg_14_0.goBuildInfo, var_14_3 and var_14_4)

	local var_14_5 = var_14_0:isBuildingCanLevup(var_14_1, var_14_2 + 1, false)

	if not var_14_3 then
		arg_14_0:setBubbleIcon(var_14_5 and "survival_map_bubble_add")
		gohelper.setActive(arg_14_0.imagebubble, false)

		return
	end

	if var_14_1.isSingleLevel then
		arg_14_0.txtBuildInfo.text = var_14_1.baseCo.name
	else
		arg_14_0.txtBuildInfo.text = string.format("%s\n<size=28>Lv.%s</size>", var_14_1.baseCo.name, var_14_2)
	end

	gohelper.setActive(arg_14_0.goBuildLevelup, var_14_5)

	if var_14_1:isEqualType(SurvivalEnum.BuildingType.Npc) then
		arg_14_0:setBubbleIcon("survival_map_icon_20")

		local var_14_6 = var_14_0:getRecruitInfo()
		local var_14_7 = var_14_6:isInRecruit()
		local var_14_8 = var_14_6:isCanSelectNpc()

		gohelper.setActive(arg_14_0.goRest, var_14_7)

		local var_14_9 = var_14_7 and 0.6 or 1

		arg_14_0.cgImg.alpha = var_14_9

		gohelper.setActive(arg_14_0.goRecruitFinish, var_14_8)
		gohelper.setActive(arg_14_0.goCanBuild, not var_14_7 and not var_14_8)
		gohelper.setActive(arg_14_0.imagebubble, true)

		return
	elseif var_14_1:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		local var_14_10 = var_14_1.survivalReputationPropMo.prop.reputationId
		local var_14_11 = var_14_1.survivalReputationPropMo.prop.reputationLevel
		local var_14_12 = SurvivalConfig.instance:getBuildReputationIcon(var_14_10, var_14_11)

		arg_14_0:setBubbleIcon(var_14_12)
		gohelper.setActive(arg_14_0.imagebubble, true)
		arg_14_0:refreshReputation(false)

		return
	elseif var_14_1:isEqualType(SurvivalEnum.BuildingType.Shop) then
		arg_14_0:setBubbleIcon("survival_map_icon_15")
		gohelper.setActive(arg_14_0.imagebubble, true)

		return
	end

	arg_14_0:setBubbleIcon()
	gohelper.setActive(arg_14_0.imagebubble, false)
end

function var_0_0.OnReceiveSurvivalReputationExpReply(arg_15_0)
	arg_15_0:refreshReputation(true)
end

function var_0_0.onDelayPopupFinishEvent(arg_16_0)
	arg_16_0:refreshReputation(true)
end

function var_0_0.refreshReputation(arg_17_0, arg_17_1)
	local var_17_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_17_0.unitId)

	if not var_17_0 then
		return
	end

	local var_17_1 = var_17_0.survivalReputationPropMo
	local var_17_2 = var_17_0:isEqualType(SurvivalEnum.BuildingType.ReputationShop)

	gohelper.setActive(arg_17_0.image_level_reputation, var_17_2)

	if var_17_2 then
		local var_17_3 = var_17_1.prop.reputationLevel
		local var_17_4 = SurvivalShelterModel.instance:getWeekInfo().clientData
		local var_17_5 = var_17_0.survivalReputationPropMo.survivalShopMo.id
		local var_17_6 = var_17_4:getReputationShopHUDUILevel(var_17_5)

		UISpriteSetMgr.instance:setSurvivalSprite(arg_17_0.image_level_reputation, string.format("survival_level_icon_%s", var_17_6))

		if arg_17_1 and var_17_6 < var_17_3 then
			UISpriteSetMgr.instance:setSurvivalSprite(arg_17_0.image_level_reputation, string.format("survival_level_icon_%s", var_17_3))
			arg_17_0.animGoBuildInfo:Play()
			var_17_4:setReputationShopHUDUILevel(var_17_5, var_17_3)
		end
	end
end

function var_0_0.refreshReputationRedDot(arg_18_0)
	local var_18_0 = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_18_0.unitId)

	if var_18_0 and var_18_0:isEqualType(SurvivalEnum.BuildingType.ReputationShop) then
		local var_18_1 = SurvivalConfig.instance:getReputationRedDotType(var_18_0.buildingId)

		RedDotController.instance:addRedDot(arg_18_0.go_reddot_reputation, var_18_1)
	end
end

function var_0_0.setBubbleIcon(arg_19_0, arg_19_1)
	if not arg_19_0._isVisible then
		return
	end

	if arg_19_1 == arg_19_0.bubbleIconName then
		return
	end

	arg_19_0.bubbleIconName = arg_19_1

	if not arg_19_1 or string.nilorempty(arg_19_1) then
		gohelper.setActive(arg_19_0.imageicon, false)

		return
	end

	gohelper.setActive(arg_19_0.imageicon, true)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_19_0.imageicon, arg_19_1, true)
end

function var_0_0.setVisible(arg_20_0, arg_20_1)
	if arg_20_0._isVisible == arg_20_1 then
		return
	end

	arg_20_0._isVisible = arg_20_1

	gohelper.setActive(arg_20_0.rootGO, arg_20_1)
end

function var_0_0.getEntity(arg_21_0)
	return SurvivalMapHelper.instance:getShelterEntity(arg_21_0.unitType, arg_21_0.unitId)
end

function var_0_0.dispose(arg_22_0)
	gohelper.destroy(arg_22_0.go)
end

function var_0_0.playAnim(arg_23_0, arg_23_1)
	if not arg_23_0._isVisible then
		return
	end

	arg_23_0.animator:Play(arg_23_1, 0, 0)
end

function var_0_0.onDestroy(arg_24_0)
	if arg_24_0.click then
		arg_24_0.click:RemoveClickListener()
	end

	arg_24_0._lastSmallIcon = nil
end

return var_0_0
