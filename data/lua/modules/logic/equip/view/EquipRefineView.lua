module("modules.logic.equip.view.EquipRefineView", package.seeall)

local var_0_0 = class("EquipRefineView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagelock = gohelper.findChildImage(arg_1_0.viewGO, "#go_effect/#go_progress/#image_lock")
	arg_1_0._txtattributelv = gohelper.findChildText(arg_1_0.viewGO, "#go_effect/#go_progress/#txt_attributelv")
	arg_1_0._gorefinedescViewPort = gohelper.findChild(arg_1_0.viewGO, "#go_effect/scroll_refinedesc/Viewport/")
	arg_1_0._gosuiteffect = gohelper.findChild(arg_1_0.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect")
	arg_1_0._txtsuiteffect2 = gohelper.findChildText(arg_1_0.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_effect/#go_cost")
	arg_1_0._gobreakcount = gohelper.findChild(arg_1_0.viewGO, "#go_effect/#go_cost/title/#go_breakcount")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_effect/#go_cost/#go_btns")
	arg_1_0._btnrefine = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_effect/#go_cost/#go_btns/#btn_refine")
	arg_1_0._goimprove = gohelper.findChild(arg_1_0.viewGO, "#go_effect/#go_improve")
	arg_1_0._animimprove = arg_1_0._goimprove:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._btnback = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_effect/#go_improve/#btn_back")
	arg_1_0._golackequip = gohelper.findChild(arg_1_0.viewGO, "#go_effect/#go_improve/#go_lackequip")
	arg_1_0._gofullgrade = gohelper.findChild(arg_1_0.viewGO, "#go_effect/#go_fullgrade")
	arg_1_0._gobaseskill = gohelper.findChild(arg_1_0.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect/#go_baseskill")
	arg_1_0._goeffect = gohelper.findChild(arg_1_0.viewGO, "#go_effect")
	arg_1_0._gonoteffect = gohelper.findChild(arg_1_0.viewGO, "#go_noteffect")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnrefine:AddClickListener(arg_2_0._btnrefineOnClick, arg_2_0)
	arg_2_0._btnback:AddClickListener(arg_2_0._btnbackOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnrefine:RemoveClickListener()
	arg_3_0._btnback:RemoveClickListener()
end

function var_0_0.onShowLeftBackpackContainer(arg_4_0, arg_4_1)
	arg_4_0.show_state = arg_4_1
end

function var_0_0._btnbackOnClick(arg_5_0, arg_5_1)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false, arg_5_1)
end

function var_0_0._btnrefineOnClick(arg_6_0)
	local var_6_0 = EquipRefineListModel.instance:getSelectedEquipMoList()

	if #var_6_0 <= 0 then
		if arg_6_0.show_state then
			GameFacade.showToast(ToastEnum.EquipRefineShow)
		else
			EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
		end

		return
	end

	arg_6_0.last_refine_lv = arg_6_0._equip_mo.refineLv

	local var_6_1
	local var_6_2
	local var_6_3
	local var_6_4
	local var_6_5
	local var_6_6 = false
	local var_6_7 = false
	local var_6_8
	local var_6_9 = TimeUtil.getDayFirstLoginRed("EquipHighLevelNotice")
	local var_6_10 = TimeUtil.getDayFirstLoginRed("EquipRefineHighLevelNotice")
	local var_6_11 = TimeUtil.getDayFirstLoginRed("EquipHighLevelAndRefineHighLevelNotice")
	local var_6_12 = TimeUtil.getDayFirstLoginRed("EquipOutMaxRefineLvCondition")
	local var_6_13 = arg_6_0._equip_mo.refineLv + EquipRefineListModel.instance:getAddRefineLv()

	if var_6_13 > EquipConfig.instance:getEquipRefineLvMax() then
		var_6_13 = EquipConfig.instance:getEquipRefineLvMax()

		if var_6_12 then
			var_6_4 = true
			var_6_6 = true
			var_6_1 = MessageBoxConfig.instance:getMessage(64)
		end
	end

	if not var_6_6 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			var_6_2 = iter_6_1.level > 1
			var_6_3 = iter_6_1.refineLv > 1

			if arg_6_0._equip_mo.config.rare == 4 and iter_6_1.equipId == 1000 then
				var_6_7 = true
				var_6_8 = iter_6_1.config.name
			end

			if var_6_3 and var_6_2 and var_6_11 and not var_6_6 then
				var_6_6 = true
				var_6_1 = string.format(MessageBoxConfig.instance:getMessage(34), var_6_13)
			end

			if var_6_2 and var_6_9 and not var_6_6 then
				var_6_6 = true
				var_6_1 = MessageBoxConfig.instance:getMessage(32)
			end

			if var_6_3 and var_6_10 and not var_6_6 then
				var_6_6 = true
				var_6_1 = string.format(MessageBoxConfig.instance:getMessage(33), var_6_13)
			end
		end
	end

	local function var_6_14()
		if var_6_6 then
			EquipController.instance:openEquipStrengthenAlertView({
				callback = function(arg_8_0)
					if arg_8_0 then
						if var_6_4 then
							TimeUtil.setDayFirstLoginRed("EquipOutMaxRefineLvCondition")
						end

						if var_6_2 and var_6_3 then
							TimeUtil.setDayFirstLoginRed("EquipHighLevelNotice")
							TimeUtil.setDayFirstLoginRed("EquipRefineHighLevelNotice")
							TimeUtil.setDayFirstLoginRed("EquipHighLevelAndRefineHighLevelNotice")
						elseif var_6_2 then
							TimeUtil.setDayFirstLoginRed("EquipHighLevelNotice")
						else
							TimeUtil.setDayFirstLoginRed("EquipRefineHighLevelNotice")
						end
					end

					arg_6_0:_sendEquipRefineRequest()
				end,
				content = var_6_1
			})
		else
			arg_6_0:_sendEquipRefineRequest()
		end
	end

	if var_6_7 then
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.EquipRefineCost, MsgBoxEnum.BoxType.Yes_No, var_6_14, nil, nil, arg_6_0, nil, nil, var_6_8)

		return
	end

	var_6_14()
end

function var_0_0._showCostGluttonyTip(arg_9_0, arg_9_1)
	return
end

function var_0_0._sendEquipRefineRequest(arg_10_0)
	EquipRpc.instance:sendEquipRefineRequest(arg_10_0._equip_mo.uid, EquipRefineListModel.instance:getSelectedEquipUidList())
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, arg_11_0._onEquipRefineReply, arg_11_0)
	arg_11_0:addEventCb(EquipController.instance, EquipEvent.onCloseEquipLevelUpView, arg_11_0._onCloseEquipLevelUpView, arg_11_0)
	arg_11_0:addEventCb(EquipController.instance, EquipEvent.onChangeRefineScrollState, arg_11_0.onShowLeftBackpackContainer, arg_11_0)
	arg_11_0:addEventCb(EquipController.instance, EquipEvent.OnRefineSelectedEquipChange, arg_11_0.refreshEquipDesc, arg_11_0)
	gohelper.addUIClickAudio(arg_11_0._btnrefine.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)

	arg_11_0.refineDescClick = gohelper.getClick(arg_11_0._gorefinedescViewPort)

	arg_11_0.refineDescClick:AddClickListener(arg_11_0._btnbackOnClick, arg_11_0)

	arg_11_0._hyperLinkClick2 = arg_11_0._txtsuiteffect2.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	arg_11_0._hyperLinkClick2:SetClickListener(arg_11_0._onHyperLinkClick, arg_11_0)
	gohelper.setActive(arg_11_0._txtsuiteffect2.gameObject, false)

	arg_11_0._txtDescList = arg_11_0:getUserDataTb_()

	arg_11_0:setBtnBackWidth()
	arg_11_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_11_0.setBtnBackWidth, arg_11_0)

	arg_11_0._viewAnim = gohelper.onceAddComponent(arg_11_0.viewGO, typeof(UnityEngine.Animator))
end

function var_0_0.setBtnBackWidth(arg_12_0)
	local var_12_0 = recthelper.getWidth(arg_12_0._goimprove.transform)

	recthelper.setWidth(arg_12_0._btnback.gameObject.transform, 0.45 * var_12_0)
end

function var_0_0._onHyperLinkClick(arg_13_0)
	EquipController.instance:openEquipSkillTipView({
		arg_13_0._equip_mo,
		arg_13_0._equip_mo.equipId,
		true
	})
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0._onEquipRefineReply(arg_15_0)
	if not arg_15_0.canRefine then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_refine)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false, true)
	EquipRefineListModel.instance:clearSelectedEquipList()
	UIBlockMgr.instance:startBlock(arg_15_0.viewName .. "ViewOpenAnim")
	TaskDispatcher.cancelTask(arg_15_0._openEquipSkillLevelUpView, arg_15_0)
	TaskDispatcher.runDelay(arg_15_0._openEquipSkillLevelUpView, arg_15_0, 1.45)
