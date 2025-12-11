module("modules.logic.room.view.common.RoomMaterialTipView", package.seeall)

local var_0_0 = class("RoomMaterialTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg1")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_bg2")
	arg_1_0._gobannerContent = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent")
	arg_1_0._goroominfoItem = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_slider")
	arg_1_0._gobannerscroll = gohelper.findChild(arg_1_0.viewGO, "left/banner/#go_bannerscroll")
	arg_1_0._goact = gohelper.findChild(arg_1_0.viewGO, "left/#go_actname")
	arg_1_0._txtactname = gohelper.findChildText(arg_1_0.viewGO, "left/#go_actname/#txt_actname")
	arg_1_0._btntheme = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "left/#btn_theme")
	arg_1_0._txttheme = gohelper.findChildText(arg_1_0.viewGO, "left/#btn_theme/txt")
	arg_1_0._gocobrand = gohelper.findChild(arg_1_0.viewGO, "left/#go_cobrand")
	arg_1_0._gobuyContent = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent")
	arg_1_0._goblockInfoItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/scroll_blockpackage/viewport/content/#go_blockInfoItem")
	arg_1_0._gopay = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay")
	arg_1_0._gopayitem = gohelper.findChild(arg_1_0.viewGO, "right/#go_buyContent/#go_pay/#go_payitem")
	arg_1_0._btninsight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "right/#go_buyContent/buy/#btn_insight")
	arg_1_0._txtcostnum = gohelper.findChildText(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	arg_1_0._gosource = gohelper.findChild(arg_1_0.viewGO, "right/#go_source")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "right/#go_source/title/#txt_time")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "right/#go_source/title/#txt_time")
	arg_1_0._scrolljump = gohelper.findChildScrollRect(arg_1_0.viewGO, "right/#go_source/#scroll_jump")
	arg_1_0._gojumpItem = gohelper.findChild(arg_1_0.viewGO, "right/#go_source/#scroll_jump/Viewport/Content/#go_jumpItem")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntheme:AddClickListener(arg_2_0._btnthemeOnClick, arg_2_0)
	arg_2_0._btninsight:AddClickListener(arg_2_0._btninsightOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntheme:RemoveClickListener()
	arg_3_0._btninsight:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnthemeOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
		type = arg_4_0.viewParam.type,
		id = arg_4_0.viewParam.id
	})
end

function var_0_0._btninsightOnClick(arg_5_0)
	return
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._gojumpItem, false)
	gohelper.setActive(arg_7_0._gobuyContent, false)
	gohelper.setActive(arg_7_0._gosource, true)

	arg_7_0._jumpParentGo = gohelper.findChild(arg_7_0.viewGO, "right/#go_source/#scroll_jump/Viewport/Content")
	arg_7_0.jumpItemGos = {}

	arg_7_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_7_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_7_0.cobrandLogoItem = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._gocobrand, RoomSourcesCobrandLogoItem, arg_7_0)
end

function var_0_0._refreshUI(arg_8_0)
	arg_8_0._roomSkinId = arg_8_0.viewParam.roomSkinId
	arg_8_0._canJump = arg_8_0.viewParam.canJump

	local var_8_0 = false
	local var_8_1 = false
	local var_8_2

	if arg_8_0._roomSkinId then
		local var_8_3 = RoomConfig.instance:getRoomSkinActId(arg_8_0._roomSkinId)

		var_8_0 = var_8_3 and var_8_3 ~= 0

		local var_8_4 = ""

		if var_8_0 then
			local var_8_5 = ActivityConfig.instance:getActivityCo(var_8_3)

			var_8_4 = var_8_5 and var_8_5.name or ""
		end

		arg_8_0._txtactname.text = var_8_4

		local var_8_6 = ActivityModel.instance:getActMO(var_8_3)
		local var_8_7 = var_8_6 and var_8_6:getRemainTimeStr3(false, true) or ""

		arg_8_0._txttime.text = var_8_7
	else
		arg_8_0._config = ItemModel.instance:getItemConfig(arg_8_0.viewParam.type, arg_8_0.viewParam.id)

		local var_8_8 = RoomConfig.instance:getThemeIdByItem(arg_8_0.viewParam.id, arg_8_0.viewParam.type)
		local var_8_9 = var_8_8 and lua_room_theme.configDict[var_8_8]

		arg_8_0._txttheme.text = var_8_9 and var_8_9.name or ""
		var_8_1 = var_8_8 ~= nil
		var_8_2 = arg_8_0._config.sourcesType
	end

	arg_8_0.cobrandLogoItem:setSourcesTypeStr(var_8_2)
	gohelper.setActive(arg_8_0._goact, var_8_0)
	gohelper.setActive(arg_8_0._gotime, var_8_0)
	gohelper.setActive(arg_8_0._btntheme.gameObject, var_8_1 and not arg_8_0.cobrandLogoItem:getIsShow())
	arg_8_0:_cloneJumpItem()
end

