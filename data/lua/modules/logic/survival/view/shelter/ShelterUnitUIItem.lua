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
	arg_2_0.txtBuildInfo = gohelper.findChildTextMesh(arg_2_0.rootGO, "#go_Info/Info/#txt_Info")
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
end

function var_0_0.onStart(arg_3_0)
	arg_3_0.go:GetComponent(typeof(SLFramework.LuaMonobehavier)).enabled = false
end

function var_0_0.initClick(arg_4_0)
	local var_4_0 = SurvivalEnum.ShelterUnitType.Build == arg_4_0.unitType or SurvivalEnum.ShelterUnitType.Monster == arg_4_0.unitType or SurvivalEnum.ShelterUnitType.Player == arg_4_0.unitType

	gohelper.setActive(arg_4_0.goRaycast, var_4_0)

	if not var_4_0 or arg_4_0.click then
		return
	end

	arg_4_0.click = gohelper.getClick(arg_4_0.go)

	arg_4_0.click:AddClickListener(arg_4_0.onClick, arg_4_0)
end

function var_0_0.initFollower(arg_5_0)
	if arg_5_0._uiFollower then
		return
	end

	local var_5_0 = arg_5_0:getEntity()

	if not var_5_0 then
		return
	end

	local var_5_1 = false

	if arg_5_0.unitType == SurvivalEnum.ShelterUnitType.Player then
		var_5_1 = true
	end

	if not var_5_1 then
		gohelper.setActive(arg_5_0.goarrow, false)

		arg_5_0._uiFollower = gohelper.onceAddComponent(arg_5_0.go, typeof(ZProj.UIFollower))
	else
		gohelper.setActive(arg_5_0.goarrow, true)

		arg_5_0._uiFollower = gohelper.onceAddComponent(arg_5_0.go, typeof(ZProj.UIFollowerInRange))

		arg_5_0._uiFollower:SetBoundArrow(arg_5_0.goarrowleft, arg_5_0.goarrowright, arg_5_0.goarrowtop, arg_5_0.goarrowbottom)

		local var_5_2 = ViewMgr.instance:getUIRoot().transform
		local var_5_3 = recthelper.getWidth(var_5_2)
		local var_5_4 = recthelper.getHeight(var_5_2)

		var_5_4 = var_5_3 / var_5_4 < 1.7777777777777777 and 1080 or var_5_4

		local var_5_5 = var_5_3 / 2
		local var_5_6 = var_5_4 / 2

		arg_5_0._uiFollower:SetRange(-var_5_5, var_5_5, -var_5_6, var_5_6)
		arg_5_0._uiFollower:SetArrowCallback(arg_5_0.onArrowCallback, arg_5_0)
	end

	arg_5_0._uiFollower:SetEnable(true)

	local var_5_7 = CameraMgr.instance:getMainCamera()
	local var_5_8 = CameraMgr.instance:getUICamera()
	local var_5_9 = ViewMgr.instance:getUIRoot().transform
	local var_5_10 = var_5_0:getFolowerTransform()

	arg_5_0._uiFollower:Set(var_5_7, var_5_8, var_5_9, var_5_10, 0, 0.4, 0, 0, 0)
end

function var_0_0.onArrowCallback(arg_6_0, arg_6_1)
	if arg_6_0.unitType == SurvivalEnum.ShelterUnitType.Player then
		if arg_6_1 then
			arg_6_0:setVisible(true)
		else
			arg_6_0:refreshPlayerInfo()
		end
	else
		gohelper.setActive(arg_6_0.imagebubble, not arg_6_1)
	end

	if arg_6_1 then
		gohelper.addChildPosStay(arg_6_0.root2, arg_6_0.go)
	else
		gohelper.addChildPosStay(arg_6_0.root1, arg_6_0.go)
	end
end

function var_0_0.onClick(arg_7_0)
	if SurvivalEnum.ShelterUnitType.Player == arg_7_0.unitType then
		local var_7_0 = arg_7_0:getEntity()

		if var_7_0 then
			var_7_0:onClickPlayer()
		end
	end

	SurvivalMapHelper.instance:gotoUnit(arg_7_0.unitType, arg_7_0.unitId)
end

local var_0_1 = {
	[SurvivalEnum.ShelterUnitType.Monster] = "survival_map_bubble_red"
}

function var_0_0.initBg(arg_8_0)
	local var_8_0 = arg_8_0.unitType
	local var_8_1 = var_0_1[var_8_0] or "survival_map_bubble_green"

	UISpriteSetMgr.instance:setSurvivalSprite(arg_8_0.imagebubble, var_8_1)
end

function var_0_0.refreshInfo(arg_9_0)
	local var_9_0 = arg_9_0.unitType

	if var_9_0 == SurvivalEnum.ShelterUnitType.Player then
		arg_9_0:refreshPlayerInfo()
	elseif var_9_0 == SurvivalEnum.ShelterUnitType.Build then
		arg_9_0:refreshBuildingInfo()
	elseif var_9_0 == SurvivalEnum.ShelterUnitType.Monster then
		arg_9_0:refreshMonsterInfo()
	elseif var_9_0 == SurvivalEnum.ShelterUnitType.Npc then
		arg_9_0:refreshNpcInfo()
	end
end

function var_0_0.refreshNpcInfo(arg_10_0)
	local var_10_0 = arg_10_0:getEntity()

	if not var_10_0 then
		return
	end

	local var_10_1 = not var_10_0:isInPlayerPos()

	if var_10_1 then
		local var_10_2 = SurvivalMapHelper.instance:getShelterNpcPriorityBehavior(arg_10_0.unitId)

		var_10_1 = var_10_2 and var_10_2.isMark == 1 or false
	end

	arg_10_0:setVisible(var_10_1)
	arg_10_0:setBubbleIcon("survival_map_icon_1")
