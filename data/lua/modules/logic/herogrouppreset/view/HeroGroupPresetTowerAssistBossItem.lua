module("modules.logic.herogrouppreset.view.HeroGroupPresetTowerAssistBossItem", package.seeall)

local var_0_0 = class("HeroGroupPresetTowerAssistBossItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goOpen = gohelper.findChild(arg_1_0.viewGO, "root/go_open")
	arg_1_0.goLock = gohelper.findChild(arg_1_0.viewGO, "root/go_lock")
	arg_1_0.goSelected = gohelper.findChild(arg_1_0.viewGO, "root/go_selected")
	arg_1_0.goUnSelect = gohelper.findChild(arg_1_0.viewGO, "root/go_unselect")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "click")
	arg_1_0.btnSure = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnSure")
	arg_1_0.goSureBg = gohelper.findChild(arg_1_0.viewGO, "root/btnSure/bg")
	arg_1_0.btnCancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/btnCancel")
	arg_1_0.goLevel = gohelper.findChild(arg_1_0.viewGO, "root/level")
	arg_1_0.txtLevel = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/level/#txt_level")
	arg_1_0.goArrow = gohelper.findChild(arg_1_0.viewGO, "root/level/#go_Arrow")
	arg_1_0.goTrial = gohelper.findChild(arg_1_0.viewGO, "root/go_trial")
	arg_1_0.goTrialEffect = gohelper.findChild(arg_1_0.viewGO, "root/#saoguang")
	arg_1_0.hasPlayTrialEffect = false
	arg_1_0.itemList = {}

	arg_1_0:createItem(arg_1_0.goOpen)
	arg_1_0:createItem(arg_1_0.goLock)
	arg_1_0:createItem(arg_1_0.goSelected)
	arg_1_0:createItem(arg_1_0.goUnSelect)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onBtnClick, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnSure, arg_2_0.onBtnSure, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnCancel, arg_2_0.onBtnCancel, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ResetTalent, arg_2_0._onResetTalent, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.ActiveTalent, arg_2_0._onActiveTalent, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClick)
	arg_3_0:removeClickCb(arg_3_0.btnSure)
	arg_3_0:removeClickCb(arg_3_0.btnCancel)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._onResetTalent(arg_5_0, arg_5_1)
	arg_5_0:refreshTalent()
end

function var_0_0._onActiveTalent(arg_6_0, arg_6_1)
	arg_6_0:refreshTalent()
end

function var_0_0.onBtnSure(arg_7_0)
	arg_7_0:_getHeroGroupMo():setAssistBossId(arg_7_0._mo.bossId)
	arg_7_0:saveGroup()

	do return end

	if not arg_7_0._mo then
		return
	end

	if arg_7_0._mo.isLock == 1 and not arg_7_0.isLimitedTrial then
		GameFacade.showToast(ToastEnum.TowerAssistBossLock)

		return
	end

	local var_7_0 = TowerModel.instance:getRecordFightParam()

	if var_7_0.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	if var_7_0.towerType == TowerEnum.TowerType.Boss then
		GameFacade.showToast(ToastEnum.TowerAssistBossCannotChange)

		return
	end

	if TowerModel.instance:isBossBan(arg_7_0._mo.bossId) then
		GameFacade.showToast(ToastEnum.TowerAssistBossBan, arg_7_0._mo.config.name)

		return
	end

	arg_7_0:_getHeroGroupMo():setAssistBossId(arg_7_0._mo.bossId)
	arg_7_0:saveGroup()
end

function var_0_0.onBtnCancel(arg_8_0)
	local var_8_0 = TowerModel.instance:getRecordFightParam()

	if var_8_0.isHeroGroupLock then
		GameFacade.showToast(ToastEnum.TowerHeroGroupCantEdit)

		return
	end

	if var_8_0.towerType == TowerEnum.TowerType.Boss then
		GameFacade.showToast(ToastEnum.TowerAssistBossCannotChange)

		return
	end

	arg_8_0:_getHeroGroupMo():setAssistBossId(0)
	arg_8_0:saveGroup()
end

function var_0_0._getHeroGroupMo(arg_9_0)
	if arg_9_0._viewParam.otherParam and arg_9_0._viewParam.otherParam.heroGroupMO then
		return arg_9_0._viewParam.otherParam.heroGroupMO
	end

	return HeroGroupModel.instance:getCurGroupMO()
end

function var_0_0.saveGroup(arg_10_0)
	if arg_10_0._viewParam.otherParam and arg_10_0._viewParam.otherParam.saveGroup then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		arg_10_0._viewParam.otherParam.saveGroup()

		return
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
end

function var_0_0.onBtnClick(arg_11_0)
	do return end

	if not arg_11_0._mo then
		return
	end

	if arg_11_0._mo.isLock == 1 and not arg_11_0.isLimitedTrial then
		GameFacade.showToast(ToastEnum.TowerAssistBossLock)

		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
		bossId = arg_11_0._mo.bossId,
		isFromHeroGroup = arg_11_0._mo.isFromHeroGroup
	})
