module("modules.logic.survival.view.shelter.ShelterManagerInfoView", package.seeall)

local var_0_0 = class("ShelterManagerInfoView", LuaCompBase)

function var_0_0.getView(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = gohelper.clone(arg_1_0, arg_1_1, arg_1_2)

	return MonoHelper.addNoUpdateLuaComOnceToGo(var_1_0, var_0_0)
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.viewGO = arg_2_1
	arg_2_0.transform = arg_2_1.transform
	arg_2_0.goRoot = gohelper.findChild(arg_2_0.viewGO, "root")
	arg_2_0.btnClose = gohelper.findChildButtonWithAudio(arg_2_0.goRoot, "#btn_close")

	gohelper.setActive(arg_2_0.btnClose, false)
	arg_2_0:initNpc()
	arg_2_0:initbuild()

	arg_2_0.goEmpty = gohelper.findChild(arg_2_0.goRoot, "#go_empty")
	arg_2_0.animator = arg_2_0.viewGO:GetComponent(gohelper.Type_Animator)
end

function var_0_0.initNpc(arg_3_0)
	arg_3_0.goNpc = gohelper.findChild(arg_3_0.goRoot, "#go_npc")
	arg_3_0.imgNpcQuality = gohelper.findChildImage(arg_3_0.goNpc, "top/middle/npc/#image_quality")
	arg_3_0.imgNpcChess = gohelper.findChildSingleImage(arg_3_0.goNpc, "top/middle/npc/#image_chess")
	arg_3_0.txtNpcName = gohelper.findChildTextMesh(arg_3_0.goNpc, "top/middle/npc/#txt_name")
	arg_3_0.goNpcReset = gohelper.findChild(arg_3_0.goNpc, "top/left/rest")
	arg_3_0.btnNpcLeave = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_leave")
	arg_3_0.btnNpcGoto = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_goto")
	arg_3_0.btnNpcReset = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_rest")
	arg_3_0.btnNpcJoin = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_join")
	arg_3_0.btnNpcSelect = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_select")
	arg_3_0.btnNpcUnSelect = gohelper.findChildButtonWithAudio(arg_3_0.goNpc, "bottom/#btn_unSelect")
	arg_3_0.goNpcAttrItem = gohelper.findChild(arg_3_0.goNpc, "scroll_base/Viewport/Content/#go_attrs/#go_baseitem")

	gohelper.setActive(arg_3_0.goNpcAttrItem, false)

	arg_3_0.txtNpcInfo = gohelper.findChildTextMesh(arg_3_0.goNpc, "scroll_base/Viewport/Content/#txt_info")
	arg_3_0.npcAttrList = {}
	arg_3_0.goNpcCost = gohelper.findChild(arg_3_0.goNpc, "right/tips")
	arg_3_0.txtNpcCostTips = gohelper.findChildTextMesh(arg_3_0.goNpcCost, "#txt_tips")
end

function var_0_0.initbuild(arg_4_0)
	arg_4_0.goBuild = gohelper.findChild(arg_4_0.goRoot, "#go_build")
	arg_4_0.imageBuild = gohelper.findChildImage(arg_4_0.goBuild, "top/middle/build/#image_build")
	arg_4_0.simageBuild = gohelper.findChildSingleImage(arg_4_0.goBuild, "top/middle/build/#image_build")
	arg_4_0.goImageBuild = gohelper.findChild(arg_4_0.goBuild, "top/middle/build/#image_build")
	arg_4_0.txtBuildName = gohelper.findChildTextMesh(arg_4_0.goBuild, "top/middle/build/#txt_name")
	arg_4_0.goBuildDestroyed = gohelper.findChild(arg_4_0.goBuild, "top/middle/build/#go_Destroyed")
	arg_4_0.goBuildLocked = gohelper.findChild(arg_4_0.goBuild, "top/middle/build/#go_Locked")
	arg_4_0.btnBuildLevup = gohelper.findChildButtonWithAudio(arg_4_0.goBuild, "bottom/#btn_LevelUp")
	arg_4_0.btnBuild = gohelper.findChildButtonWithAudio(arg_4_0.goBuild, "bottom/#btn_build")
	arg_4_0.btnBuildRepair = gohelper.findChildButtonWithAudio(arg_4_0.goBuild, "bottom/#btn_repair")
	arg_4_0.goBuildLock = gohelper.findChild(arg_4_0.goBuild, "bottom/#go_lock")
	arg_4_0.goBuildLockBuild = gohelper.findChild(arg_4_0.goBuild, "bottom/#go_lock/txt_build")
	arg_4_0.goBuildLockLevup = gohelper.findChild(arg_4_0.goBuild, "bottom/#go_lock/txt_levup")
	arg_4_0.txtBuildLock = gohelper.findChildTextMesh(arg_4_0.goBuild, "bottom/#go_lock/#txt_lock")
	arg_4_0.goBuildCost = gohelper.findChild(arg_4_0.goBuild, "bottom/#go_num")
	arg_4_0.txtBuildCost = gohelper.findChildTextMesh(arg_4_0.goBuild, "bottom/#go_num/#txt_count")
	arg_4_0.goBuildAttrLevelup = gohelper.findChild(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_attrs/#go_LevelUp")
	arg_4_0.txtBuildLevel1 = gohelper.findChildTextMesh(arg_4_0.goBuildAttrLevelup, "#image_title/#txt_level1")
	arg_4_0.txtBuildLevel2 = gohelper.findChildTextMesh(arg_4_0.goBuildAttrLevelup, "#image_title/#txt_level2")
	arg_4_0.goBuildAttrLevel = gohelper.findChild(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_attrs/#go_Level")
	arg_4_0.txtBuildLevel = gohelper.findChildTextMesh(arg_4_0.goBuildAttrLevel, "#image_title/#txt_level")
	arg_4_0.txtBuildAttrCurrentItem = gohelper.findChildTextMesh(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_current/#txt_current")
	arg_4_0.goBuildAttrNext = gohelper.findChild(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_next")
	arg_4_0.txtBuildAttrNextItem = gohelper.findChildTextMesh(arg_4_0.goBuild, "scroll_base/Viewport/Content/#go_next/#txt_next")
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnClose, arg_5_0.onClickBtnClose, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcGoto, arg_5_0.onClickBtnNpcGoto, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcReset, arg_5_0.onClickBtnNpcReset, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcJoin, arg_5_0.onClickBtnNpcJoin, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnBuildLevup, arg_5_0.onClickBtnBuildLevup, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnBuildRepair, arg_5_0.onClickBtnBuildRepair, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnBuild, arg_5_0.onClickBtnBuild, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcSelect, arg_5_0.onClickBtnNpcSelect, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcLeave, arg_5_0.onClickBtnNpcLeave, arg_5_0)
	arg_5_0:addClickCb(arg_5_0.btnNpcUnSelect, arg_5_0.onClickBtnNpcUnSelect, arg_5_0)
	arg_5_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_5_0.onShelterBagUpdate, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0:removeClickCb(arg_6_0.btnClose)
	arg_6_0:removeClickCb(arg_6_0.btnNpcGoto)
	arg_6_0:removeClickCb(arg_6_0.btnNpcReset)
	arg_6_0:removeClickCb(arg_6_0.btnNpcJoin)
	arg_6_0:removeClickCb(arg_6_0.btnBuildLevup)
	arg_6_0:removeClickCb(arg_6_0.btnBuildRepair)
	arg_6_0:removeClickCb(arg_6_0.btnBuild)
	arg_6_0:removeClickCb(arg_6_0.btnNpcSelect)
	arg_6_0:removeClickCb(arg_6_0.btnNpcLeave)
	arg_6_0:removeClickCb(arg_6_0.btnNpcUnSelect)
	arg_6_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_6_0.onShelterBagUpdate, arg_6_0)
end

function var_0_0.onShelterBagUpdate(arg_7_0)
	arg_7_0:refreshView()
end

function var_0_0.onClickBtnClose(arg_8_0)
	return
end

function var_0_0.onClickBtnNpcLeave(arg_9_0)
	SurvivalShelterTentListModel.instance:quickSelectNpc(arg_9_0.showId)
end

function var_0_0.onClickBtnNpcJoin(arg_10_0)
	SurvivalShelterTentListModel.instance:quickSelectNpc(arg_10_0.showId)
end

function var_0_0.onClickBtnNpcSelect(arg_11_0)
	SurvivalShelterChooseNpcListModel.instance:setSelectNpcToPos(arg_11_0.showId)
	arg_11_0:setNextSelectPos()
end

function var_0_0.onClickBtnNpcUnSelect(arg_12_0)
	local var_12_0 = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(arg_12_0.showId)

	SurvivalShelterChooseNpcListModel.instance:setSelectNpcToPos(nil, var_12_0)
	arg_12_0:setNextSelectPos()
end

function var_0_0.setNextSelectPos(arg_13_0)
	local var_13_0 = SurvivalShelterChooseNpcListModel.instance:getNextCanSelectPosIndex()

	if var_13_0 ~= nil then
		SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSetNpcSelectPos, var_13_0)
	end
end

function var_0_0.onClickBtnNpcReset(arg_14_0)
	ViewMgr.instance:closeView(ViewName.ShelterNpcManagerView)
	ViewMgr.instance:openView(ViewName.ShelterTentManagerView)
end

function var_0_0.onClickBtnNpcGoto(arg_15_0)
	SurvivalMapHelper.instance:gotoNpc(arg_15_0.showId)
end

function var_0_0.onClickBtnBuildLevup(arg_16_0)
	local var_16_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_16_1 = var_16_0:getBuildingInfo(arg_16_0.showId)

	if not var_16_1 then
		return
	end

	local var_16_2 = SurvivalConfig.instance:getBuildingConfig(var_16_1.buildingId, var_16_1.level + 1, true)
	local var_16_3, var_16_4, var_16_5, var_16_6 = var_16_0:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(var_16_2.lvUpCost, var_16_1, SurvivalEnum.AttrType.BuildCost)

	if not var_16_3 then
		local var_16_7 = lua_survival_item.configDict[var_16_4]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_16_7.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalUpgradeRequest(var_16_1.id)
end

function var_0_0.onClickBtnBuild(arg_17_0)
	local var_17_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_17_1 = var_17_0:getBuildingInfo(arg_17_0.showId)

	if not var_17_1 then
		return
	end

	local var_17_2 = SurvivalConfig.instance:getBuildingConfig(var_17_1.buildingId, var_17_1.level + 1, true)
	local var_17_3, var_17_4, var_17_5, var_17_6 = var_17_0:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(var_17_2.lvUpCost, var_17_1, SurvivalEnum.AttrType.BuildCost)

	if not var_17_3 then
		local var_17_7 = lua_survival_item.configDict[var_17_4]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_17_7.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalBuildRequest(var_17_1.id)
end

function var_0_0.onClickBtnBuildRepair(arg_18_0)
	local var_18_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_18_1 = var_18_0:getBuildingInfo(arg_18_0.showId)

	if not var_18_1 then
		return
	end

	local var_18_2 = SurvivalConfig.instance:getBuildingConfig(var_18_1.buildingId, var_18_1.level, true)
	local var_18_3, var_18_4, var_18_5, var_18_6 = var_18_0:getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(var_18_2.repairCost, var_18_1, SurvivalEnum.AttrType.RepairCost)

	if not var_18_3 then
		local var_18_7 = lua_survival_item.configDict[var_18_4]

		GameFacade.showToast(ToastEnum.DiamondBuy, var_18_7.name)

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalRepairRequest(var_18_1.id)
end

function var_0_0.refreshParam(arg_19_0, arg_19_1)
	arg_19_0.viewParam = arg_19_1 or {}
	arg_19_0.showType = arg_19_0.viewParam.showType or SurvivalEnum.InfoShowType.None
	arg_19_0.showId = arg_19_0.viewParam.showId or 0
	arg_19_0.otherParam = arg_19_0.viewParam.otherParam or {}

	arg_19_0:refreshAnimName()
	arg_19_0:refreshView()
end

function var_0_0.refreshAnimName(arg_20_0)
	local var_20_0 = not arg_20_0.showId

	arg_20_0.animName = nil

	if var_20_0 then
		arg_20_0.animName = UIAnimationName.Open
	elseif arg_20_0.showId ~= arg_20_0.lastShowId or arg_20_0.showType ~= arg_20_0.lastShowType then
		arg_20_0.animName = UIAnimationName.Switch
		arg_20_0.delayRefreshTime = 0.167
	end

	arg_20_0.lastShowId = arg_20_0.showId
	arg_20_0.lastShowType = arg_20_0.showType
end

function var_0_0.refreshView(arg_21_0)
	if arg_21_0.animName then
		arg_21_0.animator:Play(arg_21_0.animName, 0, 0)
	end

	arg_21_0.animName = nil

	TaskDispatcher.cancelTask(arg_21_0.refreshInfo, arg_21_0)

	if arg_21_0.delayRefreshTime then
		TaskDispatcher.runDelay(arg_21_0.refreshInfo, arg_21_0, arg_21_0.delayRefreshTime)
	else
		arg_21_0:refreshInfo()
	end

	arg_21_0.delayRefreshTime = nil
end

function var_0_0.refreshInfo(arg_22_0)
	if arg_22_0.showType == SurvivalEnum.InfoShowType.Building then
		arg_22_0:refreshBuilding()
	elseif arg_22_0.showType == SurvivalEnum.InfoShowType.Npc or arg_22_0.showType == SurvivalEnum.InfoShowType.NpcOnlyConfig then
		arg_22_0:refreshNpc()
	else
		arg_22_0:showEmpty()
	end
end

function var_0_0.refreshBuilding(arg_23_0)
	local var_23_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_23_1 = var_23_0:getBuildingInfo(arg_23_0.showId)

	if not var_23_1 then
		arg_23_0:showEmpty()

		return
	end

	gohelper.setActive(arg_23_0.goBuild, true)
	gohelper.setActive(arg_23_0.goNpc, false)
	gohelper.setActive(arg_23_0.goEmpty, false)

	local var_23_2 = var_23_1.level
	local var_23_3 = var_23_2 + 1
	local var_23_4 = SurvivalConfig.instance:getBuildingConfig(var_23_1.buildingId, var_23_2, true)
	local var_23_5 = SurvivalConfig.instance:getBuildingConfig(var_23_1.buildingId, var_23_3, true)

	arg_23_0.txtBuildName.text = var_23_1.baseCo.name

	local var_23_6, var_23_7 = var_23_0:isBuildingUnlock(var_23_1.buildingId, var_23_3, true)
	local var_23_8 = not var_23_1:isBuild()
	local var_23_9 = var_23_1.status == SurvivalEnum.BuildingStatus.Destroy

	gohelper.setActive(arg_23_0.goBuildDestroyed, var_23_9)
	gohelper.setActive(arg_23_0.goBuildLocked, not var_23_6 and var_23_8)
	arg_23_0.simageBuild:LoadImage(var_23_1.baseCo.icon, arg_23_0.onLoadedImage, arg_23_0)
	ZProj.UGUIHelper.SetGrayscale(arg_23_0.goImageBuild, not var_23_6 and var_23_8)
	gohelper.setActive(arg_23_0.btnBuildLevup, false)
	gohelper.setActive(arg_23_0.btnBuild, false)
	gohelper.setActive(arg_23_0.btnBuildRepair, false)
	gohelper.setActive(arg_23_0.goBuildLock, false)
	gohelper.setActive(arg_23_0.goBuildCost, false)

	if var_23_6 then
		if var_23_8 then
			gohelper.setActive(arg_23_0.btnBuild, true)
			arg_23_0:refreshBuildCost(var_23_5 and var_23_5.lvUpCost, var_23_1, SurvivalEnum.AttrType.BuildCost)
		elseif var_23_9 then
			gohelper.setActive(arg_23_0.btnBuildRepair, true)
			arg_23_0:refreshBuildCost(var_23_4 and var_23_4.repairCost, var_23_1, SurvivalEnum.AttrType.RepairCost)
		else
			gohelper.setActive(arg_23_0.btnBuildLevup, var_23_5 ~= nil)
			arg_23_0:refreshBuildCost(var_23_5 and var_23_5.lvUpCost, var_23_1, SurvivalEnum.AttrType.BuildCost)
		end
	else
		gohelper.setActive(arg_23_0.goBuildLock, true)

		arg_23_0.txtBuildLock.text = var_23_7

		gohelper.setActive(arg_23_0.goBuildLockBuild, var_23_8)
		gohelper.setActive(arg_23_0.goBuildLockLevup, not var_23_8)
	end

	local var_23_10 = var_23_1.level > 0 and var_23_5 ~= nil and not var_23_9

	gohelper.setActive(arg_23_0.goBuildAttrLevelup, var_23_10)
	gohelper.setActive(arg_23_0.goBuildAttrLevel, not var_23_10)
	gohelper.setActive(arg_23_0.goBuildAttrNext, var_23_10)

	arg_23_0.txtBuildAttrCurrentItem.text = var_23_4 and var_23_4.desc or var_23_5 and var_23_5.desc or ""

	if var_23_10 then
		arg_23_0.txtBuildAttrNextItem.text = var_23_5.desc
		arg_23_0.txtBuildLevel1.text = string.format("Lv.%s", var_23_2)
		arg_23_0.txtBuildLevel2.text = string.format("Lv.%s", var_23_3)
	else
		arg_23_0.txtBuildLevel.text = string.format("Lv.%s", var_23_2)
	end
end

function var_0_0.onLoadedImage(arg_24_0)
	arg_24_0.imageBuild:SetNativeSize()
end

function var_0_0.refreshBuildCost(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	if string.nilorempty(arg_25_1) then
		gohelper.setActive(arg_25_0.goBuildCost, false)
	else
		gohelper.setActive(arg_25_0.goBuildCost, true)

		local var_25_0, var_25_1, var_25_2, var_25_3 = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Shelter):costIsEnough(arg_25_1, arg_25_2, arg_25_3)

		if var_25_0 then
			arg_25_0.txtBuildCost.text = string.format("%s/%s", var_25_3, var_25_2)
		else
			arg_25_0.txtBuildCost.text = string.format("<color=#D74242>%s</color>/%s", var_25_3, var_25_2)
		end
	end
end

function var_0_0.refreshNpc(arg_26_0)
	if arg_26_0.showType == SurvivalEnum.InfoShowType.NpcOnlyConfig then
		arg_26_0:_refreshNpcOnlyConfig()

		return
	end

	local var_26_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_26_1 = var_26_0:getNpcInfo(arg_26_0.showId)

	if not var_26_1 then
		arg_26_0:showEmpty()

		return
	end

	gohelper.setActive(arg_26_0.goBuild, false)
	gohelper.setActive(arg_26_0.goNpc, true)
	gohelper.setActive(arg_26_0.goEmpty, false)

	local var_26_2 = arg_26_0.otherParam.tentBuildingId
	local var_26_3 = arg_26_0.otherParam.tentBuildingPos
	local var_26_4 = var_26_2 ~= nil and var_26_2 ~= 0
	local var_26_5 = var_26_1.co

	arg_26_0.txtNpcName.text = var_26_5.name

	SurvivalUnitIconHelper.instance:setNpcIcon(arg_26_0.imgNpcChess, var_26_5.headIcon)
	UISpriteSetMgr.instance:setSurvivalSprite(arg_26_0.imgNpcQuality, string.format("survival_bag_itemquality2_%s", var_26_5.rare))

	arg_26_0.txtNpcInfo.text = var_26_5.npcDesc

	local var_26_6, var_26_7 = var_26_0:getNpcPostion(arg_26_0.showId)
	local var_26_8 = var_26_6 ~= nil

	gohelper.setActive(arg_26_0.goNpcReset, not var_26_4 and var_26_8)
	gohelper.setActive(arg_26_0.btnNpcGoto, not var_26_4 and var_26_8)
	gohelper.setActive(arg_26_0.btnNpcReset, not var_26_4 and not var_26_8)

	local var_26_9, var_26_10 = SurvivalConfig.instance:getNpcConfigTag(arg_26_0.showId)

	for iter_26_0 = 1, math.max(#var_26_10, #arg_26_0.npcAttrList) do
		local var_26_11 = arg_26_0:getNpcAttrItem(iter_26_0)

		arg_26_0:refreshNpcAttrItem(var_26_11, var_26_10[iter_26_0])
	end

	gohelper.setActive(arg_26_0.btnNpcJoin, var_26_4 and var_26_2 ~= var_26_6)
	gohelper.setActive(arg_26_0.btnNpcLeave, var_26_4 and var_26_2 == var_26_6)
	arg_26_0:refreshNpcCost(var_26_5)
end

function var_0_0.refreshNpcCost(arg_27_0, arg_27_1)
	if not arg_27_1 then
		gohelper.setActive(arg_27_0.goNpcCost, false)

		return
	end

	gohelper.setActive(arg_27_0.goNpcCost, true)

	local var_27_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_27_1 = string.split(arg_27_1.cost, "#")
	local var_27_2 = string.splitToNumber(var_27_1[2], ":")[2] or 0
	local var_27_3 = var_27_0:getAttr(SurvivalEnum.AttrType.NpcFoodCost, var_27_2)

	arg_27_0.txtNpcCostTips.text = formatLuaLang("ShelterManagerInfoView_npc_foodcost", var_27_3)
end

function var_0_0._refreshNpcOnlyConfig(arg_28_0)
	gohelper.setActive(arg_28_0.goBuild, false)
	gohelper.setActive(arg_28_0.goNpc, true)
	gohelper.setActive(arg_28_0.goEmpty, false)

	local var_28_0 = SurvivalConfig.instance:getNpcConfig(arg_28_0.showId)

	if var_28_0 then
		arg_28_0.txtNpcName.text = var_28_0.name

		if not string.nilorempty(var_28_0.headIcon) then
			SurvivalUnitIconHelper.instance:setNpcIcon(arg_28_0.imgNpcChess, var_28_0.headIcon)
		end

		UISpriteSetMgr.instance:setSurvivalSprite(arg_28_0.imgNpcQuality, string.format("survival_bag_itemquality2_%s", var_28_0.rare))

		arg_28_0.txtNpcInfo.text = var_28_0.npcDesc
	end

	gohelper.setActive(arg_28_0.goNpcReset, false)
	gohelper.setActive(arg_28_0.btnNpcGoto, false)
	gohelper.setActive(arg_28_0.btnNpcReset, false)
	gohelper.setActive(arg_28_0.btnNpcJoin, false)

	local var_28_1, var_28_2 = SurvivalConfig.instance:getNpcConfigTag(arg_28_0.showId)

	for iter_28_0 = 1, math.max(#var_28_2, #arg_28_0.npcAttrList) do
		local var_28_3 = arg_28_0:getNpcAttrItem(iter_28_0)

		arg_28_0:refreshNpcAttrItem(var_28_3, var_28_2[iter_28_0])
	end

	local var_28_4 = arg_28_0.otherParam and arg_28_0.otherParam.showSelect or true
	local var_28_5 = arg_28_0.otherParam and arg_28_0.otherParam.showUnSelect or true
	local var_28_6 = SurvivalShelterChooseNpcListModel.instance:isQuickSelect()

	if var_28_4 then
		local var_28_7 = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(arg_28_0.showId)

		gohelper.setActive(arg_28_0.btnNpcSelect, var_28_7 == nil and not var_28_6)
	end

	if var_28_5 then
		local var_28_8 = SurvivalShelterChooseNpcListModel.instance:npcIdIsSelect(arg_28_0.showId)

		gohelper.setActive(arg_28_0.btnNpcUnSelect, var_28_8 ~= nil and not var_28_6)
	end

	arg_28_0:refreshNpcCost()
end

function var_0_0.getNpcAttrItem(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.npcAttrList[arg_29_1]

	if not var_29_0 then
		var_29_0 = arg_29_0:getUserDataTb_()
		var_29_0.go = gohelper.cloneInPlace(arg_29_0.goNpcAttrItem, tostring(arg_29_1))
		var_29_0.imgTitle = gohelper.findChildImage(var_29_0.go, "#image_title")
		var_29_0.txtTitle = gohelper.findChildTextMesh(var_29_0.go, "#image_title/#txt_title")
		var_29_0.txtDesc = gohelper.findChildTextMesh(var_29_0.go, "layout/#go_decitem/#txt_desc")
		arg_29_0.npcAttrList[arg_29_1] = var_29_0
	end

	return var_29_0
end

function var_0_0.refreshNpcAttrItem(arg_30_0, arg_30_1, arg_30_2)
	if not arg_30_2 then
		gohelper.setActive(arg_30_1.go, false)

		return
	end

	gohelper.setActive(arg_30_1.go, true)

	local var_30_0 = lua_survival_tag.configDict[arg_30_2]

	if var_30_0 == nil then
		logError("tagId is nil" .. arg_30_2)

		return
	end

	arg_30_1.txtTitle.text = var_30_0.name
	arg_30_1.txtDesc.text = var_30_0.desc

	UISpriteSetMgr.instance:setSurvivalSprite(arg_30_1.imgTitle, string.format("survivalpartnerteam_attrbg%s", var_30_0.color))
end

function var_0_0.showEmpty(arg_31_0)
	gohelper.setActive(arg_31_0.goBuild, false)
	gohelper.setActive(arg_31_0.goNpc, false)
	gohelper.setActive(arg_31_0.goEmpty, true)
end

function var_0_0.onDestroy(arg_32_0)
	arg_32_0.simageBuild:UnLoadImage()
	TaskDispatcher.cancelTask(arg_32_0.refreshInfo, arg_32_0)
end

return var_0_0