end

function var_0_0.refreshMonsterInfo(arg_11_0)
	local var_11_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_11_1 = var_11_0:getMonsterFight()

	if var_11_1.fightCo == nil then
		arg_11_0:setVisible(false)

		return
	end

	local var_11_2 = arg_11_0:getEntity()

	if not var_11_2 then
		return
	end

	local var_11_3 = not var_11_2:isInPlayerPos()

	arg_11_0:setVisible(var_11_3)

	if not var_11_3 then
		return
	end

	gohelper.setActive(arg_11_0.goMonster, true)

	local var_11_4 = var_11_1.endTime - var_11_0.day

	if var_11_4 > 0 then
		gohelper.setActive(arg_11_0.goMonsterTime, true)

		arg_11_0.txtTime.text = string.format("%s%s", var_11_4, TimeUtil.DateEnFormat.Day)
	else
		gohelper.setActive(arg_11_0.goMonsterTime, false)
	end

	local var_11_5 = var_11_1.fightCo.smallheadicon

	if var_11_5 and (arg_11_0._lastSmallIcon == nil or var_11_5 ~= arg_11_0._lastSmallIcon) then
		arg_11_0.sImageMonsterIcon:LoadImage(ResUrl.monsterHeadIcon(var_11_5))

		arg_11_0._lastSmallIcon = var_11_5
	end
end

function var_0_0.refreshPlayerInfo(arg_12_0)
	local var_12_0 = arg_12_0:getEntity()
	local var_12_1 = var_12_0 and var_12_0:isVisible() or false

	arg_12_0:setVisible(not var_12_1)
	gohelper.setActive(arg_12_0.goHero, true)
	gohelper.setActive(arg_12_0.imagebubble, false)
	arg_12_0:setBubbleIcon()
end

function var_0_0.refreshBuildingInfo(arg_13_0)
	local var_13_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_13_1 = var_13_0:getBuildingInfo(arg_13_0.unitId)

	if not var_13_1 then
		arg_13_0:setVisible(false)

		return
	end

	local var_13_2 = var_13_1:getLevel()
	local var_13_3 = var_13_1:isBuild()

	if not var_13_3 and not var_13_0:isBuildingUnlock(var_13_1.buildingId, var_13_2 + 1) then
		arg_13_0:setVisible(false)

		return
	end

	arg_13_0:setVisible(true)
	gohelper.setActive(arg_13_0.goBuildInfo, var_13_3)

	local var_13_4 = var_13_0:isBuildingCanLevup(var_13_1, var_13_2 + 1, false)

	if not var_13_3 then
		arg_13_0:setBubbleIcon(var_13_4 and "survival_map_bubble_add")
		gohelper.setActive(arg_13_0.imagebubble, false)

		return
	end

	if var_13_1.isSingleLevel then
		arg_13_0.txtBuildInfo.text = var_13_1.baseCo.name
	else
		arg_13_0.txtBuildInfo.text = string.format("%s\n<size=28>Lv.%s</size>", var_13_1.baseCo.name, var_13_2)
	end

	gohelper.setActive(arg_13_0.goBuildLevelup, var_13_4)

	if var_13_1:isEqualType(SurvivalEnum.BuildingType.Npc) then
		arg_13_0:setBubbleIcon("survival_map_icon_20")

		local var_13_5 = var_13_0:getRecruitInfo()
		local var_13_6 = var_13_5:isInRecruit()
		local var_13_7 = var_13_5:isCanSelectNpc()

		gohelper.setActive(arg_13_0.goRest, var_13_6)

		local var_13_8 = var_13_6 and 0.6 or 1

		arg_13_0.cgImg.alpha = var_13_8

		gohelper.setActive(arg_13_0.goRecruitFinish, var_13_7)
		gohelper.setActive(arg_13_0.goCanBuild, not var_13_6 and not var_13_7)
		gohelper.setActive(arg_13_0.imagebubble, true)

		return
	end

	arg_13_0:setBubbleIcon()
	gohelper.setActive(arg_13_0.imagebubble, false)
end

function var_0_0.setBubbleIcon(arg_14_0, arg_14_1)
	if not arg_14_0._isVisible then
		return
	end

	if arg_14_1 == arg_14_0.bubbleIconName then
		return
	end

	arg_14_0.bubbleIconName = arg_14_1

	if not arg_14_1 or string.nilorempty(arg_14_1) then
		gohelper.setActive(arg_14_0.imageicon, false)

		return
	end

	gohelper.setActive(arg_14_0.imageicon, true)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_14_0.imageicon, arg_14_1, true)
end

function var_0_0.setVisible(arg_15_0, arg_15_1)
	if arg_15_0._isVisible == arg_15_1 then
		return
	end

	arg_15_0._isVisible = arg_15_1

	gohelper.setActive(arg_15_0.rootGO, arg_15_1)
end

function var_0_0.getEntity(arg_16_0)
	return SurvivalMapHelper.instance:getShelterEntity(arg_16_0.unitType, arg_16_0.unitId)
end

function var_0_0.dispose(arg_17_0)
	gohelper.destroy(arg_17_0.go)
end

function var_0_0.playAnim(arg_18_0, arg_18_1)
	if not arg_18_0._isVisible then
		return
	end

	arg_18_0.animator:Play(arg_18_1, 0, 0)
end

function var_0_0.onDestroy(arg_19_0)
	if arg_19_0.click then
		arg_19_0.click:RemoveClickListener()
	end

	arg_19_0._lastSmallIcon = nil
end

return var_0_0
