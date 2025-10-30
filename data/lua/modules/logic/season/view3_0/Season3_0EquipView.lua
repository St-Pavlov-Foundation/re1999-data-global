module("modules.logic.season.view3_0.Season3_0EquipView", package.seeall)

local var_0_0 = class("Season3_0EquipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagehero = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/hero/mask/#simage_hero")
	arg_1_0._golackcards = gohelper.findChild(arg_1_0.viewGO, "right/#go_lackcards")
	arg_1_0._btnequip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/btncontain/#btn_equip")
	arg_1_0._btnopenhandbook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/btncontain/#btn_openhandbook")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "left/equipDesc/#go_empty")
	arg_1_0._gotipPos = gohelper.findChild(arg_1_0.viewGO, "#go_tippos")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnequip:AddClickListener(arg_2_0._btnequipOnClick, arg_2_0)
	arg_2_0._btnopenhandbook:AddClickListener(arg_2_0._btnhandbookOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, arg_2_0.handleEquipUpdate, arg_2_0)
	arg_2_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_2_0.handleSaveSucc, arg_2_0)
	arg_2_0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipChangeCard, arg_2_0.handleEquipCardChanged, arg_2_0)
	arg_2_0:addEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipChangeSlot, arg_2_0.handleEquipSlotChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnequip:RemoveClickListener()
	arg_3_0._btnopenhandbook:RemoveClickListener()
	arg_3_0:removeEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipUpdate, arg_3_0.handleEquipUpdate, arg_3_0)
	arg_3_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_3_0.handleSaveSucc, arg_3_0)
	arg_3_0:removeEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipChangeCard, arg_3_0.handleEquipCardChanged, arg_3_0)
	arg_3_0:removeEventCb(Activity104EquipController.instance, Activity104EquipEvent.EquipChangeSlot, arg_3_0.handleEquipSlotChanged, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._simagebg1:LoadImage(ResUrl.getSeasonIcon("full/hechengye_bj.jpg"))

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._animEventWrap = arg_4_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_4_0._animEventWrap:AddEventListener("switch", arg_4_0.handleSwitchAnimFrame, arg_4_0)

	arg_4_0._slotItems = {}
	arg_4_0._descItems = {}
end

function var_0_0.onDestroyView(arg_5_0)
	arg_5_0._simagebg1:UnLoadImage()
	arg_5_0._simagehero:UnLoadImage()
	arg_5_0._animEventWrap:RemoveAllEventListener()

	for iter_5_0, iter_5_1 in pairs(arg_5_0._slotItems) do
		iter_5_1.btnClick:RemoveClickListener()
		gohelper.setActive(iter_5_1.goPos, true)

		if iter_5_1.icon then
			iter_5_1.icon:disposeUI()
			gohelper.destroy(iter_5_1.icon.viewGO)
		end

		if iter_5_1.animEventWrap then
			iter_5_1.animEventWrap:RemoveAllEventListener()
		end
	end

	Activity104EquipController.instance:onCloseView()
end

function var_0_0.onOpen(arg_6_0)
	local var_6_0 = arg_6_0.viewParam.pos or 1
	local var_6_1 = arg_6_0.viewParam.actId
	local var_6_2 = arg_6_0.viewParam.slot or 1
	local var_6_3 = arg_6_0.viewParam.group or 1

	Activity104EquipController.instance:onOpenView(var_6_1, var_6_3, var_6_0, var_6_2)
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.refreshUI(arg_8_0)
	local var_8_0 = Activity104EquipItemListModel.instance:getList()
	local var_8_1 = not var_8_0 or #var_8_0 == 0

	gohelper.setActive(arg_8_0._golackcards, var_8_1)
	arg_8_0:refreshSlots()
	arg_8_0:refreshDescGroup()
end

function var_0_0.handleEquipUpdate(arg_9_0)
	arg_9_0:refreshSlots()
	arg_9_0:refreshDescGroup()
end

function var_0_0.refreshSlots(arg_10_0)
	local var_10_0 = true

	for iter_10_0 = 1, Activity104EquipItemListModel.MaxPos do
		if Activity104EquipItemListModel.instance.curEquipMap[iter_10_0] ~= Activity104EquipItemListModel.EmptyUid then
			var_10_0 = false
		end

		arg_10_0:refreshSlot(iter_10_0)
	end

	gohelper.setActive(arg_10_0._goempty, var_10_0)
end

function var_0_0.refreshSlot(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getOrCreateSlot(arg_11_1)

	if arg_11_1 > Activity104EquipItemListModel.instance:getShowUnlockSlotCount() then
		gohelper.setActive(var_11_0.go, false)

		return
	end

	gohelper.setActive(var_11_0.go, true)

	local var_11_1 = Activity104EquipItemListModel.instance.curEquipMap[arg_11_1]

	gohelper.setActive(var_11_0.goSelect, Activity104EquipItemListModel.instance.curSelectSlot == arg_11_1)

	local var_11_2 = Activity104EquipItemListModel.instance:slotIsLock(arg_11_1)

	gohelper.setActive(var_11_0.goBtnAdd, not var_11_2)
	gohelper.setActive(var_11_0.goLock, var_11_2)

	if var_11_1 == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(var_11_0.goPos, false)
		gohelper.setActive(var_11_0.goEmpty, true)

		if Activity104EquipItemListModel.instance:curMapIsTrialEquipMap() then
			gohelper.setActive(var_11_0.go, false)
		end
	else
		gohelper.setActive(var_11_0.goPos, true)
		gohelper.setActive(var_11_0.goEmpty, false)

		local var_11_3 = arg_11_0:getOrCreateSlotIcon(var_11_0)
		local var_11_4 = Activity104EquipItemListModel.instance:getEquipMO(var_11_1)

		if var_11_4 then
			var_11_3:updateData(var_11_4.itemId)
		elseif Activity104EquipItemListModel.isTrialEquip(var_11_1) then
			local var_11_5 = string.splitToNumber(var_11_1, "#")

			var_11_3:updateData(var_11_5[1])
		end
	end
end

var_0_0.MaxUISlot = 2

function var_0_0.refreshDescGroup(arg_12_0)
	for iter_12_0 = 1, var_0_0.MaxUISlot do
		local var_12_0 = Activity104EquipItemListModel.instance.curEquipMap[iter_12_0]
		local var_12_1 = arg_12_0:getOrCreateDesc(iter_12_0)

		if not string.nilorempty(var_12_0) then
			arg_12_0:refreshDesc(var_12_1, var_12_0, iter_12_0)
		end
	end
end

function var_0_0.refreshDesc(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if gohelper.isNil(arg_13_1.go) then
		return
	end

	if arg_13_2 == Activity104EquipItemListModel.EmptyUid then
		gohelper.setActive(arg_13_1.go, false)
	else
		gohelper.setActive(arg_13_1.go, true)

		local var_13_0 = Activity104EquipItemListModel.instance:getEquipMO(arg_13_2)
		local var_13_1 = var_13_0 and var_13_0.itemId

		if not var_13_1 and Activity104EquipItemListModel.isTrialEquip(arg_13_2) then
			var_13_1 = string.splitToNumber(arg_13_2, "#")[1]
		end

		if var_13_1 then
			local var_13_2 = SeasonConfig.instance:getSeasonEquipCo(var_13_1)

			if var_13_2 then
				arg_13_1.txtName.text = string.format("[%s]", var_13_2.name)

				local var_13_3
				local var_13_4 = SeasonEquipMetaUtils.getCareerColorDarkBg(var_13_1)

				if Activity104EquipItemListModel.instance.curSelectSlot ~= arg_13_3 then
					var_13_4 = var_13_4 .. SeasonEquipMetaUtils.No_Effect_Alpha
					var_13_3 = "#cac8c5" .. SeasonEquipMetaUtils.No_Effect_Alpha
				else
					var_13_3 = "#ec7731"
				end

				SLFramework.UGUI.GuiHelper.SetColor(arg_13_1.txtName, var_13_3)
				arg_13_0:refreshProps(var_13_2, arg_13_1, var_13_4)
				arg_13_0:refreshSkills(var_13_2, arg_13_1, var_13_4)
			else
				logError(string.format("can't find season equip config, id = [%s]", var_13_1))
			end
		else
			logError(string.format("can't find season equip MO, itemUid = [%s]", arg_13_2))
		end
	end
end

function var_0_0.refreshProps(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = {}
	local var_14_1 = false

	if arg_14_1 and arg_14_1.attrId ~= 0 then
		local var_14_2 = SeasonEquipMetaUtils.getEquipPropsStrList(arg_14_1.attrId)

		for iter_14_0, iter_14_1 in ipairs(var_14_2) do
			local var_14_3 = arg_14_0:getOrCreatePropText(iter_14_0, arg_14_2)

			gohelper.setActive(var_14_3.go, true)

			var_14_3.txtDesc.text = iter_14_1

			SLFramework.UGUI.GuiHelper.SetColor(var_14_3.txtDesc, arg_14_3)

			var_14_0[var_14_3] = true
			var_14_1 = true
		end
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_2.propItems) do
		if not var_14_0[iter_14_3] then
			gohelper.setActive(iter_14_3.go, false)
		end
	end

	gohelper.setActive(arg_14_2.goAttrParent, var_14_1)
end

function var_0_0.refreshSkills(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = SeasonEquipMetaUtils.getSkillEffectStrList(arg_15_1)

	for iter_15_0 = 1, math.max(#arg_15_2.skillItems, #var_15_0) do
		local var_15_1 = arg_15_0:getOrCreateSkillText(iter_15_0, arg_15_2)

		arg_15_0:updateSkillText(var_15_1, var_15_0[iter_15_0], arg_15_3)
	end
end

function var_0_0.getOrCreatePropText(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2.propItems[arg_16_1]

	if not var_16_0 then
		var_16_0 = arg_16_0:getUserDataTb_()
		var_16_0.go = gohelper.cloneInPlace(arg_16_2.goAttrDesc, "propname_" .. tostring(arg_16_1))
		var_16_0.txtDesc = gohelper.findChildText(var_16_0.go, "txt_attributedesc")
		arg_16_2.propItems[arg_16_1] = var_16_0
	end

	return var_16_0
end

function var_0_0.getOrCreateSkillText(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_2.skillItems[arg_17_1]

	if not var_17_0 then
		var_17_0 = arg_17_0:getUserDataTb_()
		var_17_0.go = gohelper.cloneInPlace(arg_17_2.goSkillDesc, "skill_" .. tostring(arg_17_1))
		var_17_0.txtDesc = gohelper.findChildText(var_17_0.go, "txt_skilldesc")
		var_17_0.fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(var_17_0.txtDesc.gameObject, FixTmpBreakLine)
		arg_17_2.skillItems[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0.updateSkillText(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if not arg_18_2 then
		gohelper.setActive(arg_18_1.go, false)

		return
	end

	gohelper.setActive(arg_18_1.go, true)

	arg_18_2 = HeroSkillModel.instance:skillDesToSpot(arg_18_2)
	arg_18_1.txtDesc.text = SkillHelper.addLink(arg_18_2)

	arg_18_1.fixTmpBreakLine:refreshTmpContent(arg_18_1.txtDesc)
	SLFramework.UGUI.GuiHelper.SetColor(arg_18_1.txtDesc, arg_18_3)
	SkillHelper.addHyperLinkClick(arg_18_1.txtDesc, arg_18_0.setSkillClickCallBack, arg_18_0)
end

function var_0_0.setSkillClickCallBack(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0, var_19_1 = recthelper.getAnchor(arg_19_0._gotipPos.transform)
	local var_19_2 = Vector2.New(var_19_0, var_19_1)

	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(arg_19_1, var_19_2, CommonBuffTipEnum.Pivot.Left)
end

function var_0_0.getOrCreateSlot(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_0._slotItems[arg_20_1]

	if not var_20_0 then
		var_20_0 = arg_20_0:getUserDataTb_()
		var_20_0.index = arg_20_1
		var_20_0.mainView = arg_20_0
		var_20_0.go = gohelper.findChild(arg_20_0.viewGO, "left/equipSlot/slot" .. tostring(arg_20_1))
		var_20_0.goPos = gohelper.findChild(var_20_0.go, "go_equip/go_pos")
		var_20_0.goSelect = gohelper.findChild(var_20_0.go, "go_equip/go_select")
		var_20_0.goBtnAdd = gohelper.findChild(var_20_0.go, "go_empty/btn_add")
		var_20_0.goEmpty = gohelper.findChild(var_20_0.go, "go_empty")
		var_20_0.goLock = gohelper.findChild(var_20_0.go, "go_lock")
		var_20_0.btnClick = gohelper.findChildButtonWithAudio(var_20_0.go, "btn_click")

		var_20_0.btnClick:AddClickListener(arg_20_0.onClickSlot, arg_20_0, arg_20_1)

		var_20_0.animator = var_20_0.go:GetComponent(typeof(UnityEngine.Animator))
		var_20_0.animEventWrap = var_20_0.go:GetComponent(typeof(ZProj.AnimationEventWrap))

		var_20_0.animEventWrap:AddEventListener("switch", arg_20_0.handleSlotSwitchAnimFrame, var_20_0)

		arg_20_0._slotItems[arg_20_1] = var_20_0
	end

	return var_20_0
end

function var_0_0.getOrCreateSlotIcon(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.icon

	if not var_21_0 then
		local var_21_1 = arg_21_0.viewContainer:getSetting().otherRes[2]
		local var_21_2 = arg_21_0:getResInst(var_21_1, arg_21_1.goPos, "icon")

		var_21_0 = MonoHelper.addNoUpdateLuaComOnceToGo(var_21_2, Season3_0CelebrityCardEquip)
		arg_21_1.icon = var_21_0
	end

	return var_21_0
end

function var_0_0.getOrCreateDesc(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._descItems[arg_22_1]

	if not var_22_0 then
		var_22_0 = arg_22_0:getUserDataTb_()
		var_22_0.go = gohelper.findChild(arg_22_0.viewGO, "left/equipDesc/#go_equipDesc/#go_effect" .. tostring(arg_22_1))
		var_22_0.txtName = gohelper.findChildText(var_22_0.go, "txt_name")
		var_22_0.goAttrDesc = gohelper.findChild(var_22_0.go, "desc/scroll_desc/Viewport/Content/attrlist/#go_attributeitem" .. tostring(arg_22_1))
		var_22_0.goSkillDesc = gohelper.findChild(var_22_0.go, "desc/scroll_desc/Viewport/Content/skilldesc/#go_skilldescitem" .. tostring(arg_22_1))
		var_22_0.goAttrParent = gohelper.findChild(var_22_0.go, "desc/scroll_desc/Viewport/Content/attrlist")
		var_22_0.propItems = {}
		var_22_0.skillItems = {}
		arg_22_0._descItems[arg_22_1] = var_22_0
	end

	return var_22_0
end

function var_0_0.onClickSlot(arg_23_0, arg_23_1)
	if Activity104EquipItemListModel.instance.curSelectSlot ~= arg_23_1 then
		if not Activity104EquipItemListModel.instance:slotIsLock(arg_23_1) then
			Activity104EquipController.instance:setSlot(arg_23_1)
		else
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)
		end
	end
end

function var_0_0.handleSaveSucc(arg_24_0)
	if arg_24_0._isManualSave then
		GameFacade.showToast(Activity104EquipController.Toast_Save_Succ)
		arg_24_0:closeThis()
	end
end

function var_0_0.handleSwitchAnimFrame(arg_25_0)
	arg_25_0:refreshSlots()
	arg_25_0:refreshDescGroup()
end

function var_0_0.handleSlotSwitchAnimFrame(arg_26_0)
	arg_26_0.mainView:refreshDescGroup()
end

function var_0_0.handleEquipCardChanged(arg_27_0, arg_27_1)
	local var_27_0 = Activity104EquipItemListModel.instance.curSelectSlot
	local var_27_1 = arg_27_0:getOrCreateSlot(var_27_0)
	local var_27_2 = arg_27_1.isNew and "open" or "switch"

	var_27_1.animator:Play(var_27_2, 0, 0)

	if arg_27_1.unloadSlot then
		arg_27_0:getOrCreateSlot(arg_27_1.unloadSlot).animator:Play("close", 0, 0)
	end

	arg_27_0._animator:Play("switch", 0, 0)
end

function var_0_0.handleEquipSlotChanged(arg_28_0)
	arg_28_0._animator:Play("switch", 0, 0)
	arg_28_0:refreshSlots()
end

function var_0_0._btnequipOnClick(arg_29_0)
	arg_29_0._isManualSave = Activity104EquipController.instance:checkCanSaveSlot()

	if arg_29_0._isManualSave then
		Activity104EquipController.instance:saveShowSlot()
	end
end

function var_0_0._btnhandbookOnClick(arg_30_0)
	ViewMgr.instance:openView(ViewName.Season3_0EquipBookView, {
		actId = arg_30_0.viewParam.actId
	})
end

return var_0_0
