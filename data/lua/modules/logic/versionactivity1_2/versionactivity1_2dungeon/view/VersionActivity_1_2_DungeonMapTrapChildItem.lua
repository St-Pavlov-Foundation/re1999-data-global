module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapTrapChildItem", package.seeall)

slot0 = class("VersionActivity_1_2_DungeonMapTrapChildItem", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._goselectbg = gohelper.findChild(slot0.viewGO, "#go_selectbg")
	slot0._gounselectbg = gohelper.findChild(slot0.viewGO, "#go_unselectbg")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "bottom/#go_cost")
	slot0._imageIcon = gohelper.findChildImage(slot0.viewGO, "content/iconbg/icon")
	slot0._simageicon = gohelper.findChildImage(slot0.viewGO, "bottom/#go_cost/iconnode/icon")
	slot0._txtcost = gohelper.findChildText(slot0.viewGO, "bottom/#go_cost/#txt_cost")
	slot0._gopalcing = gohelper.findChild(slot0.viewGO, "bottom/#go_palcing")
	slot0._btnremove = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_remove", AudioEnum.UI.play_ui_pkls_role_disappear)
	slot0._btnmake = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_make")
	slot0._btnreplace = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_replace", AudioEnum.UI.play_ui_lvhu_trap_replace)
	slot0._btnplace = gohelper.findChildButtonWithAudio(slot0.viewGO, "bottom/#btn_place", AudioEnum.UI.play_ui_lvhu_trap_replace)
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "content/#txt_name")
	slot0._txtinfo = gohelper.findChildText(slot0.viewGO, "content/#txt_info")
	slot0._vx_make = gohelper.findChild(slot0.viewGO, "vx_make")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnremove:AddClickListener(slot0._btnremoveOnClick, slot0)
	slot0._btnmake:AddClickListener(slot0._btnmakeOnClick, slot0)
	slot0._btnreplace:AddClickListener(slot0._btnreplaceOnClick, slot0)
	slot0._btnplace:AddClickListener(slot0._btnplaceOnClick, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceivePutTrapReply, slot0._onReceivePutTrapReply, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveBuildTrapReply, slot0._onReceiveBuildTrapReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnremove:RemoveClickListener()
	slot0._btnmake:RemoveClickListener()
	slot0._btnreplace:RemoveClickListener()
	slot0._btnplace:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._vx_make, false)
end

function slot0._btnremoveOnClick(slot0)
	Activity116Rpc.instance:sendPutTrapRequest(0)
end

function slot0._btnmakeOnClick(slot0)
	if #slot0._costData > 0 and not ItemModel.instance:goodsIsEnough(slot0._costData[1], slot0._costData[2], slot0._costData[3]) then
		GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)

		return
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = slot0._config.name,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	Activity116Rpc.instance:sendBuildTrapRequest(slot0._config.id)
end

function slot0._btnreplaceOnClick(slot0)
	Activity116Rpc.instance:sendPutTrapRequest(slot0._config.id)
end

function slot0._btnplaceOnClick(slot0)
	Activity116Rpc.instance:sendPutTrapRequest(slot0._config.id)
end

function slot0._onReceivePutTrapReply(slot0)
	slot0:onOpen()
end

function slot0._onReceiveBuildTrapReply(slot0, slot1)
	slot0:onOpen()

	if slot1 == slot0._config.id then
		gohelper.setActive(slot0._vx_make, false)
		gohelper.setActive(slot0._vx_make, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_prop_pick)
	end
end

function slot0.onRefreshViewParam(slot0, slot1)
	slot0._config = slot1
end

function slot0.onOpen(slot0)
	slot0._trapIds = VersionActivity1_2DungeonModel.instance.trapIds
	slot0._putTrap = VersionActivity1_2DungeonModel.instance.putTrap

	gohelper.setActive(slot0._goselectbg, slot0._putTrap == slot0._config.id)
	gohelper.setActive(slot0._gounselectbg, slot0._putTrap ~= slot0._config.id)

	slot0._makeDone = slot0._trapIds[slot0._config.id]
	slot0._putting = slot0._putTrap == slot0._config.id

	gohelper.setActive(slot0._btnmake.gameObject, not slot0._makeDone)
	gohelper.setActive(slot0._gopalcing, slot0._putting)
	gohelper.setActive(slot0._btnremove.gameObject, slot0._putting)
	gohelper.setActive(slot0._btnreplace.gameObject, slot0._putTrap ~= 0 and slot0._makeDone and not slot0._putting)
	gohelper.setActive(slot0._btnplace.gameObject, slot0._putTrap == 0 and slot0._makeDone)

	slot0._txtname.text = slot0._config.name
	slot0._txtinfo.text = string.gsub(slot0._config.desc, "\\n", "\n")

	slot0:_showCost()
	UISpriteSetMgr.instance:setVersionActivityDungeon_1_2Sprite(slot0._imageIcon, slot0._config.icon)
end

function slot0._showCost(slot0)
	gohelper.setActive(slot0._gocost, not slot0._makeDone)

	if not slot0._makeDone then
		slot0._costData = string.splitToNumber(slot0._config.cost, "#")

		if #slot0._costData > 0 then
			UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._simageicon, CurrencyConfig.instance:getCurrencyCo(slot0._costData[2]).icon .. "_1")

			slot0._txtcost.text = slot0._costData[3]
			slot0._costIconClick = gohelper.getClick(slot0._simageicon.gameObject)

			slot0._costIconClick:AddClickListener(slot0._onBtnCostIcon, slot0)

			if ItemModel.instance:goodsIsEnough(slot0._costData[1], slot0._costData[2], slot0._costData[3]) then
				SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#ACCB8A")
			else
				SLFramework.UGUI.GuiHelper.SetColor(slot0._txtcost, "#D97373")
			end
		else
			gohelper.setActive(slot0._gocost, false)
		end
	end
end

function slot0._onBtnCostIcon(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._costData[1], slot0._costData[2])
end

function slot0.onClose(slot0)
	if slot0._costIconClick then
		slot0._costIconClick:RemoveClickListener()
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