end

function var_0_0._openEquipSkillLevelUpView(arg_16_0)
	UIBlockMgr.instance:endBlock(arg_16_0.viewName .. "ViewOpenAnim")
	EquipController.instance:openEquipSkillLevelUpView({
		arg_16_0._equip_mo,
		arg_16_0.last_refine_lv
	})
	arg_16_0:_refreshList()
	arg_16_0:refreshUI()
end

function var_0_0._refreshList(arg_17_0)
	EquipRefineListModel.instance:initData(arg_17_0._equip_mo)
	EquipRefineListModel.instance:sortData()
	EquipRefineListModel.instance:refreshData()
	arg_17_0.viewContainer.equipView:refreshRefineEquipList()
end

function var_0_0.refreshEquipDesc(arg_18_0)
	if not arg_18_0.canRefine then
		return
	end

	local var_18_0 = arg_18_0._equip_mo.refineLv + EquipRefineListModel.instance:getAddRefineLv()
	local var_18_1 = EquipConfig.instance:getEquipRefineLvMax()

	arg_18_0:_setEquipSkillDesc(var_18_1 < var_18_0 and var_18_1 or var_18_0)
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0._equip_mo = arg_19_0.viewContainer.viewParam.equipMO
	arg_19_0.canRefine = arg_19_0._equip_mo.config.rare > EquipConfig.instance:getNotShowRefineRare()

	arg_19_0:refreshUI()
	EquipRefineListModel.instance:initData(arg_19_0._equip_mo)
	EquipRefineListModel.instance:sortData()
	EquipRefineSelectedListModel.instance:initList()
	arg_19_0._viewAnim:Play(UIAnimationName.Open)
