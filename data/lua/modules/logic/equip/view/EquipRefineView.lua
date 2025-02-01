module("modules.logic.equip.view.EquipRefineView", package.seeall)

slot0 = class("EquipRefineView", BaseView)

function slot0.onInitView(slot0)
	slot0._imagelock = gohelper.findChildImage(slot0.viewGO, "#go_effect/#go_progress/#image_lock")
	slot0._txtattributelv = gohelper.findChildText(slot0.viewGO, "#go_effect/#go_progress/#txt_attributelv")
	slot0._gorefinedescViewPort = gohelper.findChild(slot0.viewGO, "#go_effect/scroll_refinedesc/Viewport/")
	slot0._gosuiteffect = gohelper.findChild(slot0.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect")
	slot0._txtsuiteffect2 = gohelper.findChildText(slot0.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect/#go_baseskill/#txt_suiteffect2")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "#go_effect/#go_cost")
	slot0._gobreakcount = gohelper.findChild(slot0.viewGO, "#go_effect/#go_cost/title/#go_breakcount")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_effect/#go_cost/#go_btns")
	slot0._btnrefine = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_effect/#go_cost/#go_btns/#btn_refine")
	slot0._goimprove = gohelper.findChild(slot0.viewGO, "#go_effect/#go_improve")
	slot0._animimprove = slot0._goimprove:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnback = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_effect/#go_improve/#btn_back")
	slot0._golackequip = gohelper.findChild(slot0.viewGO, "#go_effect/#go_improve/#go_lackequip")
	slot0._gofullgrade = gohelper.findChild(slot0.viewGO, "#go_effect/#go_fullgrade")
	slot0._gobaseskill = gohelper.findChild(slot0.viewGO, "#go_effect/scroll_refinedesc/Viewport/#go_suiteffect/#go_baseskill")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#go_effect")
	slot0._gonoteffect = gohelper.findChild(slot0.viewGO, "#go_noteffect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnrefine:AddClickListener(slot0._btnrefineOnClick, slot0)
	slot0._btnback:AddClickListener(slot0._btnbackOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnrefine:RemoveClickListener()
	slot0._btnback:RemoveClickListener()
end

function slot0.onShowLeftBackpackContainer(slot0, slot1)
	slot0.show_state = slot1
end

function slot0._btnbackOnClick(slot0, slot1)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false, slot1)
end

function slot0._btnrefineOnClick(slot0)
	if #EquipRefineListModel.instance:getSelectedEquipMoList() <= 0 then
		if slot0.show_state then
			GameFacade.showToast(ToastEnum.EquipRefineShow)
		else
			EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
		end

		return
	end

	slot0.last_refine_lv = slot0._equip_mo.refineLv
	slot2, slot3, slot4, slot5, slot6 = nil
	slot7 = false
	slot8 = false
	slot9 = nil
	slot10 = TimeUtil.getDayFirstLoginRed("EquipHighLevelNotice")
	slot11 = TimeUtil.getDayFirstLoginRed("EquipRefineHighLevelNotice")
	slot12 = TimeUtil.getDayFirstLoginRed("EquipHighLevelAndRefineHighLevelNotice")

	if EquipConfig.instance:getEquipRefineLvMax() < slot0._equip_mo.refineLv + EquipRefineListModel.instance:getAddRefineLv() then
		slot6 = EquipConfig.instance:getEquipRefineLvMax()

		if TimeUtil.getDayFirstLoginRed("EquipOutMaxRefineLvCondition") then
			slot5 = true
			slot7 = true
			slot2 = MessageBoxConfig.instance:getMessage(64)
		end
	end

	if not slot7 then
		for slot17, slot18 in ipairs(slot1) do
			slot3 = slot18.level > 1
			slot4 = slot18.refineLv > 1

			if slot0._equip_mo.config.rare == 4 and slot18.equipId == 1000 then
				slot8 = true
				slot9 = slot18.config.name
			end

			if slot4 and slot3 and slot12 and not slot7 then
				slot7 = true
				slot2 = string.format(MessageBoxConfig.instance:getMessage(34), slot6)
			end

			if slot3 and slot10 and not slot7 then
				slot7 = true
				slot2 = MessageBoxConfig.instance:getMessage(32)
			end

			if slot4 and slot11 and not slot7 then
				slot7 = true
				slot2 = string.format(MessageBoxConfig.instance:getMessage(33), slot6)
			end
		end
	end

	function slot14()
		if uv0 then
			EquipController.instance:openEquipStrengthenAlertView({
				callback = function (slot0)
					if slot0 then
						if uv0 then
							TimeUtil.setDayFirstLoginRed("EquipOutMaxRefineLvCondition")
						end

						if uv1 and uv2 then
							TimeUtil.setDayFirstLoginRed("EquipHighLevelNotice")
							TimeUtil.setDayFirstLoginRed("EquipRefineHighLevelNotice")
							TimeUtil.setDayFirstLoginRed("EquipHighLevelAndRefineHighLevelNotice")
						elseif uv1 then
							TimeUtil.setDayFirstLoginRed("EquipHighLevelNotice")
						else
							TimeUtil.setDayFirstLoginRed("EquipRefineHighLevelNotice")
						end
					end

					uv3:_sendEquipRefineRequest()
				end,
				content = uv5
			})
		else
			uv4:_sendEquipRefineRequest()
		end
	end

	if slot8 then
		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.EquipRefineCost, MsgBoxEnum.BoxType.Yes_No, slot14, nil, , slot0, nil, , slot9)

		return
	end

	slot14()
end

function slot0._showCostGluttonyTip(slot0, slot1)
end

function slot0._sendEquipRefineRequest(slot0)
	EquipRpc.instance:sendEquipRefineRequest(slot0._equip_mo.uid, EquipRefineListModel.instance:getSelectedEquipUidList())
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onEquipRefineReply, slot0._onEquipRefineReply, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onCloseEquipLevelUpView, slot0._onCloseEquipLevelUpView, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.onChangeRefineScrollState, slot0.onShowLeftBackpackContainer, slot0)
	slot0:addEventCb(EquipController.instance, EquipEvent.OnRefineSelectedEquipChange, slot0.refreshEquipDesc, slot0)
	gohelper.addUIClickAudio(slot0._btnrefine.gameObject, AudioEnum.HeroGroupUI.Play_UI_Inking_Finish)

	slot0.refineDescClick = gohelper.getClick(slot0._gorefinedescViewPort)

	slot0.refineDescClick:AddClickListener(slot0._btnbackOnClick, slot0)

	slot0._hyperLinkClick2 = slot0._txtsuiteffect2.gameObject:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	slot0._hyperLinkClick2:SetClickListener(slot0._onHyperLinkClick, slot0)
	gohelper.setActive(slot0._txtsuiteffect2.gameObject, false)

	slot0._txtDescList = slot0:getUserDataTb_()

	slot0:setBtnBackWidth()
	slot0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, slot0.setBtnBackWidth, slot0)

	slot0._viewAnim = gohelper.onceAddComponent(slot0.viewGO, typeof(UnityEngine.Animator))
