module("modules.logic.equip.view.EquipTeamView", package.seeall)

local var_0_0 = class("EquipTeamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebgmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bgmask")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._goequipcontainer = gohelper.findChild(arg_1_0.viewGO, "#go_equipcontainer")
	arg_1_0._scrollequip = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_equipcontainer/#scroll_equip")
	arg_1_0._goequipsort = gohelper.findChild(arg_1_0.viewGO, "#go_equipcontainer/#go_equipsort")
	arg_1_0._btnequiplv = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiplv")
	arg_1_0._btnequiprare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_equipcontainer/#go_equipsort/#btn_equiprare")
	arg_1_0._simagenoequiptip = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_noequiptip")
	arg_1_0._goroletags = gohelper.findChild(arg_1_0.viewGO, "tags/#go_roletags")
	arg_1_0._goposlist = gohelper.findChild(arg_1_0.viewGO, "tags/#go_poslist")
	arg_1_0._gostorytag = gohelper.findChild(arg_1_0.viewGO, "tags/#go_roletags/#go_storytag")
	arg_1_0._goaidtag = gohelper.findChild(arg_1_0.viewGO, "tags/#go_roletags/#go_aidtag")
	arg_1_0._goskillpos = gohelper.findChild(arg_1_0.viewGO, "#go_skillpos")
	arg_1_0._goTouchArea = gohelper.findChild(arg_1_0.viewGO, "#go_touchArea")
	arg_1_0._simageblurmask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blurmask")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._simagemask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnequiplv:AddClickListener(arg_2_0._btnequiplvOnClick, arg_2_0)
	arg_2_0._btnequiprare:AddClickListener(arg_2_0._btnequiprareOnClick, arg_2_0)
	arg_2_0._slide:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._slide:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequiplv:RemoveClickListener()
	arg_3_0._btnequiprare:RemoveClickListener()
	arg_3_0._slide:RemoveDragBeginListener()
	arg_3_0._slide:RemoveDragEndListener()
end

var_0_0.DragAbsPositionX = 30

function var_0_0._btnshowskillOnClick(arg_4_0)
	return
end

function var_0_0._btnequiplvOnClick(arg_5_0)
	EquipTeamListModel.instance:sortByLevel()
	arg_5_0:_refreshEquipBtnIcon()
end

function var_0_0._btnequiprareOnClick(arg_6_0)
	EquipTeamListModel.instance:sortByQuality()
	arg_6_0:_refreshEquipBtnIcon()
end

function var_0_0._refreshEquipBtnIcon(arg_7_0)
	local var_7_0 = EquipTeamListModel.instance:getBtnTag()

	gohelper.setActive(arg_7_0._equipLvBtns[1], var_7_0 ~= 1)
	gohelper.setActive(arg_7_0._equipLvBtns[2], var_7_0 == 1)
	gohelper.setActive(arg_7_0._equipQualityBtns[1], var_7_0 ~= 2)
	gohelper.setActive(arg_7_0._equipQualityBtns[2], var_7_0 == 2)

	local var_7_1, var_7_2, var_7_3 = EquipTeamListModel.instance:getRankState()

	transformhelper.setLocalScale(arg_7_0._equipLvArrow[1], 1, var_7_1, 1)
	transformhelper.setLocalScale(arg_7_0._equipLvArrow[2], 1, var_7_1, 1)
	transformhelper.setLocalScale(arg_7_0._equipQualityArrow[1], 1, var_7_2, 1)
	transformhelper.setLocalScale(arg_7_0._equipQualityArrow[2], 1, var_7_2, 1)
end

function var_0_0._onHyperLinkClick(arg_8_0)
	local var_8_0 = recthelper.uiPosToScreenPos(arg_8_0._goskillpos.transform, ViewMgr.instance:getUICanvas())

	EquipController.instance:openEquipSkillTipView({
		arg_8_0._equipMO,
		nil,
		true,
		var_8_0
	})
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0.startDragPosX = arg_9_2.position.x
end