end

function var_0_0.refreshUI(arg_20_0)
	gohelper.setActive(arg_20_0._goeffect, arg_20_0.canRefine)
	gohelper.setActive(arg_20_0._gonoteffect, not arg_20_0.canRefine)

	if arg_20_0.viewContainer:getIsOpenLeftBackpack() then
		if not arg_20_0.canRefine then
			arg_20_0.viewContainer.equipView:changeStrengthenScrollVisibleState(false)
		else
			arg_20_0.viewContainer.equipView:hideStrengthenScrollAndShowRefineScroll()
		end
	else
		gohelper.setActive(arg_20_0._goimprove, false)
	end

	if not arg_20_0.canRefine then
		return
	end

	arg_20_0.is_max_lv = arg_20_0._equip_mo.refineLv >= EquipConfig.instance:getEquipRefineLvMax()

	gohelper.setActive(arg_20_0._gocost, not arg_20_0.is_max_lv)
	arg_20_0:_setEquipSkillDesc(arg_20_0._equip_mo.refineLv)
	gohelper.setActive(arg_20_0._gofullgrade, arg_20_0.is_max_lv)

	if arg_20_0.is_max_lv then
		arg_20_0.viewContainer:setIsOpenLeftBackpack(false)
	end
end

function var_0_0._setEquipSkillDesc(arg_21_0, arg_21_1)
	if not arg_21_0.canRefine then
		return
	end

	arg_21_0._txtattributelv.text = arg_21_1

	arg_21_0:_showSkillBaseDes(arg_21_1)
