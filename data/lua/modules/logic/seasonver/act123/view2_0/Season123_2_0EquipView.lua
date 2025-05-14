module("modules.logic.seasonver.act123.view2_0.Season123_2_0EquipView", package.seeall)

local var_0_0 = class("Season123_2_0EquipView", BaseView)

function var_0_0._rebuildLayout_overseas(arg_1_0, arg_1_1)
	FrameTimerController.onDestroyViewMember(arg_1_0, "_txtDescFrameTimer")

	arg_1_0._txtDescFrameTimer = FrameTimerController.instance:register(function()
		for iter_2_0, iter_2_1 in pairs(arg_1_1) do
			local var_2_0 = iter_2_1.txtDesc
			local var_2_1 = var_2_0.transform
			local var_2_2 = var_2_0:GetPreferredValues()

			recthelper.setHeight(var_2_1, var_2_2.y)
		end
	end, nil, 1, 1)

	arg_1_0._txtDescFrameTimer:Start()
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0._simagebg1 = gohelper.findChildSingleImage(arg_3_0.viewGO, "bg/#simage_bg1")
	arg_3_0._simagehero = gohelper.findChildSingleImage(arg_3_0.viewGO, "left/hero/mask/#simage_hero")
	arg_3_0._golackcards = gohelper.findChild(arg_3_0.viewGO, "right/#go_lackcards")
	arg_3_0._btnequip = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "right/btncontain/#btn_equip")
	arg_3_0._btnopenhandbook = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "right/btncontain/#btn_openhandbook")
	arg_3_0._goempty = gohelper.findChild(arg_3_0.viewGO, "left/equipDesc/#go_empty")
	arg_3_0._gotipPos = gohelper.findChild(arg_3_0.viewGO, "#go_tippos")

	if arg_3_0._editableInitView then
		arg_3_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnequip:AddClickListener(arg_4_0._btnequipOnClick, arg_4_0)
	arg_4_0._btnopenhandbook:AddClickListener(arg_4_0._btnhandbookOnClick, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnequip:RemoveClickListener()
	arg_5_0._btnopenhandbook:RemoveClickListener()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	arg_6_0._animator = arg_6_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_6_0._animEventWrap = arg_6_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_6_0._animEventWrap:AddEventListener("switch", arg_6_0.handleSwitchAnimFrame, arg_6_0)

	arg_6_0._slotItems = {}
	arg_6_0._descItems = {}
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0._simagebg1:UnLoadImage()
	arg_7_0._simagehero:UnLoadImage()
	arg_7_0._animEventWrap:RemoveAllEventListener()

	for iter_7_0, iter_7_1 in pairs(arg_7_0._slotItems) do
		iter_7_1.btnClick:RemoveClickListener()
		gohelper.setActive(iter_7_1.goPos, true)

		if iter_7_1.icon then
			iter_7_1.icon:disposeUI()
			gohelper.destroy(iter_7_1.icon.viewGO)
		end

		if iter_7_1.animEventWrap then
			iter_7_1.animEventWrap:RemoveAllEventListener()
		end
	end

	Season123EquipController.instance:onCloseView()
end

function var_0_0.onOpen(arg_8_0)
	local var_8_0 = arg_8_0.viewParam.pos or 1
	local var_8_1 = arg_8_0.viewParam.actId
	local var_8_2 = arg_8_0.viewParam.slot or 1
	local var_8_3 = arg_8_0.viewParam.group or 1
	local var_8_4 = arg_8_0.viewParam.layer
	local var_8_5 = arg_8_0.viewParam.stage

	arg_8_0:addEventCb(Season123EquipController.instance, Season123EquipEvent.EquipUpdate, arg_8_0.handleEquipUpdate, arg_8_0)
	arg_8_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_8_0.handleSaveSucc, arg_8_0)
	arg_8_0:addEventCb(Season123EquipController.instance, Season123EquipEvent.EquipChangeCard, arg_8_0.handleEquipCardChanged, arg_8_0)
	arg_8_0:addEventCb(Season123EquipController.instance, Season123EquipEvent.EquipChangeSlot, arg_8_0.handleEquipSlotChanged, arg_8_0)
	Season123EquipController.instance:onOpenView(var_8_1, var_8_3, var_8_5, var_8_4, var_8_0, var_8_2)
	arg_8_0:refreshUI()
end

function var_0_0.onClose(arg_9_0)
	FrameTimerController.onDestroyViewMember(arg_9_0, "_txtDescFrameTimer")
end

