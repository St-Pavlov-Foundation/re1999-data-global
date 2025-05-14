module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity_1_2_DungeonMapTrapChildItem", package.seeall)

local var_0_0 = class("VersionActivity_1_2_DungeonMapTrapChildItem", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goselectbg = gohelper.findChild(arg_1_0.viewGO, "#go_selectbg")
	arg_1_0._gounselectbg = gohelper.findChild(arg_1_0.viewGO, "#go_unselectbg")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_cost")
	arg_1_0._imageIcon = gohelper.findChildImage(arg_1_0.viewGO, "content/iconbg/icon")
	arg_1_0._simageicon = gohelper.findChildImage(arg_1_0.viewGO, "bottom/#go_cost/iconnode/icon")
	arg_1_0._txtcost = gohelper.findChildText(arg_1_0.viewGO, "bottom/#go_cost/#txt_cost")
	arg_1_0._gopalcing = gohelper.findChild(arg_1_0.viewGO, "bottom/#go_palcing")
	arg_1_0._btnremove = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_remove", AudioEnum.UI.play_ui_pkls_role_disappear)
	arg_1_0._btnmake = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_make")
	arg_1_0._btnreplace = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_replace", AudioEnum.UI.play_ui_lvhu_trap_replace)
	arg_1_0._btnplace = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bottom/#btn_place", AudioEnum.UI.play_ui_lvhu_trap_replace)
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_name")
	arg_1_0._txtinfo = gohelper.findChildText(arg_1_0.viewGO, "content/#txt_info")
	arg_1_0._vx_make = gohelper.findChild(arg_1_0.viewGO, "vx_make")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnremove:AddClickListener(arg_2_0._btnremoveOnClick, arg_2_0)
	arg_2_0._btnmake:AddClickListener(arg_2_0._btnmakeOnClick, arg_2_0)
	arg_2_0._btnreplace:AddClickListener(arg_2_0._btnreplaceOnClick, arg_2_0)
	arg_2_0._btnplace:AddClickListener(arg_2_0._btnplaceOnClick, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceivePutTrapReply, arg_2_0._onReceivePutTrapReply, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveBuildTrapReply, arg_2_0._onReceiveBuildTrapReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnremove:RemoveClickListener()
	arg_3_0._btnmake:RemoveClickListener()
	arg_3_0._btnreplace:RemoveClickListener()
	arg_3_0._btnplace:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._vx_make, false)
end

function var_0_0._btnremoveOnClick(arg_5_0)
	Activity116Rpc.instance:sendPutTrapRequest(0)
end

function var_0_0._btnmakeOnClick(arg_6_0)
	if #arg_6_0._costData > 0 and not ItemModel.instance:goodsIsEnough(arg_6_0._costData[1], arg_6_0._costData[2], arg_6_0._costData[3]) then
		GameFacade.showToast(ToastEnum.Acticity1_2MaterialNotEnough)

		return
	end

	StatController.instance:track(StatEnum.EventName.FacilityMutually, {
		[StatEnum.EventProperties.FacilityName] = arg_6_0._config.name,
		[StatEnum.EventProperties.PlotProgress2] = tostring(VersionActivity1_2DungeonController.instance:getNowEpisodeId())
	})
	Activity116Rpc.instance:sendBuildTrapRequest(arg_6_0._config.id)
end

function var_0_0._btnreplaceOnClick(arg_7_0)
	Activity116Rpc.instance:sendPutTrapRequest(arg_7_0._config.id)
end

function var_0_0._btnplaceOnClick(arg_8_0)
	Activity116Rpc.instance:sendPutTrapRequest(arg_8_0._config.id)
end

function var_0_0._onReceivePutTrapReply(arg_9_0)
	arg_9_0:onOpen()
end

function var_0_0._onReceiveBuildTrapReply(arg_10_0, arg_10_1)
	arg_10_0:onOpen()

	if arg_10_1 == arg_10_0._config.id then
		gohelper.setActive(arg_10_0._vx_make, false)
		gohelper.setActive(arg_10_0._vx_make, true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_pkls_prop_pick)
	end
end

function var_0_0.onRefreshViewParam(arg_11_0, arg_11_1)
	arg_11_0._config = arg_11_1
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0._trapIds = VersionActivity1_2DungeonModel.instance.trapIds
	arg_12_0._putTrap = VersionActivity1_2DungeonModel.instance.putTrap

	gohelper.setActive(arg_12_0._goselectbg, arg_12_0._putTrap == arg_12_0._config.id)
	gohelper.setActive(arg_12_0._gounselectbg, arg_12_0._putTrap ~= arg_12_0._config.id)

	arg_12_0._makeDone = arg_12_0._trapIds[arg_12_0._config.id]
	arg_12_0._putting = arg_12_0._putTrap == arg_12_0._config.id

	gohelper.setActive(arg_12_0._btnmake.gameObject, not arg_12_0._makeDone)
	gohelper.setActive(arg_12_0._gopalcing, arg_12_0._putting)
	gohelper.setActive(arg_12_0._btnremove.gameObject, arg_12_0._putting)
	gohelper.setActive(arg_12_0._btnreplace.gameObject, arg_12_0._putTrap ~= 0 and arg_12_0._makeDone and not arg_12_0._putting)
	gohelper.setActive(arg_12_0._btnplace.gameObject, arg_12_0._putTrap == 0 and arg_12_0._makeDone)

	arg_12_0._txtname.text = arg_12_0._config.name
	arg_12_0._txtinfo.text = string.gsub(arg_12_0._config.desc, "\\n", "\n")

	arg_12_0:_showCost()
	UISpriteSetMgr.instance:setVersionActivityDungeon_1_2Sprite(arg_12_0._imageIcon, arg_12_0._config.icon)
end

function var_0_0._showCost(arg_13_0)
	gohelper.setActive(arg_13_0._gocost, not arg_13_0._makeDone)

	if not arg_13_0._makeDone then
		arg_13_0._costData = string.splitToNumber(arg_13_0._config.cost, "#")

		if #arg_13_0._costData > 0 then
			local var_13_0 = CurrencyConfig.instance:getCurrencyCo(arg_13_0._costData[2]).icon

			UISpriteSetMgr.instance:setCurrencyItemSprite(arg_13_0._simageicon, var_13_0 .. "_1")

			arg_13_0._txtcost.text = arg_13_0._costData[3]
			arg_13_0._costIconClick = gohelper.getClick(arg_13_0._simageicon.gameObject)

			arg_13_0._costIconClick:AddClickListener(arg_13_0._onBtnCostIcon, arg_13_0)

			if ItemModel.instance:goodsIsEnough(arg_13_0._costData[1], arg_13_0._costData[2], arg_13_0._costData[3]) then
				SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._txtcost, "#ACCB8A")
			else
				SLFramework.UGUI.GuiHelper.SetColor(arg_13_0._txtcost, "#D97373")
			end
		else
			gohelper.setActive(arg_13_0._gocost, false)
		end
	end
end

function var_0_0._onBtnCostIcon(arg_14_0)
	MaterialTipController.instance:showMaterialInfo(arg_14_0._costData[1], arg_14_0._costData[2])
end

function var_0_0.onClose(arg_15_0)
	if arg_15_0._costIconClick then
		arg_15_0._costIconClick:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