end

function var_0_0._showSkillBaseDes(arg_22_0, arg_22_1)
	local var_22_0 = EquipHelper.getEquipSkillDescList(arg_22_0._equip_mo.equipId, arg_22_1, "#D9A06F")

	if #var_22_0 == 0 then
		gohelper.setActive(arg_22_0._gobaseskill.gameObject, false)
	else
		gohelper.setActive(arg_22_0._gobaseskill.gameObject, true)

		local var_22_1
		local var_22_2
		local var_22_3

		for iter_22_0, iter_22_1 in ipairs(var_22_0) do
			local var_22_4 = arg_22_0._txtDescList[iter_22_0]

			if not var_22_4 then
				local var_22_5 = {}
				local var_22_6 = gohelper.cloneInPlace(arg_22_0._txtsuiteffect2.gameObject, "item_" .. iter_22_0)

				var_22_5.itemGo = var_22_6
				var_22_5.imagebasedesicon = gohelper.findChildImage(var_22_6, "#image_basedesicon")
				var_22_5.txt = var_22_6:GetComponent(gohelper.Type_TextMesh)
				var_22_4 = var_22_5

				table.insert(arg_22_0._txtDescList, var_22_4)
			end

			var_22_4.txt.text = iter_22_1

			gohelper.setActive(var_22_4.itemGo, true)
		end

		for iter_22_2 = #var_22_0 + 1, #arg_22_0._txtDescList do
			gohelper.setActive(arg_22_0._txtDescList[iter_22_2].itemGo, false)
		end
	end
end

function var_0_0._onShowEquipGroupBg(arg_23_0, arg_23_1)
	if arg_23_1 then
		arg_23_0:showScrollerContainer()
		arg_23_0._animimprove:Play("go_improve2")
	else
		arg_23_0._animimprove:Play("go_improve2_out")
		TaskDispatcher.runDelay(arg_23_0._hideScrollContainer, arg_23_0, 0.167)
	end
end

function var_0_0.showScrollContainer(arg_24_0)
	EquipRefineListModel.instance:refreshData()
	gohelper.setActive(arg_24_0._golackequip, #EquipRefineListModel.instance.data == 0)
	gohelper.setActive(arg_24_0._goimprove, true)
	arg_24_0._animimprove:Play("go_improve2")
end

function var_0_0.hideScrollContainer(arg_25_0)
	arg_25_0._animimprove:Play("go_improve2_out")
	TaskDispatcher.runDelay(arg_25_0._hideScrollContainer, arg_25_0, 0.167)
end

function var_0_0._hideScrollContainer(arg_26_0)
	gohelper.setActive(arg_26_0._goimprove, false)
end

function var_0_0._onCloseEquipLevelUpView(arg_27_0)
	if not arg_27_0.is_max_lv then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
	end
end

function var_0_0.onClose(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._openEquipSkillLevelUpView, arg_28_0)
	EquipRefineListModel.instance:clearData()
	EquipRefineSelectedListModel.instance:clearData()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	arg_28_0:playCloseAnimation()
end

function var_0_0.playCloseAnimation(arg_29_0)
	arg_29_0._viewAnim:Play(UIAnimationName.Close)
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0.refineDescClick:RemoveClickListener()
	UIBlockMgr.instance:endBlock(arg_30_0.viewName .. "ViewOpenAnim")
end

return var_0_0