function var_0_0._cloneJumpItem(arg_9_0)
	arg_9_0._scrolljump.verticalNormalizedPosition = 1

	local var_9_0 = {}

	if arg_9_0._config then
		var_9_0 = arg_9_0:_sourcesStrToTables(arg_9_0._config.sources)
	elseif arg_9_0._roomSkinId then
		local var_9_1 = RoomConfig.instance:getRoomSkinSources(arg_9_0._roomSkinId)

		var_9_0 = arg_9_0:_sourcesStrToTables(var_9_1)
	end

	for iter_9_0 = 1, #var_9_0 do
		local var_9_2 = arg_9_0.jumpItemGos[iter_9_0]

		if not var_9_2 then
			local var_9_3 = iter_9_0 == 1 and arg_9_0._gojumpItem or gohelper.clone(arg_9_0._gojumpItem, arg_9_0._jumpParentGo, "item" .. iter_9_0)

			var_9_2 = arg_9_0:getUserDataTb_()
			var_9_2.go = var_9_3
			var_9_2.originText = gohelper.findChildText(var_9_3, "frame/txt_chapter")
			var_9_2.indexText = gohelper.findChildText(var_9_3, "frame/txt_name")
			var_9_2.jumpBtn = gohelper.findChildButtonWithAudio(var_9_3, "frame/btn_jump")
			var_9_2.jumpBgGO = gohelper.findChild(var_9_3, "frame/btn_jump/jumpbg")

			table.insert(arg_9_0.jumpItemGos, var_9_2)
			var_9_2.jumpBtn:AddClickListener(function(arg_10_0)
				if arg_10_0.cantJumpTips then
					GameFacade.showToastWithTableParam(arg_10_0.cantJumpTips, arg_10_0.cantJumpParam)
				elseif arg_10_0.canJump then
					if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.ForceJumpToMainView) then
						NavigateButtonsView.homeClick()

						return
					end

					GameFacade.jump(arg_10_0.jumpId, arg_9_0._onJumpFinish, arg_9_0, arg_9_0.viewParam.recordFarmItem)
				else
					GameFacade.showToast(ToastEnum.MaterialTipJump)
				end
			end, var_9_2)
		end

		local var_9_4 = var_9_0[iter_9_0]

		var_9_2.canJump = arg_9_0._canJump
		var_9_2.jumpId = var_9_4.sourceId

		local var_9_5, var_9_6 = JumpConfig.instance:getJumpName(var_9_4.sourceId)

		var_9_2.originText.text = var_9_5 or ""
		var_9_2.indexText.text = var_9_6 or ""

		local var_9_7, var_9_8 = arg_9_0:_getCantJump(var_9_4)

		ZProj.UGUIHelper.SetGrayscale(var_9_2.jumpBgGO, var_9_7 ~= nil)

		var_9_2.cantJumpTips = var_9_7
		var_9_2.cantJumpParam = var_9_8

		gohelper.setActive(var_9_2.go, true)

		local var_9_9 = JumpController.instance:isOnlyShowJump(var_9_4.sourceId)

		gohelper.setActive(var_9_2.jumpBtn, not var_9_9)
	end

	gohelper.setActive(arg_9_0._gosource, #var_9_0 > 0)

	for iter_9_1 = #var_9_0 + 1, #arg_9_0.jumpItemGos do
		gohelper.setActive(arg_9_0.jumpItemGos[iter_9_1].go, false)
	end
end

function var_0_0._sourcesStrToTables(arg_11_0, arg_11_1)
	local var_11_0 = {}

	if not string.nilorempty(arg_11_1) then
		local var_11_1 = string.split(arg_11_1, "|")

		for iter_11_0, iter_11_1 in ipairs(var_11_1) do
			local var_11_2 = string.splitToNumber(iter_11_1, "#")
			local var_11_3 = {
				sourceId = var_11_2[1],
				probability = var_11_2[2]
			}

			var_11_3.episodeId = JumpConfig.instance:getJumpEpisodeId(var_11_3.sourceId)

			if var_11_3.probability ~= MaterialEnum.JumpProbability.Normal or not DungeonModel.instance:hasPassLevel(var_11_3.episodeId) then
				table.insert(var_11_0, var_11_3)
			end
		end
	end

	return var_11_0
end

function var_0_0._getCantJump(arg_12_0, arg_12_1)
	local var_12_0 = JumpController.instance:isJumpOpen(arg_12_1.sourceId)
	local var_12_1
	local var_12_2
	local var_12_3 = JumpConfig.instance:getJumpConfig(arg_12_1.sourceId)

	if not var_12_0 then
		var_12_1, var_12_2 = OpenHelper.getToastIdAndParam(var_12_3.openId)
	else
		var_12_1, var_12_2 = JumpController.instance:cantJump(var_12_3.param)
	end

	local var_12_4 = string.split(var_12_3.param, "#")

	if tonumber(var_12_4[1]) == JumpEnum.JumpView.RoomProductLineView and not var_12_1 then
		local var_12_5
		local var_12_6
		local var_12_7
		local var_12_8, var_12_9, var_12_10 = RoomProductionHelper.isChangeFormulaUnlock(arg_12_0.viewParam.type, arg_12_0.viewParam.id)
		local var_12_11 = var_12_10
		local var_12_12 = var_12_9

		if not var_12_8 then
			var_12_1 = var_12_12
			var_12_2 = var_12_11 and {
				var_12_11
			} or nil
		end
	end

	return var_12_1, var_12_2
end

function var_0_0.onUpdateParam(arg_13_0)
	arg_13_0:_refreshUI()
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0:_refreshUI()
end

function var_0_0.onClose(arg_15_0)
	for iter_15_0 = 1, #arg_15_0.jumpItemGos do
		arg_15_0.jumpItemGos[iter_15_0].jumpBtn:RemoveClickListener()
	end
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagebg1:UnLoadImage()
	arg_16_0._simagebg2:UnLoadImage()
	arg_16_0.cobrandLogoItem:onDestroy()
end

return var_0_0
