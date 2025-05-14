module("modules.logic.tower.view.assistboss.TowerAssistBossItem", package.seeall)

local var_0_0 = class("TowerAssistBossItem", ListScrollCellExtend)

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
	if not arg_7_0._mo then
		return
	end

	if arg_7_0._mo.isLock == 1 then
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

	HeroGroupModel.instance:getCurGroupMO():setAssistBossId(arg_7_0._mo.bossId)
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

	HeroGroupModel.instance:getCurGroupMO():setAssistBossId(0)
	arg_8_0:saveGroup()
end

function var_0_0.saveGroup(arg_9_0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
end

function var_0_0.onBtnClick(arg_10_0)
	if not arg_10_0._mo then
		return
	end

	if arg_10_0._mo.isLock == 1 then
		GameFacade.showToast(ToastEnum.TowerAssistBossLock)

		return
	end

	ViewMgr.instance:openView(ViewName.TowerAssistBossDetailView, {
		bossId = arg_10_0._mo.bossId,
		isFromHeroGroup = arg_10_0._mo.isFromHeroGroup
	})
end

function var_0_0.createItem(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getUserDataTb_()

	var_11_0.go = arg_11_1
	var_11_0.txtName = gohelper.findChildTextMesh(arg_11_1, "name/#txt_name")
	var_11_0.imgCareer = gohelper.findChildImage(arg_11_1, "career")
	var_11_0.simageBoss = gohelper.findChildSingleImage(arg_11_1, "#simage_bossicon")
	var_11_0.goTxtOpen = gohelper.findChild(arg_11_1, "toptips")
	arg_11_0.itemList[arg_11_1] = var_11_0
end

function var_0_0.onUpdateMO(arg_12_0, arg_12_1)
	arg_12_0._mo = arg_12_1

	local var_12_0 = arg_12_1.isLock == 1
	local var_12_1 = arg_12_0.goOpen

	if arg_12_1.isFromHeroGroup then
		var_12_1 = arg_12_1.isSelect and arg_12_0.goSelected or arg_12_0.goUnSelect

		gohelper.setActive(arg_12_0.btnSure, not arg_12_1.isSelect)
		gohelper.setActive(arg_12_0.btnCancel, arg_12_1.isSelect)

		local var_12_2 = arg_12_1.isBanOrder == 1 or var_12_0

		ZProj.UGUIHelper.SetGrayscale(arg_12_0.goSureBg, var_12_2)
	else
		gohelper.setActive(arg_12_0.btnSure, false)
		gohelper.setActive(arg_12_0.btnCancel, false)
	end

	if var_12_0 then
		var_12_1 = arg_12_0.goLock
	end

	for iter_12_0, iter_12_1 in pairs(arg_12_0.itemList) do
		arg_12_0:updateItem(iter_12_1, var_12_1)
	end

	local var_12_3 = not var_12_0

	gohelper.setActive(arg_12_0.goLevel, var_12_3)

	if var_12_3 then
		local var_12_4 = arg_12_0._mo.bossInfo.level

		arg_12_0.txtLevel.text = tostring(var_12_4)
	end

	arg_12_0:refreshTalent()
end

function var_0_0.refreshTalent(arg_13_0)
	gohelper.setActive(arg_13_0.goArrow, arg_13_0._mo.bossInfo and arg_13_0._mo.bossInfo:hasTalentCanActive() or false)
end

function var_0_0.updateItem(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = arg_14_1.go == arg_14_2

	gohelper.setActive(arg_14_1.go, var_14_0)

	if not var_14_0 then
		return
	end

	arg_14_1.txtName.text = arg_14_0._mo.config.name

	UISpriteSetMgr.instance:setCommonSprite(arg_14_1.imgCareer, string.format("lssx_%s", arg_14_0._mo.config.career))
	arg_14_1.simageBoss:LoadImage(arg_14_0._mo.config.bossPic)
	gohelper.setActive(arg_14_1.goTxtOpen, arg_14_0._mo.isTowerOpen and not arg_14_0._mo.isFromHeroGroup)
end

function var_0_0.onDestroyView(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0.itemList) do
		iter_15_1.simageBoss:UnLoadImage()
	end
end

return var_0_0