end

function slot0.setBtnBackWidth(slot0)
	recthelper.setWidth(slot0._btnback.gameObject.transform, 0.45 * recthelper.getWidth(slot0._goimprove.transform))
end

function slot0._onHyperLinkClick(slot0)
	EquipController.instance:openEquipSkillTipView({
		slot0._equip_mo,
		slot0._equip_mo.equipId,
		true
	})
end

function slot0.onUpdateParam(slot0)
end

function slot0._onEquipRefineReply(slot0)
	if not slot0.canRefine then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_inscription_refine)
	EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, false, true)
	EquipRefineListModel.instance:clearSelectedEquipList()
	UIBlockMgr.instance:startBlock(slot0.viewName .. "ViewOpenAnim")
	TaskDispatcher.cancelTask(slot0._openEquipSkillLevelUpView, slot0)
	TaskDispatcher.runDelay(slot0._openEquipSkillLevelUpView, slot0, 1.45)
end

function slot0._openEquipSkillLevelUpView(slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName .. "ViewOpenAnim")
	EquipController.instance:openEquipSkillLevelUpView({
		slot0._equip_mo,
		slot0.last_refine_lv
	})
	slot0:_refreshList()
	slot0:refreshUI()
end

function slot0._refreshList(slot0)
	EquipRefineListModel.instance:initData(slot0._equip_mo)
	EquipRefineListModel.instance:sortData()
	EquipRefineListModel.instance:refreshData()
	slot0.viewContainer.equipView:refreshRefineEquipList()
end

function slot0.refreshEquipDesc(slot0)
	if not slot0.canRefine then
		return
	end

	slot0:_setEquipSkillDesc(EquipConfig.instance:getEquipRefineLvMax() < slot0._equip_mo.refineLv + EquipRefineListModel.instance:getAddRefineLv() and slot2 or slot1)
end