end

function var_0_0.createItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = arg_12_1
	var_12_0.txtName = gohelper.findChildTextMesh(arg_12_1, "name/#txt_name")
	var_12_0.imgCareer = gohelper.findChildImage(arg_12_1, "career")
	var_12_0.simageBoss = gohelper.findChildSingleImage(arg_12_1, "#simage_bossicon")
	var_12_0.goTxtOpen = gohelper.findChild(arg_12_1, "toptips")
	arg_12_0.itemList[arg_12_1] = var_12_0
end

function var_0_0.onUpdateMO(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._mo = arg_13_1
	arg_13_0._viewParam = arg_13_2

	local var_13_0 = TowerModel.instance:getCurTowerType() == TowerEnum.TowerType.Limited
	local var_13_1

	var_13_1 = arg_13_1.isLock == 1 and not var_13_0

	local var_13_2 = false
	local var_13_3 = arg_13_0.goOpen

	if arg_13_1.isFromHeroGroup then
		var_13_3 = arg_13_1.isSelect and arg_13_0.goSelected or arg_13_0.goUnSelect

		gohelper.setActive(arg_13_0.btnSure, not arg_13_1.isSelect)
		gohelper.setActive(arg_13_0.btnCancel, arg_13_1.isSelect)

		local var_13_4 = arg_13_1.isBanOrder == 1 or var_13_2

		ZProj.UGUIHelper.SetGrayscale(arg_13_0.goSureBg, var_13_4)
	else
		gohelper.setActive(arg_13_0.btnSure, false)
		gohelper.setActive(arg_13_0.btnCancel, false)
	end

	if var_13_2 then
		var_13_3 = arg_13_0.goLock
	end

	for iter_13_0, iter_13_1 in pairs(arg_13_0.itemList) do
		arg_13_0:updateItem(iter_13_1, var_13_3)
	end

	local var_13_5 = not var_13_2
	local var_13_6 = false

	gohelper.setActive(arg_13_0.goLevel, var_13_6)

	if var_13_6 then
		local var_13_7 = 1

		if arg_13_0._mo.bossInfo and not arg_13_0._mo.bossInfo:getTempState() then
			var_13_7 = arg_13_0._mo.bossInfo.level

			local var_13_8 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

			arg_13_0.isLimitedTrial = var_13_0 and var_13_7 < var_13_8

			if arg_13_0.isLimitedTrial then
				var_13_7 = var_13_8

				TowerAssistBossModel.instance:setLimitedTrialBossInfo(arg_13_0._mo.bossInfo)
			else
				arg_13_0._mo.bossInfo:setTrialInfo(0, 0)
				arg_13_0._mo.bossInfo:refreshTalent()
			end
		else
			var_13_7 = tonumber(TowerConfig.instance:getTowerConstConfig(TowerEnum.ConstId.BalanceBossLevel))

			TowerAssistBossModel.instance:getTempUnlockTrialBossMO(arg_13_0._mo.id)

			arg_13_0.isLimitedTrial = true
		end

		local var_13_9 = var_13_7

		arg_13_0.txtLevel.text = tostring(var_13_9)

		SLFramework.UGUI.GuiHelper.SetColor(arg_13_0.txtLevel, arg_13_0.isLimitedTrial and "#81A8DC" or "#DCAE70")
	end

	gohelper.setActive(arg_13_0.goTrial, arg_13_0.isLimitedTrial)
	gohelper.setActive(arg_13_0.goTrialEffect, false)
	gohelper.setActive(arg_13_0.goTrialEffect, arg_13_0.isLimitedTrial and not arg_13_0.hasPlayTrialEffect)

	arg_13_0.hasPlayTrialEffect = true

	arg_13_0:refreshTalent()
end

function var_0_0.refreshTalent(arg_14_0)
	gohelper.setActive(arg_14_0.goArrow, arg_14_0._mo.bossInfo and arg_14_0._mo.bossInfo:hasTalentCanActive() and not arg_14_0.isLimitedTrial or false)
end

function var_0_0.updateItem(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_1.go == arg_15_2

	gohelper.setActive(arg_15_1.go, var_15_0)

	if not var_15_0 then
		return
	end

	arg_15_1.txtName.text = arg_15_0._mo.config.name

	UISpriteSetMgr.instance:setCommonSprite(arg_15_1.imgCareer, string.format("lssx_%s", arg_15_0._mo.config.career))
	arg_15_1.simageBoss:LoadImage(arg_15_0._mo.config.bossPic)
	gohelper.setActive(arg_15_1.goTxtOpen, false)
end

function var_0_0.onDestroyView(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0.itemList) do
		iter_16_1.simageBoss:UnLoadImage()
	end
end

return var_0_0