function var_0_0.refreshUI(arg_10_0)
	local var_10_0 = Season123EquipItemListModel.instance:getList()
	local var_10_1 = not var_10_0 or #var_10_0 == 0

	gohelper.setActive(arg_10_0._golackcards, var_10_1)
	arg_10_0:refreshSlots()
	arg_10_0:refreshDescGroup()
end

function var_0_0.handleEquipUpdate(arg_11_0)
	arg_11_0:refreshSlots()
	arg_11_0:refreshDescGroup()
end

function var_0_0.refreshSlots(arg_12_0)
	local var_12_0 = true

	for iter_12_0 = 1, Season123EquipItemListModel.MaxPos do
		if Season123EquipItemListModel.instance.curEquipMap[iter_12_0] ~= Season123EquipItemListModel.EmptyUid then
			var_12_0 = false
		end

		arg_12_0:refreshSlot(iter_12_0)
	end

	gohelper.setActive(arg_12_0._goempty, var_12_0)
end

function var_0_0.refreshSlot(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getOrCreateSlot(arg_13_1)

	if arg_13_1 > Season123EquipItemListModel.instance:getShowUnlockSlotCount() then
		gohelper.setActive(var_13_0.go, false)

		return
	end

	gohelper.setActive(var_13_0.go, true)

	local var_13_1 = Season123EquipItemListModel.instance.curEquipMap[arg_13_1]

	gohelper.setActive(var_13_0.goSelect, Season123EquipItemListModel.instance.curSelectSlot == arg_13_1)

	local var_13_2 = not Season123EquipItemListModel.instance:isEquipCardPosUnlock(arg_13_1, Season123EquipItemListModel.instance.curPos)

	gohelper.setActive(var_13_0.goBtnAdd, not var_13_2)
	gohelper.setActive(var_13_0.goLock, var_13_2)

	if var_13_1 == Season123EquipItemListModel.EmptyUid then
		gohelper.setActive(var_13_0.goPos, false)
		gohelper.setActive(var_13_0.goEmpty, true)

		if Season123EquipItemListModel.instance:curMapIsTrialEquipMap() then
			gohelper.setActive(var_13_0.go, false)
		end
	else
		gohelper.setActive(var_13_0.goPos, true)
		gohelper.setActive(var_13_0.goEmpty, false)

		local var_13_3 = arg_13_0:getOrCreateSlotIcon(var_13_0)
		local var_13_4 = Season123EquipItemListModel.instance:getEquipMO(var_13_1)

		if var_13_4 then
			var_13_3:updateData(var_13_4.itemId)
		elseif Season123EquipItemListModel.isTrialEquip(var_13_1) then
			local var_13_5 = string.splitToNumber(var_13_1, "#")

			var_13_3:updateData(var_13_5[1])
		end

		var_13_3:setIndexLimitShowState(true)
	end
end

var_0_0.MaxUISlot = 2

function var_0_0.refreshDescGroup(arg_14_0)
	for iter_14_0 = 1, var_0_0.MaxUISlot do
		local var_14_0 = Season123EquipItemListModel.instance.curEquipMap[iter_14_0]
		local var_14_1 = arg_14_0:getOrCreateDesc(iter_14_0)

		if not string.nilorempty(var_14_0) then
			arg_14_0:refreshDesc(var_14_1, var_14_0, iter_14_0)
		end
	end
end

function var_0_0.refreshDesc(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if gohelper.isNil(arg_15_1.go) then
		return
	end

	if arg_15_2 == Season123EquipItemListModel.EmptyUid then
		gohelper.setActive(arg_15_1.go, false)
	else
		gohelper.setActive(arg_15_1.go, true)

		local var_15_0 = Season123EquipItemListModel.instance:getEquipMO(arg_15_2)
		local var_15_1 = var_15_0 and var_15_0.itemId

		if not var_15_1 and Season123EquipItemListModel.isTrialEquip(arg_15_2) then
			var_15_1 = string.splitToNumber(arg_15_2, "#")[1]
		end

		if var_15_1 then
			local var_15_2 = Season123Config.instance:getSeasonEquipCo(var_15_1)

			if var_15_2 then
				arg_15_1.txtName.text = string.format("[%s]", var_15_2.name)

				local var_15_3
				local var_15_4 = Season123EquipMetaUtils.getCareerColorDarkBg(var_15_1)

				if Season123EquipItemListModel.instance.curSelectSlot ~= arg_15_3 then
					var_15_4 = var_15_4 .. Season123EquipMetaUtils.No_Effect_Alpha
					var_15_3 = "#cac8c5" .. Season123EquipMetaUtils.No_Effect_Alpha
				else
					var_15_3 = "#ec7731"
				end

				SLFramework.UGUI.GuiHelper.SetColor(arg_15_1.txtName, var_15_3)
				arg_15_0:refreshProps(var_15_2, arg_15_1, var_15_4)
				arg_15_0:refreshSkills(var_15_2, arg_15_1, var_15_4)
			else
				logError(string.format("can't find season equip config, id = [%s]", var_15_1))
			end
		else
			logError(string.format("can't find season equip MO, itemUid = [%s]", arg_15_2))
		end
	end
end

function var_0_0.refreshProps(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = {}
	local var_16_1 = false

	if arg_16_1 and arg_16_1.attrId ~= 0 then
		local var_16_2 = Season123EquipMetaUtils.getEquipPropsStrList(arg_16_1.attrId)

		for iter_16_0, iter_16_1 in ipairs(var_16_2) do
			local var_16_3 = arg_16_0:getOrCreatePropText(iter_16_0, arg_16_2)

			gohelper.setActive(var_16_3.go, true)

			var_16_3.txtDesc.text = iter_16_1

			SLFramework.UGUI.GuiHelper.SetColor(var_16_3.txtDesc, arg_16_3)

			var_16_0[var_16_3] = true
			var_16_1 = true
		end
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_2.propItems) do
		if not var_16_0[iter_16_3] then
			gohelper.setActive(iter_16_3.go, false)
		end
	end

	gohelper.setActive(arg_16_2.goAttrParent, var_16_1)
end

function var_0_0.refreshSkills(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = Season123EquipMetaUtils.getSkillEffectStrList(arg_17_1)
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_2 = arg_17_0:getOrCreateSkillText(iter_17_0, arg_17_2)

		gohelper.setActive(var_17_2.go, true)

		iter_17_1 = HeroSkillModel.instance:skillDesToSpot(iter_17_1)
		var_17_2.txtDesc.text = SkillHelper.addLink(iter_17_1)
		var_17_1[var_17_2] = true

		SkillHelper.addHyperLinkClick(var_17_2.txtDesc, arg_17_0.setSkillClickCallBack, arg_17_0)
	end

	for iter_17_2, iter_17_3 in pairs(arg_17_2.skillItems) do
		if not var_17_1[iter_17_3] then
			gohelper.setActive(iter_17_3.go, false)
		end
	end

	arg_17_0:_rebuildLayout_overseas(arg_17_2.skillItems)
end

function var_0_0.setSkillClickCallBack(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0, var_18_1 = recthelper.getAnchor(arg_18_0._gotipPos.transform)
	local var_18_2 = Vector2.New(var_18_0, var_18_1)

	CommonBuffTipController:openCommonTipViewWithCustomPos(arg_18_1, var_18_2, CommonBuffTipEnum.Pivot.Left)
end

function var_0_0.getOrCreatePropText(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_2.propItems[arg_19_1]

	if not var_19_0 then
		var_19_0 = arg_19_0:getUserDataTb_()
		var_19_0.go = gohelper.cloneInPlace(arg_19_2.goAttrDesc, "propname_" .. tostring(arg_19_1))
		var_19_0.txtDesc = gohelper.findChildText(var_19_0.go, "txt_attributedesc")
		arg_19_2.propItems[arg_19_1] = var_19_0
	end

	return var_19_0
end

function var_0_0.getOrCreateSkillText(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_2.skillItems[arg_20_1]

	if not var_20_0 then
		var_20_0 = arg_20_0:getUserDataTb_()
		var_20_0.go = gohelper.cloneInPlace(arg_20_2.goSkillDesc, "skill_" .. tostring(arg_20_1))
		var_20_0.txtDesc = gohelper.findChildText(var_20_0.go, "txt_skilldesc")

		SkillHelper.addHyperLinkClick(var_20_0.txtDesc)

		arg_20_2.skillItems[arg_20_1] = var_20_0
	end

	return var_20_0
end

function var_0_0.getOrCreateSlot(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._slotItems[arg_21_1]

	if not var_21_0 then
		var_21_0 = arg_21_0:getUserDataTb_()
		var_21_0.index = arg_21_1
		var_21_0.mainView = arg_21_0
		var_21_0.go = gohelper.findChild(arg_21_0.viewGO, "left/equipSlot/slot" .. tostring(arg_21_1))
		var_21_0.goPos = gohelper.findChild(var_21_0.go, "go_equip/go_pos")
		var_21_0.goSelect = gohelper.findChild(var_21_0.go, "go_equip/go_select")
		var_21_0.goBtnAdd = gohelper.findChild(var_21_0.go, "go_empty/btn_add")
		var_21_0.goEmpty = gohelper.findChild(var_21_0.go, "go_empty")
		var_21_0.goLock = gohelper.findChild(var_21_0.go, "go_lock")
		var_21_0.btnClick = gohelper.findChildButtonWithAudio(var_21_0.go, "btn_click")

		var_21_0.btnClick:AddClickListener(arg_21_0.onClickSlot, arg_21_0, arg_21_1)

		var_21_0.animator = var_21_0.go:GetComponent(typeof(UnityEngine.Animator))
		var_21_0.animEventWrap = var_21_0.go:GetComponent(typeof(ZProj.AnimationEventWrap))

		var_21_0.animEventWrap:AddEventListener("switch", arg_21_0.handleSlotSwitchAnimFrame, var_21_0)

		arg_21_0._slotItems[arg_21_1] = var_21_0
	end

	return var_21_0
end

function var_0_0.getOrCreateSlotIcon(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1.icon

	if not var_22_0 then
		local var_22_1 = arg_22_0.viewContainer:getSetting().otherRes[2]
		local var_22_2 = arg_22_0:getResInst(var_22_1, arg_22_1.goPos, "icon")

		var_22_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_2, Season123_2_0CelebrityCardEquip)
		arg_22_1.icon = var_22_0
	end

	return var_22_0
end

function var_0_0.getOrCreateDesc(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._descItems[arg_23_1]

	if not var_23_0 then
		var_23_0 = arg_23_0:getUserDataTb_()
		var_23_0.go = gohelper.findChild(arg_23_0.viewGO, "left/equipDesc/#go_equipDesc/#go_effect" .. tostring(arg_23_1))
		var_23_0.txtName = gohelper.findChildText(var_23_0.go, "txt_name")
		var_23_0.goAttrDesc = gohelper.findChild(var_23_0.go, "desc/scroll_desc/Viewport/Content/attrlist/#go_attributeitem" .. tostring(arg_23_1))
		var_23_0.goSkillDesc = gohelper.findChild(var_23_0.go, "desc/scroll_desc/Viewport/Content/skilldesc/#go_skilldescitem" .. tostring(arg_23_1))
		var_23_0.goAttrParent = gohelper.findChild(var_23_0.go, "desc/scroll_desc/Viewport/Content/attrlist")
		var_23_0.propItems = {}
		var_23_0.skillItems = {}
		arg_23_0._descItems[arg_23_1] = var_23_0
	end

	return var_23_0
end

function var_0_0.onClickSlot(arg_24_0, arg_24_1)
	if Season123EquipItemListModel.instance.curSelectSlot ~= arg_24_1 then
		if not Season123EquipItemListModel.instance:slotIsLock(arg_24_1) then
			Season123EquipController.instance:setSlot(arg_24_1)
		else
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)
		end
	end
end

function var_0_0.handleSaveSucc(arg_25_0)
	if arg_25_0._isManualSave then
		GameFacade.showToast(Season123EquipController.Toast_Save_Succ)
		arg_25_0:closeThis()
	end
end

function var_0_0.handleSwitchAnimFrame(arg_26_0)
	arg_26_0:refreshSlots()
	arg_26_0:refreshDescGroup()
end

function var_0_0.handleSlotSwitchAnimFrame(arg_27_0)
	arg_27_0.mainView:refreshDescGroup()
end

function var_0_0.handleEquipCardChanged(arg_28_0, arg_28_1)
	local var_28_0 = Season123EquipItemListModel.instance.curSelectSlot
	local var_28_1 = arg_28_0:getOrCreateSlot(var_28_0)
	local var_28_2 = arg_28_1.isNew and "open" or "switch"

	var_28_1.animator:Play(var_28_2, 0, 0)

	if arg_28_1.unloadSlot then
		arg_28_0:getOrCreateSlot(arg_28_1.unloadSlot).animator:Play("close", 0, 0)
	end

	arg_28_0._animator:Play("switch", 0, 0)
end

function var_0_0.handleEquipSlotChanged(arg_29_0)
	arg_29_0._animator:Play("switch", 0, 0)
	arg_29_0:refreshSlots()
end

function var_0_0._btnequipOnClick(arg_30_0)
	arg_30_0._isManualSave = Season123EquipController.instance:checkCanSaveSlot()

	if arg_30_0._isManualSave then
		Season123EquipController.instance:saveShowSlot()
	end
end

function var_0_0._btnhandbookOnClick(arg_31_0)
	Season123Controller.instance:openSeasonEquipBookView(arg_31_0.viewParam.actId)
end

return var_0_0