function slot0.onOpen(slot0)
	slot0._equip_mo = slot0.viewContainer.viewParam.equipMO
	slot0.canRefine = EquipConfig.instance:getNotShowRefineRare() < slot0._equip_mo.config.rare

	slot0:refreshUI()
	EquipRefineListModel.instance:initData(slot0._equip_mo)
	EquipRefineListModel.instance:sortData()
	EquipRefineSelectedListModel.instance:initList()
	slot0._viewAnim:Play(UIAnimationName.Open)
end

function slot0.refreshUI(slot0)
	gohelper.setActive(slot0._goeffect, slot0.canRefine)
	gohelper.setActive(slot0._gonoteffect, not slot0.canRefine)

	if slot0.viewContainer:getIsOpenLeftBackpack() then
		if not slot0.canRefine then
			slot0.viewContainer.equipView:changeStrengthenScrollVisibleState(false)
		else
			slot0.viewContainer.equipView:hideStrengthenScrollAndShowRefineScroll()
		end
	else
		gohelper.setActive(slot0._goimprove, false)
	end

	if not slot0.canRefine then
		return
	end

	slot0.is_max_lv = EquipConfig.instance:getEquipRefineLvMax() <= slot0._equip_mo.refineLv

	gohelper.setActive(slot0._gocost, not slot0.is_max_lv)
	slot0:_setEquipSkillDesc(slot0._equip_mo.refineLv)
	gohelper.setActive(slot0._gofullgrade, slot0.is_max_lv)

	if slot0.is_max_lv then
		slot0.viewContainer:setIsOpenLeftBackpack(false)
	end
end

function slot0._setEquipSkillDesc(slot0, slot1)
	if not slot0.canRefine then
		return
	end

	slot0._txtattributelv.text = slot1

	slot0:_showSkillBaseDes(slot1)
end

function slot0._showSkillBaseDes(slot0, slot1)
	if #EquipHelper.getEquipSkillDescList(slot0._equip_mo.equipId, slot1, "#D9A06F") == 0 then
		gohelper.setActive(slot0._gobaseskill.gameObject, false)
	else
		gohelper.setActive(slot0._gobaseskill.gameObject, true)

		slot3, slot4, slot5 = nil

		for slot9, slot10 in ipairs(slot2) do
			if not slot0._txtDescList[slot9] then
				slot5 = gohelper.cloneInPlace(slot0._txtsuiteffect2.gameObject, "item_" .. slot9)

				table.insert(slot0._txtDescList, {
					itemGo = slot5,
					imagebasedesicon = gohelper.findChildImage(slot5, "#image_basedesicon"),
					txt = slot5:GetComponent(gohelper.Type_TextMesh)
				})
			end

			slot3.txt.text = slot10

			gohelper.setActive(slot3.itemGo, true)
		end

		for slot9 = #slot2 + 1, #slot0._txtDescList do
			gohelper.setActive(slot0._txtDescList[slot9].itemGo, false)
		end
	end
end

function slot0._onShowEquipGroupBg(slot0, slot1)
	if slot1 then
		slot0:showScrollerContainer()
		slot0._animimprove:Play("go_improve2")
	else
		slot0._animimprove:Play("go_improve2_out")
		TaskDispatcher.runDelay(slot0._hideScrollContainer, slot0, 0.167)
	end
end

function slot0.showScrollContainer(slot0)
	EquipRefineListModel.instance:refreshData()
	gohelper.setActive(slot0._golackequip, #EquipRefineListModel.instance.data == 0)
	gohelper.setActive(slot0._goimprove, true)
	slot0._animimprove:Play("go_improve2")
end

function slot0.hideScrollContainer(slot0)
	slot0._animimprove:Play("go_improve2_out")
	TaskDispatcher.runDelay(slot0._hideScrollContainer, slot0, 0.167)
end

function slot0._hideScrollContainer(slot0)
	gohelper.setActive(slot0._goimprove, false)
end

function slot0._onCloseEquipLevelUpView(slot0)
	if not slot0.is_max_lv then
		EquipController.instance:dispatchEvent(EquipEvent.onChangeRefineScrollState, true)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._openEquipSkillLevelUpView, slot0)
	EquipRefineListModel.instance:clearData()
	EquipRefineSelectedListModel.instance:clearData()
	ViewMgr.instance:closeView(ViewName.EquipInfoTipsView)
	slot0:playCloseAnimation()
end

function slot0.playCloseAnimation(slot0)
	slot0._viewAnim:Play(UIAnimationName.Close)
end

function slot0.onDestroyView(slot0)
	slot0.refineDescClick:RemoveClickListener()
	UIBlockMgr.instance:endBlock(slot0.viewName .. "ViewOpenAnim")
end

return slot0