function var_0_0._onDragEnd(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.position.x

	if math.abs(var_10_0 - arg_10_0.startDragPosX) > var_0_0.DragAbsPositionX then
		if var_10_0 < arg_10_0.startDragPosX then
			arg_10_0:_onSlideNext()
		else
			arg_10_0:_onSlideLast()
		end
	end

	local var_10_1 = Mathf.Clamp(arg_10_0._currentSlideIndex - 1, 0, 3)

	var_10_1 = var_10_1 == 3 and 0 or var_10_1

	arg_10_0._simagebgmask:LoadImage(ResUrl.getEquipBg("bg_heromask_" .. var_10_1 .. ".png"))
	arg_10_0._simageblurmask:LoadImage(ResUrl.getUIMaskTexture("bg_zhezhao_" .. var_10_1))

	local var_10_2 = HeroGroupModel.instance:getCurGroupMO().heroList[arg_10_0._currentSlideIndex]

	arg_10_0.viewParam.heroMO = HeroModel.instance:getById(var_10_2)

	EquipTeamListModel.instance:openTeamEquip(arg_10_0._currentSlideIndex - 1, arg_10_0.viewParam.heroMO)
	arg_10_0:_changeEquip()
	arg_10_0:_setRoleTag()
end

function var_0_0._setRoleTag(arg_11_0)
	local var_11_0 = EquipTeamListModel.instance:getCurPosIndex()
	local var_11_1 = HeroSingleGroupModel.instance:getById(var_11_0 + 1)
	local var_11_2 = HeroGroupModel.instance.battleId
	local var_11_3 = var_11_2 and lua_battle.configDict[var_11_2]
	local var_11_4 = not HeroGroupModel.instance:isPositionOpen(var_11_1.id)
	local var_11_5 = var_11_1.aid and var_11_1.aid == -1
	local var_11_6 = HeroGroupModel.instance:getBattleRoleNum()
	local var_11_7 = var_11_6 and var_11_6 < var_11_1.id

	gohelper.setActive(arg_11_0._gostorytag, var_11_1.aid and var_11_1.aid ~= -1)

	if var_11_3 then
		gohelper.setActive(arg_11_0._goaidtag, not var_11_4 and not var_11_5 and not var_11_7 and var_11_1.id > var_11_3.playerMax)
	else
		gohelper.setActive(arg_11_0._goaidtag, not var_11_4 and not var_11_5 and not var_11_7 and var_11_1.id == ModuleEnum.MaxHeroCountInGroup)
	end

	if not arg_11_0._goaidtag.activeSelf and not arg_11_0._gostorytag.activeSelf then
		arg_11_0._isShowHeroTag = false

		return
	end

	gohelper.setActive(arg_11_0._goroletags, true)

	arg_11_0._isShowHeroTag = true

	local var_11_8, var_11_9 = recthelper.getAnchor(gohelper.findChild(arg_11_0._goposlist, "pos" .. var_11_0).transform)

	recthelper.setAnchor(arg_11_0._goroletags.transform, var_11_8, var_11_9)
end

function var_0_0._onSlideNext(arg_12_0)
	arg_12_0._currentSlideIndex = arg_12_0._currentSlideIndex + 1

	if arg_12_0._currentSlideIndex <= arg_12_0._maxSlideIndex then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEquipItem, arg_12_0._herogroupContainOffset_x[arg_12_0._currentSlideIndex])
	else
		arg_12_0._currentSlideIndex = arg_12_0._maxSlideIndex
	end
end

function var_0_0._onSlideLast(arg_13_0)
	arg_13_0._currentSlideIndex = arg_13_0._currentSlideIndex - 1

	if arg_13_0._currentSlideIndex > 0 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickEquipItem, arg_13_0._herogroupContainOffset_x[arg_13_0._currentSlideIndex])
	else
		arg_13_0._currentSlideIndex = 1
	end
end

function var_0_0._editableInitView(arg_14_0)
	arg_14_0._strengthenattrs = arg_14_0:getUserDataTb_()

	arg_14_0._simagenoequiptip:LoadImage(ResUrl.getEquipBg("bg_xinxiang_wuzhuangtai.png"))

	arg_14_0._equipLvBtns = arg_14_0:getUserDataTb_()
	arg_14_0._equipLvArrow = arg_14_0:getUserDataTb_()
	arg_14_0._equipQualityBtns = arg_14_0:getUserDataTb_()
	arg_14_0._equipQualityArrow = arg_14_0:getUserDataTb_()

	for iter_14_0 = 1, 2 do
		arg_14_0._equipLvBtns[iter_14_0] = gohelper.findChild(arg_14_0._btnequiplv.gameObject, "btn" .. tostring(iter_14_0))
		arg_14_0._equipLvArrow[iter_14_0] = gohelper.findChild(arg_14_0._equipLvBtns[iter_14_0], "arrow").transform
		arg_14_0._equipQualityBtns[iter_14_0] = gohelper.findChild(arg_14_0._btnequiprare.gameObject, "btn" .. tostring(iter_14_0))
		arg_14_0._equipQualityArrow[iter_14_0] = gohelper.findChild(arg_14_0._equipQualityBtns[iter_14_0], "arrow").transform
	end

	gohelper.addUIClickAudio(arg_14_0._btnequiplv.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_14_0._btnequiprare.gameObject, AudioEnum.UI.UI_Common_Click)

	arg_14_0._slide = SLFramework.UGUI.UIDragListener.Get(arg_14_0._goTouchArea)
	arg_14_0._herogroupContainOffset_x = arg_14_0:getUserDataTb_()
	arg_14_0._maxSlideIndex = 4

	arg_14_0._simagemask:LoadImage(ResUrl.getEquipBg("full/mask.png"))
end

function var_0_0.onUpdateParam(arg_15_0)
	return
end

function var_0_0.onOpen(arg_16_0)
	local var_16_0 = EquipTeamListModel.instance:getHero()
	local var_16_1 = EquipTeamListModel.instance:getCurPosIndex()

	arg_16_0._heroId = var_16_0 and var_16_0.heroId
	var_16_1 = var_16_1 == 3 and 0 or var_16_1

	arg_16_0._simagebgmask:LoadImage(ResUrl.getEquipBg("bg_heromask_" .. var_16_1 .. ".png"))
	arg_16_0._simageblurmask:LoadImage(ResUrl.getUIMaskTexture("bg_zhezhao_" .. var_16_1))
	arg_16_0:showEquipList()
	arg_16_0:_refreshEquipBtnIcon()
	arg_16_0:_setRoleTag()
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ChangeEquip, arg_16_0._changeEquip, arg_16_0)
	arg_16_0:addEventCb(EquipController.instance, EquipEvent.onUpdateEquip, arg_16_0._onEquipChange, arg_16_0)
	arg_16_0:addEventCb(EquipController.instance, EquipEvent.onDeleteEquip, arg_16_0._onEquipChange, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_16_0._hideNoEquipTip, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnCompareEquip, arg_16_0._setMaskVisible, arg_16_0)

	arg_16_0._currentSlideIndex = arg_16_0.viewParam.posIndex + 1

	arg_16_0:_initHeorGroupItemPos()
end

function var_0_0.onOpenFinish(arg_17_0)
	arg_17_0._viewAnim.enabled = true

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.setHeroGroupEquipEffect, true)
end

function var_0_0._onEquipChange(arg_18_0)
	TaskDispatcher.cancelTask(arg_18_0._changeEquip, arg_18_0)
	TaskDispatcher.runDelay(arg_18_0._changeEquip, arg_18_0, 0.1)
end

function var_0_0._changeEquip(arg_19_0)
	arg_19_0:showEquipList()
end

function var_0_0._initHeorGroupItemPos(arg_20_0)
	local var_20_0 = HeroGroupModel.instance:getHeroGroupItemPos()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		local var_20_1 = recthelper.getAnchorX(iter_20_1) + recthelper.getAnchorX(iter_20_1.parent)

		table.insert(arg_20_0._herogroupContainOffset_x, var_20_1)
	end
end

function var_0_0._showNoEquipTip(arg_21_0, arg_21_1)
	if arg_21_1 == ViewName.EquipTeamShowView then
		gohelper.setActive(arg_21_0._simagenoequiptip.gameObject, false)
	end
end

function var_0_0._hideNoEquipTip(arg_22_0, arg_22_1)
	if arg_22_1 == ViewName.EquipTeamShowView then
		gohelper.setActive(arg_22_0._simagenoequiptip.gameObject, arg_22_0._isNullEquipShow)
	end
end

function var_0_0.showEquipList(arg_23_0)
	EquipTeamListModel.instance:setEquipList(true)
	EquipTeamAttrListModel.instance:SetAttrList()

	arg_23_0._isNullEquipShow = true

	if EquipTeamAttrListModel.instance:getCount() > 0 then
		local var_23_0 = EquipTeamListModel.instance:getTeamEquip()

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			arg_23_0._equipMO = EquipModel.instance:getEquip(iter_23_1)
			arg_23_0._config = arg_23_0._equipMO.config

			local var_23_1 = ViewMgr.instance:getOpenViewNameList()

			if var_23_1[#var_23_1] == ViewName.EquipTeamShowView or not ViewMgr.instance:isOpen(ViewName.EquipTeamShowView) then
				EquipController.instance:openEquipTeamShowView({
					arg_23_0._equipMO.uid,
					true
				})
			end

			arg_23_0._isNullEquipShow = false

			break
		end
	end

	local var_23_2 = EquipTeamListModel.instance:getEquipList()
	local var_23_3 = var_23_2 and #var_23_2 or 0

	if arg_23_0._isNullEquipShow and var_23_3 > 0 then
		for iter_23_2, iter_23_3 in ipairs(var_23_2) do
			arg_23_0._equipMO = iter_23_3
			arg_23_0._config = arg_23_0._equipMO.config

			local var_23_4 = ViewMgr.instance:getOpenViewNameList()

			if var_23_4[#var_23_4] == ViewName.EquipTeamShowView or not ViewMgr.instance:isOpen(ViewName.EquipTeamShowView) then
				EquipController.instance:openEquipTeamShowView({
					arg_23_0._equipMO.uid,
					false
				})
			end

			arg_23_0._isNullEquipShow = false

			break
		end
	end

	gohelper.setActive(arg_23_0._simagenoequiptip.gameObject, arg_23_0._isNullEquipShow)
end

function var_0_0._setMaskVisible(arg_24_0, arg_24_1)
	gohelper.setActive(arg_24_0._simagemask.gameObject, arg_24_1)
	gohelper.setActive(arg_24_0._simageblurmask.gameObject, not arg_24_1)
	gohelper.setActive(arg_24_0._goroletags, arg_24_0._isShowHeroTag and not arg_24_1)
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._changeEquip, arg_25_0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.setHeroGroupEquipEffect, false)
	gohelper.setActive(arg_25_0._goroletags, false)
	EquipTeamListModel.instance:clearEquipList()
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0._simagebgmask:UnLoadImage()
	arg_26_0._simageblurmask:UnLoadImage()
	arg_26_0._simagenoequiptip:UnLoadImage()
	arg_26_0._simagemask:UnLoadImage()
end

return var_0_0
